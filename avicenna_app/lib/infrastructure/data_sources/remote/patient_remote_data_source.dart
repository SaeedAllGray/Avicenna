import 'dart:convert';
import 'dart:developer';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PatientRemoteDataSource implements RemoteDataSource {
  @override
  String url = "patients";
  Dio dio = Dio();

  @override
  Future fetchAnEntity(int id) async {
    log('pp');
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get('${ApiConstants.baseUrl}$url/$id/',
        options: Options(headers: {
          'Authorization': 'Token dcee07d8713c07984e33ef33a17c67ac012cbb1b'
        }));
    log('response.data');

    return response.data;
  }

  @override
  Future fetchEntities() {
    // TODO: implement fetchEntities
    throw UnimplementedError();
  }
}
