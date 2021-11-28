import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const Height(
    this.height, {
    this.width,
    this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }
}

class Width extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const Width(
    this.width, {
    this.height,
    this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }
}
