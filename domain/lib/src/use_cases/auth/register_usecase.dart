import 'package:domain/domain.dart';

class RegisterUseCase implements FutureUseCase<RegisterParams, AppUser> {
  final AuthRepository _repository;

  RegisterUseCase(AuthRepository repository) : _repository = repository;

  @override
  Future<AppUser> execute(RegisterParams input) async {
    return await _repository.register(input);
  }
}
