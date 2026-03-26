import '../../repositories/cleaning_repository.dart';
import '../../entities/cleaning/cleaning_service.dart';
import '../usecase.dart';

class GetCleaningServicesUseCase extends FutureUseCase<NoParams, List<CleaningService>> {
  final CleaningRepository _repository;

  GetCleaningServicesUseCase({required CleaningRepository repository})
      : _repository = repository;

  @override
  Future<List<CleaningService>> execute(NoParams input) {
    return _repository.getServices();
  }
}
