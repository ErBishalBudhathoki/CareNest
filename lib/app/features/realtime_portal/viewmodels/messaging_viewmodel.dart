import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/repositories/realtime_portal_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

/// State for messaging
class MessagingState {
  late final bool isLoading;
  late final String? error;
  late final List<MessageThread> conversations;
  late final MessageThread? activeConversation;
  late final List<SecureMessage> messages;
  late final bool isSending;
  final Map<String, TypingIndicator> typingIndicators;
  late final int unreadCount;

  MessagingState({
    this.isLoading = false,
    this.error,
    this.conversations = const [],
    this.activeConversation,
    this.messages = const [],
    this.isSending = false,
    this.typingIndicators = const {},
    this.unreadCount = 0,
  });

  MessagingState copyWith({
    bool? isLoading,
    String? error,
    List<MessageThread>? conversations,
    MessageThread? activeConversation,
    List<SecureMessage>? messages,
    bool? isSending,
    Map<String, TypingIndicator>? typingIndicators,
    int? unreadCount,
    bool clearActiveConversation = false,
  }) {
    return MessagingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      conversations: conversations ?? this.conversations,
      activeConversation: clearActiveConversation ? null : (activeConversation ?? this.activeConversation),
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      typingIndicators: typingIndicators ?? this.typingIndicators,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

class MessagingViewModel extends Notifier<MessagingState> {
  late final RealtimePortalRepository _repository;

  
  @override
  MessagingState build() {
    final apiMethod = ref.watch(apiMethodProvider);
    
    return MessagingState();
  }

  /// Clear active conversation
  void clearActiveConversation() {
    state = state.copyWith(clearActiveConversation: true);
  }

  /// Send message
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderType,
    required String recipientId,
    required String message,
    List<MessageAttachment>? attachments,
  }) async {
    state = state.copyWith(isSending: true, error: null);

    try {
      final sentMessage = await _repository.sendMessage(
        conversationId: conversationId,
        senderId: senderId,
        senderType: senderType,
        recipientId: recipientId,
        message: message,
        attachments: attachments,
      );

      // Add message to list
      final updatedMessages = [...state.messages, sentMessage];
      state = state.copyWith(
        isSending: false,
        messages: updatedMessages,
      );
    } catch (e) {
      debugPrint('Error sending message: $e');
      state = state.copyWith(
        isSending: false,
        error: e.toString(),
      );
    }
  }

  /// Get messages for conversation
  Future<void> getMessages({
    required String conversationId,
    int? limit,
    DateTime? before,
    bool silent = false,
  }) async {
    final wasLoading = state.isLoading;
    if (silent) {
      state = state.copyWith(error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final messages = await _repository.getMessages(
        conversationId: conversationId,
        limit: limit,
        before: before,
      );

      state = state.copyWith(
        isLoading: silent ? wasLoading : false,
        messages: messages,
      );
    } catch (e) {
      debugPrint('Error getting messages: $e');
      state = state.copyWith(
        isLoading: silent ? wasLoading : false,
        error: e.toString(),
      );
    }
  }

  /// Create conversation
  Future<void> createConversation({
    required String appointmentId,
    required String clientId,
    required String workerId,
    required String organizationId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final conversation = await _repository.createConversation(
        appointmentId: appointmentId,
        clientId: clientId,
        workerId: workerId,
        organizationId: organizationId,
      );

      state = state.copyWith(
        isLoading: false,
        activeConversation: conversation,
      );
    } catch (e) {
      debugPrint('Error creating conversation: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get user conversations
  Future<void> getUserConversations({
    required String userId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final conversations = await _repository.getUserConversations(
        userId: userId,
      );

      // Calculate total unread count
      int totalUnread = 0;
      for (final conv in conversations) {
        if (conv.unreadCount != null) {
          totalUnread += conv.unreadCount!.values.fold(0, (a, b) => a + b);
        }
      }

      state = state.copyWith(
        isLoading: false,
        conversations: conversations,
        unreadCount: totalUnread,
      );
    } catch (e) {
      debugPrint('Error getting conversations: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Set active conversation
  void setActiveConversation(MessageThread conversation) {
    state = state.copyWith(activeConversation: conversation);
  }

  /// Handle new message from WebSocket
  void handleNewMessage(SecureMessage message) {
    // Add to messages if it's for active conversation
    if (state.activeConversation?.id == message.conversationId) {
      final updatedMessages = [...state.messages, message];
      state = state.copyWith(messages: updatedMessages);
    }

    // Update unread count
    state = state.copyWith(unreadCount: state.unreadCount + 1);
  }

  /// Handle typing indicator from WebSocket
  void handleTypingIndicator(TypingIndicator indicator) {
    final updatedIndicators = Map<String, TypingIndicator>.from(
      state.typingIndicators,
    );

    if (indicator.isTyping) {
      updatedIndicators[indicator.userId] = indicator;
    } else {
      updatedIndicators.remove(indicator.userId);
    }

    state = state.copyWith(typingIndicators: updatedIndicators);
  }

  /// Handle message read receipt from WebSocket
  void handleMessageRead(String messageId) {
    final updatedMessages = state.messages.map((msg) {
      if (msg.id == messageId) {
        return msg.copyWith(read: true, readAt: DateTime.now());
      }
      return msg;
    }).toList();

    state = state.copyWith(messages: updatedMessages);
  }

  /// Load more messages (pagination)
  Future<void> loadMoreMessages({
    required String conversationId,
  }) async {
    if (state.messages.isEmpty) return;

    final oldestMessage = state.messages.first;

    try {
      final olderMessages = await _repository.getMessages(
        conversationId: conversationId,
        limit: 50,
        before: oldestMessage.timestamp,
      );

      final updatedMessages = [...olderMessages, ...state.messages];
      state = state.copyWith(messages: updatedMessages);
    } catch (e) {
      debugPrint('Error loading more messages: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  /// Reset state
  void reset() {
    state = MessagingState();
  }
}

/// Provider for messaging viewmodel
final messagingViewModelProvider = NotifierProvider<MessagingViewModel, MessagingState>(MessagingViewModel.new);
