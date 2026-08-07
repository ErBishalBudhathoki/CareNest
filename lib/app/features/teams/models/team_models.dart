class TeamMember {
  final String userId;
  final String displayName; // populated from userId.firstName + lastName
  final String email; // populated from userId.email
  final String role;
  final String status;
  final DateTime joinedAt;

  const TeamMember({
    required this.userId,
    this.displayName = '',
    this.email = '',
    required this.role,
    this.status = 'active',
    required this.joinedAt,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    // userId can be a populated object {_id/id, firstName, lastName, email}
    // or a plain string (when not populated)
    final rawUserId = json['userId'];
    final String userId;
    String displayName = '';
    String email = '';

    if (rawUserId is Map<String, dynamic>) {
      userId = (rawUserId['id'] ?? rawUserId['_id'] ?? '').toString();
      final first = (rawUserId['firstName'] as String? ?? '').trim();
      final last = (rawUserId['lastName'] as String? ?? '').trim();
      displayName = [first, last].where((s) => s.isNotEmpty).join(' ');
      email = (rawUserId['email'] as String? ?? '').trim();
    } else {
      userId = (rawUserId ?? '').toString();
    }

    return TeamMember(
      userId: userId,
      displayName: displayName,
      email: email,
      role: (json['role'] ?? 'member').toString(),
      status: (json['status'] ?? 'active').toString(),
      joinedAt:
          DateTime.tryParse(
            (json['joinedAt'] ?? json['createdAt'] ?? '') as String? ?? '',
          ) ??
          DateTime.now(),
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
      // backend toJSON transforms _id → id, but handle both defensively
      id: (json['id'] ?? json['_id'])?.toString(),
      name: (json['name'] ?? 'Unnamed Team').toString(),
      ownerId: (json['ownerId'] ?? json['managerId'] ?? '').toString(),
      // members may be absent on create; default to empty list
      members: (json['members'] as List<dynamic>? ?? [])
          .map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      settings: json['settings'] as Map<String, dynamic>? ?? {},
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
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
  final List<String> teamIds;
  final String initiatorId;
  final String? initiatorName; // populated firstName + lastName
  final String? initiatorEmail; // populated email
  final String type;
  final String message;
  final String status;
  final List<String> acknowledgments;
  final DateTime createdAt;

  const EmergencyBroadcast({
    this.id,
    required this.teamId,
    this.teamIds = const [],
    required this.initiatorId,
    this.initiatorName,
    this.initiatorEmail,
    required this.type,
    required this.message,
    this.status = 'active',
    this.acknowledgments = const [],
    required this.createdAt,
  });

  factory EmergencyBroadcast.fromJson(Map<String, dynamic> json) {
    final rawInitiator = json['initiatorId'];
    String iId = '';
    String? iName;
    String? iEmail;

    if (rawInitiator is Map<String, dynamic>) {
      iId = (rawInitiator['id'] ?? rawInitiator['_id'] ?? '').toString();
      final first = (rawInitiator['firstName'] as String? ?? '').trim();
      final last = (rawInitiator['lastName'] as String? ?? '').trim();
      iName = [first, last].where((s) => s.isNotEmpty).join(' ');
      iEmail = (rawInitiator['email'] as String? ?? '').trim();
    } else {
      iId = (rawInitiator ?? '').toString();
    }

    return EmergencyBroadcast(
      id: (json['id'] ?? json['_id'])?.toString(),
      teamId: (json['teamId'] ?? '').toString(),
      teamIds:
          (json['teamIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      initiatorId: iId,
      initiatorName: iName,
      initiatorEmail: iEmail,
      type: (json['type'] ?? 'general').toString(),
      message: (json['message'] ?? '').toString(),
      status: (json['status'] ?? 'active').toString(),
      acknowledgments:
          (json['acknowledgments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'teamId': teamId,
      'teamIds': teamIds,
      'initiatorId': initiatorId,
      'type': type,
      'message': message,
      'status': status,
      'acknowledgments': acknowledgments,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
