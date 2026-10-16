import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/claiming/models/claim_import_result.dart';
import 'package:carenest/app/features/claiming/models/claim_models.dart';
import 'package:carenest/app/features/claiming/viewmodels/claim_viewmodel.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';

/// NDIS claiming dashboard (Phase 6): generate a Bulk Payment Request CSV for
/// NDIA-managed claims and import the returned results file.
class ClaimDashboardView extends ConsumerStatefulWidget {
  const ClaimDashboardView({super.key});

  @override
  ConsumerState<ClaimDashboardView> createState() => _ClaimDashboardViewState();
}

class _ClaimDashboardViewState extends ConsumerState<ClaimDashboardView> {
  DateTimeRange? _range;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(claimViewModelProvider.notifier).load();
    });
  }

  String _iso(DateTime d) => d.toIso8601String().split('T').first;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(claimViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NDIS Claiming'),
        actions: [
          IconButton(
            tooltip: 'Pick period & generate',
            icon: const Icon(Icons.playlist_add_check),
            onPressed: state.isLoading ? null : _pickRangeAndGenerate,
          ),
        ],
      ),
      body: state.isLoading && state.batches.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(claimViewModelProvider.notifier).load(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.error != null) _buildError(context, state.error!),
                  if (state.lastImport != null)
                    _buildImportResult(context, state.lastImport!),
                  if (state.validation != null &&
                      state.validation!.errors.isNotEmpty)
                    _buildValidation(context, state.validation!),
                  if (state.lastCsv != null && state.lastCsv!.isNotEmpty)
                    _buildCsvActions(context, state.lastCsv!),
                  Text('Batches', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (state.batches.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No claim batches yet.\nTap the checkmark to generate one.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ...state.batches.map(_buildBatchCard),
                ],
              ),
            ),
    );
  }

  /// Reconciliation outcome of the last results import. A `partial` or
  /// `failed` import is a real business outcome, not an error: it has to stay
  /// on screen with the accepted/rejected/unmatched counts, because a claim
  /// officer has to re-submit or chase the rejected lines.
  Widget _buildImportResult(BuildContext context, ClaimImportResult result) {
    final theme = Theme.of(context);
    final clean = result.isClean;
    return Card(
      color: clean
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              clean
                  ? 'Results imported'
                  : 'Results imported — attention needed',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(result.summaryLine),
            if (result.batchStatus.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text('Batch status: ${result.batchStatus}'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(message),
      ),
    );
  }

  Widget _buildValidation(BuildContext context, ClaimValidation validation) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pre-export validation failed',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ...validation.errors
                .take(20)
                .map((e) => Text('• ${e.field}: ${e.message}')),
            if (validation.warnings.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...validation.warnings.take(5).map((w) => Text('⚠ ${w.message}')),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCsvActions(BuildContext context, String csv) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.table_view_outlined),
        title: const Text('Generated CSV ready'),
        subtitle: Text('${csv.split('\n').length - 1} rows'),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              tooltip: 'Copy CSV',
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: csv));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('CSV copied to clipboard.')),
                  );
                }
              },
            ),
            IconButton(
              tooltip: 'View CSV',
              icon: const Icon(Icons.visibility_outlined),
              onPressed: () => _showCsv(csv),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchCard(ClaimBatch batch) {
    final theme = Theme.of(context);
    final period = batch.period;
    return Card(
      child: ListTile(
        leading: Icon(_statusIcon(batch.status), color: _statusColor(theme, batch.status)),
        title: Text('Batch ${batch.id.substring(0, batch.id.length.clamp(0, 8))}'),
        subtitle: Text(
          '${batch.status} · ${batch.totals.lines} lines · '
          '\$${batch.totals.amount.toStringAsFixed(2)}'
          '${period?.from != null ? '\n${period!.from!.substring(0, 10)} → ${period.to!.substring(0, 10)}' : ''}',
        ),
        isThreeLine: period?.from != null,
        onTap: () => _showBatchDetail(batch.id),
        trailing: IconButton(
          tooltip: 'Import results',
          icon: const Icon(Icons.upload_file),
          onPressed: () => _importResults(batch.id),
        ),
      ),
    );
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'reconciled':
        return Icons.verified_outlined;
      case 'partial':
        return Icons.rule_folder_outlined;
      case 'failed':
        return Icons.error_outline;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  Color _statusColor(ThemeData theme, String status) {
    switch (status) {
      case 'reconciled':
        return theme.colorScheme.primary;
      case 'partial':
        return theme.colorScheme.tertiary;
      case 'failed':
        return theme.colorScheme.error;
      default:
        return theme.colorScheme.onSurfaceVariant;
    }
  }

  Future<void> _pickRangeAndGenerate() async {
    final now = DateTime.now();
    final picked = await showBauhausDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      initialStart: _range?.start ?? DateTime(now.year, now.month, 1),
      initialEnd: _range?.end ?? now,
    );
    if (picked == null || !mounted) return;
    setState(() => _range = picked);

    final csv = await ref.read(claimViewModelProvider.notifier).generate(
          from: _iso(picked.start),
          to: _iso(picked.end),
        );
    if (csv != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Claim batch generated.')),
      );
    }
  }

  Future<void> _importResults(String batchId) async {
    final controller = TextEditingController();
    final content = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Import results file'),
        content: TextField(
          controller: controller,
          maxLines: 8,
          decoration: const InputDecoration(
            hintText: 'Paste the Bulk Payment Results File (CSV) contents',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            child: const Text('Import'),
          ),
        ],
      ),
    );

    if (content == null || content.isEmpty || !mounted) return;
    final result = await ref
        .read(claimViewModelProvider.notifier)
        .importResults(batchId, content);
    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.isClean
                ? 'Results imported. ${result.summaryLine}'
                : 'Results imported with issues — ${result.summaryLine}',
          ),
          backgroundColor: result.isClean
              ? null
              : Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _showBatchDetail(String batchId) async {
    await ref.read(claimViewModelProvider.notifier).openBatch(batchId);
    if (!mounted) return;
    final state = ref.read(claimViewModelProvider);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            Text('Claim lines (${state.activeLines.length})',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...state.activeLines.map((line) => ListTile(
                  dense: true,
                  leading: Icon(
                    line.status == 'rejected' ? Icons.close : Icons.check,
                    color: line.status == 'rejected'
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(line.supportNumber),
                  subtitle: Text(
                    '${line.claimReference}\n'
                    '${line.quantity} × \$${line.unitPrice.toStringAsFixed(2)} '
                    '= \$${line.requestedAmount.toStringAsFixed(2)}'
                    '${line.rejectionReason.isNotEmpty ? '\n${line.rejectionReason}' : ''}',
                  ),
                  isThreeLine: true,
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _showCsv(String csv) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Bulk Payment Request CSV'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SelectableText(csv, style: const TextStyle(fontSize: 11)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
