import 'package:core/core.dart';

class CleaningService extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<CleaningType> types;

  const CleaningService({
    required this.id,
    required this.name,
    required this.description,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, description, types];
}

class CleaningType extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final bool isPopular;

  const CleaningType({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    this.isPopular = false,
  });

  @override
  List<Object?> get props => [id, name, description, price, duration, isPopular];
}
