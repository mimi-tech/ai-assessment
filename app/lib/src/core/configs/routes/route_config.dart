import 'package:ai_assessment/src/core/configs/routes/route_name.dart';
import 'package:ai_assessment/src/presentation/auth/view/login_page.dart';
import 'package:ai_assessment/src/presentation/feedback/view/feedback_rating_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver();

final GoRouter router = GoRouter(
  debugLogDiagnostics: kDebugMode || false,
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.loginRoute,
  routes: [
    GoRoute(
      name: Routes.loginRoute,
      path: Routes.loginRoute,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: LoginPage());
      },
    ),

    GoRoute(
      name: Routes.feedbackRoute,
      path: Routes.feedbackRoute,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: FeedbackRatingScreen());
      },
    ),
  ],
);
