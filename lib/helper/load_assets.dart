import 'package:flutter_svg/flutter_svg.dart';

Future loadAssets() async {
  final List<String> assetList = [
    "assets/flutter_template_logo.svg",
  ];

  await Future.wait(assetList.map((e) => precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, e), null)));
}
