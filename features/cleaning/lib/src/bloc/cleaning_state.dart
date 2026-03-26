import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

abstract class CleaningState extends Equatable {
  const CleaningState();

  @override
  List<Object?> get props => [];
}

class CleaningInitial extends CleaningState {}

class CleaningLoading extends CleaningState {}

class CleaningLoaded extends CleaningState {
  final List<CleaningService> services;
  final List<UserAddress> addresses;
  final CleaningService? selectedService;
  final CleaningType? selectedType;
  final UserAddress? selectedAddress;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const CleaningLoaded({
    required this.services,
    required this.addresses,
    this.selectedService,
    this.selectedType,
    this.selectedAddress,
    this.selectedDate,
    this.selectedTime,
  });

  @override
  List<Object?> get props => [
        services,
        addresses,
        selectedService,
        selectedType,
        selectedAddress,
        selectedDate,
        selectedTime,
      ];

  CleaningLoaded copyWith({
    List<CleaningService>? services,
    List<UserAddress>? addresses,
    CleaningService? selectedService,
    CleaningType? selectedType,
    UserAddress? selectedAddress,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    bool clearService = false,
    bool clearType = false,
    bool clearAddress = false,
    bool clearDate = false,
    bool clearTime = false,
  }) {
    return CleaningLoaded(
      services: services ?? this.services,
      addresses: addresses ?? this.addresses,
      selectedService: clearService ? null : (selectedService ?? this.selectedService),
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      selectedAddress: clearAddress ? null : (selectedAddress ?? this.selectedAddress),
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
    );
  }
}

class CleaningError extends CleaningState {
  final String message;

  const CleaningError(this.message);

  @override
  List<Object?> get props => [message];
}
