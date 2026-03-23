import '../entities/cleaning/cleaning_service.dart';
import '../entities/cleaning/cleaning_request.dart';

abstract class CleaningRepository {
  Future<List<CleaningService>> getServices();
  Future<List<CleaningRequest>> getRequests();
  Future<List<CleaningRequest>> getUpcomingRequests();
  Future<List<CleaningRequest>> getPastRequests();
  Future<CleaningRequest> createRequest(CleaningRequest request);
  Future<void> cancelRequest(int requestId);
}
