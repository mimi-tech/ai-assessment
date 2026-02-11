// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get counterAppBarTitle => 'Counter';

  @override
  String get loginLogo => 'App Logo';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'Enter your email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginForgotPassword => 'Forgot Password?';

  @override
  String get loginSignIn => 'Sign In';

  @override
  String get loginSignUpPrompt => 'Don\'t have an account? Sign Up';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackHeadingPrincipal => 'We value your feedback';

  @override
  String get feedbackSubheading =>
      'Your input helps us improve and provide\na better experience for everyone.';

  @override
  String feedbackStarCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stars selected',
      one: '1 star selected',
    );
    return '$_temp0';
  }

  @override
  String get feedbackRatingTerrible => 'Terrible';

  @override
  String get feedbackRatingBad => 'Bad';

  @override
  String get feedbackRatingOkay => 'Okay';

  @override
  String get feedbackRatingGood => 'Good';

  @override
  String get feedbackRatingExcellent => 'Excellent';

  @override
  String get feedbackRatingPlaceholder => 'How was your experience?';

  @override
  String get feedbackCommentLabel => 'Comment';

  @override
  String get feedbackCommentHint =>
      'Tell us more about your experience\n(optional)';

  @override
  String get feedbackSubmit => 'Submit Feedback';

  @override
  String get feedbackSuccessTitle => 'Thank you!';

  @override
  String get feedbackSuccessMessage =>
      'Your feedback has been submitted successfully.';

  @override
  String get commonDone => 'Done';
}
