import 'dart:async';
import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/patient/patient.dart';
import 'package:avicenna_app/domain/entries/user.dart';
import 'package:avicenna_app/domain/entries/user/user.dart';

import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthDataSource {
  Dio dio = Dio();
  AuthDataSource() {
    dio.interceptors.add(PrettyDioLogger());
  }
  FutureOr<Response> login(String username, String password) async {
    Response response = await dio.post('${ApiConstants.baseUrl}api-token-auth/',
        data: {"username": username, "password": password});
    return response;
  }

  Future<Response> deleteUser(int id, String token) async {
    late Response response;
    dio.interceptors.add(PrettyDioLogger());

    try {
      response = await dio.delete(
        '${ApiConstants.baseUrl}custom-users/$id/',
        options: Options(
          headers: {'Authorization': 'Token ${ApiConstants.getToken}'},
        ),
      );
    } catch (e) {
      print(e);
    }
    return response;
  }

  FutureOr<Response> signupDoctor(Doctor doctor) async {
    Response response = await dio.post('${ApiConstants.baseUrl}create-doctors/',
        data: doctor.toJson()..addAll({"user_id": doctor.user.id}));
    return response;
  }

  FutureOr<Response> signupPatient(Patient patient) async {
    Response response = await dio.post(
        '${ApiConstants.baseUrl}create-patients/',
        data: patient.toJson()..addAll({"user_id": patient.user.id}));
    return response;
  }

  FutureOr<Response> createUser(User user, String password) async {
    Response response = await dio.post(
        '${ApiConstants.baseUrl}create-custom-users/',
        data: user.toJson()..addAll({"password": password}));
    return response;
  }
}
