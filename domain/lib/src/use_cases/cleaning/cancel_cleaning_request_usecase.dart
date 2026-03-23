import '../../repositories/cleaning_repository.dart';
import '../usecase.dart';

class CancelCleaningRequestUseCase extends FutureUseCase<int, void> {
  final CleaningRepository _repository;

  CancelCleaningRequestUseCase({required CleaningRepository repository})
      : _repository = repository;

  @override
  Future<void> execute(int input) {
    return _repository.cancelRequest(input);
  }
}
