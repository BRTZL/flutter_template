part of 'onboarding_controller_bloc.dart';

abstract class OnboardingControllerEvent extends Equatable {
  const OnboardingControllerEvent();

  @override
  List<Object> get props => [];
}

class OnboardingControllerCheck extends OnboardingControllerEvent {}
