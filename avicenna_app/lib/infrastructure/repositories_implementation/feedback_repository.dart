import 'dart:developer';

import 'package:avicenna_app/domain/entries/feedback/feedback.dart';
import 'package:avicenna_app/infrastructure/data_sources/remote/feedback_remote_data_source.dart';
import 'package:avicenna_app/domain/repositories/entity_repository.dart';

class FeedbackRepository
    implements EntityRepository<Feedback, FeedbackRemoteDataSource> {
  @override
  FeedbackRemoteDataSource api = FeedbackRemoteDataSource();

  @override
  Future<List<Feedback>> fetchEntities() async {
    List<dynamic> response = await api.fetchEntities();
    return response.map((data) => Feedback.fromJson(data)).toList();
  }

  Future<List<Feedback>> fetchUserEntities(int id) async {
    List<dynamic> response = await api.fetchUserEntities(id);
    return response.map((data) => Feedback.fromJson(data)).toList();
  }

  Future<Feedback> createEntity(Feedback feedback) async {
    dynamic response = await api.createEntity(feedback.toJson());
    return Feedback.fromJson(response);
  }

  @override
  Future<Feedback> fetchEntity(int id) {
    // TODO: implement fetchEntity
    throw UnimplementedError();
  }
}
