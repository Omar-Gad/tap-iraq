import 'package:data/data.dart';
import 'package:domain/domain.dart';

class LoginMapper {
  static LoginRequest toRequest(LoginParams params) {
    return LoginRequest(
      login: params.login,
      password: params.password,
    );
  }

  static LoginParams toParams(LoginRequest request) {
    return LoginParams(
      login: request.login,
      password: request.password,
    );
  }
}
