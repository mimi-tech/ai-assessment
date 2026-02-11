import 'package:equatable/equatable.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();
  @override
  List<Object?> get props => [];
}

class AnalyticsLogButtonTap extends AnalyticsEvent {
  const AnalyticsLogButtonTap({
    required this.buttonName,
    this.additionalParameters,
  });
  final String buttonName;
  final Map<String, Object>? additionalParameters;
  @override
  List<Object?> get props => [buttonName, additionalParameters];
}

class AnalyticsLogScreenView extends AnalyticsEvent {
  const AnalyticsLogScreenView({required this.screenName, this.screenClass});
  final String screenName;
  final String? screenClass;
  @override
  List<Object?> get props => [screenName, screenClass];
}

class AnalyticsLogLike extends AnalyticsEvent {
  const AnalyticsLogLike({
    required this.contentType,
    required this.contentId,
    required this.screenName,
    this.additionalParameters,
  });
  final String contentType;
  final String contentId;
  final String screenName;
  final Map<String, Object>? additionalParameters;
  @override
  List<Object?> get props =>
      [contentType, contentId, screenName, additionalParameters];
}

class AnalyticsLogComment extends AnalyticsEvent {
  const AnalyticsLogComment({
    required this.contentType,
    required this.contentId,
    required this.screenName,
    this.commentLength,
    this.additionalParameters,
  });
  final String contentType;
  final String contentId;
  final String screenName;
  final String? commentLength;
  final Map<String, Object>? additionalParameters;
  @override
  List<Object?> get props =>
      [contentType, contentId, screenName, commentLength, additionalParameters];
}

class AnalyticsLogShare extends AnalyticsEvent {
  const AnalyticsLogShare({
    required this.contentType,
    required this.contentId,
    required this.screenName,
    this.shareMethod,
    this.additionalParameters,
  });
  final String contentType;
  final String contentId;
  final String screenName;
  final String? shareMethod;
  final Map<String, Object>? additionalParameters;
  @override
  List<Object?> get props =>
      [contentType, contentId, screenName, shareMethod, additionalParameters];
}

class AnalyticsLogCustom extends AnalyticsEvent {
  const AnalyticsLogCustom({required this.eventName, this.parameters});
  final String eventName;
  final Map<String, Object>? parameters;
  @override
  List<Object?> get props => [eventName, parameters];
}

class AnalyticsLogAppOpen extends AnalyticsEvent {
  const AnalyticsLogAppOpen({required this.fromWhere});
  final String fromWhere;
  @override
  List<Object?> get props => [fromWhere];
}

class AnalyticsLogLogin extends AnalyticsEvent {
  const AnalyticsLogLogin({required this.loginMethod, this.userId});
  final String loginMethod;
  final String? userId;
  @override
  List<Object?> get props => [loginMethod, userId];
}

class AnalyticsLogSignUp extends AnalyticsEvent {
  const AnalyticsLogSignUp({required this.signUpMethod});
  final String signUpMethod;
  @override
  List<Object?> get props => [signUpMethod];
}

class AnalyticsLogIconTap extends AnalyticsEvent {
  const AnalyticsLogIconTap({
    required this.iconName,
    this.iconType,
    this.additionalParameters,
  });
  final String iconName;
  final String? iconType;
  final Map<String, Object>? additionalParameters;
  @override
  List<Object?> get props => [iconName, iconType, additionalParameters];
}

class AnalyticsLogUrlLaunch extends AnalyticsEvent {
  const AnalyticsLogUrlLaunch({
    required this.url,
    required this.linkName,
    this.linkType,
    this.additionalParameters,
  });
  final String url;
  final String linkName;
  final String? linkType;
  final Map<String, Object>? additionalParameters;
  @override
  List<Object?> get props => [url, linkName, linkType, additionalParameters];
}

class AnalyticsSetCurrentScreen extends AnalyticsEvent {
  const AnalyticsSetCurrentScreen({
    required this.screenName,
  });

  final String screenName;
}

class AnalyticsSetUserProperty extends AnalyticsEvent {
  const AnalyticsSetUserProperty({
    required this.name,
    required this.value,
  });

  final String name;
  final String value;
}

class AnalyticsSetUserId extends AnalyticsEvent {
  const AnalyticsSetUserId({
    required this.userId,
  });

  final String userId;
}

class AnalyticsResetAnalyticsData extends AnalyticsEvent {
  const AnalyticsResetAnalyticsData();
}

class AnalyticsInitialized extends AnalyticsEvent {
  const AnalyticsInitialized();
}
