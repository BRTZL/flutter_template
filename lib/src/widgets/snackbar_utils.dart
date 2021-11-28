import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/app_localizations.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:flutter_template/src/models/models.dart';
import 'package:system_settings/system_settings.dart';

mixin SnackBarUtils {
  static void showErrorSnackBar(BuildContext context, {@required CustomException customException}) {
    if (customException.status == -1) return _showPermissionErrorSnackBar(context, customException: customException);

    final errorKey = 'ERRORS_${customException.error.split('-').join('_').toUpperCase()}';
    var errorMessage = AppLocalizations.of(context).translate(errorKey);
    if (kDebugMode) {
      errorMessage = '$errorMessage\n\nerror: ${customException.error}\n\nmessage: ${customException.message}';
    }
    if (errorMessage == errorKey) {
      errorMessage = customException.message ?? AppLocalizations.of(context).translate('ERRORS_UNKOWN_ERROR');
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 6),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(errorMessage),
              ),
              const SizedBox(width: 12.0),
              const Icon(FeatherIcons.alertCircle, size: 30.0),
            ],
          ),
          backgroundColor: Palette.dangerColor,
        ),
      );
  }

  static void showErrorSnackBarWithOnPressed(
    BuildContext context, {
    @required CustomException customException,
    @required Function() onPressed,
  }) {
    if (customException.status == -1) return _showPermissionErrorSnackBar(context, customException: customException);

    final errorKey = 'ERRORS_${customException.error.split('-').join('_').toUpperCase()}';
    var errorMessage = AppLocalizations.of(context).translate(errorKey);
    if (kDebugMode) {
      errorMessage = '$errorMessage\n\nerror: ${customException.error}\n\nmessage: ${customException.message}';
    }
    if (errorMessage == errorKey) {
      errorMessage = customException.message ?? AppLocalizations.of(context).translate('ERRORS_UNKOWN_ERROR');
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 6),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          action: SnackBarAction(
            label: AppLocalizations.of(context).translate('WORDS_RELOAD'),
            textColor: Colors.white,
            onPressed: onPressed,
          ),
          content: Text(errorMessage),
          backgroundColor: Palette.dangerColor,
        ),
      );
  }

  static void _showPermissionErrorSnackBar(BuildContext context, {@required CustomException customException}) {
    final errorKey = 'ERRORS_${customException.error.split('-').join('_').toUpperCase()}';
    var errorMessage = AppLocalizations.of(context).translate(errorKey);
    if (kDebugMode) {
      errorMessage = '$errorMessage\n\nerror: ${customException.error}\n\nmessage: ${customException.message}';
    }
    if (errorMessage == errorKey) {
      errorMessage = customException.message ?? AppLocalizations.of(context).translate('ERRORS_UNKOWN_ERROR');
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: AppLocalizations.of(context).translate('APP_PROFILE_PERMISSIONS_PAGE_OPEN_SETTINGS'),
            textColor: Colors.white,
            onPressed: SystemSettings.app,
          ),
          duration: const Duration(seconds: 6),
          content: Text(errorMessage),
          backgroundColor: Palette.dangerColor,
        ),
      );
  }

  static void showSuccessSnackBar(BuildContext context, {@required String text}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(text),
              ),
              const Icon(FeatherIcons.checkCircle, size: 30.0),
            ],
          ),
          backgroundColor: Palette.successColor,
        ),
      );
  }

  static void showLoadingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).translate('LOADING_TEXT'),
                ),
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Palette.primaryColor),
              ),
            ],
          ),
        ),
      );
  }

  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
