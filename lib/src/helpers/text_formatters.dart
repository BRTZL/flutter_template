import 'package:flutter/services.dart';

final decimalTextInputFormatter = FilteringTextInputFormatter.allow(RegExp('[+-]?([0-9]+([.|,][0-9]*)?|[.|,][0-9]+)'));

num parseString(String val) {
  try {
    return num.parse(val.replaceAll(',', '.'));
  } catch (e) {
    return 0;
  }
}
