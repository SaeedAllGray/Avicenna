import 'dart:convert';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DoctorRemoteDataSource implements RemoteDataSource {
  @override
  String url = "doctors";
  Dio dio = Dio();

  @override
  Future<List<dynamic>> fetchEntities() async {
    // dio.interceptors.add(PrettyDioLogger());
    // Response response = await dio.get(
    //   '${ApiConstants.baseUrl}/$url',
    // );

    // return response.data;
    String mockresponse = '''[
  {
      "id": 1,
      "first_name": "Dr. John",
      "last_name": "Smith",
      "specialization": "Cardiology",
      "username": "johnsmith",
      "email": "johnsmith@example.com",
      "phone_number": "123-456-7890",
      "address": "123 Medical Avenue, City, Country"
    },
    {
      "id": 2,
      "first_name": "Dr. Sarah",
      "last_name": "Johnson",
      "specialization": "Dermatology",
      "username": "sarahj",
      "email": "sarah.j@example.com",
      "phone_number": "987-654-3210",
      "address": "456 Dermatology Street, Town, Country"
    },
    {
      "id": 3,
      "first_name": "Dr. Michael",
      "last_name": "Brown",
      "specialization": "Pediatrics",
      "username": "mbrown",
      "email": "michaelbrown@example.com",
      "phone_number": "555-123-4567",
      "address": "789 Pediatric Lane, City, Country"
    }
]''';
    print(jsonDecode(mockresponse));
    return jsonDecode(mockresponse);
  }

  @override
  Future fetchAnEntity(int id) async {
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url/$id',
    );
    return response.data;
  }
}
