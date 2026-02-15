import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'ocr_interface.dart';

OcrService getOcrService() => AndroidOcrService();

class AndroidOcrService implements OcrService {
  static const platform = MethodChannel('com.bishal.invoice/ocr');

  @override
  Future<String> recognizeText(File image) async {
    try {
      final String result = await platform.invokeMethod('recognizeText', {'path': image.path});
      return result;
    } on PlatformException catch (e) {
      debugPrint("Failed to recognize text via MLKit: '${e.message}'.");
      return '';
    }
  }
}
