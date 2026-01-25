
import 'package:flutter/foundation.dart';
import 'package:carenest/app/features/voice_assistant/models/voice_models.dart';
import 'package:carenest/app/features/voice_assistant/repositories/voice_repository.dart';

class VoiceViewModel extends ChangeNotifier {
  final VoiceRepository _repository;

  VoiceViewModel(this._repository);

  List<VoiceCommand> _history = [];
  bool _isProcessing = false;
  String? _errorMessage;
  VoiceCommand? _lastCommand;

  List<VoiceCommand> get history => _history;
  bool get isProcessing => _isProcessing;
  String? get errorMessage => _errorMessage;
  VoiceCommand? get lastCommand => _lastCommand;

  Future<void> processCommand(String text) async {
    _isProcessing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final command = await _repository.processCommand(text);
      _lastCommand = command;
      _history.insert(0, command); // Add to top of history
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('VoiceViewModel Error: $e');
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  Future<void> loadHistory() async {
    _isProcessing = true;
    try {
      _history = await _repository.getHistory();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }
}
