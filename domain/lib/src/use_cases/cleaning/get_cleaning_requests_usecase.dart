import '../../repositories/cleaning_repository.dart';
import '../../entities/cleaning/cleaning_request.dart';
import '../usecase.dart';

class GetCleaningRequestsUseCase extends FutureUseCase<NoParams, List<CleaningRequest>> {
  final CleaningRepository _repository;

  GetCleaningRequestsUseCase({required CleaningRepository repository})
      : _repository = repository;

  @override
  Future<List<CleaningRequest>> execute(NoParams input) {
    return _repository.getRequests();
  }
}
