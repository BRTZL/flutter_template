import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/imports.dart';

class CustomLoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomLoadingWidget({
    Key key,
    @required this.child,
    @required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: child,
        ),
        if (isLoading) ...[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
              child: const Center(
                child: CustomLoader(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
