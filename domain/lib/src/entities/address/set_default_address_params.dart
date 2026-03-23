import 'package:core/core.dart';

class SetDefaultAddressParams extends Equatable {
  final int userId;
  final int addressId;

  const SetDefaultAddressParams({
    required this.userId,
    required this.addressId,
  });

  SetDefaultAddressParams copyWith({
    int? userId,
    int? addressId,
  }) {
    return SetDefaultAddressParams(
      userId: userId ?? this.userId,
      addressId: addressId ?? this.addressId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'addressId': addressId,
    };
  }

  factory SetDefaultAddressParams.fromMap(Map<String, dynamic> map) {
    return SetDefaultAddressParams(
      userId: map['userId'] as int,
      addressId: map['addressId'] as int,
    );
  }

  @override
  String toString() {
    return 'SetDefaultAddressParams(userId: $userId, addressId: $addressId)';
  }

  @override
  List<Object?> get props => [userId, addressId];
}
