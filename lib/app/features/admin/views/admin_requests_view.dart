import 'package:carenest/app/features/admin/viewmodels/admin_requests_viewmodel.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
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
      appBar: AppBarWidget(
        title: 'Approvals Dashboard',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausDesign.primary),
            onPressed: () => ref.refresh(adminRequestsViewModelProvider),
          ),
        ],
      ),
      body: requestsState.when(
        data: (requests) {
          if (requests.isEmpty) {
            return const BauhausEmptyState(
              title: 'No Pending Requests',
              message: 'All caught up! No requests require your attention.',
              icon: Icons.check_circle_outline,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            itemCount: requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space3),
            itemBuilder: (context, index) {
              return _RequestCard(request: requests[index]);
            },
          );
        },
        loading: () => const BauhausLoadingState(message: 'Loading requests...'),
        error: (e, _) => BauhausErrorState(
          description: e.toString(),
          onRetry: () => ref.refresh(adminRequestsViewModelProvider),
        ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request ${status.name} successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update request')),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final isPending = widget.request.status == RequestStatus.pending;

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BauhausChip(
                label: widget.request.type.toUpperCase(),
                variant: BauhausChipVariant.primary,
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
            style: BauhausDesign.getTextTheme(context).titleSmall,
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
                      Text('${e.key}: ',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(e.value.toString())),
                    ],
                  ),
                )),
          if (widget.request.note != null && widget.request.note!.isNotEmpty) ...[
             const SizedBox(height: BauhausDesign.space2),
             Text('Note: ${widget.request.note}', style: const TextStyle(fontStyle: FontStyle.italic)),
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
                    onPressed: () => _handleAction(RequestStatus.approved),
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
