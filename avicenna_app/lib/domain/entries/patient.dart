import 'package:avicenna_app/domain/value_objects/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  final UserInfo userInfo;
  final DateTime birthDate;

  Patient({required this.userInfo, required this.birthDate});

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
