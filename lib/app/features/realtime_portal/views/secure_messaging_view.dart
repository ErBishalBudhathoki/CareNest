import 'dart:async';

import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/notifications/models/notification_model.dart';
import 'package:carenest/app/services/notificationservice/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? _myEmail;
  Set<String> _myAlternateIds = const {};
  Map<String, String> _nameCache = const {};
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

      final storedUserId = prefs.getUserId()?.trim();
      final storedEmail = prefs.getUserEmail()?.trim();
      final storedName = prefs.getString('firstName')?.trim();
      final storedLastName = prefs.getString('lastName')?.trim();

      _myEmail = storedEmail;
      // Build a set of IDs that identify "me" — userId, email, and name.
      // Also include the explicitId from the caller (may be a MongoDB _id)
      // for isMe matching, even though we use storedUserId for API calls.
      final explicitId = widget.userId?.trim();
      _myAlternateIds = <String>{
        if (storedUserId != null && storedUserId.isNotEmpty) storedUserId,
        if (storedEmail != null && storedEmail.isNotEmpty) storedEmail,
        if (storedName != null && storedName.isNotEmpty) storedName,
        if (explicitId != null && explicitId.isNotEmpty) explicitId,
      };
      final fullName = [
        if (storedName != null && storedName.isNotEmpty) storedName,
        if (storedLastName != null && storedLastName.isNotEmpty) storedLastName,
      ].join(' ');
      if (fullName.isNotEmpty) {
        _myAlternateIds.add(fullName);
      }
      // Cache name lookups keyed by email
      if (storedEmail != null &&
          storedEmail.isNotEmpty &&
          fullName.isNotEmpty) {
        _nameCache = {storedEmail: fullName};
      }

      // Always use stored userId (matches JWT) for loading conversations.
      // explicitId can be a client/employee MongoDB _id, which the backend
      // rejects with 403. The preferredConversationId handles targeting.
      final resolvedId = (storedUserId != null && storedUserId.isNotEmpty)
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
      _seedNameCacheFromConversation(selected);
      await ref
          .read(messagingViewModelProvider.notifier)
          .getMessages(conversationId: selected.id);
      final refreshedState = ref.read(messagingViewModelProvider);
      _resetSeenMessagesForConversation(selected.id, refreshedState.messages);
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
    _seedNameCacheFromConversation(conversation);
    await ref
        .read(messagingViewModelProvider.notifier)
        .getMessages(conversationId: conversation.id, silent: true);
    final refreshedState = ref.read(messagingViewModelProvider);
    _resetSeenMessagesForConversation(conversation.id, refreshedState.messages);
    _startMessagePolling();
    _scrollToBottom();
  }

  /// Seed [_nameCache] with resolved names from the conversation so
  /// we never show raw emails in chat bubbles.
  void _seedNameCacheFromConversation(MessageThread conversation) {
    final me = _effectiveUserId;
    final isWorker =
        widget.userType == 'employee' ||
        widget.userType == 'worker' ||
        conversation.workerId == me;
    final otherName = isWorker
        ? conversation.clientName
        : conversation.workerName;
    if (otherName != null && otherName.isNotEmpty) {
      _nameCache = Map<String, String>.from(_nameCache);
      _nameCache[otherName.toLowerCase()] = otherName;
      // Also key by parts so "Harry James" can match emails that contain
      // just first or last name
      for (final part in otherName.split(' ')) {
        if (part.isNotEmpty) {
          _nameCache[part.toLowerCase()] = otherName;
        }
      }
    }
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
    final isWorkerPerspective =
        widget.userType.toLowerCase() == 'worker' ||
        conversation.workerId == me;

    if (isWorkerPerspective) {
      return conversation.clientName?.isNotEmpty == true
          ? conversation.clientName!
          : 'Client ${_shortId(conversation.clientId)}';
    }
    return conversation.workerName?.isNotEmpty == true
        ? conversation.workerName!
        : 'Worker ${_shortId(conversation.workerId)}';
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

    await ref
        .read(messagingViewModelProvider.notifier)
        .sendMessage(
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
    final conversationId = ref
        .read(messagingViewModelProvider)
        .activeConversation
        ?.id;
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
    if (!mounted || _pollInFlight) return;

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
      await ref
          .read(messagingViewModelProvider.notifier)
          .getMessages(conversationId: conversationId, silent: true);

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
    final body = messageBody.trim().isEmpty
        ? 'Secure message'
        : messageBody.trim();

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

    await _localNotificationService.createAndDisplayNotification(notification, {
      'channelId': 'message',
      'type': 'message',
      'conversationId': conversation.id,
      'direction': isIncoming ? 'incoming' : 'outgoing',
    });
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
        backgroundColor: BauhausDesign.backgroundLight,
        appBar: AppBar(
          backgroundColor: BauhausDesign.surfaceWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Secure Messaging',
            style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
              color: BauhausDesign.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.5),
            child: Container(color: BauhausDesign.neutral, height: 1.5),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
          ),
        ),
      );
    }

    if (_identityError != null) {
      return Scaffold(
        backgroundColor: BauhausDesign.backgroundLight,
        appBar: AppBar(
          backgroundColor: BauhausDesign.surfaceWhite,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Secure Messaging',
            style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
              color: BauhausDesign.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.5),
            child: Container(color: BauhausDesign.neutral, height: 1.5),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space6),
            child: Container(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              decoration: BauhausDesign.cardDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: BauhausDesign.primary,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  Text(
                    _identityError!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontMd,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space6),
                  ElevatedButton(
                    onPressed: _bootstrap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BauhausDesign.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space6,
                        vertical: BauhausDesign.space3,
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Secure Messaging',
              style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                color: BauhausDesign.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              widget.userType.toLowerCase() == 'worker'
                  ? 'CLIENT COMMUNICATION'
                  : 'WORKER COMMUNICATION',
              style: BauhausDesign.neoMonoStyle(
                context,
                color: BauhausDesign.textMuted,
                fontSize: 10,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BauhausDesign.primary),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: BauhausDesign.neutral, height: 1.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausDesign.primary),
            onPressed: _loadConversations,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: BauhausDesign.primary),
            onPressed: _showEncryptionInfo,
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  BauhausDesign.primary,
                ),
              ),
            )
          : state.activeConversation == null
          ? _buildConversationsList(state)
          : _buildChatView(state),
    );
  }

  Widget _buildConversationsList(MessagingState state) {
    if (state.conversations.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(BauhausDesign.space6),
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BauhausDesign.cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                size: 64,
                color: BauhausDesign.primary,
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'No Conversations',
                style: BauhausDesign.getTextTheme(context).headlineLarge
                    ?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                'Messages for active service shifts will appear here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontMd,
                  color: BauhausDesign.textMuted,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: BauhausDesign.primary,
      onRefresh: _loadConversations,
      child: ListView.builder(
        padding: const EdgeInsets.all(BauhausDesign.space4),
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

    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openConversation(conversation),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              children: [
                // Square Avatar with black border
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: BauhausDesign.primaryBlue,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: BauhausDesign.borderThick,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _conversationTitle(conversation),
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        _sanitizePreview(conversation.lastMessage),
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontMd,
                          color: BauhausDesign.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (unread > 0)
                  Container(
                    margin: const EdgeInsets.only(right: BauhausDesign.space3),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: BauhausDesign.primaryRed,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: BauhausDesign.borderThin,
                      ),
                    ),
                    child: Text(
                      unread.toString(),
                      style: BauhausDesign.neoMonoStyle(
                        context,
                        color: Colors.white,
                        fontSize: BauhausDesign.fontXs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: BauhausDesign.neutral,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatView(MessagingState state) {
    return Column(
      children: [
        // Solid black bottom border on active channel status block
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border(
              bottom: BorderSide(
                color: BauhausDesign.neutral,
                width: BauhausDesign.borderThick,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, color: BauhausDesign.success, size: 16),
              const SizedBox(width: 8),
              Text(
                'ENCRYPTED CHANNEL ACTIVE',
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.success,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: state.messages.isEmpty
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    decoration: BauhausDesign.cardDecoration,
                    child: Text(
                      'No messages yet',
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontMd,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textMuted,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    final isMe =
                        message.senderId == _effectiveUserId ||
                        _myAlternateIds.contains(message.senderId) ||
                        (_myEmail != null &&
                            message.senderId.toLowerCase() ==
                                _myEmail!.toLowerCase());

                    // Resolve email-looking sender names to human names
                    var displayMessage = message;
                    if (message.senderName.contains('@')) {
                      final conversation = state.activeConversation;
                      if (conversation != null) {
                        if (isMe) {
                          final nameFromCache =
                              _nameCache[message.senderName.toLowerCase()];
                          if (nameFromCache != null) {
                            displayMessage = message.copyWith(
                              senderName: nameFromCache,
                            );
                          }
                        } else {
                          // Other sender — use resolved name from conversation
                          final otherName = message.senderType == 'client'
                              ? conversation.clientName
                              : conversation.workerName;
                          if (otherName != null && otherName.isNotEmpty) {
                            displayMessage = message.copyWith(
                              senderName: otherName,
                            );
                          }
                        }
                      }
                    }

                    return MessageBubble(message: displayMessage, isMe: isMe);
                  },
                ),
        ),
        // Message composer with heavy border and solid outline button
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: const BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border(
              top: BorderSide(
                color: BauhausDesign.neutral,
                width: BauhausDesign.borderThick,
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: GoogleFonts.inter(
                      color: BauhausDesign.textDark,
                      fontSize: BauhausDesign.fontMd,
                      fontWeight: FontWeight.w500,
                    ),
                    cursorColor: BauhausDesign.neutral,
                    decoration: BauhausDesign.inputDecoration(
                      'Type a message...',
                    ),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: BauhausDesign.primary,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: BauhausDesign.borderThick,
                    ),
                    boxShadow: const [BauhausDesign.shadowHardSm],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: state.isSending ? null : _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEncryptionInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.backgroundLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: BauhausDesign.neutral, width: 2.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.lock, color: BauhausDesign.success, size: 24),
            const SizedBox(width: 12),
            Text(
              'SECURITY INFO',
              style: BauhausDesign.getTextTheme(context).headlineMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textDark,
                  ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current secure messaging protection:',
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
            ),
            const SizedBox(height: 16),
            _buildEncryptionFeature('AES-256 message encryption'),
            _buildEncryptionFeature('Authenticated API requests'),
            _buildEncryptionFeature('Shift-scoped conversation access'),
            _buildEncryptionFeature('Assigned worker/client isolation'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: BauhausDesign.primary,
              textStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Widget _buildEncryptionFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: BauhausDesign.success,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
