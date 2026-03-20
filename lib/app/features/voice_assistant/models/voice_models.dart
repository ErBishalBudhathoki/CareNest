class VoiceCommand {
  final String? id;
  final String userId;
  final String? organizationId;
  final String commandText;
  final String detectedIntent;
  final Map<String, dynamic> parameters;
  final double confidence;
  final bool executed;
  final DateTime createdAt;
  final String responseText;
  final String actionType;
  final String? suggestedRoute;
  final List<String> suggestions;
  final Map<String, dynamic>? resultData;
  final String source;
  final String language;
  final String? errorMessage;

  const VoiceCommand({
    this.id,
    required this.userId,
    this.organizationId,
    required this.commandText,
    required this.detectedIntent,
    required this.parameters,
    required this.confidence,
    required this.executed,
    required this.createdAt,
    required this.responseText,
    required this.actionType,
    this.suggestedRoute,
    required this.suggestions,
    this.resultData,
    required this.source,
    required this.language,
    this.errorMessage,
  });

  bool get canOpenRoute =>
      suggestedRoute != null &&
      suggestedRoute!.isNotEmpty &&
      suggestedRoute != 'voice_assistant';

  factory VoiceCommand.fromJson(Map<String, dynamic> json) {
    final nestedEntities = _asMap(json['nlpEntities']);
    final rawParameters = json['parameters'] ?? nestedEntities['parameters'];
    final rawResultData = json['resultData'] ?? json['result'];
    final createdAtValue = json['createdAt'];

    return VoiceCommand(
      id: _stringOrNull(json['id'] ?? json['_id']),
      userId: _stringOrNull(json['userId']) ?? '',
      organizationId: _stringOrNull(json['organizationId']),
      commandText: _stringOrNull(json['commandText'] ?? json['text']) ?? '',
      detectedIntent: _stringOrNull(
            json['detectedIntent'] ??
                json['intent'] ??
                nestedEntities['intent'],
          ) ??
          'unknown',
      parameters: _asMap(rawParameters),
      confidence: _doubleOrZero(
        json['confidence'] ?? nestedEntities['confidence'],
      ),
      executed: _boolOrFalse(json['executed'] ?? json['success']),
      createdAt: DateTime.tryParse(_stringOrNull(createdAtValue) ?? '') ??
          DateTime.now(),
      responseText: _stringOrNull(
            json['responseText'] ?? json['message'] ?? json['summary'],
          ) ??
          '',
      actionType: _stringOrNull(json['actionType']) ?? 'unsupported',
      suggestedRoute: _stringOrNull(json['suggestedRoute']),
      suggestions: _stringList(json['suggestions']),
      resultData: rawResultData == null ? null : _asMap(rawResultData),
      source: _stringOrNull(json['source']) ?? 'text',
      language: _stringOrNull(json['language']) ?? 'en-US',
      errorMessage: _stringOrNull(json['errorMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (organizationId != null) 'organizationId': organizationId,
      'commandText': commandText,
      'detectedIntent': detectedIntent,
      'parameters': parameters,
      'confidence': confidence,
      'executed': executed,
      'createdAt': createdAt.toIso8601String(),
      'responseText': responseText,
      'actionType': actionType,
      'suggestedRoute': suggestedRoute,
      'suggestions': suggestions,
      'resultData': resultData,
      'source': source,
      'language': language,
      'errorMessage': errorMessage,
    };
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map(
        (key, dynamic val) => MapEntry(key.toString(), val),
      );
    }
    return <String, dynamic>{};
  }

  static List<String> _stringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return const <String>[];
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  static double _doubleOrZero(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }

  static bool _boolOrFalse(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }
}
