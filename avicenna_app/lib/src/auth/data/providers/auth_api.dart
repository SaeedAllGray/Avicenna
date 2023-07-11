import 'dart:async';

import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

class AuthApi {
  FutureOr<Response<dynamic>> login(String username, String password) async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.get(
      '${ApiConstants.baseUrl}login/$username/$password',
    );
    return response;
  }
}
