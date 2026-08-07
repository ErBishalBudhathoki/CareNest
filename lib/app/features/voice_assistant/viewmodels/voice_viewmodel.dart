import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/voice_assistant/models/voice_models.dart';
import 'package:carenest/app/features/voice_assistant/repositories/voice_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceState {
  final List<VoiceCommand> history;
  final bool isProcessing;
  final String? errorMessage;
  final VoiceCommand? lastCommand;

  VoiceState({
    this.history = const [],
    this.isProcessing = false,
    this.errorMessage,
    this.lastCommand,
  });

  VoiceState copyWith({
    List<VoiceCommand>? history,
    bool? isProcessing,
    String? errorMessage,
    VoiceCommand? lastCommand,
  }) {
    return VoiceState(
      history: history ?? this.history,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: errorMessage,
      lastCommand: lastCommand ?? this.lastCommand,
    );
  }
}

class VoiceViewModel extends Notifier<VoiceState> {
  late final VoiceRepository _repository;

  @override
  VoiceState build() {
    _repository = ref.watch(voiceRepositoryProvider);
    return VoiceState();
  }

  Future<VoiceCommand?> processCommand(
    String text, {
    Map<String, dynamic>? context,
  }) async {
    state = state.copyWith(isProcessing: true, errorMessage: null);

    try {
      final command = await _repository.processCommand(text, context: context);
      state = state.copyWith(
        lastCommand: command,
        history: [command, ...state.history],
      );
      return command;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      debugPrint('VoiceViewModel Error: $e');
      return null;
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }

  Future<void> loadHistory() async {
    state = state.copyWith(isProcessing: true, errorMessage: null);
    try {
      final history = await _repository.getHistory();
      state = state.copyWith(history: history);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isProcessing: false);
    }
  }
}
