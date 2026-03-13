import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int uid;
  final String name;
  final String username;

  @JsonKey(name: 'session_id')
  final String sessionId;

  @JsonKey(name: 'company_id')
  final int companyId;

  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.companyId,
    required this.sessionId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
