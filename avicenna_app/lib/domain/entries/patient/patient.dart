import 'package:avicenna_app/domain/entries/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Patient extends User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String ssn;
  final String email;

  final DateTime birthDate;

  Patient({
    required this.birthDate,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.ssn,
    required this.email,
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
