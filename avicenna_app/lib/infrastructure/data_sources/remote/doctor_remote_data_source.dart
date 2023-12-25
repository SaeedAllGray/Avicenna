import 'dart:convert';
import 'dart:developer';

import 'package:avicenna_app/domain/entries/doctor.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DoctorRemoteDataSource implements RemoteDataSource {
  String url = "doctors";
  Dio dio = Dio();

  @override
  Future fetchEntities() async {
    dio.interceptors.add(PrettyDioLogger());
    Response response = await dio.get(
      '${ApiConstants.baseUrl}/$url',
    );
    // return response.data;
    String mockresponse = '''[
  {
    "id": 1,
    "first_name": "Dr. John",
    "last_name": "Smith",
    "specialization": "Cardiology",
    "username": "johnsmith",
    "email": "johnsmith@example.com"
  },
  {
    "id": 2,
    "first_name": "Dr. Sarah",
    "last_name": "Johnson",
    "specialization": "Dermatology",
    "username": "sarahj",
    "email": "sarah.j@example.com"
  },
  {
    "id": 3,
    "first_name": "Dr. Michael",
    "last_name": "Brown",
    "specialization": "Pediatrics",
    "username": "mbrown",
    "email": "michaelbrown@example.com"
  },
  {
    "id": 4,
    "first_name": "Dr. Emily",
    "last_name": "Davis",
    "specialization": "Orthopedics",
    "username": "emily_d",
    "email": "emily.d@example.com"
  },
  {
    "id": 5,
    "first_name": "Dr. Jessica",
    "last_name": "Garcia",
    "specialization": "Neurology",
    "username": "jgarcia",
    "email": "jessica.g@example.com"
  },
  {
    "id": 6,
    "first_name": "Dr. David",
    "last_name": "Martinez",
    "specialization": "Psychiatry",
    "username": "david_m",
    "email": "david.m@example.com"
  },
  {
    "id": 7,
    "first_name": "Dr. Jennifer",
    "last_name": "Lee",
    "specialization": "Oncology",
    "username": "jenniferl",
    "email": "jenniferl@example.com"
  },
  {
    "id": 8,
    "first_name": "Dr. Andrew",
    "last_name": "Wilson",
    "specialization": "Endocrinology",
    "username": "awilson",
    "email": "andrew.w@example.com"
  },
  {
    "id": 9,
    "first_name": "Dr. Olivia",
    "last_name": "Moore",
    "specialization": "Gynecology",
    "username": "oliviam",
    "email": "olivia.moore@example.com"
  },
  {
    "id": 10,
    "first_name": "Dr. Ethan",
    "last_name": "Adams",
    "specialization": "Urology",
    "username": "ethana",
    "email": "ethan.adams@example.com"
  }
]''';
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
