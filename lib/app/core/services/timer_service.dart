import 'dart:async';
import 'dart:isolate';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class TimerService extends ChangeNotifier {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  late DateTime _startTime;
  String currentTimerClientEmail = "";
  String? _activeClientEmail; // Track which client's timer is active
  String? _activeUserEmail; // Track which user's timer is active

  // Singleton pattern to ensure only one timer service instance
  static TimerService? _instance;
  static TimerService get instance {
    _instance ??= TimerService._internal();
    return _instance!;
  }

  TimerService._internal();

  // Factory constructor
  factory TimerService() {
    return instance;
  }

  // Getters
  String get timerClientEmail => currentTimerClientEmail;
  int get elapsedSeconds => _elapsedSeconds;
  bool get isRunning => _isRunning;
  String? get activeClientEmail => _activeClientEmail;
  String? get activeUserEmail => _activeUserEmail;

  // Map to store timer state for each user and client
  final Map<String, Map<String, TimerState>> _userTimers = {};

  // SharedPreferences keys
  static const String _keyIsRunning = 'timer_is_running';
  static const String _keyStartTime = 'timer_start_time';
  static const String _keyClientEmail = 'timer_client_email';
  static const String _keyUserEmail = 'timer_user_email';
  static const String _keyElapsedSeconds = 'timer_elapsed_seconds';

  /// Initialize timer service and restore any running timer from storage
  Future<void> initialize() async {
    await _restoreTimerState();
  }

  /// Check if another timer is already running for a different client
  bool canStartTimer(String userEmail, String clientEmail) {
    if (!_isRunning) return true;
    return _activeUserEmail == userEmail && _activeClientEmail == clientEmail;
  }

  /// Get active timer info
  Map<String, String?> getActiveTimerInfo() {
    return {
      'userEmail': _activeUserEmail,
      'clientEmail': _activeClientEmail,
    };
  }

  void setTimerClientEmail(String clientEmail) {
    currentTimerClientEmail = clientEmail;
    debugPrint("Set timer Client: $currentTimerClientEmail");
    notifyListeners();
  }

  String getTimerClientEmail() {
    //debugPrint("Get timer Client: $currentTimerClientEmail");
    return currentTimerClientEmail;
  }

  int _totalTime = 0;

  int get totalTime => _totalTime;

  void setTotalTime(int totalTime) {
    _totalTime = totalTime;
    notifyListeners();
  }

  void setElapsedSeconds(int elapsedSeconds) {
    _elapsedSeconds = elapsedSeconds;
    notifyListeners();
  }

  /// Start timer with user and client context
  Future<bool> startTimer(String userEmail, String clientEmail) async {
    // Check if another timer is running
    if (_isRunning &&
        (_activeUserEmail != userEmail || _activeClientEmail != clientEmail)) {
      return false; // Cannot start, another timer is running
    }

    if (_isRunning) return true; // Already running for this user/client

    _activeUserEmail = userEmail;
    _activeClientEmail = clientEmail;
    currentTimerClientEmail = clientEmail;
    _startTime = DateTime.now();
    _isRunning = true;
    _elapsedSeconds = 0;

    // Save to persistent storage
    await _saveTimerState();

    // Start the periodic timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var currentTime = DateTime.now();
      _elapsedSeconds = currentTime.difference(_startTime).inSeconds;

      // Update storage periodically (every 10 seconds to avoid too many writes)
      if (_elapsedSeconds % 10 == 0) {
        await _saveTimerState();
      }

      notifyListeners();
    });

    notifyListeners();
    return true;
  }

  /// Legacy start method for backward compatibility
  void start() {
    if (_isRunning) return;
    _startTime = DateTime.now();
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var currentTime = DateTime.now();
      _elapsedSeconds = currentTime.difference(_startTime).inSeconds;
      notifyListeners();
    });
    notifyListeners();
  }

  /// Stop timer and clear persistent storage
  Future<void> stopTimer() async {
    _timer?.cancel();
    _isRunning = false;
    _activeUserEmail = null;
    _activeClientEmail = null;
    currentTimerClientEmail = "";

    // Clear from persistent storage
    await _clearTimerState();

    notifyListeners();
  }

  /// Legacy stop method for backward compatibility
  void stop() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer(String clientEmail) {
    currentTimerClientEmail = clientEmail;
    _elapsedSeconds = 0;
    _totalTime = 0;
    _isRunning = false;
    _activeClientEmail = null;
    _activeUserEmail = null;

    // Clear persistent storage for the reset
    _clearTimerState();

    // Notify listeners to update UI
    notifyListeners();
  }

  String getFormattedTime(int timeInSeconds) {
    int hours = (timeInSeconds ~/ 3600).toInt();
    int minutes = ((timeInSeconds % 3600) ~/ 60).toInt();
    int seconds = (timeInSeconds % 60).toInt();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Save timer state to persistent storage
  Future<void> _saveTimerState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsRunning, _isRunning);
      await prefs.setInt(_keyStartTime, _startTime.millisecondsSinceEpoch);
      await prefs.setString(_keyClientEmail, _activeClientEmail ?? '');
      await prefs.setString(_keyUserEmail, _activeUserEmail ?? '');
      await prefs.setInt(_keyElapsedSeconds, _elapsedSeconds);
    } catch (e) {
      debugPrint('Error saving timer state: $e');
    }
  }

  /// Restore timer state from persistent storage
  Future<void> _restoreTimerState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wasRunning = prefs.getBool(_keyIsRunning) ?? false;

      if (!wasRunning) return;

      final startTimeMs = prefs.getInt(_keyStartTime);
      final clientEmail = prefs.getString(_keyClientEmail);
      final userEmail = prefs.getString(_keyUserEmail);

      if (startTimeMs != null && clientEmail != null && userEmail != null) {
        _activeClientEmail = clientEmail;
        _activeUserEmail = userEmail;
        currentTimerClientEmail = clientEmail;
        _startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMs);
        _isRunning = true;

        // Calculate elapsed time since app was closed
        final currentTime = DateTime.now();
        _elapsedSeconds = currentTime.difference(_startTime).inSeconds;

        // Restart the periodic timer
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
          var currentTime = DateTime.now();
          _elapsedSeconds = currentTime.difference(_startTime).inSeconds;

          // Update storage periodically
          if (_elapsedSeconds % 10 == 0) {
            await _saveTimerState();
          }

          notifyListeners();
        });

        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error restoring timer state: $e');
      await _clearTimerState();
    }
  }

  /// Clear timer state from persistent storage
  Future<void> _clearTimerState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyIsRunning);
      await prefs.remove(_keyStartTime);
      await prefs.remove(_keyClientEmail);
      await prefs.remove(_keyUserEmail);
      await prefs.remove(_keyElapsedSeconds);
    } catch (e) {
      debugPrint('Error clearing timer state: $e');
    }
  }

  @override
  void dispose() {
    // Cancel all timers when the service is disposed
    for (final userTimers in _userTimers.values) {
      for (final timerState in userTimers.values) {
        timerState.timer?.cancel();
      }
    }
    _timer?.cancel();
    super.dispose();
  }
}
