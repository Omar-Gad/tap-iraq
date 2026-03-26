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
  final int typeId;
  final int addressId;
  final DateTime scheduledAt;
  final CleaningRequestStatus status;
  final CleanerInfo? assignedCleaner;

  const CleaningRequest({
    this.id,
    required this.serviceId,
    required this.typeId,
    required this.addressId,
    required this.scheduledAt,
    required this.status,
    this.assignedCleaner,
  });

  CleaningRequest copyWith({
    int? id,
    int? serviceId,
    int? typeId,
    int? addressId,
    DateTime? scheduledAt,
    CleaningRequestStatus? status,
    CleanerInfo? assignedCleaner,
  }) {
    return CleaningRequest(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      typeId: typeId ?? this.typeId,
      addressId: addressId ?? this.addressId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      assignedCleaner: assignedCleaner ?? this.assignedCleaner,
    );
  }

  @override
  String toString() {
    return 'CleaningRequest(id: $id, serviceId: $serviceId, typeId: $typeId, addressId: $addressId, scheduledAt: $scheduledAt, status: $status, assignedCleaner: $assignedCleaner)';
  }

  @override
  List<Object?> get props => [
        id,
        serviceId,
        typeId,
        addressId,
        scheduledAt,
        status,
        assignedCleaner,
      ];
}
