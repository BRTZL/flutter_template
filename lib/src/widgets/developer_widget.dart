import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/blocs/blocs.dart';

class DeveloperWidget extends StatefulWidget {
  final Widget child;

  const DeveloperWidget({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _DeveloperWidgetState createState() => _DeveloperWidgetState();
}

class _DeveloperWidgetState extends State<DeveloperWidget> {
  @override
  Widget build(BuildContext context) {
    if (context.read<RemoteConfigControllerBloc>().state.isTesting || kDebugMode) {
      return widget.child;
    } else {
      return const SizedBox.shrink();
    }
  }
}
