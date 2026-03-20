import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/worker/repositories/worker_repository.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_shift_card.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class WorkerShiftHistoryView extends ConsumerStatefulWidget {
  const WorkerShiftHistoryView({super.key});

  @override
  ConsumerState<WorkerShiftHistoryView> createState() =>
      _WorkerShiftHistoryViewState();
}

class _WorkerShiftHistoryViewState
    extends ConsumerState<WorkerShiftHistoryView> {
  AsyncValue<List<ShiftModel>> _historyState = const AsyncValue.loading();
  int? _selectedDays;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      _historyState = const AsyncValue.loading();
    });

    try {
      final repo = ref.read(workerRepositoryProvider);
      final data = await repo.getShiftHistory(days: _selectedDays, limit: 300);
      if (!mounted) return;
      setState(() {
        _historyState = AsyncValue.data(data);
      });
    } catch (error, stack) {
      if (!mounted) return;
      setState(() {
        _historyState = AsyncValue.error(error, stack);
      });
    }
  }

  void _setFilter(int? days) {
    if (_selectedDays == days) return;
    setState(() {
      _selectedDays = days;
    });
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text('SHIFT HISTORY', style: BauhausTheme.headerStyle),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
        actions: [
          IconButton(
            onPressed: _loadHistory,
            icon: const Icon(Icons.refresh, color: BauhausTheme.black),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Last 7 days', 7),
                _buildFilterChip('Last 30 days', 30),
                _buildFilterChip('Last 90 days', 90),
                _buildFilterChip('All', null),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _historyState.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: BauhausTheme.blue),
              ),
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Failed to load history: $error',
                        style: BauhausTheme.bodyStyle
                            .copyWith(color: BauhausTheme.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: _loadHistory,
                        child: const Text('Retry'),
                      )
                    ],
                  ),
                ),
              ),
              data: (history) {
                if (history.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BauhausTheme.blockDecoration,
                        child: Text(
                          l10n.noHistorySubtitle,
                          style: BauhausTheme.bodyStyle
                              .copyWith(color: BauhausTheme.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: history.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) =>
                      WorkerShiftCard(shift: history[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int? days) {
    final isSelected = _selectedDays == days;
    return ChoiceChip(
      label: Text(
        label,
        style: BauhausTheme.bodyStyle.copyWith(
          color: isSelected ? BauhausTheme.white : BauhausTheme.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => _setFilter(days),
      selectedColor: BauhausTheme.black,
      backgroundColor: BauhausTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: BauhausTheme.black, width: 1.5),
      ),
    );
  }
}
