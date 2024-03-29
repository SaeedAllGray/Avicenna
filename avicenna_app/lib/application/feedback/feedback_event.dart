part of 'feedback_bloc.dart';

sealed class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class GetUserFeedBacks extends FeedbackEvent {
  final int doctorId;

  const GetUserFeedBacks({required this.doctorId});
}

class LeaveFeedBack extends FeedbackEvent {
  final Feedback feedback;

  const LeaveFeedBack({required this.feedback});
}
