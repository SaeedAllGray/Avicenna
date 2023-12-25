// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      birthDate: DateTime.parse(json['birth_date'] as String),
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userName: json['user_name'] as String,
      ssn: json['ssn'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_name': instance.userName,
      'ssn': instance.ssn,
      'email': instance.email,
      'birth_date': instance.birthDate.toIso8601String(),
    };
