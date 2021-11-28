import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/models/custom_exception.dart';

part 'remote_config_controller_event.dart';
part 'remote_config_controller_state.dart';

class RemoteConfigControllerBloc extends Bloc<RemoteConfigControllerEvent, RemoteConfigControllerState> {
  final RemoteConfig _remoteConfig = RemoteConfig.instance;
  // ignore: unused_field
  final Function() _restartAppFunction;

  RemoteConfigControllerBloc({
    @required Function() restartAppFunction,
  })  : _restartAppFunction = restartAppFunction,
        super(RemoteConfigControllerInitial()) {
    add(RemoteConfigControllerGet());
  }

  @override
  Stream<RemoteConfigControllerState> mapEventToState(
    RemoteConfigControllerEvent event,
  ) async* {
    if (event is RemoteConfigControllerGet) {
      yield RemoteConfigControllerLoading.fromOldState(state);

      try {
        // await _remoteConfig.fetchAndActivate();
        final Map<String, RemoteConfigValue> values = _remoteConfig.getAll();

        yield RemoteConfigControllerSuccess.fromOldState(
          state,
          values: values,
          isTesting: kDebugMode,
        );
      } catch (e) {
        yield RemoteConfigControllerFailure.fromOldState(
          state,
          customException: CustomException.unknown(message: e.toString()),
        );
      }
    }
  }
}
