import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/src/config/imports.dart';

mixin DialogUtils {
  static Future<bool> showCustomDialog(
    BuildContext context, {
    @required String title,
    @required String subtitle,
    @required String cancel,
    @required String confirm,
    IconData icon = FeatherIcons.info,
    Color iconColor = Palette.dangerColor,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            height: 420.0,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      FeatherIcons.x,
                      color: Palette.grayColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
                Icon(
                  icon,
                  color: iconColor,
                  size: 100.w,
                ),
                const Spacer(),
                Text(
                  title,
                  style: CustomTheme.headline6(context, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  subtitle,
                  style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700, color: Palette.secondaryTextColor),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: cancel,
                        customButtonType: CustomButtonType.cancel,
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: CustomButton(
                        text: confirm,
                        customButtonType: CustomButtonType.confirm,
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showCustomSuccessDialog(
    BuildContext context, {
    @required String title,
    @required String subtitle,
    @required String confirm,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            height: 420.0,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      FeatherIcons.x,
                      color: Palette.grayColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Icon(
                  FeatherIcons.checkCircle,
                  color: Palette.successColor,
                  size: 100.w,
                ),
                const Spacer(),
                Text(
                  title,
                  style: CustomTheme.headline6(context, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  subtitle,
                  style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700, color: Palette.secondaryTextColor),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CustomButton(
                  text: confirm,
                  customButtonType: CustomButtonType.confirm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showCustomFailureDialog(
    BuildContext context, {
    @required String title,
    @required String subtitle,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            height: 400.0,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      FeatherIcons.x,
                      color: Palette.grayColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Icon(
                  FeatherIcons.alertCircle,
                  color: Palette.dangerColor,
                  size: 100.w,
                ),
                const Spacer(),
                Text(
                  title,
                  style: CustomTheme.headline6(context, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  subtitle,
                  style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700, color: Palette.secondaryTextColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
