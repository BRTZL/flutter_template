import 'package:flutter/material.dart';
import 'package:flutter_template/src/blocs/blocs.dart';

void blocGet(BuildContext context) {
  context.read<OnboardingControllerBloc>().add(OnboardingControllerCheck());
}

void blocUpdate(BuildContext context) {}
