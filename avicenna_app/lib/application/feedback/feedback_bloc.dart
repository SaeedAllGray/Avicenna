import 'dart:async';

import 'package:avicenna_app/domain/entries/feedback/feedback.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/feedback_repository.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<GetUserFeedBacks>(_onGetFeedBacksEvent);
    on<LeaveFeedBack>(_onLeaveFeedBackEvent);
  }
  FutureOr<void> _onLeaveFeedBackEvent(
      LeaveFeedBack event, Emitter<FeedbackState> emit) async {
    int? userId = await UserRepository().fetchUserId();

    if (userId != null) {
      FeedbackRepository repository = FeedbackRepository();
      Feedback feedback = event.feedback;
      feedback.patientId = userId;
      await repository.createEntity(feedback);
      emit(FeedBackCreated());
    }
  }

  FutureOr<void> _onGetFeedBacksEvent(
      GetUserFeedBacks event, Emitter<FeedbackState> emit) async {
    emit(FeedBackInProgress());
    FeedbackRepository repository = FeedbackRepository();
    List<Feedback> feedbacks =
        await repository.fetchUserEntities(event.doctorId);
    emit(FeedBacksFetched(feedbacks: feedbacks));
  }
}
