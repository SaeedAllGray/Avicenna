import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Doctor extends AbstractUser {
  final String specialization;
  final String phoneNumber;
  final String address;
  final User user;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Doctor({
    required this.specialization,
    required this.phoneNumber,
    required this.address,
    required this.user,
  });

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
