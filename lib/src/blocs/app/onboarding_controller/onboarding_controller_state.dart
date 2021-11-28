part of 'onboarding_controller_bloc.dart';

abstract class OnboardingControllerState extends Equatable {
  const OnboardingControllerState();

  @override
  List<Object> get props => [];
}

class OnboardingControllerInitial extends OnboardingControllerState {}

class OnboardingControllerLoading extends OnboardingControllerState {}

class OnboardingControllerSuccess extends OnboardingControllerState {
  final bool isCompleted;

  const OnboardingControllerSuccess({
    @required this.isCompleted,
  });

  @override
  List<Object> get props => [isCompleted];
}

class OnboardingControllerFailure extends OnboardingControllerState {
  final CustomException customException;

  const OnboardingControllerFailure({
    @required this.customException,
  });

  @override
  List<Object> get props => [customException];
}
