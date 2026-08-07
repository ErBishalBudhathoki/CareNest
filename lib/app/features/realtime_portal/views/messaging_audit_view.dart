import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/messaging_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Provider to fetch organization employees list (caches them for ID-to-Name conversion)
final orgEmployeesProvider = FutureProvider.family
    .autoDispose<Map<String, String>, String>((ref, orgId) async {
      final api = ref.read(apiMethodProvider);

      // Resolve actual organization ID (fallback to organizationIdProvider if orgId parameter is empty)
      final resolvedOrgId = orgId.isNotEmpty
          ? orgId
          : (ref.watch(organizationIdProvider) ?? '');

      debugPrint(
        '🔍 DEBUG: orgEmployeesProvider called with orgId: "$orgId", resolvedOrgId: "$resolvedOrgId"',
      );
      if (resolvedOrgId.isEmpty) {
        debugPrint('🔍 DEBUG: resolvedOrgId is empty, returning empty map');
        return {};
      }

      try {
        final response = await api.getOrganizationEmployees(resolvedOrgId);
        debugPrint(
          '🔍 DEBUG: getOrganizationEmployees success: ${response['success']}',
        );
        final Map<String, String> map = {};
        if (response['success'] == true) {
          final list =
              (response['employees'] ?? response['members'] ?? []) as List;
          debugPrint('🔍 DEBUG: employees/members list length: ${list.length}');
          for (final item in list) {
            if (item is Map) {
              final email = item['email'] as String? ?? '';
              final firstName = item['firstName'] as String? ?? '';
              final lastName = item['lastName'] as String? ?? '';
              final displayName = item['displayName'] as String? ?? '';
              final rawName = item['name'] as String? ?? '';

              String name = '$firstName $lastName'.trim();
              if (name.isEmpty) name = displayName.trim();
              if (name.isEmpty) name = rawName.trim();

              final id = item['id'] as String? ?? item['_id'] as String? ?? '';

              if (name.isNotEmpty) {
                debugPrint('🔍 DEBUG: Mapping "$id" and "$email" to "$name"');
                if (email.isNotEmpty) {
                  map[email] = name;
                  map[email.toLowerCase()] = name;
                }
                if (id.isNotEmpty) {
                  map[id] = name;
                  map[id.toLowerCase()] = name;
                }
              }
            }
          }
        }
        return map;
      } catch (e) {
        debugPrint('🔍 DEBUG: orgEmployeesProvider Exception: $e');
        return {};
      }
    });

class MessagingAuditView extends ConsumerStatefulWidget {
  final String? clientId;
  final String? clientName;
  final String? appointmentId;

  const MessagingAuditView({
    super.key,
    this.clientId,
    this.clientName,
    this.appointmentId,
  });

  @override
  ConsumerState<MessagingAuditView> createState() => _MessagingAuditViewState();
}

class _MessagingAuditViewState extends ConsumerState<MessagingAuditView> {
  String? _resolvedClientId;
  String? _resolvedClientName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_resolvedClientId == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _resolvedClientId =
          widget.clientId ?? args?['clientId'] as String? ?? 'client_123';
      _resolvedClientName =
          widget.clientName ?? args?['clientName'] as String? ?? 'Client';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadConversations();
    });
  }

  Future<void> _loadConversations() async {
    // Clear any residual active conversation first
    ref.read(messagingViewModelProvider.notifier).clearActiveConversation();
    if (_resolvedClientId != null) {
      await ref
          .read(messagingViewModelProvider.notifier)
          .getUserConversations(userId: _resolvedClientId!);
    }
  }

  Future<void> _openConversation(MessageThread conversation) async {
    ref
        .read(messagingViewModelProvider.notifier)
        .setActiveConversation(conversation);
    await ref
        .read(messagingViewModelProvider.notifier)
        .getMessages(conversationId: conversation.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messagingViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);
    final isViewingChat = state.activeConversation != null;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Text(
          isViewingChat
              ? 'SECURE CONVERSATION AUDIT'
              : 'SECURE MESSAGING LEDGER',
          style: GoogleFonts.oswald(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1.1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BauhausDesign.textDark),
          onPressed: () {
            if (isViewingChat) {
              ref
                  .read(messagingViewModelProvider.notifier)
                  .clearActiveConversation();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: isViewingChat
                ? () => _openConversation(state.activeConversation!)
                : _loadConversations,
            icon: const Icon(Icons.refresh, color: BauhausDesign.textDark),
            tooltip: 'Refresh',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: BauhausDesign.neutral, height: 1.5),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Client context strip
          _buildClientContextStrip(context),

          Expanded(
            child: state.isLoading
                ? const Center(child: BauhausLoadingState())
                : isViewingChat
                ? _buildChatView(state)
                : _buildConversationsList(state),
          ),
        ],
      ),
    );
  }

  Widget _buildClientContextStrip(BuildContext context) {
    final isViewingChat =
        ref.watch(messagingViewModelProvider).activeConversation != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThick,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isViewingChat ? 'CURRENT AUDITED CLIENT' : 'MESSAGING ARCHIVE FOR',
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _resolvedClientName ?? 'Client',
            style: GoogleFonts.oswald(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: BauhausDesign.primary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Client ID: ${_resolvedClientId ?? 'client_123'}',
            style: GoogleFonts.shareTechMono(
              fontSize: 11,
              color: BauhausDesign.textMuted,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList(MessagingState state) {
    if (state.conversations.isEmpty) {
      return const Center(
        child: BauhausEmptyState(
          title: 'No Message Threads',
          message:
              'No secure messaging conversations are active for this client.',
          icon: Icons.chat_bubble_outline,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: state.conversations.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
      itemBuilder: (context, index) {
        if (index == 0) {
          return BauhausSectionHeader(
            title: 'ACTIVE COMMUNICATION CHANNELS',
            subtitle:
                'This client has ${state.conversations.length} message threads. Tap a channel to audit and inspect transcripts.',
          );
        }

        final thread = state.conversations[index - 1];
        final unread = thread.unreadCount?[_resolvedClientId ?? ''] ?? 0;

        final employeesMap =
            ref.watch(orgEmployeesProvider(thread.organizationId)).value ?? {};
        final workerName = (thread.workerName?.isNotEmpty == true)
            ? thread.workerName!
            : employeesMap[thread.workerId] ??
                  employeesMap[thread.workerId.toLowerCase()] ??
                  'Worker ${_shortId(thread.workerId)}';

        return Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _openConversation(thread),
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: BauhausDesign.secondary,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.forum_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workerName,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            thread.lastMessage ?? 'No messages yet',
                            style: GoogleFonts.inter(
                              fontSize: 13,
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
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '$unread UNREAD',
                          style: GoogleFonts.shareTechMono(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: BauhausDesign.neutral,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatView(MessagingState state) {
    final active = state.activeConversation!;
    final employeesMap =
        ref.watch(orgEmployeesProvider(active.organizationId)).value ?? {};
    final workerName = (active.workerName?.isNotEmpty == true)
        ? active.workerName!
        : employeesMap[active.workerId] ??
              employeesMap[active.workerId.toLowerCase()] ??
              'Worker ${_shortId(active.workerId)}';

    return Column(
      children: [
        // Sub-header displaying counterparts
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: BauhausDesign.surfaceWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AUDITING TRANSCRIPT',
                style: GoogleFonts.shareTechMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.success,
                ),
              ),
              Text(
                'Worker: $workerName',
                style: GoogleFonts.shareTechMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textMuted,
                ),
              ),
            ],
          ),
        ),
        Divider(color: BauhausDesign.neutral, height: 1.5, thickness: 1.5),

        Expanded(
          child: state.messages.isEmpty
              ? const Center(
                  child: BauhausEmptyState(
                    title: 'Empty Transcript',
                    message:
                        'No encrypted messages have been logged in this channel yet.',
                    icon: Icons.hourglass_empty_rounded,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.messages.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    final msg = state.messages[index];
                    final isClient = msg.senderType.toLowerCase() == 'client';

                    return Align(
                      alignment: isClient
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isClient
                              ? BauhausDesign.surfaceWhite
                              : BauhausDesign.neutral.withOpacity(0.1),
                          border: Border.all(
                            color: isClient
                                ? BauhausDesign.neutral
                                : BauhausDesign.neutral.withOpacity(0.5),
                            width: 1.5,
                          ),
                          boxShadow: isClient
                              ? const [BauhausDesign.shadowHardSm]
                              : [],
                        ),
                        padding: const EdgeInsets.all(BauhausDesign.space3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  msg.senderName.isNotEmpty
                                      ? msg.senderName.toUpperCase()
                                      : (isClient ? 'CLIENT' : 'WORKER'),
                                  style: GoogleFonts.shareTechMono(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isClient
                                        ? BauhausDesign.primary
                                        : BauhausDesign.secondary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  DateFormat('HH:mm').format(msg.timestamp),
                                  style: GoogleFonts.shareTechMono(
                                    fontSize: 10,
                                    color: BauhausDesign.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              msg.message,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                height: 1.35,
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),

        // Return button block
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          decoration: const BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border(
              top: BorderSide(color: BauhausDesign.neutral, width: 1.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  onPressed: () => ref
                      .read(messagingViewModelProvider.notifier)
                      .clearActiveConversation(),
                  text: 'RETURN TO THREADS LIST',
                  icon: Icons.keyboard_return,
                  variant: BauhausActionVariant.ghost,
                  isSmall: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _shortId(String value) {
    if (value.length <= 8) return value;
    return value.substring(value.length - 8);
  }
}
