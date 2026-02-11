import 'package:ai_assessment/src/core/configs/environment/environment_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

abstract class AnalyticsService {
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

class IAnalyticsService implements AnalyticsService {
  static final bool isProdMode = EnvironmentConfig.isProdMode() && !kDebugMode;
  static final _analytics = FirebaseAnalytics.instance;

  String formatCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('dd, MMMM yyyy h:mm a');
    return formatter.format(now);
  }

  String get formattedDate => formatCurrentDateTime();

  @override
  Future<void> initializeAnalytics() async {
    if (isProdMode) {
      await _analytics.setAnalyticsCollectionEnabled(true);
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
    }
  }

  @override
  Future<void> setCurrentScreen({required String screenName}) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        parameters: {
          'screen_view_time': formattedDate,
        },
      );
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logAppOpen({required String fromWhere}) async {
    try {
      await _analytics.logAppOpen(
        callOptions: AnalyticsCallOptions(global: true),
        parameters: {
          'from': fromWhere,
          'App_opened_time': formattedDate,
        },
      );
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logLogin({required String loginMethod, String? userId}) async {
    try {
      await _analytics.logLogin(
        loginMethod: loginMethod,
        parameters: {
          'login_time': formattedDate,
        },
      );
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) async {
    try {
      await _analytics.logSignUp(
        signUpMethod: signUpMethod,
        parameters: {
          'Join_Membership_time': formattedDate,
        },
      );
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logButtonTap({
    required String buttonName,
    Map<String, Object>? additionalParameters,
  }) async {
    try {
      final parameters = {
        'button_name': buttonName,
        'button_tap_time': formattedDate,
        ...?additionalParameters,
      };
      await _analytics.logEvent(name: 'button_tap', parameters: parameters);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logIconTap({
    required String iconName,
    String? iconType,
    Map<String, Object>? additionalParameters,
  }) async {
    try {
      final parameters = {
        'icon_name': iconName,
        if (iconType != null) 'icon_type': iconType,
        ...?additionalParameters,
      };
      await _analytics.logEvent(name: 'icon_tap', parameters: parameters);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logUrlLaunch({
    required String url,
    required String linkName,
    String? linkType,
    Map<String, Object>? additionalParameters,
  }) async {
    try {
      final parameters = {
        'url': url,
        'link_name': linkName,
        'link_tap_time': formattedDate,
        if (linkType != null) 'link_type': linkType,
        ...?additionalParameters,
      };
      await _analytics.logEvent(name: 'url_launch', parameters: parameters);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logLike({
    required String contentType,
    required String contentId,
    required String screenName,
    Map<String, Object>? additionalParameters,
  }) async {
    try {
      final parameters = {
        'content_type': contentType,
        'content_id': contentId,
        'screen_name': screenName,
        ...?additionalParameters,
      };
      await _analytics.logEvent(name: 'like', parameters: parameters);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logComment({
    required String contentType,
    required String contentId,
    required String screenName,
    String? commentLength,
    Map<String, Object>? additionalParameters,
  }) async {
    try {
      final parameters = {
        'content_type': contentType,
        'content_id': contentId,
        'screen_name': screenName,
        if (commentLength != null) 'comment_length': commentLength,
        ...?additionalParameters,
      };
      await _analytics.logEvent(name: 'comment', parameters: parameters);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logShare({
    required String contentType,
    required String contentId,
    required String screenName,
    String? shareMethod,
    Map<String, Object>? additionalParameters,
  }) async {
    try {
      await _analytics.logShare(
        contentType: contentType,
        itemId: contentType,
        method: screenName,
      );
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(name: eventName, parameters: parameters);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> setUserId({required String userId}) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  @override
  Future<void> resetAnalyticsData() async {
    try {
      await _analytics.resetAnalyticsData();
    } catch (error, stackTrace) {
      _handle(error, stackTrace);
    }
  }

  void _handle(Object error, StackTrace stackTrace) {
    // ExceptionHandler.handleAnalyticsException(
    //   error,
    //   stackTrace,
    //   stackTrace.runtimeType.toString(),
    // );
  }
}
