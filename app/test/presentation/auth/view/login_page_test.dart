import 'package:ai_assessment/src/presentation/auth/bloc/login_bloc.dart';
import 'package:ai_assessment/src/presentation/auth/view/login_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  late LoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
    when(() => loginBloc.state).thenReturn(const LoginState());
  });

  group('LoginPage', () {
    testWidgets('renders initial UI', (tester) async {
      await tester.pumpApp(
        LoginPage(loginBloc: loginBloc),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('adds LoginEmailChanged when email is entered', (tester) async {
      await tester.pumpApp(
        LoginPage(loginBloc: loginBloc),
      );

      await tester.enterText(find.byType(TextField).first, 'new@example.com');

      verify(() => loginBloc.add(const LoginEmailChanged(email: 'new@example.com'))).called(1);
    });

    testWidgets('adds LoginPasswordChanged when password is entered', (tester) async {
      await tester.pumpApp(
        LoginPage(loginBloc: loginBloc),
      );

      await tester.enterText(find.byType(TextField).last, 'newpassword123');

      verify(() => loginBloc.add(const LoginPasswordChanged(password: 'newpassword123'))).called(1);
    });

    testWidgets('adds LoginSubmitted when sign in button is tapped', (tester) async {
      await tester.pumpApp(
        LoginPage(loginBloc: loginBloc),
      );

      await tester.tap(find.byType(ElevatedButton));

      verify(() => loginBloc.add(const LoginSubmitted())).called(1);
    });

    testWidgets('shows loading indicator when uiState is loading', (tester) async {
      when(() => loginBloc.state).thenReturn(
        const LoginState(uiState: LoginUiState.loading),
      );

      await tester.pumpApp(
        LoginPage(loginBloc: loginBloc),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when errorMessage is not empty', (tester) async {
      const errorMessage = 'Invalid credentials';
      when(() => loginBloc.state).thenReturn(
        const LoginState(errorMessage: errorMessage),
      );

      await tester.pumpApp(
        LoginPage(loginBloc: loginBloc),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}
