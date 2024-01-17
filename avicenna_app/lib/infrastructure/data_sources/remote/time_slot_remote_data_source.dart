import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TimeSlotRemoteDataSource implements RemoteDataSource {
  @override
  String url = "time-slots";
  Dio dio = Dio();

  @override
  Future<List<dynamic>> fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url',
    );

    return response.data;
  }

  Future<dynamic> createEntity(Map<String, dynamic> data) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.post(
      '${ApiConstants.baseUrl}$url/',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Token dcee07d8713c07984e33ef33a17c67ac012cbb1b'
        },
      ),
    );
    return response.data;
  }

  Future<List<dynamic>> fetchUserTimeSlotsEntities(int doctorId) async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
        '${ApiConstants.baseUrl}$url?user_id=$doctorId',
        options: Options(headers: {
          'Authorization': 'Token dcee07d8713c07984e33ef33a17c67ac012cbb1b'
        }));

    return response.data['results'];
  }

  @override
  Future fetchAnEntity(int id) async {
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url/$id',
    );
    return response.data;
  }
}
