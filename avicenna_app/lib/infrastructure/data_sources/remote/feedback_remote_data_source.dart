import 'dart:convert';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FeedbackRemoteDataSource implements RemoteDataSource {
  @override
  String url = "reviews";
  Dio dio = Dio();

  @override
  Future<List<dynamic>> fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get('${ApiConstants.baseUrl}$url',
        options: Options(
            headers: {'Authorization': 'Token ${ApiConstants.getToken}'}));

    return response.data['results'];
  }

  Future<List<dynamic>> fetchUserEntities(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
        '${ApiConstants.baseUrl}$url/?user_id=$id',
        options: Options(
            headers: {'Authorization': 'Token ${ApiConstants.getToken}'}));

    return response.data['results'];
  }

  Future<dynamic> createEntity(Map<String, dynamic> data) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.post(
      '${ApiConstants.baseUrl}$url/',
      data: data,
      options:
          Options(headers: {'Authorization': 'Token ${ApiConstants.getToken}'}),
    );
    return response.data;
  }

  @override
  Future fetchAnEntity(int id) async {
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url/$id',
    );
    return response.data;
  }
}
