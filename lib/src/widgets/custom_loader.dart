import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/src/config/imports.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({
    Key key,
    this.duration = const Duration(milliseconds: 2000),
    this.controller,
  }) : super(key: key);

  final Duration duration;
  final AnimationController controller;

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1;
  Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat();

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeInOutQuint,
        ),
      ),
    );

    _animation2 = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: CustomLoaderCurve(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: Palette.primaryColor,
      size: 64.w,
      itemCount: 8,
    );

    // ignore: dead_code
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - _animation2.value,
        child: Center(
          child: Transform(
            transform: Matrix4.identity()..rotateZ((_animation1.value) * 2 * pi),
            alignment: FractionalOffset.center,
            child: Center(
              child: SvgPicture.asset(
                'assets/flutter_template_logo.svg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomLoaderCurve extends Curve {
  const CustomLoaderCurve();

  @override
  double transform(double t) => (t <= 0.5) ? 2 * t : 2 * (1 - t);
}
