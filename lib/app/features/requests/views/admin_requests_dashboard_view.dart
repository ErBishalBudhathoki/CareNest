import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/viewmodels/admin_requests_viewmodel.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdminRequestsDashboardView extends ConsumerStatefulWidget {
  const AdminRequestsDashboardView({super.key});

  @override
  ConsumerState<AdminRequestsDashboardView> createState() =>
      _AdminRequestsDashboardViewState();
}

class _AdminRequestsDashboardViewState
    extends ConsumerState<AdminRequestsDashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
      lib/app/features/requests/repositories/    debugPrint('AdminRequestsDashboardView: Initializing');
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    debugPrint('AdminRequestsDashboardView: Disposing');
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('AdminRequestsDashboardView: Building');
    // Listen for new notifications
    ref.listen(notificationProvider, (previous, next) {
      // Cast to ensure type safety and satisfy linter
      final NotificationState currentState = next as NotificationState;
      final NotificationState? previousState = previous as NotificationState?;

      if (previousState != null &&
          currentState.notifications.length >
              previousState.notifications.length) {
        // Check if the latest notification is related to a request
        if (currentState.notifications.isNotEmpty) {
          final latest = currentState.notifications.first;
          if (latest.data != null &&
              latest.data!['type'] == 'request_created') {
            // Refresh the request list
            ref.read(adminRequestsViewModelProvider.notifier).fetchRequests();

            // Show a snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('New Request: ${latest.title}'),
                action: SnackBarAction(
                  label: 'View',
                  onPressed: () {
                    // If we are already on this screen, just switch to Pending tab if needed
                    _tabController.animateTo(0); // Switch to Pending
                  },
                ),
              ),
            );
          }
        }
      }
    });

    final requestsState = ref.watch(adminRequestsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests Dashboard'),
        backgroundColor: AppColors.colorPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: AppColors.colorAccent,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Declined'),
          ],
        ),
      ),
      body: requestsState.when(
        data: (requests) {
          final pending = requests
              .where((r) => r.status.toLowerCase() == 'pending')
              .toList();
          final approved = requests
              .where((r) => r.status.toLowerCase() == 'approved')
              .toList();
          final declined = requests
              .where((r) => r.status.toLowerCase() == 'declined')
              .toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildRequestList(pending, true),
              _buildRequestList(approved, false),
              _buildRequestList(declined, false),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(adminRequestsViewModelProvider.notifier).fetchRequests();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildRequestList(List<RequestModel> requests, bool showActions) {
    if (requests.isEmpty) {
      return const Center(child: Text('No requests found'));
    }

    return ListView.builder(
      itemCount: requests.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      request.type,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                    Text(
                      request.createdAt != null
                          ? DateFormat('MMM d, y').format(request.createdAt!)
                          : '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('User: ${request.userId}'), // Should ideally show name
                const SizedBox(height: 8),
                _buildDetails(request),
                if (request.note != null && request.note!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Note: ${request.note}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                if (showActions) ...[
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _handleAction(request, 'Declined'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.error,
                        ),
                        child: const Text('Decline'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _handleAction(request, 'Approved'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Approve'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetails(RequestModel request) {
    // Custom display based on request type
    if (request.type == 'Time Off') {
      final startsStr =
          request.details['starts'] ?? request.details['startDate'];
      final endsStr = request.details['ends'] ?? request.details['endDate'];
      final type = request.details['timeOffType'];

      String from = startsStr ?? '';
      String to = endsStr ?? '';

      if (startsStr != null) {
        try {
          from = DateFormat('MMM d, y').format(DateTime.parse(startsStr));
        } catch (e) {
          // Keep original string if parse fails
        }
      }
      if (endsStr != null) {
        try {
          to = DateFormat('MMM d, y').format(DateTime.parse(endsStr));
        } catch (e) {
          // Keep original string if parse fails
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('From: $from'),
          Text('To: $to'),
          if (type != null) Text('Type: $type'),
        ],
      );
    } else if (request.type == 'Shift') {
      final startsStr = request.details['starts'] ?? request.details['date'];
      final endsStr = request.details['ends'];
      final job = request.details['job'];

      String date = '';
      String timeRange = '';

      if (startsStr != null) {
        try {
          final startDt = DateTime.parse(startsStr);
          date = DateFormat('MMM d, y').format(startDt);

          final startTime = DateFormat('h:mm a').format(startDt);
          String endTime = '';

          if (endsStr != null) {
            final endDt = DateTime.parse(endsStr);
            endTime = DateFormat('h:mm a').format(endDt);
          } else if (request.details['endTime'] != null) {
            // Legacy format fallback
            endTime = request.details['endTime'];
          }

          timeRange = '$startTime - $endTime';
        } catch (e) {
          // Fallback for legacy
          if (request.details['date'] != null) {
            date = request.details['date'];
          }
          if (request.details['startTime'] != null &&
              request.details['endTime'] != null) {
            timeRange =
                '${request.details['startTime']} - ${request.details['endTime']}';
          }
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (job != null)
            Text('Job: $job',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          if (date.isNotEmpty) Text('Date: $date'),
          if (timeRange.isNotEmpty) Text('Time: $timeRange'),
        ],
      );
    }
    return Text(request.details.toString());
  }

  Future<void> _handleAction(RequestModel request, String status) async {
    if (status == 'Declined') {
      // Show dialog for reason
      final reasonController = TextEditingController();
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Decline Request'),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              labelText: 'Reason (optional)',
              hintText: 'Enter reason for declining',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Decline'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        if (!mounted) return;
        await ref
            .read(adminRequestsViewModelProvider.notifier)
            .updateRequestStatus(
              request.id!,
              status,
              reason: reasonController.text,
            );
      }
    } else {
      await ref
          .read(adminRequestsViewModelProvider.notifier)
          .updateRequestStatus(request.id!, status);
    }
  }
}
