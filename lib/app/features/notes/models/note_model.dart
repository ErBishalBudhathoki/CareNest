class Note {
  final String id;
  final String userEmail;
  final String clientEmail;
  final String notes;
  final String organizationId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.userEmail,
    required this.clientEmail,
    required this.notes,
    required this.organizationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? '',
      userEmail: json['userEmail'] ?? '',
      clientEmail: json['clientEmail'] ?? '',
      notes: json['notes'] ?? '',
      organizationId: json['organizationId'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userEmail': userEmail,
      'clientEmail': clientEmail,
      'notes': notes,
      'organizationId': organizationId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Note copyWith({
    String? id,
    String? userEmail,
    String? clientEmail,
    String? notes,
    String? organizationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      clientEmail: clientEmail ?? this.clientEmail,
      notes: notes ?? this.notes,
      organizationId: organizationId ?? this.organizationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NotesPagination {
  final int page;
  final int limit;
  final int total;
  final int pages;

  NotesPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory NotesPagination.fromJson(Map<String, dynamic> json) {
    return NotesPagination(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 1,
    );
  }
}

class NotesResponse {
  final List<Note> notes;
  final NotesPagination pagination;

  NotesResponse({
    required this.notes,
    required this.pagination,
  });

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> notesList = json['notes'] ?? [];
    return NotesResponse(
      notes: notesList.map((e) => Note.fromJson(e)).toList(),
      pagination: NotesPagination.fromJson(json['pagination'] ?? {}),
    );
  }
}
