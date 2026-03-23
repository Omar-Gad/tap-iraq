import '../entities/address/user_address.dart';

abstract class AddressRepository {
  Future<List<UserAddress>> getAddresses(int userId);
  Future<UserAddress> addAddress(UserAddress address);
  Future<UserAddress> updateAddress(UserAddress address);
  Future<void> deleteAddress(int addressId);
  Future<void> setDefaultAddress(int userId, int addressId);
}
