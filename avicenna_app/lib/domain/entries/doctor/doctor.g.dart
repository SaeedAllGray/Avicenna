// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String,
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userName: json['user_name'] as String,
      ssn: json['ssn'] as String,
      email: json['email'] as String,
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_name': instance.userName,
      'ssn': instance.ssn,
      'email': instance.email,
      'specialization': instance.specialization,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
    };
