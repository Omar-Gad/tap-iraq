import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/domain.dart';
import 'cleaning_state.dart';

class CleaningCubit extends Cubit<CleaningState> {
  final GetCleaningServicesUseCase _getServices;
  final GetAddressesUseCase _getAddresses;
  final CreateCleaningRequestUseCase _createRequest;

  CleaningCubit({
    required GetCleaningServicesUseCase getServices,
    required GetAddressesUseCase getAddresses,
    required CreateCleaningRequestUseCase createRequest,
    required CancelCleaningRequestUseCase cancelRequest,
  })  : _getServices = getServices,
        _getAddresses = getAddresses,
        _createRequest = createRequest,
        super(CleaningInitial());

  Future<void> fetchBookingData(int userId) async {
    emit(CleaningLoading());
    try {
      final services = await _getServices.execute(const NoParams());
      final addresses = await _getAddresses.execute(userId);
      
      UserAddress? defaultAddress;
      try {
        defaultAddress = addresses.firstWhere((a) => a.isDefault);
      } catch (_) {
        if (addresses.isNotEmpty) defaultAddress = addresses.first;
      }

      emit(CleaningLoaded(
        services: services,
        addresses: addresses,
        selectedAddress: defaultAddress,
      ));
    } catch (e) {
      emit(CleaningError(e.toString()));
    }
  }

  void selectService(CleaningService service) {
    if (state is! CleaningLoaded) return;
    emit((state as CleaningLoaded).copyWith(
      selectedService: service,
      clearType: true,
    ));
  }

  void selectType(CleaningType type) {
    if (state is! CleaningLoaded) return;
    emit((state as CleaningLoaded).copyWith(selectedType: type));
  }

  void selectAddress(UserAddress address) {
    if (state is! CleaningLoaded) return;
    emit((state as CleaningLoaded).copyWith(selectedAddress: address));
  }

  void selectDate(DateTime date) {
    if (state is! CleaningLoaded) return;
    emit((state as CleaningLoaded).copyWith(selectedDate: date));
  }

  void selectTime(TimeOfDay time) {
    if (state is! CleaningLoaded) return;
    emit((state as CleaningLoaded).copyWith(selectedTime: time));
  }

  Future<void> placeOrder() async {
    if (state is! CleaningLoaded) return;
    final s = state as CleaningLoaded;

    if (s.selectedService == null || s.selectedType == null || s.selectedAddress == null || s.selectedDate == null || s.selectedTime == null) {
      emit(const CleaningError('Please select all required booking options.'));
      // Restore state after error? No, let UI handle error display
      return;
    }

    final scheduledAt = DateTime(
      s.selectedDate!.year,
      s.selectedDate!.month,
      s.selectedDate!.day,
      s.selectedTime!.hour,
      s.selectedTime!.minute,
    );

    try {
      final request = CleaningRequest(
        serviceId: s.selectedService!.id,
        typeId: s.selectedType!.id,
        addressId: s.selectedAddress!.id!,
        scheduledAt: scheduledAt,
        status: CleaningRequestStatus.scheduled,
      );
      
      await _createRequest.execute(request);
      
      // Navigate or show success? For now, re-emit loaded with success?
      // Actually, I'll just re-load for simplicity in this mock
      emit(CleaningInitial());
      await fetchBookingData(s.selectedAddress!.userId);
    } catch (e) {
      emit(CleaningError(e.toString()));
    }
  }
}
