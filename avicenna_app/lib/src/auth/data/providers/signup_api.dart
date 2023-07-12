import 'dart:async';

import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:avicenna_app/src/models/doctor.dart';

import 'package:avicenna_app/src/models/patient.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

class SignupApi {
  // FutureOr<Response<dynamic>> signUpDoctor(
  //     Doctor doctor, String password) async {
  //   Dio dio = Dio();
  //   dio.interceptors.add(PrettyDioLogger());

  //   Response response = await dio.get(
  //     '${ApiConstants.baseUrl}create-user/doctor/${doctor.username}/$password/${doctor.firstname}/${doctor.lastname}/${doctor.email}/<str:phone_number>/<str:specialization>/<str:address>/',
  //   );
  //   return response.statusCode == 200;
  // }

  FutureOr<bool> signUpPatient(Patient patient, String password) async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.baseUrl}create-user/patient/${patient.username}/$password/${patient.firstname}/${patient.lastname}/${patient.email}/${patient.socialSecurityNumber}/',
    );
    return response.statusCode == 200;
  }
}
