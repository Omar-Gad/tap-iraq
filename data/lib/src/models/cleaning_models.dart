class CleaningServiceModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String duration;

  const CleaningServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });
}

class CleaningRequestModel {
  final int? id;
  final int serviceId;
  final int addressId;
  final DateTime scheduledAt;
  final int status;
  final String? cleanerName;
  final String? cleanerPhone;
  final String? cleanerPhotoUrl;

  const CleaningRequestModel({
    this.id,
    required this.serviceId,
    required this.addressId,
    required this.scheduledAt,
    required this.status,
    this.cleanerName,
    this.cleanerPhone,
    this.cleanerPhotoUrl,
  });
}
