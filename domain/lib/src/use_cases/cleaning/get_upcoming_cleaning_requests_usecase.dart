import 'package:domain/domain.dart';

class GetUpcomingCleaningRequestsUseCase {
  final CleaningRepository _repository;

  GetUpcomingCleaningRequestsUseCase({required CleaningRepository repository})
      : _repository = repository;

  Future<List<CleaningRequest>> execute() {
    return _repository.getUpcomingRequests();
  }
}
