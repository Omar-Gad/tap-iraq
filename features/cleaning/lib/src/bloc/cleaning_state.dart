import 'package:equatable/equatable.dart';
import 'package:domain/domain.dart';

abstract class CleaningState extends Equatable {
  const CleaningState();

  @override
  List<Object?> get props => [];
}

class CleaningInitial extends CleaningState {}

class CleaningLoading extends CleaningState {}

class CleaningLoaded extends CleaningState {
  final List<CleaningService> services;
  final List<CleaningRequest> requests;

  const CleaningLoaded({
    required this.services,
    required this.requests,
  });

  @override
  List<Object?> get props => [services, requests];

  CleaningLoaded copyWith({
    List<CleaningService>? services,
    List<CleaningRequest>? requests,
  }) {
    return CleaningLoaded(
      services: services ?? this.services,
      requests: requests ?? this.requests,
    );
  }
}

class CleaningError extends CleaningState {
  final String message;

  const CleaningError(this.message);

  @override
  List<Object?> get props => [message];
}
