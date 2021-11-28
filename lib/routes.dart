import 'package:flutter/widgets.dart';
import 'package:flutter_template/src/views/app/navigation/navigation_wrapper.dart';
import 'package:flutter_template/src/views/app/onboarding/onboarding_wrapper.dart';
import 'package:flutter_template/src/views/auth/auth_wrapper.dart';
import 'package:flutter_template/src/views/splash_screen.dart';

mixin Routes {
  static const initialRoute = '/splash';

  static final Map<String, WidgetBuilder> routes = {
    '/splash': (context) => const SplashScreen(),
    // Authentication
    '/auth': (context) => const AuthWrapper(),
    // Onboarding
    '/onboarding': (context) => const OnboardingWrapper(),
    // App
    '/home': (context) => const NavigationWrapper(),
  };
}
