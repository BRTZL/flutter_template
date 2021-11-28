import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'bottom_navigation_bar_event.dart';
part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarBloc extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(const BottomNavigationBarInitial(index: 0));

  @override
  Stream<BottomNavigationBarState> mapEventToState(
    BottomNavigationBarEvent event,
  ) async* {
    if (event is BottomNavigationBarUpdate) {
      yield BottomNavigationBarUpdated(index: event.index);
    }
  }
}
