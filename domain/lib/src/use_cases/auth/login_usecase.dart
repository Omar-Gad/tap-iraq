import 'package:domain/domain.dart';

class LoginUseCase implements FutureUseCase<LoginParams, AppUser> {
  final AuthRepository _repository;

  LoginUseCase(AuthRepository repository) : _repository = repository;

  @override
  Future<AppUser> execute(LoginParams input) async {
    return await _repository.login(input);
  }
}
