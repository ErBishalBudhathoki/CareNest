import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';

import '../repositories/sil_repository.dart';

/// Milestone 2.1: bottom sheet for SIL resident absences (hospital, family
/// leave, holidays). Lists the absences of one occupancy and lets a SIL
/// admin record a new absence or end an ongoing one — the input the SIL
/// billing engine needs to pause claims after 28 days of leave.
class SilAbsenceSheet extends ConsumerStatefulWidget {
  const SilAbsenceSheet({
    super.key,
    required this.occupancyId,
    required this.residentLabel,
  });

  final String occupancyId;
  final String residentLabel;

  @override
  ConsumerState<SilAbsenceSheet> createState() => _SilAbsenceSheetState();
}

class _AbsenceRow {
  const _AbsenceRow(this.raw);

  final Map<String, dynamic> raw;

  String get id => (raw['_id'] ?? raw['id'] ?? '').toString();
  DateTime? get startDate => DateTime.tryParse(raw['startDate']?.toString() ?? '');
  DateTime? get endDate => DateTime.tryParse(raw['endDate']?.toString() ?? '');
  String get reason => (raw['reason'] ?? 'hospital').toString();
  String? get notes => raw['notes']?.toString();
  int get maxClaimableDays => (raw['maxClaimableDays'] as num?)?.toInt() ?? 28;
  int get claimedDays => (raw['claimedDays'] as num?)?.toInt() ?? 0;
  bool get isOngoing => endDate == null;
}

class _SilAbsenceSheetState extends ConsumerState<SilAbsenceSheet> {
  List<_AbsenceRow> _rows = const [];
  bool _loading = true;
  String? _error;

  SILRepository get _repo => ref.read(silRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final rows = (await _repo.listSilAbsences(occupancyId: widget.occupancyId))
          .map(_AbsenceRow.new)
          .toList();
      if (!mounted) return;
      setState(() {
        _rows = rows;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  String _reasonLabel(AppLocalizations l10n, String reason) => switch (reason) {
        'hospital' => l10n.silAbsenceReasonHospital,
        'family_leave' => l10n.silAbsenceReasonFamilyLeave,
        'holiday' => l10n.silAbsenceReasonHoliday,
        'transition' => l10n.silAbsenceReasonTransition,
        _ => l10n.other,
      };

  IconData _reasonIcon(String reason) => switch (reason) {
        'hospital' => Icons.local_hospital_outlined,
        'family_leave' => Icons.family_restroom_outlined,
        'holiday' => Icons.beach_access_outlined,
        'transition' => Icons.home_work_outlined,
        _ => Icons.event_note_outlined,
      };

  String _fmtDate(DateTime? date) =>
      date == null ? '—' : DateFormat('d MMM yyyy').format(date.toLocal());

  Future<void> _recordAbsence() async {
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const _RecordAbsenceDialog(),
    );
    if (result == null || !mounted) return;

    try {
      await _repo.recordSilAbsence(
        widget.occupancyId,
        startDate: result['startDate'] as DateTime,
        endDate: result['endDate'] as DateTime?,
        reason: result['reason'] as String?,
        notes: result['notes'] as String?,
        maxClaimableDays: result['maxClaimableDays'] as int?,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.silAbsenceRecorded)),
      );
      await _load();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.silAbsenceSaveFailed(e.toString()))),
      );
    }
  }

  Future<void> _endAbsence(_AbsenceRow row) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.silAbsenceEndConfirmTitle),
        content: Text(l10n.silAbsenceEndConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.silAbsenceEndAction),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;

    try {
      await _repo.endSilAbsence(
        widget.occupancyId,
        row.id,
        endDate: DateTime.now(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.silAbsenceEnded)),
      );
      await _load();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.silAbsenceSaveFailed(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${l10n.silAbsencesTitle} — ${widget.residentLabel}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.close,
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildBody(context, l10n, scrollController),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FilledButton.icon(
                    onPressed: _recordAbsence,
                    icon: const Icon(Icons.add),
                    label: Text(l10n.silAbsenceRecordAction),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    ScrollController scrollController,
  ) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.silAbsenceLoadFailed(_error!)),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _load, child: Text(l10n.retry)),
          ],
        ),
      );
    }
    if (_rows.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_hospital_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(l10n.silAbsenceEmpty),
          ],
        ),
      );
    }
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _rows.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _buildRow(context, l10n, _rows[index]),
    );
  }

  Widget _buildRow(BuildContext context, AppLocalizations l10n, _AbsenceRow row) {
    final theme = Theme.of(context);
    final range = row.isOngoing
        ? '${_fmtDate(row.startDate)} → ${l10n.silAbsenceOngoing}'
        : '${_fmtDate(row.startDate)} → ${_fmtDate(row.endDate)}';
    return Card(
      child: ListTile(
        leading: Icon(_reasonIcon(row.reason)),
        title: Text(
          _reasonLabel(l10n, row.reason),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(range),
            Text(
              l10n.silAbsenceClaimedDays(
                row.claimedDays,
                row.maxClaimableDays,
              ),
              style: theme.textTheme.bodySmall,
            ),
            if ((row.notes ?? '').isNotEmpty)
              Text(
                row.notes!,
                style: theme.textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: row.isOngoing
            ? TextButton(
                onPressed: () => _endAbsence(row),
                child: Text(l10n.silAbsenceEndAction),
              )
            : null,
      ),
    );
  }
}

class _RecordAbsenceDialog extends StatefulWidget {
  const _RecordAbsenceDialog();

  @override
  State<_RecordAbsenceDialog> createState() => _RecordAbsenceDialogState();
}

class _RecordAbsenceDialogState extends State<_RecordAbsenceDialog> {
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  bool _stillAway = true;
  String _reason = 'hospital';
  final _notesController = TextEditingController();
  final _maxDaysController = TextEditingController(text: '28');
  String? _error;

  @override
  void dispose() {
    _notesController.dispose();
    _maxDaysController.dispose();
    super.dispose();
  }

  String _format(DateTime date) => DateFormat('d MMM yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.silAbsenceRecordAction),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.silAbsenceStartDate),
              subtitle: Text(_format(_startDate)),
              trailing: const Icon(Icons.date_range_outlined),
              onTap: () async {
                final picked = await showBauhausDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(DateTime.now().year - 3),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) setState(() => _startDate = picked);
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.silAbsenceStillAway),
              value: _stillAway,
              onChanged: (value) => setState(() {
                _stillAway = value;
                if (value) _endDate = null;
              }),
            ),
            if (!_stillAway) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.silAbsenceEndDate),
                subtitle: Text(_endDate == null ? '—' : _format(_endDate!)),
                trailing: const Icon(Icons.event_outlined),
                onTap: () async {
                  final picked = await showBauhausDatePicker(
                    context: context,
                    initialDate: _endDate ?? _startDate,
                    firstDate: _startDate,
                    lastDate: DateTime(DateTime.now().year + 3),
                  );
                  if (picked != null) setState(() => _endDate = picked);
                },
              ),
            ],
            DropdownButtonFormField<String>(
              value: _reason,
              decoration: InputDecoration(
                labelText: l10n.silAbsenceReason,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              items: [
                DropdownMenuItem(value: 'hospital', child: Text(l10n.silAbsenceReasonHospital)),
                DropdownMenuItem(value: 'family_leave', child: Text(l10n.silAbsenceReasonFamilyLeave)),
                DropdownMenuItem(value: 'holiday', child: Text(l10n.silAbsenceReasonHoliday)),
                DropdownMenuItem(value: 'transition', child: Text(l10n.silAbsenceReasonTransition)),
                DropdownMenuItem(value: 'other', child: Text(l10n.other)),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _reason = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: l10n.notes,
                hintText: l10n.silAbsenceNotesHint,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              maxLines: 2,
              maxLength: 500,
            ),
            TextField(
              controller: _maxDaysController,
              decoration: InputDecoration(
                labelText: l10n.silAbsenceMaxClaimableDays,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              keyboardType: TextInputType.number,
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l10n.save),
        ),
      ],
    );
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final maxDays = int.tryParse(_maxDaysController.text.trim());
    if (maxDays == null || maxDays < 1 || maxDays > 365) {
      setState(() => _error = '${l10n.silAbsenceMaxClaimableDays}: 1–365');
      return;
    }
    final endDate = _stillAway ? null : _endDate;
    if (endDate != null && endDate.isBefore(_startDate)) {
      setState(() => _error = l10n.silAbsenceEndDate);
      return;
    }
    Navigator.of(context).pop({
      'startDate': _startDate,
      'endDate': endDate,
      'reason': _reason,
      'notes': _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      'maxClaimableDays': maxDays,
    });
  }
}
