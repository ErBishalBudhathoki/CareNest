import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/client_portal/viewmodels/client_portal_viewmodel.dart';

class ClientPortalDashboard extends ConsumerStatefulWidget {
  final String? clientId;

  const ClientPortalDashboard({
    super.key,
    this.clientId,
  });

  @override
  ConsumerState<ClientPortalDashboard> createState() => _ClientPortalDashboardState();
}

class _ClientPortalDashboardState extends ConsumerState<ClientPortalDashboard> {
  @override
  void initState() {
    super.initState();
    if (widget.clientId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(clientPortalViewModelProvider.notifier).loadDashboard(widget.clientId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientPortalViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.primary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'CLIENT PORTAL',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: BauhausLoadingState())
          : state.error != null
              ? Center(
                  child: BauhausEmptyState(
                    title: 'Error',
                    message: state.error!,
                    icon: Icons.error_outline,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dashboard Header
                      BauhausSectionHeader(title: 'TODAY\'S APPOINTMENTS'),
                      const SizedBox(height: 16),

                      if (state.dashboard != null) ...[
                        // Upcoming Appointments
                        BauhausCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: BauhausDesign.primary.withOpacity(0.1),
                                        border: Border.all(color: BauhausDesign.primary, width: 2),
                                      ),
                                      child: const Icon(
                                        Icons.calendar_today_outlined,
                                        color: BauhausDesign.primary,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Next Appointment',
                                            style: BauhausDesign.getTextTheme(context).titleMedium,
                                          ),
                                          Text(
                                            state.dashboard!.todayAppointments.isNotEmpty
                                                ? state.dashboard!.todayAppointments.first.startTime
                                                : 'No appointments today',
                                            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                                                  color: BauhausDesign.neutral,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Worker Location Section
                        BauhausSectionHeader(title: 'WORKER LOCATION'),
                        const SizedBox(height: 16),
                        BauhausCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 48,
                                  color: BauhausDesign.secondary,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Track your worker in real-time',
                                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                BauhausActionButton(
                                  onPressed: () {
                                    // Load worker location
                                    if (state.dashboard!.todayAppointments.isNotEmpty) {
                                      ref
                                          .read(clientPortalViewModelProvider.notifier)
                                          .getWorkerLocation(state.dashboard!.todayAppointments.first.appointmentId);
                                    }
                                  },
                                  text: 'VIEW LOCATION',
                                  icon: Icons.my_location,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Messaging Section
                        BauhausSectionHeader(title: 'MESSAGING'),
                        const SizedBox(height: 16),
                        BauhausCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.message_outlined,
                                  size: 48,
                                  color: BauhausDesign.warning,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Send a message to your worker',
                                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                BauhausActionButton(
                                  onPressed: () {
                                    _showMessageDialog(context);
                                  },
                                  text: 'SEND MESSAGE',
                                  icon: Icons.send,
                                  variant: BauhausActionVariant.secondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Feedback Section
                        BauhausSectionHeader(title: 'SERVICE FEEDBACK'),
                        const SizedBox(height: 16),
                        BauhausCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.star_outline,
                                  size: 48,
                                  color: BauhausDesign.accent,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Rate your recent service',
                                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                BauhausActionButton(
                                  onPressed: () {
                                    _showFeedbackDialog(context);
                                  },
                                  text: 'SUBMIT FEEDBACK',
                                  icon: Icons.rate_review,
                                  variant: BauhausActionVariant.warning,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
    );
  }

  void _showMessageDialog(BuildContext context) {
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Message'),
        content: TextField(
          controller: messageController,
          decoration: const InputDecoration(
            hintText: 'Type your message...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () async {
              final message = messageController.text.trim();
              if (message.isNotEmpty) {
                final success = await ref.read(clientPortalViewModelProvider.notifier).sendMessage({
                  'clientId': widget.clientId,
                  'message': message,
                  'timestamp': DateTime.now().toIso8601String(),
                });
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success ? 'Message sent!' : 'Failed to send message'),
                      backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
                    ),
                  );
                }
              }
            },
            child: const Text('SEND'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    int rating = 5;
    final feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Service Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rate your service:'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: BauhausDesign.accent,
                    ),
                    onPressed: () => setState(() => rating = index + 1),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: feedbackController,
                decoration: const InputDecoration(
                  hintText: 'Additional comments...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () async {
                final success = await ref.read(clientPortalViewModelProvider.notifier).submitFeedback({
                  'clientId': widget.clientId,
                  'rating': rating,
                  'feedback': feedbackController.text.trim(),
                  'timestamp': DateTime.now().toIso8601String(),
                });
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success ? 'Feedback submitted!' : 'Failed to submit feedback'),
                      backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
                    ),
                  );
                }
              },
              child: const Text('SUBMIT'),
            ),
          ],
        ),
      ),
    );
  }
}
