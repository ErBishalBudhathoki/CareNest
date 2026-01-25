
class TeamMember {
  final String userId;
  final String role;
  final String status;
  final DateTime joinedAt;

  const TeamMember({
    required this.userId,
    required this.role,
    this.status = 'active',
    required this.joinedAt,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      userId: json['userId'] as String,
      role: json['role'] as String,
      status: json['status'] as String? ?? 'active',
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}

class Team {
  final String? id;
  final String name;
  final String ownerId;
  final List<TeamMember> members;
  final Map<String, dynamic> settings;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Team({
    this.id,
    required this.name,
    required this.ownerId,
    required this.members,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'] as String?,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      members: (json['members'] as List<dynamic>)
          .map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      settings: json['settings'] as Map<String, dynamic>? ?? {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'name': name,
      'ownerId': ownerId,
      'members': members.map((e) => e.toJson()).toList(),
      'settings': settings,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class EmergencyBroadcast {
  final String? id;
  final String teamId;
  final String initiatorId;
  final String type;
  final String message;
  final String status;
  final List<String> acknowledgments;
  final DateTime createdAt;

  const EmergencyBroadcast({
    this.id,
    required this.teamId,
    required this.initiatorId,
    required this.type,
    required this.message,
    this.status = 'active',
    this.acknowledgments = const [],
    required this.createdAt,
  });

  factory EmergencyBroadcast.fromJson(Map<String, dynamic> json) {
    return EmergencyBroadcast(
      id: json['_id'] as String?,
      teamId: json['teamId'] as String,
      initiatorId: json['initiatorId'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      status: json['status'] as String? ?? 'active',
      acknowledgments: (json['acknowledgments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'teamId': teamId,
      'initiatorId': initiatorId,
      'type': type,
      'message': message,
      'status': status,
      'acknowledgments': acknowledgments,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
