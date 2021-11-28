import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/helper/navigation_helper.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:in_app_notification/in_app_notification.dart';

class CloudMessagingListener extends StatefulWidget {
  final Widget child;

  const CloudMessagingListener({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _CloudMessagingListenerState createState() => _CloudMessagingListenerState();
}

class _CloudMessagingListenerState extends State<CloudMessagingListener> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      FirebaseMessaging.instance.getToken().then((value) {
        log(value, name: 'FCM_TOKEN');
      });
    }

    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    FirebaseMessaging.onMessage.listen(onMessage);
  }

  void onMessageOpenedApp(RemoteMessage message) {
    if (message.data != null) {
      navigateWithParameter(context, message.data);
    }
  }

  void onMessage(RemoteMessage message) {
    if (message.notification != null) {
      InAppNotification.show(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((Platform.isIOS ? message.notification.apple.imageUrl : message.notification.android.imageUrl) != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    Platform.isIOS ? message.notification.apple.imageUrl : message.notification.android.imageUrl,
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                const SizedBox(width: 20.0),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.notification.title,
                      style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      message.notification.body,
                      style: CustomTheme.body(context, color: Palette.secondaryTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).withShadow(
          borderRadius: BorderRadius.circular(15.0),
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(12.0),
          borderColor: Palette.primaryColor,
        ),
        onTap: () {
          if (message.data != null) {
            navigateWithParameter(context, message.data);
          }
        },
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
