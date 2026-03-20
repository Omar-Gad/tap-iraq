import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final int uid;
  @JsonKey(name: 'user_id')
  final int userId;
  final String street;
  @JsonKey(name: 'property_type')
  final int propertyType;
  @JsonKey(name: 'property_size')
  final int propertySize;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  AddressModel({
    required this.uid,
    required this.userId,
    required this.street,
    required this.propertyType,
    required this.propertySize,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
