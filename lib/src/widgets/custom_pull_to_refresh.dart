import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_template/src/config/imports.dart';

class CustomPullToRefresh extends StatefulWidget {
  final Widget child;
  final Function() onRefresh;

  const CustomPullToRefresh({
    Key key,
    @required this.child,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  _CustomPullToRefreshState createState() => _CustomPullToRefreshState();
}

class _CustomPullToRefreshState extends State<CustomPullToRefresh> with SingleTickerProviderStateMixin {
  static const _indicatorSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: () async {
        widget.onRefresh();
      },
      completeStateDuration: const Duration(seconds: 1),
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget _) {
                return Container(
                  alignment: Alignment.center,
                  height: controller.value * _indicatorSize,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: const AlwaysStoppedAnimation(
                          Palette.primaryColor,
                        ),
                        value: controller.isDragging || controller.isArmed ? controller.value.clamp(0.0, 1.0).toDouble() : null,
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(
                    0.0,
                    controller.value * _indicatorSize,
                  ),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
