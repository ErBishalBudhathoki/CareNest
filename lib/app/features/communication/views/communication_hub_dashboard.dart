import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/communication/viewmodels/communication_viewmodel.dart';

class CommunicationHubDashboard extends ConsumerStatefulWidget {
  final String? userId;

  const CommunicationHubDashboard({
    super.key,
    this.userId,
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

  late final TextEditingController _messageController;
  late final TextEditingController _broadcastController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _broadcastController = TextEditingController();
    if (widget.userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(communicationViewModelProvider.notifier)
            .loadConversations(widget.userId!);
        ref.read(communicationViewModelProvider.notifier).loadTemplates();
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _broadcastController.dispose();
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
          BauhausCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BauhausSectionHeader(title: 'Select Channel'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: ['SMS', 'Email', 'In-App'].map((channel) {
                      return BauhausChip(
                        label: channel,
                        isSelected: _selectedChannel == channel,
                        variant: BauhausChipVariant.secondary,
                        onTap: () => setState(() => _selectedChannel = channel),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  BauhausTextField(
                    controller: _messageController,
                    label: 'Message',
                    hintText: 'Type your message...',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      onPressed: state.isSending
                          ? null
                          : () async {
                              final message = _messageController.text.trim();
                              if (message.isNotEmpty) {
                                final success = await ref
                                    .read(
                                        communicationViewModelProvider.notifier)
                                    .sendMessage({
                                  'userId': widget.userId,
                                  'message': message,
                                  'channel': _selectedChannel,
                                  'timestamp': DateTime.now().toIso8601String(),
                                });
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(success
                                          ? 'Message sent!'
                                          : 'Failed to send message'),
                                      backgroundColor: success
                                          ? BauhausDesign.success
                                          : BauhausDesign.error,
                                    ),
                                  );
                                  if (success) {
                                    _messageController.clear();
                                  }
                                }
                              }
                            },
                      text: state.isSending ? 'SENDING...' : 'SEND MESSAGE',
                      icon: Icons.send,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Templates
          if (state.templates.isNotEmpty) ...[
            BauhausSectionHeader(title: 'MESSAGE TEMPLATES'),
            const SizedBox(height: 16),
            ...state.templates.map((template) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BauhausCard(
                  child: ListTile(
                    leading: const Icon(Icons.description_outlined,
                        color: BauhausDesign.warning),
                    title: Text(
                      template.name,
                      style: BauhausDesign.getTextTheme(context)
                          .titleSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      template.content,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textDark.withOpacity(0.6),
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: BauhausIconButton(
                      icon: Icons.add_circle_outline,
                      onPressed: () {
                        _messageController.text = template.content;
                        setState(() {}); // Trigger sync
                      },
                      variant: BauhausActionVariant.primary,
                      isSmall: true,
                    ),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildBroadcastTab(CommunicationState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(title: 'BROADCAST MESSAGE'),
          const SizedBox(height: 16),
          BauhausCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.campaign_outlined,
                    size: 48,
                    color: BauhausDesign.warning,
                  ),
                  const SizedBox(height: 16),
                  BauhausSectionHeader(title: 'Send to Group'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      border:
                          Border.all(color: BauhausDesign.neutral, width: 2),
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        value: _selectedGroup,
                        dropdownColor: BauhausDesign.surfaceWhite,
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        items: [
                          'All Workers',
                          'Active Workers',
                          'Managers',
                          'Clients'
                        ].map((group) {
                          return DropdownMenuItem(
                            value: group,
                            child: Text(
                              group,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(color: BauhausDesign.textDark),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedGroup = value);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  BauhausTextField(
                    controller: _broadcastController,
                    label: 'Message',
                    hintText: 'Type your broadcast message...',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      onPressed: state.isSending
                          ? null
                          : () async {
                              final message = _broadcastController.text.trim();
                              if (message.isNotEmpty) {
                                final success = await ref
                                    .read(
                                        communicationViewModelProvider.notifier)
                                    .broadcastMessage({
                                  'organizationId': widget.userId,
                                  'group': _selectedGroup,
                                  'message': message,
                                  'timestamp': DateTime.now().toIso8601String(),
                                });
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(success
                                          ? 'Broadcast sent!'
                                          : 'Failed to send broadcast'),
                                      backgroundColor: success
                                          ? BauhausDesign.success
                                          : BauhausDesign.error,
                                    ),
                                  );
                                  if (success) {
                                    _broadcastController.clear();
                                  }
                                }
                              }
                            },
                      text: state.isSending ? 'SENDING...' : 'SEND BROADCAST',
                      icon: Icons.send,
                      variant: BauhausActionVariant.warning,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
