import 'dart:convert';

/// DebugLog provides structured, timestamped debug logging for UI flows,
/// network requests/responses, and error states. Logs are printed as JSON
/// lines for easy filtering and analysis in console output.
class DebugLog {
  static String? _currentFlowId;
  static final List<Map<String, dynamic>> _buffer = [];

  /// Start a new logical flow for correlation across logs.
  /// Returns the generated `flowId` that can be used to tag events.
  static String startFlow(String name, {Map<String, dynamic>? details}) {
    final id = _generateId();
    final entry = {
      'ts': _ts(),
      'level': 'INFO',
      'event': 'flow_start',
      'flow': name,
      'flowId': id,
      'details': ?details,
    };
    _write(entry);
    _currentFlowId = id;
    return id;
  }

  /// Mark the end of a flow with success/failure and optional summary.
  static void endFlow(
    String flowId, {
    bool success = true,
    String? message,
    Map<String, dynamic>? summary,
  }) {
    final entry = {
      'ts': _ts(),
      'level': success ? 'INFO' : 'ERROR',
      'event': 'flow_end',
      'flowId': flowId,
      'message': ?message,
      'summary': ?summary,
    };
    _write(entry);
    if (_currentFlowId == flowId) _currentFlowId = null;
  }

  /// Set the current flow id for subsequent logs (used for correlation).
  static void setCurrentFlowId(String? flowId) {
    _currentFlowId = flowId;
  }

  /// Clear the current flow id.
  static void clearCurrentFlowId() {
    _currentFlowId = null;
  }

  /// Log a UI state change.
  static void uiState(
    String state,
    Map<String, dynamic> details, {
    String? flowId,
  }) {
    final entry = {
      'ts': _ts(),
      'level': 'INFO',
      'event': 'ui_state',
      'flowId': flowId ?? _currentFlowId,
      'state': state,
      'details': details,
    };
    _write(entry);
  }

  /// Log a network request with method, url, and payload.
  static void networkRequest(
    String method,
    String url, {
    Map<String, dynamic>? payload,
    String? flowId,
  }) {
    final entry = {
      'ts': _ts(),
      'level': 'INFO',
      'event': 'network_request',
      'flowId': flowId ?? _currentFlowId,
      'method': method,
      'url': url,
      'payload': ?payload,
    };
    _write(entry);
  }

  /// Log a network response with status and body and optional duration.
  static void networkResponse(
    String url,
    int statusCode, {
    dynamic body,
    int? durationMs,
    String? flowId,
  }) {
    final entry = {
      'ts': _ts(),
      'level': statusCode >= 200 && statusCode < 300 ? 'INFO' : 'ERROR',
      'event': 'network_response',
      'flowId': flowId ?? _currentFlowId,
      'url': url,
      'statusCode': statusCode,
      'durationMs': ?durationMs,
      'body': ?body,
    };
    _write(entry);
  }

  /// Log an error with contextual details.
  static void error(
    String message, {
    Map<String, dynamic>? details,
    String? flowId,
  }) {
    final entry = {
      'ts': _ts(),
      'level': 'ERROR',
      'event': 'error',
      'flowId': flowId ?? _currentFlowId,
      'message': message,
      'details': ?details,
    };
    _write(entry);
  }

  /// Retrieve an in-memory buffer of recent log entries for inspection.
  static List<Map<String, dynamic>> get buffer => List.unmodifiable(_buffer);

  static void _write(Map<String, dynamic> entry) {
    _buffer.add(entry);
    // Keep buffer to last 500 events
    if (_buffer.length > 500) {
      _buffer.removeAt(0);
    }
    // Print as JSON line for structured logs
    // Using print to avoid debugPrint truncation for very long lines
    print(jsonEncode(entry));
  }

  static String _ts() => DateTime.now().toIso8601String();
  static String _generateId() =>
      'flow_${DateTime.now().microsecondsSinceEpoch}_${(_rand() % 10000).toString().padLeft(4, '0')}';
  static int _randSeed = 123456789;
  static int _rand() {
    // Simple LCG to avoid importing math.Random
    _randSeed = (1103515245 * _randSeed + 12345) & 0x7fffffff;
    return _randSeed;
  }
}
