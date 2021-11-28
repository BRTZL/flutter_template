import 'package:flutter/material.dart';

extension ShadowExtension on Widget {
  Container withShadow({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BorderRadius borderRadius,
    Color borderColor,
    double offset = 6.0,
    double blurRadius = 16.0,
  }) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(15.0),
        border: borderColor != null
            ? Border.all(
                color: borderColor,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: Offset(-offset, -offset),
            blurRadius: blurRadius,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: Offset(offset, offset),
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: this,
      ),
    );
  }
}

extension ButtonExtension on Widget {
  Material withOnPressed({
    @required Function() onPressed,
    Function() onLongPressed,
    BorderRadius borderRadius,
    EdgeInsets padding,
    EdgeInsets margin,
    Color color,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),
          child: this,
        ),
      ),
    );
  }
}

extension TextExtension on num {
  String toFixed() {
    final numAsString = toStringAsFixed(1);

    if (numAsString.endsWith('.0')) {
      return toStringAsFixed(0);
    } else {
      return numAsString;
    }
  }
}
