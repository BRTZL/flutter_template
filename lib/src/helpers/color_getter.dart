import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/palette.dart';

MaterialColor getColor(num value, num valueMax) {
  if (value == null || valueMax == null) {
    return Palette.primaryColor;
  }

  if (value < valueMax / 2) {
    return Palette.warningColor;
  } else if (value >= valueMax / 2 && value < valueMax) {
    return Palette.successColor;
  } else {
    return Palette.dangerColor;
  }
}
