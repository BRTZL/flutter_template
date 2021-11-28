import 'package:flutter/material.dart';

class ReassembleListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onReassemble;

  const ReassembleListener({
    Key key,
    @required this.child,
    @required this.onReassemble,
  }) : super(key: key);

  @override
  _ReassembleListenerState createState() => _ReassembleListenerState();
}

class _ReassembleListenerState extends State<ReassembleListener> {
  @override
  void reassemble() {
    super.reassemble();
    if (widget.onReassemble != null) {
      widget.onReassemble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
