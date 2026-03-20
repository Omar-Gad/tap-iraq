import 'package:data/src/models/models.dart';

abstract class ApiProvider {
  // Auth
  Future<UserModel> login(LoginRequest request);
  Future<UserModel> register(RegisterRequest request);
  Future<bool> checkSession();
  Future<void> logout();

  // Addresses
  Future<List<AddressModel>> getAddresses(int userId);
  Future<AddressModel> addAddress(AddressModel address);
  Future<AddressModel> updateAddress(AddressModel address);
  Future<void> deleteAddress(int addressId);
  Future<void> setDefaultAddress(int userId, int addressId);
}
