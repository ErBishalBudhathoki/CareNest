import 'dart:io';

abstract class OcrService {
  Future<String> recognizeText(File image);
}
