import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'ocr_interface.dart';

OcrService getOcrService() => AndroidOcrService();

class AndroidOcrService implements OcrService {
  @override
  Future<String> recognizeText(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      debugPrint("Failed to recognize text via ML Kit: '$e'.");
      return '';
    } finally {
      await textRecognizer.close();
    }
  }
}
