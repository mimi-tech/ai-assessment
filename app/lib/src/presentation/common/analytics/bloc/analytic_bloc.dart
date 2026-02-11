
import 'package:ai_assessment/src/presentation/common/analytics/bloc/analytic_event.dart';
import 'package:ai_assessment/src/presentation/common/analytics/bloc/analytic_state.dart';
import 'package:ai_assessment/src/repositories/common/analytics_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticBloc extends Bloc<AnalyticsEvent, AnalyticState> {
  AnalyticBloc({required this.analyticsRepository})
      : super(const AnalyticState()) {
    on<AnalyticsLogButtonTap>(_onLogButtonTap);
    on<AnalyticsLogScreenView>(_onLogScreenView);
    on<AnalyticsLogLike>(_onLogLike);
    on<AnalyticsLogComment>(_onLogComment);
    on<AnalyticsLogShare>(_onLogShare);
    on<AnalyticsLogCustom>(_onLogCustomEvent);
    on<AnalyticsLogAppOpen>(_onLogAppOpen);
    on<AnalyticsLogLogin>(_onLogLogin);
    on<AnalyticsLogSignUp>(_onLogSignUp);
    on<AnalyticsLogIconTap>(_onLogIconTap);
    on<AnalyticsLogUrlLaunch>(_onLogUrlLaunch);
    on<AnalyticsSetCurrentScreen>(_onSetCurrentScreen);
    on<AnalyticsSetUserProperty>(_onSetUserProperty);
    on<AnalyticsSetUserId>(_onSetUserId);
    on<AnalyticsResetAnalyticsData>(_onResetAnalyticsData);
    on<AnalyticsInitialized>(_onAnalyticsInitialized);
  }
  final IAnalyticsRepository analyticsRepository;

  Future<void> _onLogButtonTap(
    AnalyticsLogButtonTap event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logButtonTap(
      buttonName: event.buttonName,
      additionalParameters: event.additionalParameters,
    );
  }

  Future<void> _onLogScreenView(
    AnalyticsLogScreenView event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logScreenView(
      screenName: event.screenName,
      screenClass: event.screenClass,
    );
  }

  Future<void> _onLogLike(
    AnalyticsLogLike event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logLike(
      contentType: event.contentType,
      contentId: event.contentId,
      screenName: event.screenName,
      additionalParameters: event.additionalParameters,
    );
  }

  Future<void> _onLogComment(
    AnalyticsLogComment event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logComment(
      contentType: event.contentType,
      contentId: event.contentId,
      screenName: event.screenName,
      commentLength: event.commentLength,
      additionalParameters: event.additionalParameters,
    );
  }

  Future<void> _onLogShare(
    AnalyticsLogShare event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logShare(
      contentType: event.contentType,
      contentId: event.contentId,
      screenName: event.screenName,
      shareMethod: event.shareMethod,
      additionalParameters: event.additionalParameters,
    );
  }

  Future<void> _onLogCustomEvent(
    AnalyticsLogCustom event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logCustomEvent(
      eventName: event.eventName,
      parameters: event.parameters,
    );
  }

  Future<void> _onLogAppOpen(
    AnalyticsLogAppOpen event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logAppOpen(fromWhere: event.fromWhere);
  }

  Future<void> _onLogLogin(
    AnalyticsLogLogin event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logLogin(
      loginMethod: event.loginMethod,
      userId: event.userId,
    );
  }

  Future<void> _onLogSignUp(
    AnalyticsLogSignUp event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logSignUp(signUpMethod: event.signUpMethod);
  }

  Future<void> _onLogIconTap(
    AnalyticsLogIconTap event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logIconTap(
      iconName: event.iconName,
      iconType: event.iconType,
      additionalParameters: event.additionalParameters,
    );
  }

  Future<void> _onLogUrlLaunch(
    AnalyticsLogUrlLaunch event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.logUrlLaunch(
      url: event.url,
      linkName: event.linkName,
      linkType: event.linkType,
      additionalParameters: event.additionalParameters,
    );
  }

  Future<void> _onSetCurrentScreen(
    AnalyticsSetCurrentScreen event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.setCurrentScreen(screenName: event.screenName);
  }

  Future<void> _onSetUserProperty(
    AnalyticsSetUserProperty event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.setUserProperty(
      name: event.name,
      value: event.value,
    );
  }

  Future<void> _onSetUserId(
    AnalyticsSetUserId event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.setUserId(userId: event.userId);
  }

  Future<void> _onResetAnalyticsData(
    AnalyticsResetAnalyticsData event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.resetAnalyticsData();
  }

  Future<void> _onAnalyticsInitialized(
    AnalyticsInitialized event,
    Emitter<AnalyticState> emit,
  ) async {
    await analyticsRepository.initializeAnalytics();
  }
}
