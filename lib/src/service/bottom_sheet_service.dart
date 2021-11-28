import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/app_localizations.dart';
import 'package:flutter_template/src/enums/document_source.dart';

mixin BottomSheetService {
  static Future<DocumentSource> showDocumentSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(FeatherIcons.camera),
                title: Text(
                  AppLocalizations.of(context).translate('DOCUMENT_CAMERA'),
                ),
                onTap: () {
                  Navigator.of(context).pop(DocumentSource.CAMERA);
                },
              ),
              ListTile(
                leading: const Icon(FeatherIcons.image),
                title: Text(
                  AppLocalizations.of(context).translate('DOCUMENT_GALLERY'),
                ),
                onTap: () {
                  Navigator.of(context).pop(DocumentSource.GALLERY);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
