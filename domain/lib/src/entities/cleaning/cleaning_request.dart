import 'package:core/core.dart';

enum CleaningRequestStatus {
  scheduled,
  inProgress,
  completed,
  canceled,
}

class CleanerInfo extends Equatable {
  final String name;
  final String phone;
  final String? photoUrl;

  const CleanerInfo({
    required this.name,
    required this.phone,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [name, phone, photoUrl];
}

class CleaningRequest extends Equatable {
  final int? id;
  final int serviceId;
  final int addressId;
  final DateTime scheduledAt;
  final CleaningRequestStatus status;
  final CleanerInfo? assignedCleaner;

  const CleaningRequest({
    this.id,
    required this.serviceId,
    required this.addressId,
    required this.scheduledAt,
    required this.status,
    this.assignedCleaner,
  });

  CleaningRequest copyWith({
    int? id,
    int? serviceId,
    int? addressId,
    DateTime? scheduledAt,
    CleaningRequestStatus? status,
    CleanerInfo? assignedCleaner,
  }) {
    return CleaningRequest(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      addressId: addressId ?? this.addressId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      assignedCleaner: assignedCleaner ?? this.assignedCleaner,
    );
  }

  @override
  String toString() {
    return 'CleaningRequest(id: $id, serviceId: $serviceId, addressId: $addressId, scheduledAt: $scheduledAt, status: $status, assignedCleaner: $assignedCleaner)';
  }

  @override
  List<Object?> get props => [
        id,
        serviceId,
        addressId,
        scheduledAt,
        status,
        assignedCleaner,
      ];
}
