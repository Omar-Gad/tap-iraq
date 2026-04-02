import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final int uid;
  @JsonKey(name: 'user_id')
  final int userId;
  final String street;
  final String city;
  final String zipCode;
  final String label;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  AddressModel({
    required this.uid,
    required this.userId,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.label,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
