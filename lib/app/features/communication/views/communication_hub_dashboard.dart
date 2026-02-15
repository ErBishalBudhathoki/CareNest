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
  ConsumerState<CommunicationHubDashboard> createState() => _CommunicationHubDashboardState();
}

class _CommunicationHubDashboardState extends ConsumerState<CommunicationHubDashboard> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(communicationViewModelProvider.notifier).loadConversations(widget.userId!);
        ref.read(communicationViewModelProvider.notifier).loadTemplates();
      });
    }
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
            child: Row(
              children: [
                _buildTab('INBOX', 0),
                _buildTab('COMPOSE', 1),
                _buildTab('BROADCAST', 2),
              ],
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
            color: isSelected ? BauhausDesign.secondary : BauhausDesign.surfaceWhite,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? BauhausDesign.secondary : BauhausDesign.neutral,
                width: isSelected ? 3 : 1,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(
                  color: isSelected ? BauhausDesign.surfaceWhite : BauhausDesign.neutral,
                  fontWeight: FontWeight.bold,
                ),
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
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.secondary, width: 2),
              ),
              child: const Icon(Icons.person_outline, color: BauhausDesign.secondary),
            ),
            title: Text(
              conversation.participantName,
              style: BauhausDesign.getTextTheme(context).titleMedium,
            ),
            subtitle: Text(
              conversation.lastMessage,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: conversation.unreadCount > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: BauhausDesign.primary,
                    ),
                    child: Text(
                      '${conversation.unreadCount}',
                      style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
                : null,
            onTap: () {
              ref.read(communicationViewModelProvider.notifier).loadMessages(conversation.conversationId);
              _showConversationDialog(context, conversation.participantName);
            },
          ),
        );
      },
    );
  }

  Widget _buildComposeTab(CommunicationState state) {
    final messageController = TextEditingController();
    String selectedChannel = 'SMS';

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
                  Text(
                    'Channel',
                    style: BauhausDesign.getTextTheme(context).titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: ['SMS', 'Email', 'In-App'].map((channel) {
                      return ChoiceChip(
                        label: Text(channel),
                        selected: selectedChannel == channel,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => selectedChannel = channel);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Message',
                    style: BauhausDesign.getTextTheme(context).titleMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      onPressed: state.isSending
                          ? null
                          : () async {
                              final message = messageController.text.trim();
                              if (message.isNotEmpty) {
                                final success = await ref.read(communicationViewModelProvider.notifier).sendMessage({
                                  'userId': widget.userId,
                                  'message': message,
                                  'channel': selectedChannel,
                                  'timestamp': DateTime.now().toIso8601String(),
                                });
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(success ? 'Message sent!' : 'Failed to send message'),
                                      backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
                                    ),
                                  );
                                  if (success) {
                                    messageController.clear();
                                  }
                                }
                              }
                            },
                      text: state.isSending ? 'SENDING...' : 'SEND MESSAGE',
                      icon: Icons.send,
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
                    leading: const Icon(Icons.description_outlined, color: BauhausDesign.warning),
                    title: Text(
                      template.name,
                      style: BauhausDesign.getTextTheme(context).titleSmall,
                    ),
                    subtitle: Text(
                      template.content,
                      style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.neutral,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        messageController.text = template.content;
                      },
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
    final broadcastController = TextEditingController();
    String selectedGroup = 'All Workers';

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
                  Text(
                    'Send to Group',
                    style: BauhausDesign.getTextTheme(context).titleMedium,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedGroup,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: ['All Workers', 'Active Workers', 'Managers', 'Clients'].map((group) {
                      return DropdownMenuItem(value: group, child: Text(group));
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedGroup = value);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Message',
                    style: BauhausDesign.getTextTheme(context).titleMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: broadcastController,
                    decoration: const InputDecoration(
                      hintText: 'Type your broadcast message...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      onPressed: state.isSending
                          ? null
                          : () async {
                              final message = broadcastController.text.trim();
                              if (message.isNotEmpty) {
                                final success = await ref.read(communicationViewModelProvider.notifier).broadcastMessage({
                                  'organizationId': widget.userId,
                                  'group': selectedGroup,
                                  'message': message,
                                  'timestamp': DateTime.now().toIso8601String(),
                                });
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(success ? 'Broadcast sent!' : 'Failed to send broadcast'),
                                      backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
                                    ),
                                  );
                                  if (success) {
                                    broadcastController.clear();
                                  }
                                }
                              }
                            },
                      text: state.isSending ? 'SENDING...' : 'SEND BROADCAST',
                      icon: Icons.send,
                      variant: BauhausActionVariant.warning,
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
        title: Text(participantName),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: state.messages.isEmpty
              ? const Center(child: Text('No messages'))
              : ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return ListTile(
                      title: Text(message.message),
                      subtitle: Text(message.sentAt),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}
