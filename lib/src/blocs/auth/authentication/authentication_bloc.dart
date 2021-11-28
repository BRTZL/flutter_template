import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/src/models/models.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    add(AuthenticationStateUpdated());
    FirebaseAuth.instance.authStateChanges().listen((user) {
      add(AuthenticationStateUpdated());
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStateUpdated) {
      yield* _mapAuthenticationStateUpdatedToState(event, state);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStateUpdatedToState(
    AuthenticationStateUpdated event,
    AuthenticationState state,
  ) async* {
    yield AuthenticationLoading();

    try {
      if (FirebaseAuth.instance.currentUser != null) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } on PlatformException catch (_) {
      yield AuthenticationNotAuthenticated();
      rethrow;
    } on CustomException catch (_) {
      yield AuthenticationNotAuthenticated();
      rethrow;
    } catch (e) {
      yield AuthenticationFailure(customException: CustomException.now(error: 'authentication-read-token-error', message: e.toString()));
    }
  }
}
