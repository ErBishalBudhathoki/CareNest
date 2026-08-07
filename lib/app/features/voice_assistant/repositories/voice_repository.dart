import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/voice_models.dart';

final voiceRepositoryProvider = Provider<VoiceRepository>((ref) {
  return VoiceRepository(ref.read(app_providers.apiMethodProvider));
});

class VoiceRepository {
  final ApiMethod _apiMethod;

  VoiceRepository(this._apiMethod);

  Future<VoiceCommand> processCommand(
    String text, {
    Map<String, dynamic>? context,
  }) async {
    final response = await _apiMethod.post(
      'api/voice/command',
      body: {'commandText': text, if (context != null) 'context': context},
    );

    if (response['success'] == true) {
      return VoiceCommand.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to process voice command');
    }
  }

  Future<List<VoiceCommand>> getHistory() async {
    final response = await _apiMethod.get('api/voice/history');

    if (response['success'] == true) {
      final List<dynamic> list = response['data'];
      return list.map((e) => VoiceCommand.fromJson(e)).toList();
    } else {
      throw Exception(
        response['message'] ?? 'Failed to fetch voice command history',
      );
    }
  }
}
