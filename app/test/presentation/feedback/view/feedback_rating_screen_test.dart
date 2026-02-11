import 'package:ai_assessment/src/presentation/feedback/bloc/feedback_rating_bloc.dart';
import 'package:ai_assessment/src/presentation/feedback/view/feedback_rating_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockFeedbackRatingBloc extends MockBloc<FeedbackRatingEvent, FeedbackRatingState> implements FeedbackRatingBloc {}

void main() {
  late FeedbackRatingBloc feedbackRatingBloc;

  setUp(() {
    feedbackRatingBloc = MockFeedbackRatingBloc();
    when(() => feedbackRatingBloc.state).thenReturn(const FeedbackRatingState());
  });

  group('FeedbackRatingScreen', () {
    testWidgets('renders initial UI', (tester) async {
      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      expect(find.text('Feedback'), findsOneWidget); // AppBar title
      expect(find.byType(Icon), findsNWidgets(6)); // Back button + 5 stars
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('adds FeedbackRatingChanged when a star is tapped', (tester) async {
      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      // Tap the 4th star (index 3)
      await tester.tap(find.byIcon(Icons.star_outline_rounded).at(3));

      verify(() => feedbackRatingBloc.add(const FeedbackRatingChanged(rating: 4))).called(1);
    });

    testWidgets('adds FeedbackCommentChanged when comment is entered', (tester) async {
      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      await tester.enterText(find.byType(TextField), 'Great app!');

      verify(() => feedbackRatingBloc.add(const FeedbackCommentChanged(comment: 'Great app!'))).called(1);
    });

    testWidgets('adds FeedbackSubmitted when submit button is tapped', (tester) async {
      when(() => feedbackRatingBloc.state).thenReturn(
        const FeedbackRatingState(rating: 5),
      );

      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      await tester.tap(find.byType(ElevatedButton));

      verify(() => feedbackRatingBloc.add(const FeedbackSubmitted())).called(1);
    });

    testWidgets('submit button is disabled when rating is 0', (tester) async {
      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      final submitButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(submitButton.onPressed, isNull);
    });

    testWidgets('shows loading indicator when uiState is submitting', (tester) async {
      when(() => feedbackRatingBloc.state).thenReturn(
        const FeedbackRatingState(rating: 5, uiState: FeedbackUiState.submitting),
      );

      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows success dialog when uiState is submitted', (tester) async {
      whenListen(
        feedbackRatingBloc,
        Stream.fromIterable([
          const FeedbackRatingState(rating: 5, uiState: FeedbackUiState.submitting),
          const FeedbackRatingState(rating: 5, uiState: FeedbackUiState.submitted),
        ]),
        initialState: const FeedbackRatingState(rating: 5),
      );

      await tester.pumpApp(
        FeedbackRatingScreen(feedbackRatingBloc: feedbackRatingBloc),
      );

      // Allow the listener to trigger and dialog to show
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Thank you!'), findsOneWidget);
    });
  });
}
