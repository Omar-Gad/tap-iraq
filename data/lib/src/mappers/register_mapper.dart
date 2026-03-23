import 'package:data/data.dart';
import 'package:domain/domain.dart';

class RegisterMapper {
  static RegisterRequest toRequest(RegisterParams params) {
    return RegisterRequest(
      name: params.name,
      login: params.login,
      password: params.password,
    );
  }

  static RegisterParams toParams(RegisterRequest request) {
    return RegisterParams(
      name: request.name,
      login: request.login,
      password: request.password,
    );
  }
}
