import 'package:carenest/app/features/admin/viewmodels/admin_requests_viewmodel.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdminRequestsView extends ConsumerWidget {
  const AdminRequestsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsState = ref.watch(adminRequestsViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(
        context,
        onRefresh: () => ref.refresh(adminRequestsViewModelProvider),
      ),
      body: requestsState.when(
        data: (loadedRequests) {
          final pendingCount = loadedRequests
              .where((r) => r.status == RequestStatus.pending)
              .length;
          if (loadedRequests.isEmpty) {
            return Column(
              children: [
                _buildStatusStrip(context, pendingCount),
                const SizedBox(height: BauhausDesign.space4),
                const Expanded(
                  child: BauhausEmptyState(
                    title: 'No Pending Requests',
                    message:
                        'All caught up! No requests require your attention.',
                    icon: Icons.check_circle_outline,
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              _buildStatusStrip(context, pendingCount),
              const SizedBox(height: BauhausDesign.space3),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: loadedRequests.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    return _RequestCard(request: loadedRequests[index]);
                  },
                ),
              ),
            ],
          );
        },
        loading: () =>
            const BauhausLoadingState(message: 'Loading requests...'),
        error: (e, _) => BauhausErrorState(
          description: e.toString(),
          onRetry: () => ref.refresh(adminRequestsViewModelProvider),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context, {
    required VoidCallback onRefresh,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border(
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: BauhausDesign.textDark),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    'Approvals Dashboard',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BauhausDesign.getTextTheme(context)
                        .displaySmall
                        ?.copyWith(color: BauhausDesign.textDark),
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.refresh, color: BauhausDesign.textDark),
                  onPressed: onRefresh,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusStrip(BuildContext context, int pendingCount) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        BauhausDesign.space4,
        BauhausDesign.space4,
        BauhausDesign.space4,
        0,
      ),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          const Icon(Icons.fact_check, color: BauhausDesign.secondary),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              'Pending approvals',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          BauhausChip(
            label: '$pendingCount',
            variant: pendingCount > 0
                ? BauhausChipVariant.warning
                : BauhausChipVariant.success,
            size: BauhausChipSize.small,
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends ConsumerStatefulWidget {
  final RequestModel request;

  const _RequestCard({required this.request});

  @override
  ConsumerState<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends ConsumerState<_RequestCard> {
  bool _isProcessing = false;

  Future<void> _handleAction(RequestStatus status) async {
    setState(() => _isProcessing = true);
    try {
      final success = await ref
          .read(adminRequestsViewModelProvider.notifier)
          .updateStatus(widget.request.id!, status);

      if (mounted) {
        if (success) {
          _showFeedback('Request ${status.name} successfully', isError: false);
        } else {
          _showFeedback('Failed to update request');
        }
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _confirmDeletionApproval() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            side: const BorderSide(color: BauhausDesign.neoDanger, width: 3),
          ),
          title: Text(
            'Confirm Account Deletion',
            style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                  color: BauhausDesign.neoDanger,
                ),
          ),
          content: Text(
            'Approving this request will immediately deactivate the user account and schedule it for permanent deletion in 90 days.\n\nAre you sure you want to proceed?',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            BauhausActionButton(
              text: 'Approve Deletion',
              variant: BauhausActionVariant.danger,
              onPressed: () {
                Navigator.of(context).pop();
                _handleAction(RequestStatus.approved);
              },
            ),
          ],
        );
      },
    );
  }

  void _showFeedback(String message, {bool isError = true}) {
    final borderColor = isError ? BauhausDesign.error : BauhausDesign.success;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: BauhausDesign.surfaceLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          side: BorderSide(color: borderColor, width: 2),
        ),
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final isPending = widget.request.status == RequestStatus.pending;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BauhausChip(
                label: widget.request.type.toUpperCase(),
                variant: widget.request.type == 'ACCOUNT_DELETION'
                    ? BauhausChipVariant.error
                    : BauhausChipVariant.primary,
                size: BauhausChipSize.small,
              ),
              BauhausChip(
                label: widget.request.status.name.toUpperCase(),
                variant: _getStatusVariant(widget.request.status),
                size: BauhausChipSize.small,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            'Request from ${widget.request.createdBy}',
            style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'Created: ${widget.request.createdAt != null ? dateFormat.format(widget.request.createdAt!) : "Unknown"}',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          if (widget.request.details.isNotEmpty)
            ...widget.request.details.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${e.key}: ',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          e.value.toString(),
                          style: BauhausDesign.getTextTheme(context)
                              .bodySmall
                              ?.copyWith(color: BauhausDesign.textDark),
                        ),
                      ),
                    ],
                  ),
                )),
          if (widget.request.note != null &&
              widget.request.note!.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Note: ${widget.request.note}',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
          if (isPending) ...[
            const SizedBox(height: BauhausDesign.space4),
            const Divider(),
            const SizedBox(height: BauhausDesign.space2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isProcessing)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else ...[
                  BauhausActionButton(
                    text: 'Reject',
                    variant: BauhausActionVariant.danger,
                    isSmall: true,
                    isOutlined: true,
                    onPressed: () => _handleAction(RequestStatus.rejected),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  BauhausActionButton(
                    text: 'Approve',
                    variant: BauhausActionVariant.success,
                    isSmall: true,
                    onPressed: widget.request.type == 'ACCOUNT_DELETION'
                        ? _confirmDeletionApproval
                        : () => _handleAction(RequestStatus.approved),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  BauhausChipVariant _getStatusVariant(RequestStatus status) {
    switch (status) {
      case RequestStatus.approved:
        return BauhausChipVariant.success;
      case RequestStatus.rejected:
        return BauhausChipVariant.error;
      case RequestStatus.pending:
        return BauhausChipVariant.warning;
      default:
        return BauhausChipVariant.neutral;
    }
  }
}
