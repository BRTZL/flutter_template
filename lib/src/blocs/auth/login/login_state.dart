part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final PhoneNumber phoneNumber;
  final String verificationId;
  final String code;

  final bool isEnabled;

  const LoginState({
    this.phoneNumber,
    this.verificationId,
    this.code,
    this.isEnabled = false,
  });

  @override
  List<Object> get props => [phoneNumber, verificationId, code, isEnabled];
}

class LoginInitial extends LoginState {}

class LoginUpdated extends LoginState {
  LoginUpdated.fromOldState(
    LoginState state, {
    PhoneNumber phoneNumber,
    String verificationId,
    String code,
    bool isEnabled,
  }) : super(
          phoneNumber: phoneNumber ?? state.phoneNumber,
          verificationId: verificationId ?? state.verificationId,
          code: code ?? state.code,
          isEnabled: isEnabled ?? state.isEnabled,
        );
}

class LoginLoading extends LoginState {
  LoginLoading.fromOldState(LoginState state)
      : super(
          phoneNumber: state.phoneNumber,
          verificationId: state.verificationId,
          code: state.code,
          isEnabled: state.isEnabled,
        );
}

class LoginSuccess extends LoginState {
  LoginSuccess.fromOldState(LoginState state)
      : super(
          phoneNumber: state.phoneNumber,
          verificationId: state.verificationId,
          code: state.code,
          isEnabled: state.isEnabled,
        );
}

class LoginFailure extends LoginState {
  final CustomException customException;

  LoginFailure.fromOldState(
    LoginState state, {
    @required this.customException,
  }) : super(
          phoneNumber: state.phoneNumber,
          verificationId: state.verificationId,
          code: state.code,
          isEnabled: state.isEnabled,
        );

  @override
  List<Object> get props => [customException, ...super.props];
}
