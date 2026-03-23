import 'package:data/data.dart';
import 'package:data/src/mappers/address_mapper.dart';
import 'package:domain/domain.dart';

class AddressRepositoryImpl implements AddressRepository {
  final ApiProvider _apiProvider;

  AddressRepositoryImpl(this._apiProvider);

  @override
  Future<List<UserAddress>> getAddresses(int userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final models = await _apiProvider.getAddresses(userId);
    return models.map(AddressMapper.fromDtoToEntity).toList();
  }

  @override
  Future<UserAddress> addAddress(UserAddress address) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final model = await _apiProvider.addAddress(
      AddressMapper.toDto(address),
    );

    if (address.isDefault) {
      await setDefaultAddress(address.userId, model.uid);
    }

    return AddressMapper.fromDtoToEntity(model);
  }

  @override
  Future<UserAddress> updateAddress(UserAddress address) async {
    if (address.id == null) {
      throw Exception('Address id is required for update');
    }
    await Future.delayed(const Duration(milliseconds: 800));

    final model = await _apiProvider.updateAddress(
      AddressMapper.toDto(address),
    );

    if (address.isDefault) {
      await setDefaultAddress(address.userId, address.id!);
    }

    return AddressMapper.fromDtoToEntity(model);
  }

  @override
  Future<void> deleteAddress(int addressId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    await _apiProvider.deleteAddress(addressId);
  }

  @override
  Future<void> setDefaultAddress(int userId, int addressId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    await _apiProvider.setDefaultAddress(userId, addressId);
  }
}
