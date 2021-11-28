import 'package:flutter/material.dart';

mixin Palette {
  //? COLORS

  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFF80B3FF),
      100: Color(0xFF66A3FF),
      200: Color(0xFF4D94FF),
      300: Color(0xFF3385FF),
      400: Color(0xFF1A75FF),
      500: Color(_primaryValue),
      600: Color(0xFF005CE6),
      700: Color(0xFF0052CC),
      800: Color(0xFF0047B3),
      900: Color(0xFF003D99),
    },
  );
  static const int _primaryValue = 0xFF0066FF;

  static const MaterialColor secondaryColor = MaterialColor(
    _secondaryValue,
    <int, Color>{
      50: Color(0xFFE9EBED),
      100: Color(0xFFD4D6DC),
      200: Color(0xFFA8AEB8),
      300: Color(0xFF7D8595),
      400: Color(0xFF515D71),
      500: Color(_secondaryValue),
      600: Color(0xFF1E2A3E),
      700: Color(0xFF171F2F),
      800: Color(0xFF0F151F),
      900: Color(0xFF080A10),
    },
  );
  static const int _secondaryValue = 0xFF26344E;

  static const MaterialColor dangerColor = MaterialColor(
    _dangerValue,
    <int, Color>{
      50: Color(0xFFFFEEEB),
      100: Color(0xFFFEDDD6),
      200: Color(0xFFFDBBAD),
      300: Color(0xFFFC9A84),
      400: Color(0xFFFB785B),
      500: Color(_dangerValue),
      600: Color(0xFFC84528),
      700: Color(0xFF96341E),
      800: Color(0xFF642214),
      900: Color(0xFF32110A),
    },
  );
  static const int _dangerValue = 0xFFFA5632;

  static const MaterialColor warningColor = MaterialColor(
    _warningValue,
    <int, Color>{
      50: Color(0xFFFFF8E9),
      100: Color(0xFFFFF1D2),
      200: Color(0xFFFFE4A5),
      300: Color(0xFFFFD678),
      400: Color(0xFFFFC94B),
      500: Color(_warningValue),
      600: Color(0xFFCC9618),
      700: Color(0xFF997012),
      800: Color(0xFF664B0C),
      900: Color(0xFF332506),
    },
  );
  static const int _warningValue = 0xFFFFBB1E;

  static const MaterialColor successColor = MaterialColor(
    _successValue,
    <int, Color>{
      50: Color(0xFFE6F9EE),
      200: Color(0xFFCDF3DD),
      100: Color(0xFF9CE7BC),
      300: Color(0xFF6ADB9A),
      400: Color(0xFF39CF79),
      500: Color(_successValue),
      600: Color(0xFF069C46),
      700: Color(0xFF05893D),
      800: Color(0xFF04622C),
      900: Color(0xFF023A1A),
    },
  );
  static const int _successValue = 0xFF07C357;

  static const MaterialColor grayColor = MaterialColor(
    _grayValue,
    <int, Color>{
      50: Color(0xFFF7F9FA),
      100: Color(0xFFEFF2F5),
      200: Color(0xFFDFE5EB),
      300: Color(0xFFCED8E1),
      400: Color(0xFFBECBD7),
      500: Color(_grayValue),
      600: Color(0xFF8B98A4),
      700: Color(0xFF68727B),
      800: Color(0xFF464C52),
      900: Color(0xFF232629),
    },
  );
  static const int _grayValue = 0xFFAEBECD;

  static Color primaryTextColor = secondaryColor.shade500;
  static Color secondaryTextColor = grayColor.shade700;
  static Color hintTextColor = grayColor.shade600;

  static const LinearGradient linearGradient = LinearGradient(
    colors: [
      primaryColor,
      primaryColor,
    ],
  );
}
