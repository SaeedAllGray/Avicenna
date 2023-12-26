import 'dart:async';

import 'package:avicenna_app/domain/entries/feedback/feedback.dart';
import 'package:avicenna_app/infrastructure/repositories_implementation/feedback_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<GetFeedBacks>(_onGeFeedBacksEvent);
  }
  FutureOr<void> _onGeFeedBacksEvent(
      FeedbackEvent event, Emitter<FeedbackState> emit) async {
    emit(FeedBackInProgress());
    FeedbackRepository repository = FeedbackRepository();
    List<Feedback> feedbacks = await repository.fetchEntities();
    emit(FeedBacksFetched(feedbacks: feedbacks));
  }
}
