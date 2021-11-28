// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase blocBase) {
    super.onCreate(blocBase);
    if (kDebugMode) {
      print('onCreate -- blocBase: ${blocBase.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
    }
  }

  @override
  void onChange(BlocBase blocBase, Change change) {
    super.onChange(blocBase, change);
    if (kDebugMode) {
      print('onChange -- blocBase: ${blocBase.runtimeType}, change: $change');
      if (change.nextState.toString().endsWith('Failure')) {
        if (change.nextState.customException.status != 0) {
          log(change.nextState.customException.status.toString(), name: blocBase.runtimeType.toString());
        }
        log(change.nextState.customException.error.toString(), name: blocBase.runtimeType.toString());
        log(change.nextState.customException.message.toString(), name: blocBase.runtimeType.toString());
        log(change.nextState.customException.path.toString(), name: blocBase.runtimeType.toString());
      }
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
    }
  }

  @override
  void onError(BlocBase blocBase, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- blocBase: ${blocBase.runtimeType}, error: $error');
    }
    super.onError(blocBase, error, stackTrace);
  }

  @override
  void onClose(BlocBase blocBase) {
    super.onClose(blocBase);
    if (kDebugMode) {
      print('onClose -- blocBase: ${blocBase.runtimeType}');
    }
  }
}
