import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateMyAppListener extends StatefulWidget {
  final Widget child;

  const RateMyAppListener({
    Key key,
    @required this.child,
  }) : super(key: key);

  static void rate(BuildContext context) {
    context.findAncestorStateOfType<_RateMyAppListenerState>().rate();
  }

  @override
  _RateMyAppListenerState createState() => _RateMyAppListenerState();
}

class _RateMyAppListenerState extends State<RateMyAppListener> {
  final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'com.bartuozel.flutter_template.rate_my_app.preferences',
    minDays: 7,
    minLaunches: 14,
    remindDays: 7,
    remindLaunches: 14,
    googlePlayIdentifier: 'com.bartuozel.flutter_template',
    appStoreIdentifier: '1564294357',
  );

  void rate() {
    rateMyApp.showRateDialog(
      context,
      title: 'Rate this app',
      message: 'You like this app ? Then take a little bit of your time to leave a rating :',
      ignoreNativeDialog: false,
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }

  @override
  void initState() {
    super.initState();
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
