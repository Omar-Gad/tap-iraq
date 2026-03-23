import 'package:data/data.dart';
import 'package:data/src/mappers/address_mapper.dart';
import 'package:data/src/providers/mock/app_database.dart';
import 'package:drift/drift.dart';
import 'package:faker/faker.dart';

class FakeApiProvider implements ApiProvider {
  final AppDatabase _db;
  final _faker = Faker();
  int? _currentUserId;

  FakeApiProvider(this._db);

  @override
  Future<UserModel> login(LoginRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final user = await (_db.select(_db.users)
          ..where((t) => t.login.equals(request.login)))
        .getSingleOrNull();

    if (user == null) {
      throw Exception('User not found');
    }

    if (user.password != request.password) {
      throw Exception('Invalid password');
    }

    final sessionId = _faker.guid.guid();

    await (_db.update(_db.users)..where((t) => t.id.equals(user.id))).write(
      UsersCompanion(
        sessionId: Value(sessionId),
        isSessionActive: const Value(true),
      ),
    );

    _currentUserId = user.id;

    return UserModel(
      uid: user.id,
      name: user.name,
      username: user.login,
      companyId: user.companyId,
      sessionId: sessionId,
    );
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final existing = await (_db.select(_db.users)
          ..where((t) => t.login.equals(request.login)))
        .getSingleOrNull();

    if (existing != null) {
      throw Exception('User with this login already exists');
    }

    final sessionId = _faker.guid.guid();

    final id = await _db.into(_db.users).insert(
          UsersCompanion.insert(
            name: request.name,
            login: request.login,
            password: request.password,
            sessionId: Value(sessionId),
            companyId: const Value(1),
            isSessionActive: const Value(true),
          ),
        );

    _currentUserId = id;

    return UserModel(
      uid: id,
      name: request.name,
      username: request.login,
      companyId: 1,
      sessionId: sessionId,
    );
  }

  @override
  Future<bool> checkSession() async {
    if (_currentUserId == null) return false;

    final user = await (_db.select(_db.users)
          ..where((t) => t.id.equals(_currentUserId!)))
        .getSingleOrNull();

    return user?.isSessionActive ?? false;
  }

  @override
  Future<void> logout() async {
    if (_currentUserId != null) {
      await (_db.update(_db.users)..where((t) => t.id.equals(_currentUserId!)))
          .write(
        const UsersCompanion(
          isSessionActive: Value(false),
          sessionId: Value(''),
        ),
      );
      _currentUserId = null;
    }
  }

  @override
  Future<List<AddressModel>> getAddresses(int userId) async {
    final result = await (_db.select(_db.addresses)
          ..where((t) => t.userId.equals(userId)))
        .get();
    return result.map(AddressMapper.fromDriftToDto).toList();
  }

  @override
  Future<AddressModel> addAddress(AddressModel address) async {
    final id = await _db.into(_db.addresses).insert(
          AddressesCompanion.insert(
            userId: address.userId,
            street: address.street,
            propertyType: address.propertyType,
            propertySize: address.propertySize,
            isDefault: Value(address.isDefault),
          ),
        );

    final inserted = await (_db.select(_db.addresses)
          ..where((t) => t.id.equals(id)))
        .getSingle();

    return AddressMapper.fromDriftToDto(inserted);
  }

  @override
  Future<AddressModel> updateAddress(AddressModel address) async {
    await (_db.update(_db.addresses)..where((t) => t.id.equals(address.uid)))
        .write(
      AddressesCompanion(
        street: Value(address.street),
        propertyType: Value(address.propertyType),
        propertySize: Value(address.propertySize),
        isDefault: Value(address.isDefault),
      ),
    );

    final updated = await (_db.select(_db.addresses)
          ..where((t) => t.id.equals(address.uid)))
        .getSingle();

    return AddressMapper.fromDriftToDto(updated);
  }

  @override
  Future<void> deleteAddress(int addressId) async {
    await (_db.delete(_db.addresses)..where((t) => t.id.equals(addressId)))
        .go();
  }

  @override
  Future<void> setDefaultAddress(int userId, int addressId) async {
    await (_db.update(_db.addresses)..where((t) => t.userId.equals(userId)))
        .write(const AddressesCompanion(isDefault: Value(false)));

    await (_db.update(_db.addresses)..where((t) => t.id.equals(addressId)))
        .write(const AddressesCompanion(isDefault: Value(true)));
  }

  Future<void> _ensureServicesExist() async {
    final existing = await _db.select(_db.cleaningServices).get();
    if (existing.isEmpty) {
      final services = [
        CleaningServicesCompanion.insert(
          name: 'Regular Cleaning',
          description: 'Standard house cleaning for everyday maintenance.',
          price: 50.0,
          duration: '2h',
        ),
        CleaningServicesCompanion.insert(
          name: 'Deep Cleaning',
          description:
              'Thorough cleaning for hard-to-reach places and stubborn dirt.',
          price: 100.0,
          duration: '4h',
        ),
        CleaningServicesCompanion.insert(
          name: 'Post-Construction Cleaning',
          description:
              'Intense cleaning after renovation or construction work.',
          price: 200.0,
          duration: '6h',
        ),
      ];

      for (final service in services) {
        await _db.into(_db.cleaningServices).insert(service);
      }
    }
  }

  @override
  Future<List<CleaningServiceModel>> getCleaningServices() async {
    await _ensureServicesExist();
    final result = await _db.select(_db.cleaningServices).get();
    return result
        .map((s) => CleaningServiceModel(
              id: s.id,
              name: s.name,
              description: s.description,
              price: s.price,
              duration: s.duration,
            ))
        .toList();
  }

  @override
  Future<List<CleaningRequestModel>> getCleaningRequests() async {
    final result = await _db.select(_db.cleaningRequests).get();
    return result.map(_mapRequestToModel).toList();
  }

  @override
  Future<List<CleaningRequestModel>> getUpcomingCleaningRequests() async {
    final upcomingStatuses = [0, 1]; // scheduled, inProgress
    final result = await (_db.select(_db.cleaningRequests)
          ..where((t) => t.status.isIn(upcomingStatuses)))
        .get();
    return result.map(_mapRequestToModel).toList();
  }

  @override
  Future<List<CleaningRequestModel>> getPastCleaningRequests() async {
    final pastStatuses = [2, 3]; // completed, canceled
    final result = await (_db.select(_db.cleaningRequests)
          ..where((t) => t.status.isIn(pastStatuses)))
        .get();
    return result.map(_mapRequestToModel).toList();
  }

  @override
  Future<CleaningRequestModel> createCleaningRequest(
      CleaningRequestModel request) async {
    final id = await _db.into(_db.cleaningRequests).insert(
          CleaningRequestsCompanion.insert(
            userId: _currentUserId ?? 1,
            serviceId: request.serviceId,
            addressId: request.addressId,
            scheduledAt: request.scheduledAt,
            status: request.status,
            cleanerName: Value(request.cleanerName),
            cleanerPhone: Value(request.cleanerPhone),
            cleanerPhotoUrl: Value(request.cleanerPhotoUrl),
          ),
        );

    final inserted = await (_db.select(_db.cleaningRequests)
          ..where((t) => t.id.equals(id)))
        .getSingle();

    return _mapRequestToModel(inserted);
  }

  @override
  Future<void> cancelCleaningRequest(int requestId) async {
    await (_db.update(_db.cleaningRequests)
          ..where((t) => t.id.equals(requestId)))
        .write(
      const CleaningRequestsCompanion(status: Value(3)), // 3 is now 'canceled'
    );
  }

  CleaningRequestModel _mapRequestToModel(CleaningRequestEntry r) {
    return CleaningRequestModel(
      id: r.id,
      serviceId: r.serviceId,
      addressId: r.addressId,
      scheduledAt: r.scheduledAt,
      status: r.status,
      cleanerName: r.cleanerName,
      cleanerPhone: r.cleanerPhone,
      cleanerPhotoUrl: r.cleanerPhotoUrl,
    );
  }
}
