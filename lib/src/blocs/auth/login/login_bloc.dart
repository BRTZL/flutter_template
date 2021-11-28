import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/models/models.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUpdatePhoneNumber) {
      // ignore: avoid_redundant_argument_values
      yield LoginUpdated.fromOldState(state, phoneNumber: event.phoneNumber, verificationId: null);
    } else if (event is LoginUpdatePhoneNumberValidation) {
      yield LoginUpdated.fromOldState(state, isEnabled: event.isValid);
    } else if (event is LoginSendCode) {
      yield LoginLoading.fromOldState(state);
      // ignore: avoid_redundant_argument_values
      yield LoginUpdated.fromOldState(state, verificationId: null);

      try {
        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: state.phoneNumber.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            try {
              await _firebaseAuth.signInWithCredential(credential);
            } on FirebaseAuthException catch (e) {
              add(LoginFailureEvent(
                customException: CustomException.now(
                  message: e.message,
                  error: e.code,
                  path: e.stackTrace.toString(),
                ),
              ));
            } catch (e) {
              add(LoginFailureEvent(
                customException: CustomException.unknown(
                  message: e.toString(),
                  path: e.stackTrace.toString(),
                ),
              ));
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            add(LoginFailureEvent(
              customException: CustomException.now(
                message: e.message,
                error: e.code,
                path: e.stackTrace.toString(),
              ),
            ));
          },
          codeSent: (String verificationId, int resendToken) {
            add(LoginCodeSentEvent(verificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        yield LoginSuccess.fromOldState(state);
      } catch (e) {
        yield LoginFailure.fromOldState(state, customException: CustomException.unknown(message: e.toString()));
      }
    } else if (event is LoginVerifyCode) {
      yield LoginLoading.fromOldState(state);

      try {
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: state.verificationId,
          smsCode: event.code,
        );

        inspect(credential);

        await _firebaseAuth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        yield LoginFailure.fromOldState(
          state,
          customException: CustomException.now(
            message: e.message,
            error: e.code,
            path: e.stackTrace.toString(),
          ),
        );
      } catch (e) {
        yield LoginFailure.fromOldState(state, customException: CustomException.unknown(message: e.toString()));
      }
    } else if (event is LoginResendCode) {
      yield LoginLoading.fromOldState(state);
      add(LoginSendCode());
      yield LoginSuccess.fromOldState(state);
    } else if (event is LoginCodeSentEvent) {
      yield LoginLoading.fromOldState(state);
      yield LoginUpdated.fromOldState(state, verificationId: event.verificationId);
    } else if (event is LoginFailureEvent) {
      yield LoginFailure.fromOldState(state, customException: event.customException);
    }
  }
}
