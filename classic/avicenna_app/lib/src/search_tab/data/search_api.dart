import 'dart:convert';
import 'dart:developer';

import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SearchApi {
  Future<List<Doctor>> getAllDoctors() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.baseUrl}get-all-doctors/',
    );
    log(response.data);
    List<Doctor> doctors = (jsonDecode(response.data) as List)
        .map((e) => Doctor.fromJson(e))
        .toList();
    return doctors;
  }
}
