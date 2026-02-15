import 'dart:io';
import 'ocr_interface.dart';
import 'ocr_ios.dart';
import 'ocr_android.dart';

OcrService getOcrService() {
  if (Platform.isIOS) {
    return IOSOcrService();
  }
  return AndroidOcrService();
}
