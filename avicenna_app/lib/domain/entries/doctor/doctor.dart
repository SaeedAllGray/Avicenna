import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String specialization;
  final String phoneNumber;
  final String address;

  Doctor({
    required this.phoneNumber,
    required this.address,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.specialization,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
