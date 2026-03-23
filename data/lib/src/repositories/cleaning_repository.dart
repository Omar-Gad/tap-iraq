import 'package:data/data.dart';
import 'package:data/src/mappers/cleaning_mapper.dart';
import 'package:domain/domain.dart';

class CleaningRepositoryImpl implements CleaningRepository {
  final ApiProvider _apiProvider;

  CleaningRepositoryImpl(this._apiProvider);

  @override
  Future<List<CleaningService>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final models = await _apiProvider.getCleaningServices();
    return models.map(CleaningMapper.entityFromServiceModel).toList();
  }

  @override
  Future<List<CleaningRequest>> getRequests() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final models = await _apiProvider.getCleaningRequests();
    return models.map(CleaningMapper.entityFromRequestModel).toList();
  }

  @override
  Future<List<CleaningRequest>> getUpcomingRequests() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final models = await _apiProvider.getUpcomingCleaningRequests();
    return models.map(CleaningMapper.entityFromRequestModel).toList();
  }

  @override
  Future<List<CleaningRequest>> getPastRequests() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final models = await _apiProvider.getPastCleaningRequests();
    return models.map(CleaningMapper.entityFromRequestModel).toList();
  }

  @override
  Future<CleaningRequest> createRequest(CleaningRequest request) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final model = await _apiProvider.createCleaningRequest(
      CleaningMapper.entityToRequestModel(request),
    );
    return CleaningMapper.entityFromRequestModel(model);
  }

  @override
  Future<void> cancelRequest(int requestId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    await _apiProvider.cancelCleaningRequest(requestId);
  }
}
