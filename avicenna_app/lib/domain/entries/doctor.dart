import 'package:avicenna_app/domain/value_objects/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  final UserInfo userInfo;
  final String specialization;

  Doctor({required this.userInfo, required this.specialization});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
