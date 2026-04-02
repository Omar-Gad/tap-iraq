import 'package:core/core.dart';

class UserAddress extends Equatable {
  final int? id;
  final int userId;
  final String label;
  final String street;
  final String city;
  final String zipCode;
  final bool isDefault;

  const UserAddress({
    this.id,
    required this.userId,
    required this.street,
    required this.isDefault,
    required this.city,
    required this.label,
    required this.zipCode,
  });

  UserAddress copyWith({
    int? id,
    int? userId,
    String? street,
    bool? isDefault,
    String? city,
    String? label,
    String? zipCode,
  }) {
    return UserAddress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      street: street ?? this.street,
      isDefault: isDefault ?? this.isDefault,
      city: city ?? this.city,
      label: label ?? this.label,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'label': label,
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'isDefault': isDefault,
    };
  }

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      id: map['id'] as int?,
      userId: map['userId'] as int,
      label: map['label'] as String,
      street: map['street'] as String,
      city: map['city'] as String,
      zipCode: map['zipCode'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserAddress(id: $id, userId: $userId, label: $label, street: $street, city: $city, zipCode: $zipCode, isDefault: $isDefault)';
  }


  @override
  List<Object?> get props => [
        id,
        userId,
        street,
        isDefault,
        city,
        label,
        zipCode,
      ];
}
