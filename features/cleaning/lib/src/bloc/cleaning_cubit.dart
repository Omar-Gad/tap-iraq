import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/domain.dart';
import 'cleaning_state.dart';

class CleaningCubit extends Cubit<CleaningState> {
  final GetCleaningServicesUseCase _getServices;
  final GetCleaningRequestsUseCase _getRequests;
  final CreateCleaningRequestUseCase _createRequest;
  final CancelCleaningRequestUseCase _cancelRequest;

  CleaningCubit({
    required GetCleaningServicesUseCase getServices,
    required GetCleaningRequestsUseCase getRequests,
    required CreateCleaningRequestUseCase createRequest,
    required CancelCleaningRequestUseCase cancelRequest,
  })  : _getServices = getServices,
        _getRequests = getRequests,
        _createRequest = createRequest,
        _cancelRequest = cancelRequest,
        super(CleaningInitial());

  Future<void> fetchCleaningData() async {
    emit(CleaningLoading());
    try {
      final services = await _getServices.execute(const NoParams());
      final requests = await _getRequests.execute(const NoParams());
      emit(CleaningLoaded(services: services, requests: requests));
    } catch (e) {
      emit(CleaningError(e.toString()));
    }
  }

  Future<void> createRequest(CleaningRequest request) async {
    if (state is! CleaningLoaded) return;
    final currentState = state as CleaningLoaded;

    try {
      final newRequest = await _createRequest.execute(request);
      emit(currentState.copyWith(
        requests: [newRequest, ...currentState.requests],
      ));
    } catch (e) {
      emit(CleaningError(e.toString()));
    }
  }

  Future<void> cancelRequest(int requestId) async {
    if (state is! CleaningLoaded) return;
    final currentState = state as CleaningLoaded;

    try {
      await _cancelRequest.execute(requestId);
      final updatedRequests = currentState.requests.map((r) {
        if (r.id == requestId) {
          return CleaningRequest(
            id: r.id,
            serviceId: r.serviceId,
            addressId: r.addressId,
            scheduledAt: r.scheduledAt,
            status: CleaningRequestStatus.canceled,
            assignedCleaner: r.assignedCleaner,
          );
        }
        return r;
      }).toList();
      emit(currentState.copyWith(requests: updatedRequests));
    } catch (e) {
      emit(CleaningError(e.toString()));
    }
  }
}
