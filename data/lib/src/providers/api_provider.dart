import 'package:data/src/models/models.dart';

abstract class ApiProvider {
  Future<UserModel> login(LoginRequest request);

  Future<UserModel> register(RegisterRequest request);

  Future<bool> checkSession();

  Future<void> logout();
}
