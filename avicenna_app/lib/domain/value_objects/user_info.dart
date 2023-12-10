import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String? email;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
