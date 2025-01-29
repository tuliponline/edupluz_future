import 'package:edupluz_future/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:edupluz_future/features/auth/presentation/pages/sign_in_page.dart';
import 'package:edupluz_future/features/auth/presentation/pages/sign_up_page.dart';
import 'package:edupluz_future/features/maintenance/presentation/pages/maintenance_page.dart';
import 'package:edupluz_future/features/onboarding/onboarding_page.dart';
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
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: Routes.maintenance.name,
        path: '/maintenance',
        builder: (context, state) => const MaintenancePage(),
      ),
      GoRoute(
        name: Routes.signin.name,
        path: '/signin',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: Routes.signup.name,
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: Routes.forgotpassword.name,
        path: '/forgotpassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        name: Routes.onboarding.name,
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
    ],
  );
}
