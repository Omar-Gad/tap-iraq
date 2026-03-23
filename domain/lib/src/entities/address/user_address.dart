import 'package:core/core.dart';

enum PropertyType {
  villa,
  apartment,
}

enum PropertySize {
  small,
  medium,
  large,
}

class UserAddress extends Equatable {
  final int? id;
  final int userId;
  final String street;
  final PropertyType propertyType;
  final PropertySize propertySize;
  final bool isDefault;

  const UserAddress({
    this.id,
    required this.userId,
    required this.street,
    required this.propertyType,
    required this.propertySize,
    required this.isDefault,
  });

  UserAddress copyWith({
    int? id,
    int? userId,
    String? street,
    PropertyType? propertyType,
    PropertySize? propertySize,
    bool? isDefault,
  }) {
    return UserAddress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      street: street ?? this.street,
      propertyType: propertyType ?? this.propertyType,
      propertySize: propertySize ?? this.propertySize,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'street': street,
      'propertyType': propertyType.index,
      'propertySize': propertySize.index,
      'isDefault': isDefault,
    };
  }

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      id: map['id'] as int?,
      userId: map['userId'] as int,
      street: map['street'] as String,
      propertyType: PropertyType.values[map['propertyType'] as int],
      propertySize: PropertySize.values[map['propertySize'] as int],
      isDefault: map['isDefault'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserAddress(id: $id, userId: $userId, street: $street, propertyType: $propertyType, propertySize: $propertySize, isDefault: $isDefault)';
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        street,
        propertyType,
        propertySize,
        isDefault,
      ];
}
