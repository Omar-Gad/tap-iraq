import 'package:domain/domain.dart';

class SignOutUseCase implements FutureUseCase<NoParams, void> {
  final AuthRepository _repository;

  SignOutUseCase(AuthRepository repository) : _repository = repository;

  @override
  Future<void> execute(NoParams input) async {
    return await _repository.logout();
  }
}
