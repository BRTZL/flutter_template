import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/src/enums/navigation_type.dart';
import 'package:share/share.dart';

mixin DynamicLinkService {
  static Future<Uri> createDynamicLink({
    @required NavigationType navigationType,
    @required int id,
    String title,
    String description,
    String imageUrl,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://flutter_template.com/share',
      link: Uri.parse('https://flutter_template.com/share?type=${EnumToString.convertToString(navigationType)}&id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.bartuozel.flutter_template',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.bartuozel.flutter_template',
        minimumVersion: '1',
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      socialMetaTagParameters: title != null || description != null || imageUrl != null
          ? SocialMetaTagParameters(
              title: title,
              description: description,
              imageUrl: imageUrl != null ? Uri.parse(imageUrl) : null,
            )
          : null,
    );

    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    return shortDynamicLink.shortUrl;
  }

  static Future<void> shareDynamicLink({
    @required NavigationType navigationType,
    @required int id,
    String title,
    String description,
    String imageUrl,
  }) async {
    final Uri deepLink = await createDynamicLink(
      navigationType: navigationType,
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );

    await Share.share(deepLink.toString());

    await FirebaseAnalytics().logShare(
      contentType: EnumToString.convertToString(navigationType),
      itemId: id.toString(),
      method: 'link',
    );
  }
}
