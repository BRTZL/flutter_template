part of 'remote_config_controller_bloc.dart';

abstract class RemoteConfigControllerEvent extends Equatable {
  const RemoteConfigControllerEvent();

  @override
  List<Object> get props => [];
}

class RemoteConfigControllerGet extends RemoteConfigControllerEvent {}
