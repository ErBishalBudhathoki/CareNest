import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';
import 'package:carenest/app/features/client_portal/viewmodels/client_portal_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientServiceHistoryView extends ConsumerStatefulWidget {
  final String clientId;

  const ClientServiceHistoryView({super.key, required this.clientId});

  @override
  ConsumerState<ClientServiceHistoryView> createState() =>
      _ClientServiceHistoryViewState();
}

class _ClientServiceHistoryViewState
    extends ConsumerState<ClientServiceHistoryView> {
  String _filter = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final int _pageSize = 20;
  int _limit = 20;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(clientPortalViewModelProvider.notifier)
          .loadServiceHistory(widget.clientId, limit: _limit);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientPortalViewModelProvider);
    final history = _applySearch(_applyFilter(state.serviceHistory));
    final canLoadMore = state.serviceHistory.length >= _limit;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Text(
          'Service History',
          style: GoogleFonts.oswald(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1.1,
          ),
        ),
        foregroundColor: BauhausDesign.textDark,
        actions: [
          IconButton(
            onPressed: () => ref
                .read(clientPortalViewModelProvider.notifier)
                .loadServiceHistory(widget.clientId, limit: _limit),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: BauhausLoadingState())
          : state.error != null && state.serviceHistory.isEmpty
          ? Center(
              child: BauhausErrorState(
                title: 'Unable to Load History',
                message: state.error!,
                onRetry: () => ref
                    .read(clientPortalViewModelProvider.notifier)
                    .loadServiceHistory(widget.clientId),
              ),
            )
          : Column(
              children: [
                _buildFilterBar(context),
                _buildSummaryRow(context, state.serviceHistory.length),
                Expanded(
                  child: history.isEmpty
                      ? const BauhausEmptyState(
                          title: 'No Services Found',
                          message: 'Completed services will appear here.',
                        )
                      : RefreshIndicator(
                          color: BauhausDesign.primary,
                          backgroundColor: BauhausDesign.surfaceWhite,
                          onRefresh: () async {
                            await ref
                                .read(clientPortalViewModelProvider.notifier)
                                .loadServiceHistory(
                                  widget.clientId,
                                  limit: _limit,
                                );
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.all(BauhausDesign.space4),
                            itemCount: history.length + 1,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: BauhausDesign.space3),
                            itemBuilder: (context, index) {
                              if (index == history.length) {
                                return _buildLoadMoreFooter(
                                  context,
                                  canLoadMore: canLoadMore,
                                );
                              }

                              return _ServiceHistoryCard(
                                service: history[index],
                                clientId: widget.clientId,
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
      ),
      child: Column(
        children: [
          BauhausSearchBar(
            controller: _searchController,
            hintText: 'Search services, workers, or notes...',
            onChanged: (value) {
              setState(() => _searchQuery = value);
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
          const SizedBox(height: BauhausDesign.space3),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'All', 'all'),
                const SizedBox(width: BauhausDesign.space2),
                _buildFilterChip(context, 'With Feedback', 'with_feedback'),
                const SizedBox(width: BauhausDesign.space2),
                _buildFilterChip(context, 'Needs Feedback', 'needs_feedback'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, String value) {
    final isSelected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3,
          vertical: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? BauhausDesign.primary
              : BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          border: Border.all(
            color: isSelected ? BauhausDesign.primary : BauhausDesign.neutral,
            width: 1.5,
          ),
          boxShadow: isSelected ? const [BauhausDesign.shadowHardXs] : [],
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? BauhausDesign.surfaceWhite
                : BauhausDesign.textDark,
          ),
        ),
      ),
    );
  }

  List<ServiceHistory> _applyFilter(List<ServiceHistory> history) {
    if (_filter == 'with_feedback') {
      return history
          .where(
            (item) =>
                item.rating > 0 || (item.feedback ?? '').trim().isNotEmpty,
          )
          .toList();
    }

    if (_filter == 'needs_feedback') {
      return history
          .where(
            (item) => item.rating == 0 && (item.feedback ?? '').trim().isEmpty,
          )
          .toList();
    }

    return history;
  }

  List<ServiceHistory> _applySearch(List<ServiceHistory> history) {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return history;

    return history.where((item) {
      final serviceName = item.serviceName.toLowerCase();
      final workerName = item.workerName.toLowerCase();
      final date = item.date.toLowerCase();
      final feedback = (item.feedback ?? '').toLowerCase();

      return serviceName.contains(query) ||
          workerName.contains(query) ||
          date.contains(query) ||
          feedback.contains(query);
    }).toList();
  }

  Widget _buildSummaryRow(BuildContext context, int totalLoaded) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space2,
      ),
      child: Row(
        children: [
          Text(
            'Loaded: $totalLoaded services',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreFooter(
    BuildContext context, {
    required bool canLoadMore,
  }) {
    if (!canLoadMore) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: BauhausActionButton(
        onPressed: _isLoadingMore
            ? null
            : () async {
                setState(() {
                  _isLoadingMore = true;
                  _limit += _pageSize;
                });

                await ref
                    .read(clientPortalViewModelProvider.notifier)
                    .loadServiceHistory(
                      widget.clientId,
                      limit: _limit,
                      silent: true,
                    );

                if (!mounted) return;
                setState(() => _isLoadingMore = false);
              },
        text: _isLoadingMore ? 'LOADING...' : 'LOAD MORE',
        icon: Icons.add,
        variant: BauhausActionVariant.secondary,
        isFullWidth: true,
      ),
    );
  }
}

class _ServiceHistoryCard extends ConsumerWidget {
  final ServiceHistory service;
  final String clientId;

  const _ServiceHistoryCard({required this.service, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = service.rating;
    final hasFeedback =
        rating > 0 || (service.feedback ?? '').trim().isNotEmpty;
    final buttonLabel = hasFeedback ? 'UPDATE FEEDBACK' : 'SUBMIT FEEDBACK';

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.serviceName,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            '${service.date} • ${service.startTime} - ${service.endTime}',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'Worker: ${service.workerName}',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: BauhausDesign.space2),
          if (rating > 0)
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  size: 16,
                  color: BauhausDesign.accent,
                ),
              ),
            ),
          if ((service.feedback ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space2),
            Text(
              service.feedback!,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
          ],
          const SizedBox(height: BauhausDesign.space3),
          BauhausActionButton(
            onPressed: () => _showServiceHistoryFeedbackDialog(
              context,
              ref,
              service,
              clientId,
            ),
            text: buttonLabel,
            icon: Icons.rate_review,
            variant: BauhausActionVariant.primary,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  void _showServiceHistoryFeedbackDialog(
    BuildContext context,
    WidgetRef ref,
    ServiceHistory service,
    String clientId,
  ) {
    Navigator.pushNamed(
      context,
      Routes.serviceConfirmation,
      arguments: {
        'appointmentId': service.serviceId,
        'clientId': clientId,
        'workerId': 'worker_123',
        'workerName': service.workerName,
        'serviceName': service.serviceName,
      },
    );
  }
}
