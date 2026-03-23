import '../../repositories/cleaning_repository.dart';
import '../../entities/cleaning/cleaning_request.dart';
import '../usecase.dart';

class CreateCleaningRequestUseCase extends FutureUseCase<CleaningRequest, CleaningRequest> {
  final CleaningRepository _repository;

  CreateCleaningRequestUseCase({required CleaningRepository repository})
      : _repository = repository;

  @override
  Future<CleaningRequest> execute(CleaningRequest input) {
    return _repository.createRequest(input);
  }
}
