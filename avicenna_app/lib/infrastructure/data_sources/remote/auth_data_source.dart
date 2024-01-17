import 'dart:async';
import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';

import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthDataSource {
  Dio dio = Dio();
  AuthDataSource() {
    dio.interceptors.add(PrettyDioLogger());
  }
  FutureOr<Response> login(String username, String password) async {
    late Response response1;
    try {
      Response response = await dio.post(
          '${ApiConstants.baseUrl}api-token-auth/',
          data: {"username": username, "password": password});
      response1 = response;
    } catch (e) {
      log(e.toString());
    }
    return response1;
  }

  FutureOr<Response> signupDoctor(Doctor doctor) async {
    Response response =
        await dio.post('${ApiConstants.baseUrl}/signup', data: doctor.toJson());
    return response;
  }

  FutureOr<Response> signupPatient(Patient patient) async {
    Response response = await dio.post('${ApiConstants.baseUrl}/signup',
        data: patient.toJson());
    return response;
  }

  FutureOr<Response> signup(AbstractUser user) async {
    if (user is Doctor) {
      Response response = await signupDoctor(user);
      return response;
    } else {
      Response response = await signupPatient(user as Patient);
      return response;
    }
  }
}
