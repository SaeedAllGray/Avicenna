import 'package:avicenna_app/src/constants/api_constant.dart';
import 'package:avicenna_app/src/models/doctor.dart';
import 'package:avicenna_app/src/models/patient.dart';
import 'package:avicenna_app/src/models/user.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ScheduleApi {
  final Dio dio = Dio();

  Future<Response> getSchedules() async {
    dio.interceptors.add(PrettyDioLogger());
    User user = await User.getUser();
    if (user is Doctor) {
      Response response = await dio.get(
        '${ApiConstants.baseUrl}get-appointments/doctor/${user.id}/',
      );
      return response;
    } else {
      Response response = await dio.get(
        '${ApiConstants.baseUrl}get-appointments/patient/${(user as Patient).id}/',
      );
      return response;
    }
  }

  Future<Response> deleteSchedule(int id) async {
    dio.interceptors.add(PrettyDioLogger());

    Response response = await dio.delete(
      '${ApiConstants.baseUrl}delete-appointment/$id/',
    );
    return response;
  }
}
