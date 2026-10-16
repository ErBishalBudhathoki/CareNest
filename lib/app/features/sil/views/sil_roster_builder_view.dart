import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';

/// Weekly SIL roster builder (Phase 4). Builds a roster from shifts and shows
/// ratio compliance; supports publishing and inline staff assignment.
class SILRosterBuilderView extends ConsumerStatefulWidget {
  const SILRosterBuilderView({
    super.key,
    required this.propertyId,
    required this.propertyName,
    this.weekStarting,
    this.autoBuild = false,
  });

  final String propertyId;
  final String propertyName;
  final DateTime? weekStarting;

  /// When true the roster is rebuilt from shifts on open, so the caller can
  /// land straight on the assign list after planning a week.
  final bool autoBuild;

  @override
  ConsumerState<SILRosterBuilderView> createState() =>
      _SILRosterBuilderViewState();
}

class _SILRosterBuilderViewState extends ConsumerState<SILRosterBuilderView> {
  SILRoster? _roster;
  late DateTime _weekStarting;
  bool _loading = false;
  String? _error;
  List<Map<String, dynamic>> _employees = const [];

  static DateTime _mondayOf(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return d.subtract(Duration(days: (d.weekday + 6) % 7));
  }

  SILRepository get _repo => ref.read(silRepositoryProvider);

  String get _weekIso => _weekStarting.toIso8601String().split('T').first;

  /// Format an ISO-8601 instant (stored in UTC) as a local `HH:MM` clock.
  ///
  /// Slicing the raw ISO string showed the UTC clock, so a 09:00 AEDT shift
  /// read as "22:00".
  static String _localHm(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    final local = parsed.toLocal();
    final h = local.hour.toString().padLeft(2, '0');
    final m = local.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void initState() {
    super.initState();
    _weekStarting = _mondayOf(widget.weekStarting ?? DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // When arriving straight from "Plan week & assign staff" the shifts were
      // just materialised, so build the roster immediately instead of showing
      // an empty "No roster for this week" state.
      if (widget.autoBuild) {
        _build();
      } else {
        _load();
      }
      _loadEmployees();
    });
  }

  Future<void> _loadEmployees() async {
    final orgId = ref.read(app_providers.organizationIdProvider);
    if (orgId == null || orgId.isEmpty) return;
    try {
      final api = ref.read(app_providers.apiMethodProvider);
      final response = await api.getOrganizationEmployees(orgId);
      final list = (response['employees'] as List?) ?? const [];
      if (!mounted) return;
      setState(() {
        _employees = list
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .where((e) => (e['email']?.toString() ?? '').isNotEmpty)
            .toList();
      });
    } catch (_) {
      // Assignment is optional; the roster still renders without the list.
    }
  }

  String _employeeLabel(Map<String, dynamic> e) {
    final name = [e['firstName'], e['lastName']]
        .where((v) => v != null && v.toString().trim().isNotEmpty)
        .join(' ')
        .trim();
    return name.isEmpty ? (e['email']?.toString() ?? '') : name;
  }

  Future<void> _assign(SILRosterEntry entry) async {
    if (entry.shiftId == null) return;
    if (_employees.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No employees available to assign.')),
      );
      return;
    }
    final selected = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Assign support worker'),
        children: [
          for (final e in _employees)
            SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop(e),
              child: Text(_employeeLabel(e)),
            ),
        ],
      ),
    );
    if (selected == null || !mounted) return;
    try {
      final api = ref.read(app_providers.apiMethodProvider);
      final response = await api.updateShift(entry.shiftId!, {
        'employeeEmail': selected['email'],
      });
      if (!mounted) return;
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Assigned ${_employeeLabel(selected)}.')),
        );
        await _build();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['error']?.toString() ?? 'Assignment failed.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

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
    final unassigned = entry.assignedStaff == 0 && entry.shiftId != null;
    final start = _localHm(entry.startTime);
    final end = _localHm(entry.endTime);
    final timeRange = start.isEmpty
        ? ''
        : end.isEmpty
        ? start
        : '$start–$end';

    return Card(
      child: ListTile(
        leading: Icon(Icons.event, color: color),
        title: Text(entry.shiftType),
        subtitle: Text(
          '$timeRange · staff ${entry.assignedStaff}/${entry.requiredStaff}',
        ),
        onTap: unassigned ? () => _assign(entry) : null,
        trailing: unassigned
            ? ActionChip(
                avatar: const Icon(Icons.person_add_alt, size: 18),
                label: const Text('Assign'),
                onPressed: () => _assign(entry),
              )
            : Chip(
                label: Text(entry.compliance),
                backgroundColor: color.withValues(alpha: 0.12),
                side: BorderSide(color: color),
              ),
      ),
    );
  }
}
