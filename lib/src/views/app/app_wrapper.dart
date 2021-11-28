import 'package:flutter/material.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/views/app/navigation/navigation_wrapper.dart';
import 'package:flutter_template/src/views/app/onboarding/onboarding_wrapper.dart';
import 'package:flutter_template/src/views/splash_screen.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingControllerBloc, OnboardingControllerState>(
      builder: (context, state) {
        if (state is OnboardingControllerSuccess) {
          if (state.isCompleted) {
            return const NavigationWrapper();
          } else {
            return const OnboardingWrapper();
          }
        }
        return const SplashScreen();
      },
    );
  }
}
