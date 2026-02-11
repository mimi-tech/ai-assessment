part of 'feedback_rating_bloc.dart';

abstract class FeedbackRatingEvent extends Equatable {
  const FeedbackRatingEvent();

  @override
  List<Object?> get props => [];
}

class FeedbackRatingChanged extends FeedbackRatingEvent {
  const FeedbackRatingChanged({required this.rating});

  final int rating;

  @override
  List<Object?> get props => [rating];
}

class FeedbackCommentChanged extends FeedbackRatingEvent {
  const FeedbackCommentChanged({required this.comment});

  final String comment;

  @override
  List<Object?> get props => [comment];
}

class FeedbackSubmitted extends FeedbackRatingEvent {
  const FeedbackSubmitted();
}
