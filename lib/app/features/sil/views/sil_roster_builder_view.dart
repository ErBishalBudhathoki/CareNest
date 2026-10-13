import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';

/// Weekly SIL roster builder (Phase 4). Builds a roster from shifts and shows
/// ratio compliance; supports publishing.
class SILRosterBuilderView extends ConsumerStatefulWidget {
  const SILRosterBuilderView({
    super.key,
    required this.propertyId,
    required this.propertyName,
  });

  final String propertyId;
  final String propertyName;

  @override
  ConsumerState<SILRosterBuilderView> createState() =>
      _SILRosterBuilderViewState();
}

class _SILRosterBuilderViewState extends ConsumerState<SILRosterBuilderView> {
  SILRoster? _roster;
  DateTime _weekStarting = _mondayOf(DateTime.now());
  bool _loading = false;
  String? _error;

  static DateTime _mondayOf(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return d.subtract(Duration(days: (d.weekday + 6) % 7));
  }

  SILRepository get _repo => ref.read(silRepositoryProvider);

  String get _weekIso =>
      _weekStarting.toIso8601String().split('T').first;

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final roster = await _repo.getRoster(
        propertyId: widget.propertyId,
        weekStarting: _weekIso,
      );
      if (mounted) setState(() => _roster = roster);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _build() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final roster = await _repo.buildRoster(
        propertyId: widget.propertyId,
        weekStarting: _weekIso,
      );
      if (mounted) setState(() => _roster = roster);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _publish() async {
    final roster = _roster;
    if (roster == null) return;
    try {
      final published = await _repo.publishRoster(roster.id);
      if (mounted) setState(() => _roster = published);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final roster = _roster;
    return Scaffold(
      appBar: AppBar(
        title: Text('Roster · ${widget.propertyName}'),
        actions: [
          if (roster != null && roster.status == 'draft')
            TextButton(
              onPressed: _publish,
              child: const Text('Publish'),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Week of $_weekIso'
                    '${roster != null ? ' · ${roster.status}' : ''}',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() =>
                        _weekStarting = _weekStarting.subtract(const Duration(days: 7)));
                    _load();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() =>
                        _weekStarting = _weekStarting.add(const Duration(days: 7)));
                    _load();
                  },
                ),
                IconButton(
                  tooltip: 'Build from shifts',
                  icon: const Icon(Icons.autorenew),
                  onPressed: _build,
                ),
              ],
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : roster == null || roster.entries.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No roster for this week.\nTap the refresh icon to build from shifts.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      if (roster.ratioWarnings.isNotEmpty)
                        Card(
                          color: Theme.of(context).colorScheme.errorContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Ratio warnings',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                ...roster.ratioWarnings
                                    .map((w) => Text('• ${w.message}')),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      ...roster.entries.map(_buildEntry),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntry(SILRosterEntry entry) {
    final theme = Theme.of(context);
    final color = entry.compliance == 'ok'
        ? theme.colorScheme.primary
        : entry.compliance == 'understaffed'
        ? theme.colorScheme.error
        : theme.colorScheme.tertiary;

    return Card(
      child: ListTile(
        leading: Icon(Icons.event, color: color),
        title: Text(entry.shiftType),
        subtitle: Text(
          '${entry.startTime != null ? entry.startTime!.substring(11, 16) : ''}'
          '${entry.endTime != null ? '–${entry.endTime!.substring(11, 16)}' : ''}'
          ' · staff ${entry.assignedStaff}/${entry.requiredStaff}',
        ),
        trailing: Chip(
          label: Text(entry.compliance),
          backgroundColor: color.withValues(alpha: 0.12),
          side: BorderSide(color: color),
        ),
      ),
    );
  }
}
