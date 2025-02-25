import 'package:edupluz_future/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:edupluz_future/features/auth/presentation/pages/sign_in_page.dart';
import 'package:edupluz_future/features/auth/presentation/pages/sign_up_page.dart';
import 'package:edupluz_future/features/maintenance/presentation/pages/maintenance_page.dart';
import 'package:edupluz_future/features/navigation/presentation/pages/navigation_page.dart';
import 'package:edupluz_future/features/onboarding/onboarding_page.dart';
import 'package:edupluz_future/features/presentation/question_page.dart';
import 'package:edupluz_future/features/splash/presentation/pages/splash_page.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static bool get canPop {
    try {
      return Navigator.canPop(navigatorKey.currentContext!);
    } catch (_) {}
    return false;
  }

  static void popIfCanPop() {
    try {
      final context = navigatorKey.currentContext;
      if (canPop && context != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      Logger().e('***NavigationService pop error*** $e');
    }
  }
}

// https://www.kodeco.com/19457817-flutter-navigator-2-0-and-deep-links

GoRouter getRouter({String initialLocation = '/splash'}) {
  return GoRouter(
    initialLocation: initialLocation,
    navigatorKey: NavigationService.navigatorKey,
    observers: [
      // AnalyticsRouteObserver(),
    ],
    routes: [
      GoRoute(
        name: Routes.splash.name,
        path: Routes.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: Routes.maintenance.name,
        path: Routes.maintenance.path,
        builder: (context, state) => const MaintenancePage(),
      ),
      GoRoute(
        name: Routes.signin.name,
        path: Routes.signin.path,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: Routes.signup.name,
        path: Routes.signup.path,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: Routes.forgotpassword.name,
        path: Routes.forgotpassword.path,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        name: Routes.onboarding.name,
        path: Routes.onboarding.path,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: Routes.question.name,
        path: Routes.question.path,
        builder: (context, state) => const QuestionPage(),
      ),
      GoRoute(
        name: Routes.navigation.name,
        path: Routes.navigation.path,
        builder: (context, state) => const NavigationPage(),
      ),
    ],
  );
}
