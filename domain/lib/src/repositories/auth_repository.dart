import 'package:domain/domain.dart';

abstract class AuthRepository {
  Future<AppUser> login(LoginParams params);

  Future<AppUser> register(RegisterParams params);

  Future<bool> checkSession();

  Future<void> logout();
}
