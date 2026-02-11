part of 'feedback_rating_bloc.dart';

enum FeedbackUiState { initial, submitting, submitted, error }

class FeedbackRatingState extends Equatable {
  const FeedbackRatingState({
    this.rating = 0,
    this.comment = '',
    this.uiState = FeedbackUiState.initial,
  });

  final int rating;
  final String comment;
  final FeedbackUiState uiState;

  FeedbackRatingState copyWith({
    int? rating,
    String? comment,
    FeedbackUiState? uiState,
  }) {
    return FeedbackRatingState(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      uiState: uiState ?? this.uiState,
    );
  }

  @override
  List<Object?> get props => [rating, comment, uiState];
}
