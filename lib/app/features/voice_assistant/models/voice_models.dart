
class VoiceCommand {
  final String? id;
  final String userId;
  final String commandText;
  final String detectedIntent;
  final Map<String, dynamic> parameters;
  final double confidence;
  final bool executed;
  final DateTime createdAt;

  const VoiceCommand({
    this.id,
    required this.userId,
    required this.commandText,
    required this.detectedIntent,
    required this.parameters,
    required this.confidence,
    required this.executed,
    required this.createdAt,
  });

  factory VoiceCommand.fromJson(Map<String, dynamic> json) {
    return VoiceCommand(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      commandText: json['commandText'] as String,
      detectedIntent: json['detectedIntent'] as String,
      parameters: json['parameters'] as Map<String, dynamic>? ?? {},
      confidence: (json['confidence'] as num).toDouble(),
      executed: json['executed'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'commandText': commandText,
      'detectedIntent': detectedIntent,
      'parameters': parameters,
      'confidence': confidence,
      'executed': executed,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
