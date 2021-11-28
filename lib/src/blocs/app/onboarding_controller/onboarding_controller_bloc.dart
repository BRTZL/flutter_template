import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/models/custom_exception.dart';

part 'onboarding_controller_event.dart';
part 'onboarding_controller_state.dart';

class OnboardingControllerBloc extends Bloc<OnboardingControllerEvent, OnboardingControllerState> {
  OnboardingControllerBloc() : super(OnboardingControllerInitial());

  @override
  Stream<OnboardingControllerState> mapEventToState(
    OnboardingControllerEvent event,
  ) async* {
    if (event is OnboardingControllerCheck) {
      yield* _mapOnboardingControllerCheckToState(event, state);
    }
  }

  Stream<OnboardingControllerState> _mapOnboardingControllerCheckToState(
    OnboardingControllerCheck event,
    OnboardingControllerState state,
  ) async* {
    yield OnboardingControllerLoading();

    try {
      yield const OnboardingControllerSuccess(isCompleted: true);
    } on CustomException catch (e) {
      yield OnboardingControllerFailure(customException: e);
    } catch (e) {
      yield OnboardingControllerFailure(customException: CustomException.now(error: 'onboarding-status-error', message: e.toString()));
    }
  }
}
