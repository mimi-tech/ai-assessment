import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feedback_rating_event.dart';
part 'feedback_rating_state.dart';

class FeedbackRatingBloc
    extends Bloc<FeedbackRatingEvent, FeedbackRatingState> {
  FeedbackRatingBloc() : super(const FeedbackRatingState()) {
    on<FeedbackRatingChanged>(_onRatingChanged);
    on<FeedbackCommentChanged>(_onCommentChanged);
    on<FeedbackSubmitted>(_onSubmitted);
  }

  void _onRatingChanged(
    FeedbackRatingChanged event,
    Emitter<FeedbackRatingState> emit,
  ) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onCommentChanged(
    FeedbackCommentChanged event,
    Emitter<FeedbackRatingState> emit,
  ) {
    emit(state.copyWith(comment: event.comment));
  }

  Future<void> _onSubmitted(
    FeedbackSubmitted event,
    Emitter<FeedbackRatingState> emit,
  ) async {
    emit(state.copyWith(uiState: FeedbackUiState.submitting));

    // Simulate network delay for submission
    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(uiState: FeedbackUiState.submitted));
  }
}
