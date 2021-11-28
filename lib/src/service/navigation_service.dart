import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final instance = NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(Widget widget) {
    return navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => widget));
  }
}
