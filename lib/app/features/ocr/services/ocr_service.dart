import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'ocr_stub.dart' if (dart.library.io) 'ocr_platform.dart';

class OcrService {
  final _picker = ImagePicker();
  final _cropper = ImageCropper();
  final _implementation = getOcrService();

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  Future<File?> cropImage(File file) async {
    final croppedFile = await _cropper.cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Receipt',
            toolbarColor: const Color(0xFF1D3557), // Bauhaus Blue
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Receipt',
        ),
      ],
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  Future<String> extractText(File file) async {
    return _implementation.recognizeText(file);
  }

  void dispose() {
    // No disposal needed for now as we removed direct MLKit usage from here
  }
}
