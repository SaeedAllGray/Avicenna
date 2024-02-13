import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DoctorRemoteDataSource implements RemoteDataSource {
  @override
  String url = ApiConstants.DOCTOR;
  Dio dio = Dio();

  @override
  Future<List<dynamic>> fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get('${ApiConstants.baseUrl}$url',
        options: Options(
            headers: {'Authorization': 'Token ${ApiConstants.getToken}'}));

    return response.data['results'];
  }

  @override
  Future<dynamic> fetchAnEntity(int id) async {
    Response response = await dio.get('${ApiConstants.baseUrl}$url/$id',
        options: Options(
            headers: {'Authorization': 'Token ${ApiConstants.getToken}'}));

    return response.data;
  }
}
