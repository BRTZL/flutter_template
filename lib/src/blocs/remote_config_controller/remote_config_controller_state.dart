part of 'remote_config_controller_bloc.dart';

abstract class RemoteConfigControllerState extends Equatable {
  final Map<String, RemoteConfigValue> values;
  final bool isTesting;

  const RemoteConfigControllerState({
    this.values,
    this.isTesting = false,
  });

  @override
  List<Object> get props => [values, isTesting];
}

class RemoteConfigControllerInitial extends RemoteConfigControllerState {}

class RemoteConfigControllerLoading extends RemoteConfigControllerState {
  RemoteConfigControllerLoading.fromOldState(
    RemoteConfigControllerState state,
  ) : super(
          values: state.values,
          isTesting: state.isTesting,
        );
}

class RemoteConfigControllerSuccess extends RemoteConfigControllerState {
  RemoteConfigControllerSuccess.fromOldState(
    RemoteConfigControllerState state, {
    Map<String, RemoteConfigValue> values,
    bool isTesting,
  }) : super(
          values: values ?? state.values,
          isTesting: isTesting ?? state.isTesting,
        );
}

class RemoteConfigControllerFailure extends RemoteConfigControllerState {
  final CustomException customException;

  RemoteConfigControllerFailure.fromOldState(
    RemoteConfigControllerState state, {
    @required this.customException,
  }) : super(
          values: state.values,
          isTesting: state.isTesting,
        );

  @override
  List<Object> get props => [customException, ...super.props];
}
