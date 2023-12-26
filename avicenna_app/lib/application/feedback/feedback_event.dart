part of 'feedback_bloc.dart';

sealed class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class GetFeedBacks extends FeedbackEvent {
  final int doctorId;

  const GetFeedBacks({required this.doctorId});
}
