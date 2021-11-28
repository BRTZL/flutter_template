import 'package:url_launcher/url_launcher.dart';

Future<void> launchLink(String url) async {
  if (await canLaunch(url)) {
    return launch(url);
  }

  return;
}
