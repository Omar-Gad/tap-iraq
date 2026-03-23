import 'package:domain/domain.dart';

class GetPastCleaningRequestsUseCase {
  final CleaningRepository _repository;

  GetPastCleaningRequestsUseCase({required CleaningRepository repository})
      : _repository = repository;

  Future<List<CleaningRequest>> execute() {
    return _repository.getPastRequests();
  }
}
