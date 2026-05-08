import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/communication/viewmodels/communication_viewmodel.dart';

class CommunicationHubDashboard extends ConsumerStatefulWidget {
  final String? userId;
  final String? organizationId;
  final String? currentUserId;

  const CommunicationHubDashboard({
    super.key,
    this.userId,
    this.organizationId,
    this.currentUserId,
  });

  @override
  ConsumerState<CommunicationHubDashboard> createState() =>
      _CommunicationHubDashboardState();
}

class _CommunicationHubDashboardState
    extends ConsumerState<CommunicationHubDashboard> {
  int _selectedTab = 0;
  String _selectedChannel = 'SMS';
  String _selectedGroup = 'All Workers';
  final String _broadcastType = 'announcement';

  late final TextEditingController _messageController;
  late final TextEditingController _broadcastController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _subjectController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _broadcastController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    if (widget.userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(communicationViewModelProvider.notifier)
            .loadConversations(widget.userId!);
        ref.read(communicationViewModelProvider.notifier).loadTemplates();
        if (widget.organizationId != null) {
          ref.read(communicationViewModelProvider.notifier).loadActiveBroadcasts(widget.organizationId!);
          ref.read(communicationViewModelProvider.notifier).loadBroadcastHistory(widget.organizationId!);
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _broadcastController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communicationViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'COMMUNICATION HUB',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Selector
          Container(
            color: BauhausDesign.surfaceWhite,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 520) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        _buildCompactTab('INBOX', 0),
                        const SizedBox(width: 8),
                        _buildCompactTab('COMPOSE', 1),
                        const SizedBox(width: 8),
                        _buildCompactTab('BROADCAST', 2),
                      ],
                    ),
                  );
                }

                return Row(
                  children: [
                    _buildTab('INBOX', 0),
                    _buildTab('COMPOSE', 1),
                    _buildTab('BROADCAST', 2),
                  ],
                );
              },
            ),
          ),
          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildInboxTab(state)
                : _selectedTab == 1
                    ? _buildComposeTab(state)
                    : _buildBroadcastTab(state),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? BauhausDesign.secondary
                : BauhausDesign.surfaceWhite,
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? BauhausDesign.secondary
                    : BauhausDesign.neutral,
                width: isSelected ? 4 : 2,
              ),
              right: index < 2
                  ? const BorderSide(color: BauhausDesign.neutral, width: 2)
                  : BorderSide.none,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: isSelected
                      ? BauhausDesign.surfaceWhite
                      : BauhausDesign.textDark.withOpacity(0.7),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        constraints: const BoxConstraints(minWidth: 120),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? BauhausDesign.secondary : BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: isSelected
                    ? BauhausDesign.surfaceWhite
                    : BauhausDesign.textDark,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
              ),
        ),
      ),
    );
  }

  Widget _buildInboxTab(CommunicationState state) {
    if (state.isLoading) {
      return const Center(child: BauhausLoadingState());
    }

    if (state.conversations.isEmpty) {
      return const Center(
        child: BauhausEmptyState(
          title: 'No Conversations',
          message: 'You have no conversations yet',
          icon: Icons.inbox_outlined,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: state.conversations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final conversation = state.conversations[index];
        return BauhausCard(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: const Icon(Icons.person_outline,
                  color: BauhausDesign.secondary, size: 28),
            ),
            title: Text(
              conversation.participantName,
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              conversation.lastMessage,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textDark.withOpacity(0.6),
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: conversation.unreadCount > 0
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: BauhausDesign.primary,
                      border:
                          Border.all(color: BauhausDesign.neutral, width: 1.5),
                    ),
                    child: Text(
                      '${conversation.unreadCount}',
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  )
                : const Icon(Icons.chevron_right, color: BauhausDesign.neutral),
            onTap: () {
              ref
                  .read(communicationViewModelProvider.notifier)
                  .loadMessages(conversation.conversationId);
              _showConversationDialog(context, conversation.participantName);
            },
          ),
        );
      },
    );
  }

  Widget _buildComposeTab(CommunicationState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(title: 'NEW MESSAGE'),
          const SizedBox(height: 16),
          // Channel selector
          BauhausCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BauhausSectionHeader(title: 'CHANNEL'),
                  const SizedBox(height: 12),
                  Row(
                    children: ['In-App', 'SMS', 'Email'].map((ch) {
                      final sel = _selectedChannel == ch;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedChannel = ch),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: sel ? BauhausDesign.secondary : BauhausDesign.surfaceOffWhite,
                              border: Border.all(color: sel ? BauhausDesign.secondary : BauhausDesign.neutral, width: 2),
                              boxShadow: sel ? const [BauhausDesign.shadowHardSm] : [],
                            ),
                            alignment: Alignment.center,
                            child: Text(ch, style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                              color: sel ? BauhausDesign.surfaceWhite : BauhausDesign.textDark,
                              fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  if (_selectedChannel == 'SMS') ...[
                    BauhausSectionHeader(title: 'RECIPIENT PHONE'),
                    const SizedBox(height: 8),
                    BauhausTextField(controller: _phoneController, label: 'Phone Number', hintText: '+61 4XX XXX XXX', keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                  ] else if (_selectedChannel == 'Email') ...[
                    BauhausSectionHeader(title: 'RECIPIENT EMAIL'),
                    const SizedBox(height: 8),
                    BauhausTextField(controller: _emailController, label: 'Email Address', hintText: 'employee@example.com', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 8),
                    BauhausTextField(controller: _subjectController, label: 'Subject', hintText: 'Message subject...'),
                    const SizedBox(height: 16),
                  ] else ...[
                    BauhausSectionHeader(title: 'RECIPIENT'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceOffWhite,
                        border: Border.all(color: BauhausDesign.neutral, width: 2),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedGroup,
                          dropdownColor: BauhausDesign.surfaceWhite,
                          items: ['All Workers', 'Active Workers', 'Managers', 'Clients'].map((g) =>
                            DropdownMenuItem(value: g, child: Text(g, style: BauhausDesign.getTextTheme(context).bodyMedium))
                          ).toList(),
                          onChanged: (v) { if (v != null) setState(() => _selectedGroup = v); },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  BauhausTextField(
                    controller: _messageController,
                    label: 'Message',
                    hintText: _selectedChannel == 'SMS'
                        ? 'Type SMS (160 chars)...'
                        : _selectedChannel == 'Email'
                            ? 'Type email body...'
                            : 'Type your in-app message...',
                    maxLines: _selectedChannel == 'Email' ? 8 : 4,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      onPressed: state.isSending ? null : () async {
                        final message = _messageController.text.trim();
                        if (message.isEmpty) return;

                        if (_selectedChannel == 'SMS') {
                          final phone = _phoneController.text.trim();
                          if (phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a phone number'), backgroundColor: BauhausDesign.error)
                            );
                            return;
                          }
                          
                          // Launch SMS intent
                          final Uri smsUri = Uri(
                            scheme: 'sms',
                            path: phone,
                            queryParameters: <String, String>{
                              'body': message,
                            },
                          );
                          
                          try {
                            if (await canLaunchUrl(smsUri)) {
                              await launchUrl(smsUri);
                            } else {
                              throw 'Could not launch SMS app';
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error launching SMS app: $e'), backgroundColor: BauhausDesign.error)
                              );
                            }
                            return; // Don't log if we couldn't even launch it
                          }
                        } else if (_selectedChannel == 'Email') {
                          final email = _emailController.text.trim();
                          final subject = _subjectController.text.trim();
                          if (email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter an email address'), backgroundColor: BauhausDesign.error)
                            );
                            return;
                          }
                          
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: email,
                            query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}'
                          );
                          
                          try {
                            if (await canLaunchUrl(emailUri)) {
                              await launchUrl(emailUri);
                            }
                          } catch (e) {
                            // Proceed to log failure or success anyway
                          }
                        }

                        // Log to backend
                        final success = await ref
                            .read(communicationViewModelProvider.notifier)
                            .sendMessage({
                          'userId': widget.userId,
                          'message': message,
                          'channel': _selectedChannel,
                          'group': _selectedChannel == 'In-App' ? _selectedGroup : (_selectedChannel == 'SMS' ? _phoneController.text : _emailController.text),
                          'timestamp': DateTime.now().toIso8601String(),
                        });
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(success ? '$_selectedChannel sent and logged!' : 'Logged offline/Failed to log'),
                            backgroundColor: success ? BauhausDesign.success : BauhausDesign.warning,
                          ));
                          if (success) _messageController.clear();
                        }
                      },
                      text: state.isSending ? 'SENDING...' : 'SEND $_selectedChannel',
                      icon: _selectedChannel == 'SMS' ? Icons.sms : _selectedChannel == 'Email' ? Icons.email : Icons.send,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Templates
          if (state.templates.isNotEmpty) ...[
            const SizedBox(height: 24),
            BauhausSectionHeader(title: 'MESSAGE TEMPLATES'),
            const SizedBox(height: 16),
            ...state.templates.map((t) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: BauhausCard(
                child: ListTile(
                  leading: const Icon(Icons.description_outlined, color: BauhausDesign.warning),
                  title: Text(t.name, style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  subtitle: Text(t.content, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: BauhausIconButton(
                    icon: Icons.add_circle_outline,
                    onPressed: () => setState(() => _messageController.text = t.content),
                    variant: BauhausActionVariant.primary,
                    isSmall: true,
                  ),
                ),
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildBroadcastTab(CommunicationState state) {
    final currentUserId = widget.currentUserId ?? '';
    final active = state.activeBroadcasts.where((b) =>
      !b.acknowledgments.contains(currentUserId)).toList();
    final hasActive = active.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Active Broadcasts Banner ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: hasActive ? BauhausDesign.secondary : BauhausDesign.neutral,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Icon(hasActive ? Icons.campaign : Icons.campaign_outlined,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      hasActive ? 'ACTIVE BROADCASTS  ·  ${active.length}' : 'BROADCAST CHANNEL',
                      style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.5),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white, size: 16),
                      onPressed: () {
                        if (widget.organizationId != null) {
                          ref.read(communicationViewModelProvider.notifier)
                            .loadActiveBroadcasts(widget.organizationId!);
                        }
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: hasActive ? const Color(0xFFF0F7FF) : BauhausDesign.surfaceOffWhite,
                  border: Border.all(
                    color: hasActive ? BauhausDesign.secondary : BauhausDesign.neutral, width: 2),
                  boxShadow: [BoxShadow(
                    color: hasActive ? BauhausDesign.secondary : BauhausDesign.neutral,
                    offset: const Offset(4, 4), blurRadius: 0)],
                ),
                child: Column(
                  children: [
                    if (!hasActive)
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: BauhausDesign.success, size: 16),
                            const SizedBox(width: 8),
                            Text('No active broadcasts — all clear.',
                              style: BauhausDesign.getTextTheme(context).bodyMedium),
                          ],
                        ),
                      )
                    else
                      ...active.map((b) => _CommsBroadcastTile(
                        broadcast: b,
                        onAcknowledge: () {
                          ref.read(communicationViewModelProvider.notifier)
                            .acknowledgeBroadcast(b.id, currentUserId);
                        },
                      )),
                    // Admin send button
                    GestureDetector(
                      onTap: () => _showBroadcastDialog(context, state),
                      child: Container(
                        width: double.infinity,
                        color: BauhausDesign.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.campaign, color: Colors.white, size: 14),
                            const SizedBox(width: 8),
                            Text('SEND BROADCAST',
                              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ── Broadcast History ──
          if (state.broadcastHistory.isNotEmpty) ...[
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(width: 4, height: 16, color: BauhausDesign.secondary),
                  const SizedBox(width: 10),
                  Text('BROADCAST HISTORY',
                    style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      fontWeight: FontWeight.w800, letterSpacing: 2.5)),
                ],
              ),
            ),
            ...state.broadcastHistory.map((b) => _CommsBroadcastHistoryTile(broadcast: b)),
          ],
        ],
      ),
    );
  }

  void _showBroadcastDialog(BuildContext context, CommunicationState state) {
    final msgCtrl = TextEditingController();
    String type = _broadcastType;
    String group = _selectedGroup;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BoxShadow(color: BauhausDesign.secondary, offset: Offset(6,6), blurRadius: 0)],
          ),
          child: StatefulBuilder(
            builder: (ctx, setS) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: BauhausDesign.neutral,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.campaign, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text('SEND BROADCAST', style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.8)),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.65),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Type
                        Text('TYPE', style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                          fontWeight: FontWeight.w800, letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Row(
                          children: ['announcement', 'reminder', 'update'].map((t) {
                            final sel = type == t;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setS(() => type = t),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: sel ? BauhausDesign.secondary : BauhausDesign.surfaceOffWhite,
                                    border: Border.all(color: sel ? BauhausDesign.secondary : BauhausDesign.neutral, width: 2),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(t.toUpperCase(), style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                                    color: sel ? Colors.white : BauhausDesign.textDark,
                                    fontWeight: FontWeight.w800, letterSpacing: 1)),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        // Target group
                        Text('TARGET GROUP', style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                          fontWeight: FontWeight.w800, letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: BauhausDesign.surfaceOffWhite,
                            border: Border.all(color: BauhausDesign.neutral, width: 2),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: group,
                              dropdownColor: BauhausDesign.surfaceWhite,
                              items: ['All Workers', 'Active Workers', 'Managers', 'Clients'].map((g) =>
                                DropdownMenuItem(value: g, child: Text(g))
                              ).toList(),
                              onChanged: (v) { if (v != null) setS(() => group = v); },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Message
                        Text('MESSAGE', style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                          fontWeight: FontWeight.w800, letterSpacing: 2)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: msgCtrl,
                          maxLines: 4,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: BauhausDesign.surfaceOffWhite,
                            hintText: 'Type your broadcast message...',
                            border: const OutlineInputBorder(borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: BauhausDesign.neutral, width: 2)),
                            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: BauhausDesign.neutral, width: 2)),
                            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: BauhausDesign.secondary, width: 2)),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(ctx),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: BauhausDesign.surfaceOffWhite,
                                    border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('CANCEL', style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                                    fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final msg = msgCtrl.text.trim();
                                  if (msg.isEmpty) return;
                                  Navigator.pop(ctx);
                                  final success = await ref
                                    .read(communicationViewModelProvider.notifier)
                                    .broadcastMessage({
                                      'organizationId': widget.organizationId,
                                      'group': group,
                                      'type': type,
                                      'message': msg,
                                      'timestamp': DateTime.now().toIso8601String(),
                                    });
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(success ? 'Broadcast sent!' : 'Failed to send broadcast'),
                                      backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
                                    ));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: BauhausDesign.secondary,
                                    border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                                    boxShadow: const [BauhausDesign.shadowHardSm],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('BROADCAST', style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                                    color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConversationDialog(BuildContext context, String participantName) {
    final state = ref.read(communicationViewModelProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.backgroundLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: BauhausDesign.neutral, width: 3),
        ),
        title: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: BauhausDesign.secondary,
            border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2)),
          ),
          child: Text(
            participantName.toUpperCase(),
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.surfaceWhite,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: state.messages.isEmpty
              ? const Center(
                  child: Text(
                    'No messages',
                    style: TextStyle(color: BauhausDesign.textDark),
                  ),
                )
              : ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return ListTile(
                      title: Text(
                        message.message,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.textDark),
                      ),
                      subtitle: Text(
                        message.sentAt,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.textDark.withOpacity(0.7),
                            ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          BauhausActionButton(
            onPressed: () => Navigator.pop(context),
            text: 'CLOSE',
            variant: BauhausActionVariant.primary,
            isSmall: true,
          ),
        ],
      ),
    );
  }
}

class _CommsBroadcastTile extends StatelessWidget {
  final HubBroadcastMessage broadcast;
  final VoidCallback onAcknowledge;

  const _CommsBroadcastTile({
    required this.broadcast,
    required this.onAcknowledge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: BauhausDesign.neutral, width: 2)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary,
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                child: Text(
                  broadcast.type.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'From: ${broadcast.initiatorName} • ${broadcast.group}',
                  style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                      fontWeight: FontWeight.bold, color: BauhausDesign.textDark.withOpacity(0.7)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${broadcast.createdAt.hour}:${broadcast.createdAt.minute.toString().padLeft(2, '0')}',
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            broadcast.message,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w600, color: BauhausDesign.textDark, height: 1.4),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: BauhausActionButton(
              onPressed: onAcknowledge,
              text: 'ACKNOWLEDGE',
              icon: Icons.check,
              isSmall: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommsBroadcastHistoryTile extends StatelessWidget {
  final HubBroadcastMessage broadcast;

  const _CommsBroadcastHistoryTile({required this.broadcast});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final diff = now.difference(broadcast.createdAt);
    String timeAgo;
    if (diff.inDays > 0) timeAgo = '${diff.inDays}d ago';
    else if (diff.inHours > 0) timeAgo = '${diff.inHours}h ago';
    else timeAgo = '${diff.inMinutes}m ago';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                broadcast.type.toUpperCase(),
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.secondary, fontWeight: FontWeight.w800, fontSize: 10),
              ),
              const Spacer(),
              Text(
                timeAgo,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark.withOpacity(0.6), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            broadcast.message,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.textDark, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.group, size: 12, color: BauhausDesign.neutral),
              const SizedBox(width: 4),
              Text(
                broadcast.group,
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    fontSize: 10, color: BauhausDesign.textDark.withOpacity(0.7)),
              ),
              const Spacer(),
              Text(
                '${broadcast.acknowledgments.length} ack',
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    fontSize: 10, color: BauhausDesign.success, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
