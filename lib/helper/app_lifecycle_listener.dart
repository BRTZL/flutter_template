import 'package:flutter/material.dart';

typedef AppLifecycleListenerCallback = Function(AppLifecycleState state, AppLifecycleState oldState);

class AppLifecycleListener extends StatefulWidget {
  final Widget _child;
  final AppLifecycleListenerCallback _appLifecycleListenerCallback;

  const AppLifecycleListener({
    Key key,
    @required Widget child,
    @required AppLifecycleListenerCallback appLifecycleListenerCallback,
  })  : _child = child,
        _appLifecycleListenerCallback = appLifecycleListenerCallback,
        super(key: key);

  @override
  _AppLifecycleReactorState createState() => _AppLifecycleReactorState();
}

class _AppLifecycleReactorState extends State<AppLifecycleListener> with WidgetsBindingObserver {
  AppLifecycleState _oldState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget._appLifecycleListenerCallback(state, _oldState);
    _oldState = state;
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }
}
