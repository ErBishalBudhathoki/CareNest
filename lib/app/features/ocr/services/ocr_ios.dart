import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'ocr_interface.dart';

class IOSOcrService implements OcrService {
  static const platform = MethodChannel('com.bishal.invoice/vision');

  @override
  Future<String> recognizeText(File image) async {
    try {
      final String result =
          await platform.invokeMethod('recognizeText', {'path': image.path});
      return result;
    } on PlatformException catch (e) {
      debugPrint("Failed to recognize text via Apple Vision: '${e.message}'.");
      return '';
    }
  }
}
