import 'package:carenest/app/features/notifications/providers/notification_provider.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/viewmodels/admin_requests_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for new notifications
    ref.listen(notificationProvider, (previous, next) {
      final NotificationState currentState = next as NotificationState;
      final NotificationState? previousState = previous as NotificationState?;

      if (previousState != null &&
          currentState.notifications.length >
              previousState.notifications.length) {
        if (currentState.notifications.isNotEmpty) {
          final latest = currentState.notifications.first;
          if (latest.data != null &&
              latest.data!['type'] == 'request_created') {
            try {
              ref.read(adminRequestsViewModelProvider.notifier).fetchRequests();
            } catch (e) {
              debugPrint('Error fetching requests in listener: $e');
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('New Request: ${latest.title}'),
                backgroundColor: BauhausDesign.primary,
                action: SnackBarAction(
                  label: 'View',
                  textColor: BauhausDesign.surfaceWhite,
                  onPressed: () {
                    _tabController.animateTo(0);
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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BauhausIconButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.of(context).pop(),
            isSmall: true,
            variant: BauhausActionVariant.neutral,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.requestsDashboardTitle,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: BauhausIconButton(
              icon: Icons.refresh,
              onPressed: () {
                try {
                  ref
                      .read(adminRequestsViewModelProvider.notifier)
                      .fetchRequests();
                } catch (e) {
                  debugPrint('Error refreshing requests: $e');
                }
              },
              isSmall: true,
              variant: BauhausActionVariant.neutral,
            ),
          ),
        ],
        backgroundColor: BauhausDesign.primary,
        foregroundColor: BauhausDesign.surfaceWhite,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space4,
                vertical: BauhausDesign.space2),
            child: Container(
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 2.0),
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: BauhausDesign.textDark,
                unselectedLabelColor: BauhausDesign.neutral,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: BauhausDesign.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                indicatorPadding: const EdgeInsets.all(4),
                labelStyle:
                    BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                unselectedLabelStyle:
                    BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.pendingTab),
                  Tab(text: AppLocalizations.of(context)!.approvedTab),
                  Tab(text: AppLocalizations.of(context)!.declinedTab),
                ],
              ),
            ),
          ),
        ),
      ),
      body: requestsState.when(
        data: (requests) {
          final pending = requests
              .where((r) =>
                  r.status == RequestStatus.pending ||
                  r.status == RequestStatus.claimed)
              .toList();
          final approved = requests
              .where((r) => r.status == RequestStatus.approved)
              .toList();
          final declined = requests
              .where((r) => r.status == RequestStatus.declined)
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
        loading: () => const Center(
            child: CircularProgressIndicator(color: BauhausDesign.primary)),
        error: (e, st) => Center(
            child: Text('Error: $e',
                style: BauhausDesign.getTextTheme(context)
                    .bodyMedium
                    ?.copyWith(color: BauhausDesign.error))),
      ),
    );
  }

  Widget _buildRequestList(List<RequestModel> requests, bool showActions) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BauhausEmptyState(
              title: "No requests found",
              icon: Icons.inbox_outlined,
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: requests.length,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemBuilder: (context, index) {
        final request = requests[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          child: BauhausCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.neutral.withOpacity(0.05),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(BauhausDesign.radiusMd - 1),
                      topRight: Radius.circular(BauhausDesign.radiusMd - 1),
                    ),
                    border: const Border(
                      bottom: BorderSide(
                        color: BauhausDesign.neutral,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BauhausChip(
                        label: request.type.toUpperCase(),
                        isSmall: true,
                        variant: BauhausChipVariant.primary,
                      ),
                      Text(
                        request.createdAt != null
                            ? DateFormat('MMM d, y').format(request.createdAt!)
                            : '',
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person,
                              size: 16, color: BauhausDesign.textMuted),
                          const SizedBox(width: BauhausDesign.space2),
                          Text(
                            '${AppLocalizations.of(context)!.userLabelCaps} ${request.createdBy ?? request.userId}',
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      _buildDetails(request),
                      if (request.note != null && request.note!.isNotEmpty)
                        Padding(
                          padding:
                              const EdgeInsets.only(top: BauhausDesign.space3),
                          child: Container(
                            padding: const EdgeInsets.all(BauhausDesign.space2),
                            decoration: BoxDecoration(
                              color: BauhausDesign.neutral.withOpacity(0.05),
                              borderRadius:
                                  BorderRadius.circular(BauhausDesign.radiusSm),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.note_outlined,
                                    size: 14, color: BauhausDesign.textMuted),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    request.note!,
                                    style: BauhausDesign.getTextTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                          color: BauhausDesign.textMuted,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (showActions) ...[
                        const SizedBox(height: BauhausDesign.space4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BauhausActionButton(
                              text: AppLocalizations.of(context)!.declineButton,
                              onPressed: () =>
                                  _handleAction(request, 'Declined'),
                              variant: BauhausActionVariant.danger,
                              isSmall: true,
                              isOutlined: true,
                            ),
                            const SizedBox(width: BauhausDesign.space3),
                            if (request.type == 'SHIFT_SWAP_OFFER' &&
                                (request.details['claimantEmail'] == null ||
                                    request.details['claimantEmail']
                                        .toString()
                                        .isEmpty))
                              BauhausChip(
                                label: "WAITING FOR CLAIM",
                                variant: BauhausChipVariant.neutral,
                                isSmall: true,
                              )
                            else
                              BauhausActionButton(
                                text:
                                    AppLocalizations.of(context)!.approveButton,
                                onPressed: () =>
                                    _handleAction(request, 'Approved'),
                                variant: BauhausActionVariant.success,
                                isSmall: true,
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetails(RequestModel request) {
    if (request.type == 'Time Off') {
      final startsStr =
          request.details['starts'] ?? request.details['startDate'];
      final endsStr = request.details['ends'] ?? request.details['endDate'];
      final type = request.details['timeOffType'];

      String from = startsStr ?? '';
      String to = endsStr ?? '';

      try {
        if (startsStr != null) {
          from = DateFormat('MMM d, y').format(DateTime.parse(startsStr));
        }
        if (endsStr != null) {
          to = DateFormat('MMM d, y').format(DateTime.parse(endsStr));
        }
      } catch (e) {
        // Keep original
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(AppLocalizations.of(context)!.fromLabelCaps, from),
          const SizedBox(height: 4),
          _buildDetailRow(AppLocalizations.of(context)!.toLabelCaps, to),
          if (type != null) ...[
            const SizedBox(height: 4),
            _buildDetailRow(AppLocalizations.of(context)!.typeLabelCaps, type),
          ],
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
            endTime = request.details['endTime'];
          }

          timeRange = '$startTime - $endTime';
        } catch (e) {
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
            _buildDetailRow(AppLocalizations.of(context)!.jobLabelCaps, job),
          if (date.isNotEmpty) ...[
            const SizedBox(height: 4),
            _buildDetailRow(AppLocalizations.of(context)!.dateLabelCaps, date),
          ],
          if (timeRange.isNotEmpty) ...[
            const SizedBox(height: 4),
            _buildDetailRow(
                AppLocalizations.of(context)!.timeLabelCaps, timeRange),
          ],
        ],
      );
    } else if (request.type == 'SHIFT_SWAP_OFFER') {
      final dateStr = request.details['date'];
      final start = request.details['startTime'];
      final end = request.details['endTime'];
      final client = request.details['clientName'];
      final claimantName = request.details['claimantName'];
      final claimantEmail = request.details['claimantEmail'];

      String formattedDate = '';
      if (dateStr != null) {
        try {
          formattedDate =
              DateFormat('MMM d, y').format(DateTime.parse(dateStr));
        } catch (e) {
          formattedDate = dateStr;
        }
      }

      String displayClaimant = claimantName ?? claimantEmail ?? 'Unknown';
      if (claimantName != null &&
          claimantName.toLowerCase() == 'you' &&
          claimantEmail != null) {
        displayClaimant = claimantEmail;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (client != null) _buildDetailRow("CLIENT", client),
          if (formattedDate.isNotEmpty) ...[
            const SizedBox(height: 4),
            _buildDetailRow(
                AppLocalizations.of(context)!.dateLabelCaps, formattedDate),
          ],
          if (start != null && end != null) ...[
            const SizedBox(height: 4),
            _buildDetailRow(
                AppLocalizations.of(context)!.timeLabelCaps, '$start - $end'),
          ],
          if (claimantName != null || claimantEmail != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_pin,
                    size: 16, color: BauhausDesign.accent),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CLAIMED BY",
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                                color: BauhausDesign.textMuted,
                                fontWeight: FontWeight.bold),
                      ),
                      Text(
                        displayClaimant,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.textDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]
        ],
      );
    }
    return Text(
      request.details.toString(),
      style: BauhausDesign.getTextTheme(context).bodyMedium,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            value,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAction(RequestModel request, String status) async {
    if (status == 'Declined') {
      final reasonController = TextEditingController();
      final confirm = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => Dialog(
          backgroundColor: Colors.transparent,
          child: BauhausCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Decline Request",
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          color: BauhausDesign.error,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                BauhausTextField(
                  controller: reasonController,
                  label: "Reason",
                  hintText: "Enter reason for cancellation",
                  maxLines: 3,
                ),
                const SizedBox(height: BauhausDesign.space4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BauhausActionButton(
                      text: "Cancel",
                      variant: BauhausActionVariant.neutral,
                      isOutlined: true,
                      onPressed: () => Navigator.pop(dialogContext, false),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    BauhausActionButton(
                      text: "Confirm",
                      variant: BauhausActionVariant.danger,
                      onPressed: () => Navigator.pop(dialogContext, true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      if (confirm != true) return;

      try {
        await ref
            .read(adminRequestsViewModelProvider.notifier)
            .updateRequestStatus(request.id!, 'rejected',
                reason: reasonController.text);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Request declined'),
              backgroundColor: BauhausDesign.error,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    } else {
      try {
        await ref
            .read(adminRequestsViewModelProvider.notifier)
            .updateRequestStatus(request.id!, 'approved');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Request approved'),
              backgroundColor: BauhausDesign.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }
}
