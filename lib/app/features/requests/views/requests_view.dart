import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'add_shift_request_view.dart';
import 'add_time_off_request_view.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_view_model.dart';
import 'package:carenest/app/features/notifications/providers/notification_provider.dart';

class RequestsView extends ConsumerStatefulWidget {
  final String email;

  const RequestsView({super.key, required this.email});

  @override
  ConsumerState<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends ConsumerState<RequestsView> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 14));

  void _showRequestOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'Add a shift request',
                style: TextStyle(
                  color: AppColors.colorBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.5,
                    maxChildSize: 0.75,
                    expand: false,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: AddShiftRequestView(email: widget.email),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Add a time off request',
                style: TextStyle(
                  color: AppColors.colorBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.5,
                    maxChildSize: 0.75,
                    expand: false,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: AddTimeOffRequestView(email: widget.email),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.colorBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );
    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.description_outlined,
          size: 64,
          color: AppColors.colorGrey300,
        ),
        const SizedBox(height: 16),
        Text(
          'No requests to display',
          style: TextStyle(
            color: AppColors.colorGrey500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen for new notifications
    ref.listen(notificationProvider, (previous, next) {
      debugPrint('DEBUG_REQUESTS: Notification state changed');
      final NotificationState currentState = next as NotificationState;
      final NotificationState? previousState = previous as NotificationState?;

      debugPrint(
          'DEBUG_REQUESTS: Previous count: ${previousState?.notifications.length ?? 0}, New count: ${currentState.notifications.length}');

      if (previousState != null &&
          currentState.notifications.length >
              previousState.notifications.length) {
        if (currentState.notifications.isNotEmpty) {
          final latest = currentState.notifications.first;
          debugPrint(
              'DEBUG_REQUESTS: New notification received: ${latest.title}, Type: ${latest.data?['type']}');

          if (latest.data != null && latest.data!['type'] == 'request_update') {
            // Refresh the request list
            debugPrint('DEBUG_REQUESTS: Refreshing requests list...');
            ref.read(requestsViewModelProvider.notifier).fetchRequests();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${latest.title}: ${latest.body}'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      }
    });

    final requestsState = ref.watch(requestsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.colorBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Requests',
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Date Range Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: _selectDateRange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.colorGrey200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      DateFormat('MM/dd/yyyy').format(startDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('to', style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.colorGrey200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      DateFormat('MM/dd/yyyy').format(endDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Status Counts and List
          Expanded(
            child: requestsState.when(
              data: (state) {
                // Filter requests based on date range
                // A request is in range if its 'starts' date is within [startDate, endDate]
                // Or created date? Usually shift start date.
                final filteredRequests = state.requests.where((r) {
                  DateTime? reqDate;
                  if (r.details['starts'] != null) {
                    reqDate = DateTime.parse(r.details['starts']);
                  } else if (r.createdAt != null) {
                    reqDate = r.createdAt;
                  }

                  if (reqDate == null) return false;

                  // Compare dates (ignore time for start/end boundaries)
                  final s =
                      DateTime(startDate.year, startDate.month, startDate.day);
                  final e = DateTime(
                      endDate.year, endDate.month, endDate.day, 23, 59, 59);
                  return reqDate
                          .isAfter(s.subtract(const Duration(seconds: 1))) &&
                      reqDate.isBefore(e.add(const Duration(seconds: 1)));
                }).toList();

                final pending =
                    filteredRequests.where((r) => r.status == RequestStatus.pending || r.status == RequestStatus.pendingLocal).length;
                final declined = filteredRequests
                    .where((r) => r.status == RequestStatus.rejected)
                    .length;
                final approved = filteredRequests
                    .where((r) => r.status == RequestStatus.approved)
                    .length;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatusCount(pending.toString(), 'Pending',
                            AppColors.colorGrey500),
                        _buildStatusCount(declined.toString(), 'Declined',
                            AppColors.colorGrey500),
                        _buildStatusCount(approved.toString(), 'Approved',
                            AppColors.colorGrey500),
                      ],
                    ),
                    const Divider(height: 40),
                    Expanded(
                      child: filteredRequests.isEmpty
                          ? _buildEmptyState()
                          : RefreshIndicator(
                              onRefresh: () async {
                                await ref
                                    .read(requestsViewModelProvider.notifier)
                                    .fetchRequests();
                              },
                              child: ListView.builder(
                                itemCount: filteredRequests.length,
                                itemBuilder: (context, index) {
                                  final request = filteredRequests[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    child: ListTile(
                                      title: Text(request.type,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                _getStatusIcon(request.status),
                                                color: _getStatusColor(
                                                    request.status),
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                request.status.label,
                                                style: TextStyle(
                                                  color: _getStatusColor(
                                                      request.status),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (request.note != null &&
                                              request.note!.isNotEmpty)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                  'Note: ${request.note}',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic)),
                                            ),
                                        ],
                                      ),
                                      trailing: request.details['starts'] !=
                                              null
                                          ? Text(DateFormat('MM/dd').format(
                                              DateTime.parse(
                                                  request.details['starts'])))
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _showRequestOptions,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Add a new request',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCount(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(RequestStatus status) {
    switch (status) {
      case RequestStatus.approved:
        return Icons.check_circle;
      case RequestStatus.rejected:
      case RequestStatus.cancelled:
        return Icons.cancel;
      case RequestStatus.pending:
      case RequestStatus.pendingLocal:
      default:
        return Icons.access_time;
    }
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.approved:
        return Colors.green;
      case RequestStatus.rejected:
      case RequestStatus.cancelled:
        return Colors.red;
      case RequestStatus.pending:
      case RequestStatus.pendingLocal:
      default:
        return Colors.orange;
    }
  }
}
