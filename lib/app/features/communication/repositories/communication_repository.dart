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
  Future<Map<String, dynamic>> sendMessage({
    required Map<String, dynamic> messageData,
  }) async {
    try {
      final response = await _apiMethod.sendMessage(messageData: messageData);
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error sending message: $e'};
    }
  }

  /// Get all conversations for a user
  Future<Map<String, dynamic>> getConversations({
    required String userId,
  }) async {
    try {
      final response = await _apiMethod.getConversations(userId: userId);
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching conversations: $e'};
    }
  }

  /// Get messages for a specific conversation
  Future<Map<String, dynamic>> getMessages({
    required String conversationId,
  }) async {
    try {
      final response = await _apiMethod.getMessages(conversationId: conversationId);
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching messages: $e'};
    }
  }

  /// Broadcast message to a group
  Future<Map<String, dynamic>> broadcastMessage({
    required Map<String, dynamic> broadcastData,
  }) async {
    try {
      final response = await _apiMethod.broadcastMessage(broadcastData: broadcastData);
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error broadcasting message: $e'};
    }
  }

  /// Schedule a message for later delivery
  Future<Map<String, dynamic>> scheduleMessage({
    required Map<String, dynamic> scheduleData,
  }) async {
    try {
      final response = await _apiMethod.scheduleMessage(scheduleData: scheduleData);
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error scheduling message: $e'};
    }
  }

  /// Get available message templates
  Future<Map<String, dynamic>> getMessageTemplates() async {
    try {
      final response = await _apiMethod.getMessageTemplates();
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
      final response = await _apiMethod.getMessageStatus(messageId: messageId);
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching message status: $e'};
    }
  }
}
