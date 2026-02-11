// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get counterAppBarTitle => '카운터';

  @override
  String get loginLogo => '앱 로고';

  @override
  String get loginEmailLabel => '이메일';

  @override
  String get loginEmailHint => '이메일을 입력하세요';

  @override
  String get loginPasswordLabel => '비밀번호';

  @override
  String get loginPasswordHint => '비밀번호를 입력하세요';

  @override
  String get loginForgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get loginSignIn => '로그인';

  @override
  String get loginSignUpPrompt => '계정이 없으신가요? 회원가입';

  @override
  String get feedbackTitle => '피드백';

  @override
  String get feedbackHeadingPrincipal => '여러분의 피드백을 소중히 생각합니다';

  @override
  String get feedbackSubheading =>
      '여러분의 의견은 저희가 서비스를 개선하고\n모두에게 더 나은 경험을 제공하는 데 도움이 됩니다.';

  @override
  String feedbackStarCount(int count) {
    return '$count개의 별이 선택되었습니다';
  }

  @override
  String get feedbackRatingTerrible => '최악이에요';

  @override
  String get feedbackRatingBad => '별로예요';

  @override
  String get feedbackRatingOkay => '보통이에요';

  @override
  String get feedbackRatingGood => '좋아요';

  @override
  String get feedbackRatingExcellent => '최고예요';

  @override
  String get feedbackRatingPlaceholder => '경험이 어떠셨나요?';

  @override
  String get feedbackCommentLabel => '코멘트';

  @override
  String get feedbackCommentHint => '경험에 대해 더 자세히 알려주세요\n(선택 사항)';

  @override
  String get feedbackSubmit => '피드백 제출';

  @override
  String get feedbackSuccessTitle => '감사합니다!';

  @override
  String get feedbackSuccessMessage => '피드백이 성공적으로 제출되었습니다.';

  @override
  String get commonDone => '완료';
}
