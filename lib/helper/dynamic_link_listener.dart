import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/helper/navigation_helper.dart';

class DynamicLinkListener extends StatefulWidget {
  final Widget child;

  const DynamicLinkListener({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _DynamicLinkListenerState createState() => _DynamicLinkListenerState();
}

class _DynamicLinkListenerState extends State<DynamicLinkListener> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;

        if (deepLink != null) {
          navigateWithParameter(context, deepLink.queryParameters);
        }
      },
      onError: (OnLinkErrorException e) async {
        inspect(e);
      },
    );

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      navigateWithParameter(context, deepLink.queryParameters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
