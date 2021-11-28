import 'dart:io';

import 'package:flutter_template/src/enums/document_source.dart';
import 'package:flutter_template/src/service/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
  final ImagePicker _imagePicker;

  FilePickerService() : _imagePicker = ImagePicker();

  Future<File> pickFile(DocumentSource documentSource) async {
    File file;

    if (documentSource == DocumentSource.CAMERA) {
      await PermissionService.requestCamera();

      final XFile pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return null;

      final File tempFile = await _cropImage(File(pickedFile.path));

      if (tempFile == null) return null;
      file = tempFile;
    } else if (documentSource == DocumentSource.GALLERY) {
      await PermissionService.requestPhotos();

      final XFile pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final File tempFile = await _cropImage(File(pickedFile.path));

      file = tempFile;
    }

    return file;
  }

  Future<File> _cropImage(File file) async {
    final File tempFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      androidUiSettings: const AndroidUiSettings(),
      iosUiSettings: const IOSUiSettings(),
      compressQuality: 30,
    );

    return tempFile;
  }
}
