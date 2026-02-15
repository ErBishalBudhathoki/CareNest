import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/messaging_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/services/websocket_service.dart';
import 'package:carenest/app/features/realtime_portal/widgets/message_bubble.dart';

/// Secure Messaging View
/// End-to-end encrypted messaging with workers
class SecureMessagingView extends ConsumerStatefulWidget {
  const SecureMessagingView({super.key});

  @override
  ConsumerState<SecureMessagingView> createState() => _SecureMessagingViewState();
}

class _SecureMessagingViewState extends ConsumerState<SecureMessagingView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final WebSocketService _wsService = WebSocketService();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeWebSocket();
    _loadConversations();
  }

  void _initializeWebSocket() {
    _wsService.connect(
      serverUrl: 'http://localhost:3000',
      userId: 'client-123',
      userType: 'client',
      token: 'auth-token',
    );

    _wsService.onNewMessage = (message) {
      ref.read(messagingViewModelProvider.notifier).handleNewMessage(message);
      _scrollToBottom();
    };

    _wsService.onTypingIndicator = (indicator) {
      ref.read(messagingViewModelProvider.notifier).handleTypingIndicator(indicator);
    };

    _wsService.onMessageRead = (messageId) {
      ref.read(messagingViewModelProvider.notifier).handleMessageRead(messageId);
    };
  }

  void _loadConversations() {
    ref.read(messagingViewModelProvider.notifier).getUserConversations(
          userId: 'client-123',
        );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final state = ref.read(messagingViewModelProvider);
    if (state.activeConversation == null) return;

    ref.read(messagingViewModelProvider.notifier).sendMessage(
          conversationId: state.activeConversation!.id,
          senderId: 'client-123',
          senderType: 'client',
          recipientId: state.activeConversation!.workerId,
          message: text,
        );

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onTypingChanged(String text) {
    final state = ref.read(messagingViewModelProvider);
    if (state.activeConversation == null) return;

    if (text.isNotEmpty && !_isTyping) {
      _isTyping = true;
      _wsService.sendTypingStart(
        conversationId: state.activeConversation!.id,
        recipientId: state.activeConversation!.workerId,
      );
    } else if (text.isEmpty && _isTyping) {
      _isTyping = false;
      _wsService.sendTypingStop(
        conversationId: state.activeConversation!.id,
        recipientId: state.activeConversation!.workerId,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _wsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messagingViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Secure Messaging',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (state.activeConversation != null)
              Text(
                'Worker Chat',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showEncryptionInfo(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.activeConversation == null
              ? _buildConversationsList(state)
              : _buildChatView(state),
    );
  }

  Widget _buildConversationsList(state) {
    if (state.conversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Color(0xFF666666).withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No Conversations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a conversation with your worker',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.conversations.length,
      itemBuilder: (context, index) {
        final conversation = state.conversations[index];
        return _buildConversationCard(conversation);
      },
    );
  }

  Widget _buildConversationCard(conversation) {
    return InkWell(
      onTap: () {
        ref.read(messagingViewModelProvider.notifier).setActiveConversation(conversation);
        ref.read(messagingViewModelProvider.notifier).getMessages(
              conversationId: conversation.id,
            );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.colorPrimary.withOpacity(0.1),
              child: Icon(Icons.person, color: AppColors.colorPrimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Worker Chat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorFontPrimary,
                    ),
                  ),
                  if (conversation.lastMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      conversation.lastMessage!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF666666), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildChatView(state) {
    return Column(
      children: [
        // Encryption Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.colorSuccess.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, color: AppColors.colorSuccess, size: 16),
              const SizedBox(width: 8),
              Text(
                'End-to-end encrypted',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorSuccess,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Messages
        Expanded(
          child: state.messages.isEmpty
              ? Center(
                  child: Text(
                    'No messages yet',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    final isMe = message.senderType == 'client';
                    return MessageBubble(
                      message: message,
                      isMe: isMe,
                    );
                  },
                ),
        ),

        // Typing Indicator
        if (state.typingIndicators.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Worker is typing...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

        // Input
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  onChanged: _onTypingChanged,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: Color(0xFF666666)),
                    filled: true,
                    fillColor: AppColors.colorBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colorPrimary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: state.isSending ? null : _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEncryptionInfo() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lock, color: AppColors.colorSuccess),
            const SizedBox(width: 12),
            const Text('Encryption Info'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your messages are protected with:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildEncryptionFeature('AES-256 encryption'),
            _buildEncryptionFeature('End-to-end security'),
            _buildEncryptionFeature('Message integrity verification'),
            _buildEncryptionFeature('Secure key exchange'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Got it', style: TextStyle(color: AppColors.colorPrimary)),
          ),
        ],
      ),
    );
  }

  Widget _buildEncryptionFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.colorSuccess, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
