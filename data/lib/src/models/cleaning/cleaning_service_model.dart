class CleaningServiceModel {
  final int id;
  final String name;
  final String description;
  final List<CleaningTypeModel> types;

  const CleaningServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.types,
  });
}

class CleaningTypeModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final bool isPopular;

  const CleaningTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    this.isPopular = false,
  });
}
