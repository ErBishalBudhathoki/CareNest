import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/ocr_result.dart';

final ocrRepositoryProvider = Provider<OcrRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return OcrRepository(apiMethod);
});

class OcrRepository {
  final ApiMethod _apiMethod;

  OcrRepository(this._apiMethod);

  Future<OcrResult> parseReceipt(String rawText,
      {String source = 'unknown'}) async {
    final response = await _apiMethod.post(
      'ocr/parse', // Matches backend route /api/ocr/parse (via base URL)
      body: {'rawText': rawText, 'source': source},
    );

    if (response['success'] == true) {
      return OcrResult.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to parse receipt');
    }
  }
}
