import 'package:core/core.dart';

class CleaningService extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final String duration; // e.g. "2-3 hours"

  const CleaningService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  CleaningService copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? duration,
  }) {
    return CleaningService(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'CleaningService(id: $id, name: $name, description: $description, price: $price, duration: $duration)';
  }

  @override
  List<Object?> get props => [id, name, description, price, duration];
}
