import 'dart:convert';

import 'package:avicenna_app/infrastructure/data_sources/remote/remote_data_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FeedbackRemoteDataSource implements RemoteDataSource {
  @override
  String url = "feedback";
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
    "comment": "The doctor was very knowledgeable and helpful.",
    "rating": 5,
    "patient_id": 101,
    "doctor_id": 201
  },
  {
    "id": 2,
    "comment": "Great experience with the doctor, very friendly!",
    "rating": 4,
    "patient_id": 102,
    "doctor_id": 202
  },
  {
    "id": 3,
    "comment": "Satisfactory consultation, but wait time was a bit long.",
    "rating": 3,
    "patient_id": 103,
    "doctor_id": 203
  },
  {
    "id": 4,
    "comment": "Excellent care and attention to detail.",
    "rating": 5,
    "patient_id": 104,
    "doctor_id": 204
  },
  {
    "id": 5,
    "comment": "Could have been more informative during the appointment.",
    "rating": 2,
    "patient_id": 105,
    "doctor_id": 205
  },
  {
    "id": 6,
    "comment": "The doctor provided clear explanations, overall good experience.",
    "rating": 4,
    "patient_id": 106,
    "doctor_id": 206
  },
  {
    "id": 7,
    "comment": "Not satisfied with the treatment received, expected better.",
    "rating": 2,
    "patient_id": 107,
    "doctor_id": 207
  },
  {
    "id": 8,
    "comment": "Highly recommended! The doctor was attentive and caring.",
    "rating": 5,
    "patient_id": 108,
    "doctor_id": 208
  },
  {
    "id": 9,
    "comment": "Average consultation, nothing exceptional.",
    "rating": 3,
    "patient_id": 109,
    "doctor_id": 209
  },
  {
    "id": 10,
    "comment": "Unsatisfactory experience, need improvements in service quality.",
    "rating": 1,
    "patient_id": 110,
    "doctor_id": 210
  }
]
''';
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
