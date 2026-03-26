class CleaningRequestModel {
  final int? id;
  final int serviceId;
  final int typeId;
  final int addressId;
  final DateTime scheduledAt;
  final int status;
  final String? cleanerName;
  final String? cleanerPhone;
  final String? cleanerPhotoUrl;

  const CleaningRequestModel({
    this.id,
    required this.serviceId,
    required this.typeId,
    required this.addressId,
    required this.scheduledAt,
    required this.status,
    this.cleanerName,
    this.cleanerPhone,
    this.cleanerPhotoUrl,
  });
}
