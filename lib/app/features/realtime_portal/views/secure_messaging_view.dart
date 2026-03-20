import 'dart:async';

import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/services/notificationservice/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/messaging_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/widgets/message_bubble.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

/// Secure Messaging View
/// Role-aware secure messaging between client and assigned worker.
class SecureMessagingView extends ConsumerStatefulWidget {
  final String? userId;
  final String userType;
  final String? preferredConversationId;

  const SecureMessagingView({
    super.key,
    this.userId,
    this.userType = 'client',
    this.preferredConversationId,
  });

  @override
  ConsumerState<SecureMessagingView> createState() =>
      _SecureMessagingViewState();
}

class _SecureMessagingViewState extends ConsumerState<SecureMessagingView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  bool _isBootstrapping = true;
  bool _isMessageNotificationReady = false;
  String? _identityError;
  String? _effectiveUserId;
  String? _fallbackUserId;
  Timer? _messagePollTimer;
  bool _pollInFlight = false;
  String? _pollConversationId;
  final Set<String> _seenMessageIds = <String>{};

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() {
      _isBootstrapping = true;
      _identityError = null;
    });

    try {
      if (!_isMessageNotificationReady) {
        await _localNotificationService.initialize(requestPermissions: true);
        _isMessageNotificationReady = true;
      }

      final prefs = SharedPreferencesUtils();
      await prefs.init();

      final explicitId = widget.userId?.trim();
      final storedUserId = prefs.getUserId()?.trim();
      final storedEmail = prefs.getUserEmail()?.trim();

      final resolvedId = (explicitId != null && explicitId.isNotEmpty)
          ? explicitId
          : (storedUserId != null && storedUserId.isNotEmpty)
              ? storedUserId
              : ((storedEmail != null && storedEmail.isNotEmpty)
                  ? storedEmail
                  : null);

      if (resolvedId == null || resolvedId.isEmpty) {
        setState(() {
          _identityError = 'Unable to resolve current user identity.';
          _isBootstrapping = false;
        });
        return;
      }

      _effectiveUserId = resolvedId;
      _fallbackUserId = storedEmail;

      await _loadConversations();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _identityError = 'Failed to initialize messaging.';
        _isBootstrapping = false;
      });
    }
  }

  Future<void> _loadConversations() async {
    final userId = _effectiveUserId;
    if (userId == null || userId.isEmpty) return;

    await ref
        .read(messagingViewModelProvider.notifier)
        .getUserConversations(userId: userId);

    var state = ref.read(messagingViewModelProvider);

    // Fallback to email identity if current userId returns no thread.
    if (state.conversations.isEmpty &&
        _fallbackUserId != null &&
        _fallbackUserId != userId) {
      await ref
          .read(messagingViewModelProvider.notifier)
          .getUserConversations(userId: _fallbackUserId!);
      state = ref.read(messagingViewModelProvider);
      if (state.conversations.isNotEmpty) {
        _effectiveUserId = _fallbackUserId;
      }
    }

    if (state.conversations.isNotEmpty) {
      final preferredId = widget.preferredConversationId;
      final selected = preferredId == null
          ? state.conversations.first
          : state.conversations.firstWhere(
              (conversation) => conversation.id == preferredId,
              orElse: () => state.conversations.first,
            );

      ref
          .read(messagingViewModelProvider.notifier)
          .setActiveConversation(selected);
      await ref
          .read(messagingViewModelProvider.notifier)
          .getMessages(conversationId: selected.id);
      final refreshedState = ref.read(messagingViewModelProvider);
      _resetSeenMessagesForConversation(
        selected.id,
        refreshedState.messages,
      );
      _startMessagePolling();
      _scrollToBottom();
    } else {
      _stopMessagePolling();
    }

    if (!mounted) return;
    setState(() {
      _isBootstrapping = false;
    });
  }

  Future<void> _openConversation(MessageThread conversation) async {
    ref
        .read(messagingViewModelProvider.notifier)
        .setActiveConversation(conversation);
    await ref
        .read(messagingViewModelProvider.notifier)
        .getMessages(conversationId: conversation.id, silent: true);
    final refreshedState = ref.read(messagingViewModelProvider);
    _resetSeenMessagesForConversation(
      conversation.id,
      refreshedState.messages,
    );
    _startMessagePolling();
    _scrollToBottom();
  }

  String _getRecipientId(MessageThread conversation) {
    final me = _effectiveUserId;
    if (me != null && me.isNotEmpty) {
      if (conversation.clientId == me) return conversation.workerId;
      if (conversation.workerId == me) return conversation.clientId;
    }

    return widget.userType.toLowerCase() == 'worker'
        ? conversation.clientId
        : conversation.workerId;
  }

  String _conversationTitle(MessageThread conversation) {
    final me = _effectiveUserId;
    final isWorkerPerspective = widget.userType.toLowerCase() == 'worker' ||
        conversation.workerId == me;

    if (isWorkerPerspective) {
      return 'Client ${_shortId(conversation.clientId)}';
    }
    return 'Worker ${_shortId(conversation.workerId)}';
  }

  String _shortId(String value) {
    if (value.length <= 8) return value;
    return value.substring(value.length - 8);
  }

  String _sanitizePreview(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'No messages yet';

    final looksEncrypted = RegExp(r'^[A-Fa-f0-9]{24,}$').hasMatch(text);
    if (looksEncrypted) return 'Encrypted message';

    return text;
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final state = ref.read(messagingViewModelProvider);
    final conversation = state.activeConversation;
    final senderId = _effectiveUserId;

    if (conversation == null || senderId == null || senderId.isEmpty) {
      return;
    }

    await ref.read(messagingViewModelProvider.notifier).sendMessage(
          conversationId: conversation.id,
          senderId: senderId,
          senderType: widget.userType,
          recipientId: _getRecipientId(conversation),
          message: text,
        );

    final afterSendState = ref.read(messagingViewModelProvider);
    if (afterSendState.error != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(afterSendState.error!),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await ref
        .read(messagingViewModelProvider.notifier)
        .getMessages(conversationId: conversation.id);

    final refreshedState = ref.read(messagingViewModelProvider);
    _markSeenMessages(refreshedState.messages);
    _scrollToBottom();

    await _notifyMessageEvent(
      conversation: conversation,
      messageBody: text,
      isIncoming: false,
    );

    _messageController.clear();
  }

  void _startMessagePolling() {
    final conversationId =
        ref.read(messagingViewModelProvider).activeConversation?.id;
    if (conversationId == null || conversationId.isEmpty) {
      _stopMessagePolling();
      return;
    }

    if (_pollConversationId != conversationId) {
      _pollConversationId = conversationId;
      _seenMessageIds.clear();
      _markSeenMessages(ref.read(messagingViewModelProvider).messages);
    }

    _messagePollTimer?.cancel();
    _messagePollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _pollMessages(),
    );
  }

  Future<void> _pollMessages() async {
    if (_pollInFlight) return;

    final state = ref.read(messagingViewModelProvider);
    final conversation = state.activeConversation;
    final conversationId = conversation?.id;
    if (conversation == null ||
        conversationId == null ||
        conversationId.isEmpty) {
      return;
    }

    _pollInFlight = true;
    try {
      await ref.read(messagingViewModelProvider.notifier).getMessages(
            conversationId: conversationId,
            silent: true,
          );

      final refreshed = ref.read(messagingViewModelProvider);
      await _notifyIncomingMessages(
        conversation: conversation,
        messages: refreshed.messages,
      );
    } finally {
      _pollInFlight = false;
    }
  }

  Future<void> _notifyIncomingMessages({
    required MessageThread conversation,
    required List<SecureMessage> messages,
  }) async {
    final currentUserId = _effectiveUserId;
    if (currentUserId == null || currentUserId.isEmpty) {
      _markSeenMessages(messages);
      return;
    }

    for (final message in messages) {
      final messageId = message.id.trim();
      if (messageId.isEmpty) continue;

      final wasSeen = _seenMessageIds.contains(messageId);
      _seenMessageIds.add(messageId);

      if (wasSeen) continue;
      if (message.senderId == currentUserId) continue;

      await _notifyMessageEvent(
        conversation: conversation,
        messageBody: message.message,
        isIncoming: true,
      );
    }
  }

  void _resetSeenMessagesForConversation(
    String conversationId,
    List<SecureMessage> messages,
  ) {
    _pollConversationId = conversationId;
    _seenMessageIds.clear();
    _markSeenMessages(messages);
  }

  void _markSeenMessages(List<SecureMessage> messages) {
    for (final message in messages) {
      final id = message.id.trim();
      if (id.isNotEmpty) {
        _seenMessageIds.add(id);
      }
    }
  }

  Future<void> _notifyMessageEvent({
    required MessageThread conversation,
    required String messageBody,
    required bool isIncoming,
  }) async {
    if (!_isMessageNotificationReady) return;

    final counterpartLabel = _conversationTitle(conversation);
    final prefix = isIncoming ? 'From' : 'To';
    final body =
        messageBody.trim().isEmpty ? 'Secure message' : messageBody.trim();

    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: isIncoming ? 'New secure message' : 'Message sent',
      body: '$prefix $counterpartLabel: $body',
      timestamp: DateTime.now(),
      type: 'message',
      data: {
        'conversationId': conversation.id,
        'direction': isIncoming ? 'incoming' : 'outgoing',
      },
    );

    await _localNotificationService.createAndDisplayNotification(
      notification,
      {
        'channelId': 'message',
        'type': 'message',
        'conversationId': conversation.id,
        'direction': isIncoming ? 'incoming' : 'outgoing',
      },
    );
  }

  void _stopMessagePolling() {
    _messagePollTimer?.cancel();
    _messagePollTimer = null;
    _pollConversationId = null;
    _pollInFlight = false;
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

  @override
  void dispose() {
    _stopMessagePolling();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messagingViewModelProvider);

    if (_isBootstrapping) {
      return Scaffold(
        backgroundColor: AppColors.colorBackground,
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          title: const Text('Secure Messaging'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_identityError != null) {
      return Scaffold(
        backgroundColor: AppColors.colorBackground,
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          title: const Text('Secure Messaging'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 44),
                const SizedBox(height: 12),
                Text(_identityError!, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _bootstrap,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
            Text(
              widget.userType.toLowerCase() == 'worker'
                  ? 'Client communication'
                  : 'Worker communication',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadConversations,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: _showEncryptionInfo,
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

  Widget _buildConversationsList(MessagingState state) {
    if (state.conversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: const Color(0xFF666666).withOpacity(0.5),
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
              'Messages for active service shifts will appear here.',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadConversations,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.conversations.length,
        itemBuilder: (context, index) {
          final conversation = state.conversations[index];
          return _buildConversationCard(conversation);
        },
      ),
    );
  }

  Widget _buildConversationCard(MessageThread conversation) {
    final unread = conversation.unreadCount?[_effectiveUserId ?? ''] ?? 0;

    return InkWell(
      onTap: () => _openConversation(conversation),
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
                    _conversationTitle(conversation),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorFontPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _sanitizePreview(conversation.lastMessage),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (unread > 0)
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.colorPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  unread.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            const Icon(Icons.arrow_forward_ios,
                color: Color(0xFF666666), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildChatView(MessagingState state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: AppColors.colorSuccess.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, color: AppColors.colorSuccess, size: 16),
              const SizedBox(width: 8),
              Text(
                'Encrypted channel active',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorSuccess,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: state.messages.isEmpty
              ? const Center(
                  child: Text(
                    'No messages yet',
                    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    final isMe = message.senderId == _effectiveUserId;
                    return MessageBubble(
                      message: message,
                      isMe: isMe,
                    );
                  },
                ),
        ),
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
                  style: TextStyle(
                    color: AppColors.colorFontPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  cursorColor: AppColors.colorFontPrimary,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: const TextStyle(color: Color(0xFF666666)),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lock, color: AppColors.colorSuccess),
            const SizedBox(width: 12),
            const Text('Security Info'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current secure messaging protection:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildEncryptionFeature('AES-256 message encryption'),
            _buildEncryptionFeature('Authenticated API requests'),
            _buildEncryptionFeature('Shift-scoped conversation access'),
            _buildEncryptionFeature('Assigned worker/client isolation'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.colorPrimary),
            ),
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
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
