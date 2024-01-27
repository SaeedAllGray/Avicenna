part of 'feedback_bloc.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackInitial extends FeedbackState {}

class FeedBackInProgress extends FeedbackState {}

class FeedBacksFetched extends FeedbackState {
  final List<Feedback> feedbacks;

  const FeedBacksFetched({required this.feedbacks});
}

class FeedBackCreated extends FeedbackState {}
