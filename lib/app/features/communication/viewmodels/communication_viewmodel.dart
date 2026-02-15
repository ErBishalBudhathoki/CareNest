import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/communication/repositories/communication_repository.dart';
import 'package:carenest/app/features/communication/models/communication_models.dart';

final communicationViewModelProvider =
    StateNotifierProvider<CommunicationViewModel, CommunicationState>((ref) {
  final repository = ref.watch(communicationRepositoryProvider);
  return CommunicationViewModel(repository);
});

class CommunicationState {
  final bool isLoading;
  final String? error;
  final List<Conversation> conversations;
  final List<Message> messages;
  final List<MessageTemplate> templates;
  final MessageStatus? messageStatus;
  final bool isSending;

  CommunicationState({
    this.isLoading = false,
    this.error,
    this.conversations = const [],
    this.messages = const [],
    this.templates = const [],
    this.messageStatus,
    this.isSending = false,
  });

  CommunicationState copyWith({
    bool? isLoading,
    String? error,
    List<Conversation>? conversations,
    List<Message>? messages,
    List<MessageTemplate>? templates,
    MessageStatus? messageStatus,
    bool? isSending,
  }) {
    return CommunicationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      conversations: conversations ?? this.conversations,
      messages: messages ?? this.messages,
      templates: templates ?? this.templates,
      messageStatus: messageStatus ?? this.messageStatus,
      isSending: isSending ?? this.isSending,
    );
  }
}

class CommunicationViewModel extends StateNotifier<CommunicationState> {
  final CommunicationRepository _repository;

  CommunicationViewModel(this._repository) : super(CommunicationState());

  /// Load all conversations for a user
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

  /// Load messages for a conversation
  Future<void> loadMessages(String conversationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _repository.getMessages(conversationId: conversationId);
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

  /// Send a message
  Future<bool> sendMessage(Map<String, dynamic> messageData) async {
    state = state.copyWith(isSending: true, error: null);
    try {
      final response = await _repository.sendMessage(messageData: messageData);
      state = state.copyWith(isSending: false);
      return response['success'] == true;
    } catch (e) {
      state = state.copyWith(isSending: false, error: e.toString());
      return false;
    }
  }

  /// Broadcast message to group
  Future<bool> broadcastMessage(Map<String, dynamic> broadcastData) async {
    state = state.copyWith(isSending: true, error: null);
    try {
      final response = await _repository.broadcastMessage(broadcastData: broadcastData);
      state = state.copyWith(isSending: false);
      return response['success'] == true;
    } catch (e) {
      state = state.copyWith(isSending: false, error: e.toString());
      return false;
    }
  }

  /// Schedule a message
  Future<bool> scheduleMessage(Map<String, dynamic> scheduleData) async {
    state = state.copyWith(isSending: true, error: null);
    try {
      final response = await _repository.scheduleMessage(scheduleData: scheduleData);
      state = state.copyWith(isSending: false);
      return response['success'] == true;
    } catch (e) {
      state = state.copyWith(isSending: false, error: e.toString());
      return false;
    }
  }

  /// Load message templates
  Future<void> loadTemplates() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _repository.getMessageTemplates();
      if (response['success'] == true && response['data'] != null) {
        final templates = (response['data'] as List)
            .map((item) => MessageTemplate.fromJson(item))
            .toList();
        state = state.copyWith(isLoading: false, templates: templates);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] ?? 'Failed to load templates',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Get message status
  Future<void> getMessageStatus(String messageId) async {
    try {
      final response = await _repository.getMessageStatus(messageId: messageId);
      if (response['success'] == true && response['data'] != null) {
        final status = MessageStatus.fromJson(response['data']);
        state = state.copyWith(messageStatus: status);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
