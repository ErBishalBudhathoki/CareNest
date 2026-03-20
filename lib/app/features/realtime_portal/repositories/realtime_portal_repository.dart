import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';

class RealtimePortalRepository {
  final ApiMethod _apiMethod;

  RealtimePortalRepository(this._apiMethod);

  String _toIsoString(dynamic value) {
    if (value == null) return DateTime.now().toIso8601String();
    if (value is String && value.trim().isNotEmpty) return value;
    if (value is DateTime) return value.toIso8601String();
    final parsed = DateTime.tryParse(value.toString());
    return (parsed ?? DateTime.now()).toIso8601String();
  }

  Map<String, dynamic> _normalizeMessage(Map<String, dynamic> input) {
    final map = Map<String, dynamic>.from(input);
    map['id'] = (map['id'] ?? map['_id'] ?? '').toString();
    map['timestamp'] = _toIsoString(map['timestamp']);
    return map;
  }

  Map<String, dynamic> _normalizeConversation(Map<String, dynamic> input) {
    final map = Map<String, dynamic>.from(input);
    map['id'] = (map['id'] ?? map['_id'] ?? '').toString();
    map['createdAt'] = _toIsoString(map['createdAt']);
    if (map['lastMessageAt'] != null) {
      map['lastMessageAt'] = _toIsoString(map['lastMessageAt']);
    }
    return map;
  }

  // ============================================================================
  // Real-Time Tracking Methods
  // ============================================================================

  /// Start tracking session
  Future<TrackingSession> startTracking({
    required String appointmentId,
    required String workerId,
    required ClientLocation clientLocation,
  }) async {
    try {
      final response = await _apiMethod.startRealtimeTracking(
        appointmentId: appointmentId,
        workerId: workerId,
        clientLocation: clientLocation.toJson(),
      );

      if (response['success'] == true && response['data'] != null) {
        return TrackingSession.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to start tracking');
    } catch (e) {
      throw Exception('Error starting tracking: $e');
    }
  }

  /// Update worker location
  Future<LiveLocation> updateLocation({
    required String appointmentId,
    required String workerId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) async {
    try {
      final response = await _apiMethod.updateRealtimeLocation(
        appointmentId: appointmentId,
        workerId: workerId,
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );

      if (response['success'] == true && response['data'] != null) {
        return LiveLocation.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to update location');
    } catch (e) {
      throw Exception('Error updating location: $e');
    }
  }

  /// Stop tracking session
  Future<TrackingSession> stopTracking({
    required String appointmentId,
  }) async {
    try {
      final response = await _apiMethod.stopRealtimeTracking(
        appointmentId: appointmentId,
      );

      if (response['success'] == true && response['data'] != null) {
        return TrackingSession.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to stop tracking');
    } catch (e) {
      throw Exception('Error stopping tracking: $e');
    }
  }

  /// Get live tracking data
  Future<LiveLocation?> getLiveTracking({
    required String appointmentId,
  }) async {
    try {
      final response = await _apiMethod.getLiveTracking(
        appointmentId: appointmentId,
      );

      if (response['success'] == true && response['data'] != null) {
        return LiveLocation.fromJson(response['data']);
      }

      return null;
    } catch (e) {
      throw Exception('Error getting live tracking: $e');
    }
  }

  // ============================================================================
  // Messaging Methods
  // ============================================================================

  /// Send message
  Future<SecureMessage> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderType,
    required String recipientId,
    required String message,
    List<MessageAttachment>? attachments,
  }) async {
    try {
      final response = await _apiMethod.sendRealtimeMessage(
        conversationId: conversationId,
        senderId: senderId,
        senderType: senderType,
        recipientId: recipientId,
        message: message,
        attachments: attachments?.map((a) => a.toJson()).toList(),
      );

      if (response['success'] == true && response['data'] != null) {
        return SecureMessage.fromJson(
          _normalizeMessage(Map<String, dynamic>.from(response['data'] as Map)),
        );
      }

      throw Exception(response['message'] ?? 'Failed to send message');
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  /// Get messages
  Future<List<SecureMessage>> getMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
  }) async {
    try {
      final response = await _apiMethod.getRealtimeMessages(
        conversationId: conversationId,
        limit: limit,
        before: before?.toIso8601String(),
      );

      if (response['success'] == true && response['data'] != null) {
        final messages = response['data'] as List;
        final parsedMessages = messages
            .whereType<Map>()
            .map(
              (m) => SecureMessage.fromJson(
                _normalizeMessage(Map<String, dynamic>.from(m)),
              ),
            )
            .toList();

        // UI expects chronological order (oldest -> newest).
        parsedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return parsedMessages;
      }

      throw Exception(response['message'] ?? 'Failed to get messages');
    } catch (e) {
      throw Exception('Error getting messages: $e');
    }
  }

  /// Create conversation
  Future<MessageThread> createConversation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.createRealtimeConversation(
        appointmentId: appointmentId,
        clientId: clientId,
        workerId: workerId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return MessageThread.fromJson(
          _normalizeConversation(
            Map<String, dynamic>.from(response['data'] as Map),
          ),
        );
      }

      throw Exception(response['message'] ?? 'Failed to create conversation');
    } catch (e) {
      throw Exception('Error creating conversation: $e');
    }
  }

  /// Get user conversations
  Future<List<MessageThread>> getUserConversations({
    required String userId,
  }) async {
    try {
      final response = await _apiMethod.getUserConversations(
        userId: userId,
      );

      if (response['success'] == true && response['data'] != null) {
        final conversations = response['data'] as List;
        return conversations
            .whereType<Map>()
            .map(
              (c) => MessageThread.fromJson(
                _normalizeConversation(Map<String, dynamic>.from(c)),
              ),
            )
            .toList();
      }

      throw Exception(response['message'] ?? 'Failed to get conversations');
    } catch (e) {
      throw Exception('Error getting conversations: $e');
    }
  }

  // ============================================================================
  // Digital Signature Methods
  // ============================================================================

  /// Save signature
  Future<DigitalSignature> saveSignature({
    required String appointmentId,
    required String clientId,
    required String signatureData,
  }) async {
    try {
      final response = await _apiMethod.saveDigitalSignature(
        appointmentId: appointmentId,
        clientId: clientId,
        signatureData: signatureData,
      );

      if (response['success'] == true && response['data'] != null) {
        return DigitalSignature.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to save signature');
    } catch (e) {
      throw Exception('Error saving signature: $e');
    }
  }

  /// Submit service confirmation
  Future<ServiceConfirmation> submitServiceConfirmation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String signatureId,
    int? rating,
    String? feedback,
    List<ChecklistItem>? checklist,
    List<String>? photos,
    List<IncidentReport>? incidents,
  }) async {
    try {
      final response = await _apiMethod.submitServiceConfirmation(
        appointmentId: appointmentId,
        clientId: clientId,
        workerId: workerId,
        signatureId: signatureId,
        rating: rating,
        feedback: feedback,
        checklist: checklist?.map((c) => c.toJson()).toList(),
        photos: photos,
        incidents: incidents?.map((i) => i.toJson()).toList(),
      );

      if (response['success'] == true && response['data'] != null) {
        return ServiceConfirmation.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to submit confirmation');
    } catch (e) {
      throw Exception('Error submitting confirmation: $e');
    }
  }

  /// Get service confirmation
  Future<ServiceConfirmation?> getServiceConfirmation({
    required String appointmentId,
  }) async {
    try {
      final response = await _apiMethod.getServiceConfirmation(
        appointmentId: appointmentId,
      );

      if (response['success'] == true && response['data'] != null) {
        return ServiceConfirmation.fromJson(response['data']);
      }

      return null;
    } catch (e) {
      throw Exception('Error getting confirmation: $e');
    }
  }

  /// Get checklist template
  Future<List<ChecklistItem>> getChecklistTemplate({
    required String serviceType,
  }) async {
    try {
      final response = await _apiMethod.getChecklistTemplate(
        serviceType: serviceType,
      );

      if (response['success'] == true && response['data'] != null) {
        final checklist = response['data'] as List;
        return checklist.map((c) => ChecklistItem.fromJson(c)).toList();
      }

      throw Exception(response['message'] ?? 'Failed to get checklist');
    } catch (e) {
      throw Exception('Error getting checklist: $e');
    }
  }

  // ============================================================================
  // Family Access Methods
  // ============================================================================

  /// Invite family member
  Future<FamilyInvitation> inviteFamilyMember({
    required String clientId,
    required String invitedBy,
    required String email,
    required String name,
    required String relationship,
    String? role,
    FamilyPermissions? permissions,
  }) async {
    try {
      final response = await _apiMethod.inviteFamilyMember(
        clientId: clientId,
        invitedBy: invitedBy,
        email: email,
        name: name,
        relationship: relationship,
        role: role,
        permissions: permissions?.toJson(),
      );

      if (response['success'] == true && response['data'] != null) {
        return FamilyInvitation.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to invite family member');
    } catch (e) {
      throw Exception('Error inviting family member: $e');
    }
  }

  /// Get family members
  Future<List<FamilyMember>> getFamilyMembers({
    required String clientId,
  }) async {
    try {
      final response = await _apiMethod.getFamilyMembers(
        clientId: clientId,
      );

      if (response['success'] == true && response['data'] != null) {
        final members = response['data'] as List;
        return members.map((m) => FamilyMember.fromJson(m)).toList();
      }

      throw Exception(response['message'] ?? 'Failed to get family members');
    } catch (e) {
      throw Exception('Error getting family members: $e');
    }
  }

  /// Update permissions
  Future<FamilyMember> updatePermissions({
    required String clientId,
    required String memberId,
    required FamilyPermissions permissions,
    required String updatedBy,
  }) async {
    try {
      final response = await _apiMethod.updateFamilyPermissions(
        clientId: clientId,
        memberId: memberId,
        permissions: permissions.toJson(),
        updatedBy: updatedBy,
      );

      if (response['success'] == true && response['data'] != null) {
        return FamilyMember.fromJson(response['data']);
      }

      throw Exception(response['message'] ?? 'Failed to update permissions');
    } catch (e) {
      throw Exception('Error updating permissions: $e');
    }
  }

  /// Get access log
  Future<List<AccessAuditLog>> getAccessLog({
    required String clientId,
    int? limit,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await _apiMethod.getAccessLog(
        clientId: clientId,
        limit: limit,
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
      );

      if (response['success'] == true && response['data'] != null) {
        final logs = response['data'] as List;
        return logs.map((l) => AccessAuditLog.fromJson(l)).toList();
      }

      throw Exception(response['message'] ?? 'Failed to get access log');
    } catch (e) {
      throw Exception('Error getting access log: $e');
    }
  }
}
