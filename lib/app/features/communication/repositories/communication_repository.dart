import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

final communicationRepositoryProvider = Provider<CommunicationRepository>((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  return CommunicationRepository(apiMethod);
});

class CommunicationRepository {
  final dynamic _apiMethod;

  CommunicationRepository(this._apiMethod);

  /// Send a message via specified channel
  Future<Map<String, dynamic>> sendMessage({required Map<String, dynamic> messageData}) async {
    try {
      final response = await _apiMethod.post(
        'communication-hub/send',
        body: messageData,
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error sending message: $e'};
    }
  }

  /// Broadcast a message to a specific group
  Future<Map<String, dynamic>> broadcastMessage({required Map<String, dynamic> broadcastData}) async {
    try {
      final response = await _apiMethod.post(
        'communication-hub/broadcast',
        body: broadcastData,
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error broadcasting message: $e'};
    }
  }

  /// Fetch user conversations
  Future<Map<String, dynamic>> getConversations({required String userId}) async {
    try {
      final response = await _apiMethod.get(
        'communication-hub/conversations/$userId',
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching conversations: $e'};
    }
  }

  /// Fetch messages for a conversation
  Future<Map<String, dynamic>> getMessages({required String conversationId}) async {
    try {
      final response = await _apiMethod.get(
        'communication-hub/messages/$conversationId',
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching messages: $e'};
    }
  }

  /// Schedule a message for later delivery
  Future<Map<String, dynamic>> scheduleMessage({required Map<String, dynamic> scheduleData}) async {
    try {
      final response = await _apiMethod.post(
        'communication-hub/schedule',
        body: scheduleData,
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error scheduling message: $e'};
    }
  }

  /// Get predefined message templates
  Future<Map<String, dynamic>> getMessageTemplates() async {
    try {
      final response = await _apiMethod.get('communication-hub/templates');
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching templates: $e'};
    }
  }

  /// Get message delivery status
  Future<Map<String, dynamic>> getMessageStatus({
    required String messageId,
  }) async {
    try {
      final response = await _apiMethod.get('communication-hub/status/$messageId');
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching message status: $e'};
    }
  }

  /// Get active broadcasts for an organization
  Future<Map<String, dynamic>> getActiveBroadcasts({
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.post(
        'communication-hub/broadcasts/active',
        body: {'organizationId': organizationId},
      );
      return response;
    } catch (e) {
      return {'success': false, 'data': [], 'message': e.toString()};
    }
  }

  /// Get broadcast history for an organization
  Future<Map<String, dynamic>> getBroadcastHistory({
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.post(
        'communication-hub/broadcasts/history',
        body: {'organizationId': organizationId},
      );
      return response;
    } catch (e) {
      return {'success': false, 'data': [], 'message': e.toString()};
    }
  }
  
  /// Acknowledge a broadcast
  Future<Map<String, dynamic>> acknowledgeBroadcast({
    required String broadcastId,
    required String userId,
  }) async {
    try {
      final response = await _apiMethod.post(
        'communication-hub/broadcasts/acknowledge/$broadcastId',
        body: {'userId': userId},
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
