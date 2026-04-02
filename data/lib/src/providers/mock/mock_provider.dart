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

    // Deactivate all other sessions first
    await (_db.update(_db.users))
        .write(const UsersCompanion(isSessionActive: Value(false)));

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

    // Deactivate all other sessions first
    await (_db.update(_db.users))
        .write(const UsersCompanion(isSessionActive: Value(false)));

    final id = await _db.into(_db.users).insert(
          UsersCompanion.insert(
            name: request.name,
            login: request.login,
            password: request.password,
            phone: Value(request.phone),
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
    // Safely look for any active session
    final activeUsers = await (_db.select(_db.users)
          ..where((t) => t.isSessionActive.equals(true)))
        .get();

    if (activeUsers.isNotEmpty) {
      final activeUser = activeUsers.first;
      _currentUserId = activeUser.id;
      return true;
    }

    return false;
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
    await _ensureAddressesExist(userId);
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
            city: Value(address.city),
            zipCode: Value(address.zipCode),
            label: Value(address.label),
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
        city: Value(address.city),
        zipCode: Value(address.zipCode),
        label: Value(address.label),
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

  Future<void> _ensureAddressesExist(int userId) async {
    final existing = await (_db.select(_db.addresses)
          ..where((t) => t.userId.equals(userId)))
        .get();
    if (existing.isEmpty) {
      await _db.into(_db.addresses).insert(AddressesCompanion.insert(
            userId: userId,
            street: 'Al Mansour, District 601',
            city: const Value('Baghdad'),
            zipCode: const Value('10011'),
            label: const Value('Home'),
            isDefault: const Value(true),
          ));
      await _db.into(_db.addresses).insert(AddressesCompanion.insert(
            userId: userId,
            street: 'Karrada, Al-Atfiyah',
            city: const Value('Baghdad'),
            zipCode: const Value('10001'),
            label: const Value('Office'),
            isDefault: const Value(false),
          ));
      await _db.into(_db.addresses).insert(AddressesCompanion.insert(
            userId: userId,
            street: 'Jadriya, University St.',
            city: const Value('Baghdad'),
            zipCode: const Value('10071'),
            label: const Value('Parents Home'),
            isDefault: const Value(false),
          ));
      await _db.into(_db.addresses).insert(AddressesCompanion.insert(
            userId: userId,
            street: 'Zayouna, Near Mall',
            city: const Value('Baghdad'),
            zipCode: const Value('10044'),
            label: const Value('Gym'),
            isDefault: const Value(false),
          ));
    }
  }



  Future<void> _ensureServicesExist() async {
    final existing = await _db.select(_db.cleaningServices).get();
    if (existing.isEmpty) {
      // 1. Home Cleaning
      final homeId = await _db.into(_db.cleaningServices).insert(
            CleaningServicesCompanion.insert(
              name: 'Home Cleaning',
              description: 'Professional cleaning for your house or apartment.',
            ),
          );

      await _db.batch((b) => b.insertAll(_db.cleaningTypes, [
            CleaningTypesCompanion.insert(
              serviceId: homeId,
              name: 'Standard',
              description: 'Regular maintenance cleaning.',
              price: 45000.0,
              duration: '2-3 hours',
              isPopular: const Value(true),
            ),
            CleaningTypesCompanion.insert(
              serviceId: homeId,
              name: 'Deep Cleaning',
              description:
                  'Complete home deep cleaning with all areas covered.',
              price: 75000.0,
              duration: '4-5 hours',
              isPopular: const Value(false),
            ),
            CleaningTypesCompanion.insert(
              serviceId: homeId,
              name: 'Eco Cleaning',
              description: 'Using only environmentally friendly materials.',
              price: 55000.0,
              duration: '2-3 hours',
              isPopular: const Value(false),
            ),
            CleaningTypesCompanion.insert(
              serviceId: homeId,
              name: 'Pet-Friendly',
              description: 'Special attention to pet hair and allergens.',
              price: 50000.0,
              duration: '3-4 hours',
              isPopular: const Value(false),
            ),
          ]));

      // 2. Window Cleaning
      final windowId = await _db.into(_db.cleaningServices).insert(
            CleaningServicesCompanion.insert(
              name: 'Window Cleaning',
              description: 'Crystal clear finish for your windows and mirrors.',
            ),
          );

      await _db.batch((b) => b.insertAll(_db.cleaningTypes, [
            CleaningTypesCompanion.insert(
              serviceId: windowId,
              name: 'Regular Windows',
              description: 'Cleaning of standard window panes.',
              price: 15000.0,
              duration: '1-2 hours',
              isPopular: const Value(true),
            ),
            CleaningTypesCompanion.insert(
              serviceId: windowId,
              name: 'High Rise',
              description: 'Specialized cleaning for windows above 2nd floor.',
              price: 45000.0,
              duration: '2-4 hours',
              isPopular: const Value(false),
            ),
          ]));

      // 3. Specialized
      final specId = await _db.into(_db.cleaningServices).insert(
            CleaningServicesCompanion.insert(
              name: 'Specialized Cleaning',
              description: 'Heavy duty or specific material cleaning.',
            ),
          );

      await _db.batch((b) => b.insertAll(_db.cleaningTypes, [
            CleaningTypesCompanion.insert(
              serviceId: specId,
              name: 'Post-Construction',
              description: 'Heavy duty cleaning after renovation.',
              price: 120000.0,
              duration: '6-8 hours',
              isPopular: const Value(false),
            ),
            CleaningTypesCompanion.insert(
              serviceId: specId,
              name: 'Carpet Cleaning',
              description: 'Professional steam cleaning for all carpets.',
              price: 35000.0,
              duration: '1-2 hours',
              isPopular: const Value(true),
            ),
          ]));
    }
  }

  @override
  Future<List<CleaningServiceModel>> getCleaningServices() async {
    await _ensureServicesExist();
    final services = await _db.select(_db.cleaningServices).get();

    final List<CleaningServiceModel> result = [];
    for (final s in services) {
      final types = await (_db.select(_db.cleaningTypes)
            ..where((t) => t.serviceId.equals(s.id)))
          .get();
      result.add(CleaningServiceModel(
        id: s.id,
        name: s.name,
        description: s.description,
        types: types
            .map((t) => CleaningTypeModel(
                  id: t.id,
                  name: t.name,
                  description: t.description,
                  price: t.price,
                  duration: t.duration,
                  isPopular: t.isPopular,
                ))
            .toList(),
      ));
    }
    return result;
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
            typeId: request.typeId,
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
      typeId: r.typeId,
      addressId: r.addressId,
      scheduledAt: r.scheduledAt,
      status: r.status,
      cleanerName: r.cleanerName,
      cleanerPhone: r.cleanerPhone,
      cleanerPhotoUrl: r.cleanerPhotoUrl,
    );
  }
}
