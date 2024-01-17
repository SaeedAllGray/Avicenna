import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Patient extends AbstractUser {
  final String ssn;
  final String dateBorn;
  final User user;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Patient({required this.ssn, required this.dateBorn, required this.user});

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
