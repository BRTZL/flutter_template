import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/enums/navigation_type.dart';
import 'package:flutter_template/src/enums/notification_type.dart';

Future<void> navigateWithParameter(BuildContext context, Map<String, dynamic> data) async {
  if (data == null) return;
  final NavigationType navigationType = EnumToString.fromString(NavigationType.values, data["type"] as String);
  final NotificationType notificationType = EnumToString.fromString(NotificationType.values, data["type"] as String);
  if (navigationType == null && notificationType == null) return;

  // ignore: unused_local_variable
  int id = -1;

  if (navigationType != null) {
    id = int.tryParse(data["id"].toString());
  } else if (notificationType != null) {
    id = int.tryParse(json.decode(data["payload"] as String)["id"].toString());
  }

  if (context.read<AuthenticationBloc>().state is AuthenticationAuthenticated) {
    blocGet(context);
    if (navigationType != null) {
      // + for example
      // if (navigationType == NavigationType.test) {
      // NavigationService.instance.push(
      //   FutureLoader<Food>(
      //     future: context.read<FoodRepository>().getFood(id: id),
      //     child: (food) => FoodDetailsScreen(
      //       food: food,
      //       heroTag: '',
      //     ),
      //   ),
      // );
      // }
    } else if (notificationType != null) {}
  }
}
