import 'package:ai_assessment/src/services/common/analytics_service.dart';

abstract class AnalyticsRepository {
  Future<void> initializeAnalytics();
  Future<void> setCurrentScreen({required String screenName});
  Future<void> logAppOpen({required String fromWhere});
  Future<void> logLogin({required String loginMethod, String? userId});
  Future<void> logSignUp({required String signUpMethod});
  Future<void> logScreenView({required String screenName, String? screenClass});
  Future<void> logButtonTap({
    required String buttonName,
    Map<String, Object>? additionalParameters,
  });
  Future<void> logIconTap({
    required String iconName,
    String? iconType,
    Map<String, Object>? additionalParameters,
  });
  Future<void> logUrlLaunch({
    required String url,
    required String linkName,
    String? linkType,
    Map<String, Object>? additionalParameters,
  });
  Future<void> logLike({
    required String contentType,
    required String contentId,
    required String screenName,
    Map<String, Object>? additionalParameters,
  });
  Future<void> logComment({
    required String contentType,
    required String contentId,
    required String screenName,
    String? commentLength,
    Map<String, Object>? additionalParameters,
  });
  Future<void> logShare({
    required String contentType,
    required String contentId,
    required String screenName,
    String? shareMethod,
    Map<String, Object>? additionalParameters,
  });
  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  });
  Future<void> setUserProperty({required String name, required String value});
  Future<void> setUserId({required String userId});
  Future<void> resetAnalyticsData();
}

class IAnalyticsRepository implements AnalyticsRepository {
  IAnalyticsRepository({required AnalyticsService analyticsService})
      : _analyticsService = analyticsService;

  final AnalyticsService _analyticsService;

  @override
  Future<void> initializeAnalytics() => _analyticsService.initializeAnalytics();

  @override
  Future<void> setCurrentScreen({required String screenName}) =>
      _analyticsService.setCurrentScreen(screenName: screenName);

  @override
  Future<void> logAppOpen({required String fromWhere}) =>
      _analyticsService.logAppOpen(fromWhere: fromWhere);

  @override
  Future<void> logLogin({required String loginMethod, String? userId}) =>
      _analyticsService.logLogin(loginMethod: loginMethod, userId: userId);

  @override
  Future<void> logSignUp({required String signUpMethod}) =>
      _analyticsService.logSignUp(signUpMethod: signUpMethod);

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) =>
      _analyticsService.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );

  @override
  Future<void> logButtonTap({
    required String buttonName,
    Map<String, Object>? additionalParameters,
  }) =>
      _analyticsService.logButtonTap(
        buttonName: buttonName,
        additionalParameters: additionalParameters,
      );

  @override
  Future<void> logIconTap({
    required String iconName,
    String? iconType,
    Map<String, Object>? additionalParameters,
  }) =>
      _analyticsService.logIconTap(
        iconName: iconName,
        iconType: iconType,
        additionalParameters: additionalParameters,
      );

  @override
  Future<void> logUrlLaunch({
    required String url,
    required String linkName,
    String? linkType,
    Map<String, Object>? additionalParameters,
  }) =>
      _analyticsService.logUrlLaunch(
        url: url,
        linkName: linkName,
        linkType: linkType,
        additionalParameters: additionalParameters,
      );

  @override
  Future<void> logLike({
    required String contentType,
    required String contentId,
    required String screenName,
    Map<String, Object>? additionalParameters,
  }) =>
      _analyticsService.logLike(
        contentType: contentType,
        contentId: contentId,
        screenName: screenName,
        additionalParameters: additionalParameters,
      );

  @override
  Future<void> logComment({
    required String contentType,
    required String contentId,
    required String screenName,
    String? commentLength,
    Map<String, Object>? additionalParameters,
  }) =>
      _analyticsService.logComment(
        contentType: contentType,
        contentId: contentId,
        screenName: screenName,
        commentLength: commentLength,
        additionalParameters: additionalParameters,
      );

  @override
  Future<void> logShare({
    required String contentType,
    required String contentId,
    required String screenName,
    String? shareMethod,
    Map<String, Object>? additionalParameters,
  }) =>
      _analyticsService.logShare(
        contentType: contentType,
        contentId: contentId,
        screenName: screenName,
        shareMethod: shareMethod,
        additionalParameters: additionalParameters,
      );

  @override
  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) =>
      _analyticsService.logCustomEvent(
        eventName: eventName,
        parameters: parameters,
      );

  @override
  Future<void> setUserProperty({required String name, required String value}) =>
      _analyticsService.setUserProperty(name: name, value: value);

  @override
  Future<void> setUserId({required String userId}) =>
      _analyticsService.setUserId(userId: userId);

  @override
  Future<void> resetAnalyticsData() => _analyticsService.resetAnalyticsData();
}
