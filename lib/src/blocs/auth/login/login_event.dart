part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUpdatePhoneNumber extends LoginEvent {
  final PhoneNumber phoneNumber;

  const LoginUpdatePhoneNumber({
    @required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class LoginUpdatePhoneNumberValidation extends LoginEvent {
  final bool isValid;

  const LoginUpdatePhoneNumberValidation({
    @required this.isValid,
  });

  @override
  List<Object> get props => [isValid];
}

class LoginSendCode extends LoginEvent {}

class LoginVerifyCode extends LoginEvent {
  final String code;

  const LoginVerifyCode({
    @required this.code,
  });

  @override
  List<Object> get props => [code];
}

class LoginResendCode extends LoginEvent {}

class LoginCodeSentEvent extends LoginEvent {
  final String verificationId;

  const LoginCodeSentEvent({
    @required this.verificationId,
  });

  @override
  List<Object> get props => [verificationId];
}

class LoginFailureEvent extends LoginEvent {
  final CustomException customException;

  const LoginFailureEvent({
    @required this.customException,
  });

  @override
  List<Object> get props => [customException];
}
