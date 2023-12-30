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
    log(response.toString());
    return response.map((data) => Feedback.fromJson(data)).toList();
  }

  @override
  Future<Feedback> fetchEntity() {
    // TODO: implement fetchEntity
    throw UnimplementedError();
  }
}
