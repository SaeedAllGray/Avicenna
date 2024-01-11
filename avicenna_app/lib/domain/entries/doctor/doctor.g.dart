// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      specialization: json['specialization'] as String,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'specialization': instance.specialization,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'user': instance.user,
    };
