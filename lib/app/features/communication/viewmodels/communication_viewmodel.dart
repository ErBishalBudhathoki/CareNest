import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/communication/repositories/communication_repository.dart';
import 'package:carenest/app/features/communication/models/communication_models.dart';

final communicationViewModelProvider =
    StateNotifierProvider<CommunicationViewModel, CommunicationState>((ref) {
  final repository = ref.watch(communicationRepositoryProvider);
  return CommunicationViewModel(repository);
});

class HubBroadcastMessage {
  final String id;
  final String message;
  final String type;
  final String initiatorName;
  final String group;
  final String status;
  final List<String> acknowledgments;
  final DateTime createdAt;

  HubBroadcastMessage({
    required this.id,
    required this.message,
    this.type = 'general',
    this.initiatorName = 'Admin',
    this.group = 'All Workers',
    this.status = 'active',
    this.acknowledgments = const [],
    required this.createdAt,
  });

  factory HubBroadcastMessage.fromJson(Map<String, dynamic> j) {
    return HubBroadcastMessage(
      id: j['id'] ?? j['_id'] ?? '',
      message: j['message'] ?? '',
      type: j['type'] ?? 'general',
      initiatorName: j['initiatorName'] ?? j['initiator']?['name'] ?? 'Admin',
      group: j['group'] ?? 'All Workers',
      status: j['status'] ?? 'active',
      acknowledgments: List<String>.from(j['acknowledgments'] ?? []),
      createdAt: j['createdAt'] != null
          ? DateTime.tryParse(j['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class CommunicationState {
  final bool isLoading;
  final String? error;
  final List<Conversation> conversations;
  final List<Message> messages;
  final List<MessageTemplate> templates;
  final MessageStatus? messageStatus;
  final bool isSending;
  final List<HubBroadcastMessage> activeBroadcasts;
  final List<HubBroadcastMessage> broadcastHistory;

  CommunicationState({
    this.isLoading = false,
    this.error,
    this.conversations = const [],
    this.messages = const [],
    this.templates = const [],
    this.messageStatus,
    this.isSending = false,
    this.activeBroadcasts = const [],
    this.broadcastHistory = const [],
  });

  CommunicationState copyWith({
    bool? isLoading,
    String? error,
    List<Conversation>? conversations,
    List<Message>? messages,
    List<MessageTemplate>? templates,
    MessageStatus? messageStatus,
    bool? isSending,
    List<HubBroadcastMessage>? activeBroadcasts,
    List<HubBroadcastMessage>? broadcastHistory,
  }) {
    return CommunicationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      templates: templates ?? this.templates,
      messageStatus: messageStatus ?? this.messageStatus,
      isSending: isSending ?? this.isSending,
      activeBroadcasts: activeBroadcasts ?? this.activeBroadcasts,
      broadcastHistory: broadcastHistory ?? this.broadcastHistory,
    );
  }
}

class CommunicationViewModel extends StateNotifier<CommunicationState> {
  final CommunicationRepository _repository;

  CommunicationViewModel(this._repository) : super(CommunicationState());

  Future<void> loadConversations(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _repository.getConversations(userId: userId);
      if (response['success'] == true && response['data'] != null) {
        final conversations = (response['data'] as List)
            .map((item) => Conversation.fromJson(item))
            .toList();
        state = state.copyWith(isLoading: false, conversations: conversations);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load conversations',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMessages(String conversationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response =
          await _repository.getMessages(conversationId: conversationId);
      if (response['success'] == true && response['data'] != null) {
        final messages = (response['data'] as List)
            .map((item) => Message.fromJson(item))
            .toList();
        state = state.copyWith(isLoading: false, messages: messages);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load messages',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> sendMessage(Map<String, dynamic> messageData) async {
    state = state.copyWith(isSending: true, error: null);
    try {
      final response =
          await _repository.sendMessage(messageData: messageData);
      state = state.copyWith(isSending: false);
      return response['success'] == true;
    } catch (e) {
      state = state.copyWith(isSending: false, error: e.toString());
      return false;
    }
  }

  Future<bool> broadcastMessage(Map<String, dynamic> broadcastData) async {
    state = state.copyWith(isSending: true, error: null);
    try {
      final response =
          await _repository.broadcastMessage(broadcastData: broadcastData);
      state = state.copyWith(isSending: false);
      if (response['success'] == true) {
        // Optimistically add to active broadcasts
        final newBroadcast = HubBroadcastMessage(
          id: response['data']?['id'] ??
              DateTime.now().millisecondsSinceEpoch.toString(),
          message: broadcastData['message'] ?? '',
          type: broadcastData['type'] ?? 'general',
          group: broadcastData['group'] ?? 'All Workers',
          initiatorName: 'You',
          createdAt: DateTime.now(),
        );
        state = state.copyWith(
          activeBroadcasts: [newBroadcast, ...state.activeBroadcasts],
        );
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(isSending: false, error: e.toString());
      return false;
    }
  }

  Future<void> loadActiveBroadcasts(String organizationId) async {
    try {
      final response = await _repository.getActiveBroadcasts(
          organizationId: organizationId);
      if (response['success'] == true && response['data'] != null) {
        final broadcasts = (response['data'] as List)
            .map((item) => HubBroadcastMessage.fromJson(item))
            .toList();
        state = state.copyWith(activeBroadcasts: broadcasts);
      }
    } catch (_) {}
  }

  Future<void> loadBroadcastHistory(String organizationId) async {
    try {
      final response = await _repository.getBroadcastHistory(
          organizationId: organizationId);
      if (response['success'] == true && response['data'] != null) {
        final history = (response['data'] as List)
            .map((item) => HubBroadcastMessage.fromJson(item))
            .toList();
        state = state.copyWith(broadcastHistory: history);
      }
    } catch (_) {}
  }

  void acknowledgeBroadcast(String broadcastId, String userId) {
    final updated = state.activeBroadcasts.map((b) {
      if (b.id == broadcastId) {
        return HubBroadcastMessage(
          id: b.id,
          message: b.message,
          type: b.type,
          initiatorName: b.initiatorName,
          group: b.group,
          status: b.status,
          acknowledgments: [...b.acknowledgments, userId],
          createdAt: b.createdAt,
        );
      }
      return b;
    }).toList();
    state = state.copyWith(activeBroadcasts: updated);
    // Fire-and-forget to backend
    _repository.broadcastMessage(broadcastData: {
      'action': 'acknowledge',
      'broadcastId': broadcastId,
      'userId': userId,
    });
  }

  Future<bool> scheduleMessage(Map<String, dynamic> scheduleData) async {
    state = state.copyWith(isSending: true, error: null);
    try {
      final response =
          await _repository.scheduleMessage(scheduleData: scheduleData);
      state = state.copyWith(isSending: false);
      return response['success'] == true;
    } catch (e) {
      state = state.copyWith(isSending: false, error: e.toString());
      return false;
    }
  }

  Future<void> loadTemplates() async {
    try {
      final response = await _repository.getMessageTemplates();
      if (response['success'] == true && response['data'] != null) {
        final templates = (response['data'] as List)
            .map((item) => MessageTemplate.fromJson(item))
            .toList();
        state = state.copyWith(templates: templates);
      }
    } catch (_) {}
  }

  Future<void> getMessageStatus(String messageId) async {
    try {
      final response =
          await _repository.getMessageStatus(messageId: messageId);
      if (response['success'] == true && response['data'] != null) {
        final status = MessageStatus.fromJson(response['data']);
        state = state.copyWith(messageStatus: status);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
