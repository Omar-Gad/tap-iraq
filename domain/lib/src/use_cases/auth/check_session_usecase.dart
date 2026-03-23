import 'package:domain/domain.dart';

class CheckSessionUseCase implements FutureUseCase<NoParams, bool> {
  final AuthRepository _repository;

  CheckSessionUseCase(AuthRepository repository) : _repository = repository;

  @override
  Future<bool> execute(NoParams input) async {
    return await _repository.checkSession();
  }
}
