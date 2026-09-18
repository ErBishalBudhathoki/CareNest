import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/bulk_actions/models/bulk_action_models.dart';
import 'package:carenest/app/features/bulk_actions/repositories/bulk_actions_repository.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/repositories/timesheet_repository.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';

/// Bulk Actions View - Tabbed interface for all bulk operations.
/// Every tab loads live data and calls the real bulk endpoints; there are
/// no mock lists or simulated results anywhere in this screen.
class BulkActionsView extends ConsumerStatefulWidget {
  final String organizationId;
  final String userEmail;

  const BulkActionsView({
    super.key,
    required this.organizationId,
    required this.userEmail,
  });

  @override
  ConsumerState<BulkActionsView> createState() => _BulkActionsViewState();
}

class _BulkActionsViewState extends ConsumerState<BulkActionsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Actions'),
        backgroundColor: BauhausDesign.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
          physics: const BouncingScrollPhysics(),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
          tabs: const [
            Tab(text: 'TIMESHEETS'),
            Tab(text: 'INVOICES'),
            Tab(text: 'ASSIGNMENTS'),
            Tab(text: 'MESSAGES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BulkTimesheetTab(
            organizationId: widget.organizationId,
            userEmail: widget.userEmail,
          ),
          _BulkInvoiceTab(organizationId: widget.organizationId),
          _BulkAssignmentTab(organizationId: widget.organizationId),
          _BulkMessagingTab(organizationId: widget.organizationId),
        ],
      ),
    );
  }
}

// ============================================================================
// Shared list-state helpers
// ============================================================================

Widget _buildTabError(String message, VoidCallback onRetry) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: BauhausDesign.error),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: BauhausDesign.textDark),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text('RETRY'),
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// Bulk Timesheet Tab
// ============================================================================

class _BulkTimesheetTab extends ConsumerStatefulWidget {
  final String organizationId;
  final String userEmail;

  const _BulkTimesheetTab({
    required this.organizationId,
    required this.userEmail,
  });

  @override
  ConsumerState<_BulkTimesheetTab> createState() => _BulkTimesheetTabState();
}

class _BulkTimesheetTabState extends ConsumerState<_BulkTimesheetTab> {
  final Set<String> _selectedTimesheets = {};
  bool _isLoading = true;
  bool _isActing = false;
  String? _error;
  List<TimesheetEntry> _timesheets = [];

  @override
  void initState() {
    super.initState();
    _loadTimesheets();
  }

  Future<void> _loadTimesheets() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final apiMethod = ref.read(app_providers.apiMethodProvider);
      final now = DateTime.now();
      final items = await TimesheetRepository(apiMethod)
          .fetchOrganizationTimesheets(
            organizationId: widget.organizationId,
            startDate: now.subtract(const Duration(days: 30)),
            endDate: now,
            status: 'submitted',
          );
      if (!mounted) return;
      setState(() {
        _timesheets = items;
        _selectedTimesheets.removeWhere((id) => items.every((t) => t.id != id));
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  BulkActionsRepository get _repo =>
      BulkActionsRepository(ref.read(app_providers.apiMethodProvider));

  Future<void> _approveTimesheets() async {
    final ids = _selectedTimesheets.toList();
    setState(() => _isActing = true);
    try {
      final result = await _repo.approveTimesheets(
        timesheetIds: ids,
        organizationId: widget.organizationId,
        approvedBy: widget.userEmail,
      );
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bulkApproved(
              result.approvedCount.toString(),
              result.totalRequested.toString(),
            ),
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() => _selectedTimesheets.clear());
      await _loadTimesheets();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _rejectTimesheets() async {
    final reason = await _showRejectDialog();
    if (reason == null) return;
    final ids = _selectedTimesheets.toList();
    setState(() => _isActing = true);
    try {
      final result = await _repo.rejectTimesheets(
        timesheetIds: ids,
        organizationId: widget.organizationId,
        rejectedBy: widget.userEmail,
        reason: reason.isEmpty ? 'Rejected by admin' : reason,
      );
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bulkRejected(
              result.rejectedCount.toString(),
              result.totalRequested.toString(),
            ),
          ),
          backgroundColor: BauhausDesign.error,
        ),
      );
      setState(() => _selectedTimesheets.clear());
      await _loadTimesheets();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<String?> _showRejectDialog() async {
    final controller = TextEditingController();
    final l10n = AppLocalizations.of(context)!;
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.bulkRejectTitle),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: l10n.bulkRejectReasonHint),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.error,
            ),
            child: Text(l10n.rejectAction),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Action Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: BauhausDesign.surfaceOffWhite,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 900;
              final approveButton = ElevatedButton.icon(
                onPressed:
                    (_selectedTimesheets.isEmpty || _isActing || _isLoading)
                    ? null
                    : () => _approveTimesheets(),
                icon: const Icon(Icons.check_circle, size: 20),
                label: const Text('APPROVE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.success,
                  foregroundColor: Colors.white,
                ),
              );
              final rejectButton = ElevatedButton.icon(
                onPressed:
                    (_selectedTimesheets.isEmpty || _isActing || _isLoading)
                    ? null
                    : () => _rejectTimesheets(),
                icon: const Icon(Icons.cancel, size: 20),
                label: const Text('REJECT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.error,
                  foregroundColor: Colors.white,
                ),
              );

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_selectedTimesheets.length} selected',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [approveButton, rejectButton],
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_selectedTimesheets.length} selected',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: [approveButton, rejectButton],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // Timesheet List
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _buildTabError(_error!, _loadTimesheets);
    }
    if (_timesheets.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noSubmittedTimesheets),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadTimesheets,
      child: ListView.builder(
        itemCount: _timesheets.length,
        itemBuilder: (context, index) {
          final entry = _timesheets[index];
          final isSelected = _selectedTimesheets.contains(entry.id);
          final hours = entry.totalHours?.toString() ?? entry.timeWorked ?? '';
          final date =
              entry.shiftDate ??
              entry.workDate?.toString().split(' ').first ??
              '';
          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedTimesheets.add(entry.id);
                } else {
                  _selectedTimesheets.remove(entry.id);
                }
              });
            },
            title: Text(entry.userEmail),
            subtitle: Text('$date • $hours hours'),
          );
        },
      ),
    );
  }
}

// ============================================================================
// Bulk Invoice Tab
// ============================================================================

class _BulkInvoiceTab extends ConsumerStatefulWidget {
  final String organizationId;

  const _BulkInvoiceTab({required this.organizationId});

  @override
  ConsumerState<_BulkInvoiceTab> createState() => _BulkInvoiceTabState();
}

class _BulkInvoiceTabState extends ConsumerState<_BulkInvoiceTab> {
  final Set<String> _selectedAppointments = {};
  bool _groupByClient = true;
  bool _isLoading = true;
  bool _isActing = false;
  String? _error;
  List<Map<String, dynamic>> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  static String _stringId(Map<String, dynamic> item) {
    final raw = item['_id'] ?? item['id'] ?? '';
    return raw.toString();
  }

  Future<void> _loadAppointments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final apiMethod = ref.read(app_providers.apiMethodProvider);
      final response = await apiMethod.getAssignmentsByStatus(
        organizationId: widget.organizationId,
        status: 'completed',
      );
      if (!mounted) return;
      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to load appointments');
      }
      final all = (response['assignments'] as List? ?? [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .where((a) => a['invoiced'] != true)
          .toList();
      setState(() {
        _appointments = all;
        _selectedAppointments.removeWhere(
          (id) => all.every((a) => _stringId(a) != id),
        );
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  BulkActionsRepository get _repo =>
      BulkActionsRepository(ref.read(app_providers.apiMethodProvider));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Action Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: BauhausDesign.surfaceOffWhite,
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 900;
                  final previewButton = ElevatedButton.icon(
                    onPressed:
                        (_selectedAppointments.isEmpty ||
                            _isActing ||
                            _isLoading)
                        ? null
                        : () => _previewInvoices(),
                    icon: const Icon(Icons.preview, size: 20),
                    label: const Text('PREVIEW'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BauhausDesign.secondary,
                      foregroundColor: Colors.white,
                    ),
                  );
                  final generateButton = ElevatedButton.icon(
                    onPressed:
                        (_selectedAppointments.isEmpty ||
                            _isActing ||
                            _isLoading)
                        ? null
                        : () => _generateInvoices(),
                    icon: const Icon(Icons.receipt_long, size: 20),
                    label: const Text('GENERATE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BauhausDesign.primary,
                      foregroundColor: Colors.white,
                    ),
                  );

                  if (isCompact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_selectedAppointments.length} selected',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [previewButton, generateButton],
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_selectedAppointments.length} selected',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.end,
                          children: [previewButton, generateButton],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _groupByClient,
                onChanged: (value) {
                  setState(() => _groupByClient = value ?? true);
                },
                title: const Text('Group by client'),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        // Appointment List
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _buildTabError(_error!, _loadAppointments);
    }
    if (_appointments.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noInvoiceableAppointments),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadAppointments,
      child: ListView.builder(
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final apt = _appointments[index];
          final id = _stringId(apt);
          final isSelected = _selectedAppointments.contains(id);
          final client = (apt['clientEmail'] ?? apt['clientName'] ?? '')
              .toString();
          final worker = (apt['userEmail'] ?? '').toString();
          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedAppointments.add(id);
                } else {
                  _selectedAppointments.remove(id);
                }
              });
            },
            title: Text(client.isEmpty ? id : client),
            subtitle: Text(worker),
          );
        },
      ),
    );
  }

  Future<void> _previewInvoices() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isActing = true);
    try {
      final preview = await _repo.previewInvoices(
        appointmentIds: _selectedAppointments.toList(),
        organizationId: widget.organizationId,
        groupByClient: _groupByClient,
      );
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.invoicePreviewTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${preview.invoiceCount} invoices • '
                  '${preview.totalAppointments} appointments • '
                  '\$${preview.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                for (final item in preview.invoices) ...[
                  Text(
                    '${item.clientName} — '
                    '\$${item.totalAmount.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.closeButton),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _generateInvoices() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isActing = true);
    try {
      final result = await _repo.generateInvoices(
        appointmentIds: _selectedAppointments.toList(),
        organizationId: widget.organizationId,
        groupByClient: _groupByClient,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bulkInvoicesGenerated(
              result.invoiceCount.toString(),
              result.appointmentCount.toString(),
            ),
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() => _selectedAppointments.clear());
      await _loadAppointments();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }
}

// ============================================================================
// Bulk Assignment Tab
// ============================================================================

class _BulkAssignmentTab extends ConsumerStatefulWidget {
  final String organizationId;

  const _BulkAssignmentTab({required this.organizationId});

  @override
  ConsumerState<_BulkAssignmentTab> createState() => _BulkAssignmentTabState();
}

class _BulkAssignmentTabState extends ConsumerState<_BulkAssignmentTab> {
  final Set<String> _selectedShifts = {};
  final Map<String, String> _suggestedWorkers = {};
  final Map<String, String> _suggestedWorkerNames = {};
  bool _isLoading = true;
  bool _isActing = false;
  String? _error;
  List<ShiftModel> _shifts = [];

  @override
  void initState() {
    super.initState();
    _loadShifts();
  }

  Future<void> _loadShifts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final apiMethod = ref.read(app_providers.apiMethodProvider);
      final now = DateTime.now();
      final response = await apiMethod.getScheduleShifts(
        organizationId: widget.organizationId,
        startDate: now.subtract(const Duration(days: 7)),
        endDate: now.add(const Duration(days: 30)),
      );
      if (!mounted) return;
      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to load shifts');
      }
      final all = ((response['data'] ?? response['shifts']) as List? ?? [])
          .map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
          .where((s) => (s.employeeEmail == null || s.employeeEmail!.isEmpty))
          .toList();
      setState(() {
        _shifts = all;
        _selectedShifts.removeWhere((id) => all.every((s) => s.id != id));
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  BulkActionsRepository get _repo =>
      BulkActionsRepository(ref.read(app_providers.apiMethodProvider));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Action Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: BauhausDesign.surfaceOffWhite,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 900;
              final suggestButton = ElevatedButton.icon(
                onPressed: (_selectedShifts.isEmpty || _isActing || _isLoading)
                    ? null
                    : () => _getSuggestions(),
                icon: const Icon(Icons.lightbulb, size: 20),
                label: const Text('SUGGEST'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.secondary,
                  foregroundColor: Colors.white,
                ),
              );
              final assignButton = ElevatedButton.icon(
                onPressed: (_selectedShifts.isEmpty || _isActing || _isLoading)
                    ? null
                    : () => _assignShifts(),
                icon: const Icon(Icons.assignment_turned_in, size: 20),
                label: const Text('ASSIGN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: Colors.white,
                ),
              );

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_selectedShifts.length} shifts to assign',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [suggestButton, assignButton],
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_selectedShifts.length} shifts to assign',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: [suggestButton, assignButton],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // Shift List
        Expanded(child: _buildBody()),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _buildTabError(_error!, _loadShifts);
    }
    if (_shifts.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noUnassignedShifts),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadShifts,
      child: ListView.builder(
        itemCount: _shifts.length,
        itemBuilder: (context, index) {
          final shift = _shifts[index];
          final isSelected = _selectedShifts.contains(shift.id);
          final suggested = _suggestedWorkerNames[shift.id];
          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedShifts.add(shift.id);
                } else {
                  _selectedShifts.remove(shift.id);
                }
              });
            },
            title: Text(shift.clientName ?? shift.id),
            subtitle: Text(
              '${shift.startTime.toString().split(' ').first}'
              '${suggested != null ? ' • $suggested' : ''}',
            ),
          );
        },
      ),
    );
  }

  Future<void> _getSuggestions() async {
    setState(() => _isActing = true);
    try {
      final suggestions = await _repo.suggestAssignments(
        shiftIds: _selectedShifts.toList(),
        organizationId: widget.organizationId,
      );
      if (!mounted) return;
      setState(() {
        for (final s in suggestions) {
          if (s.suggestedWorkers.isNotEmpty) {
            final best = s.suggestedWorkers.first;
            _suggestedWorkers[s.shiftId] = best.workerId;
            _suggestedWorkerNames[s.shiftId] = best.workerName;
          }
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Suggestions loaded'),
          backgroundColor: BauhausDesign.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _assignShifts() async {
    final pairs = _selectedShifts
        .where((id) => _suggestedWorkers[id] != null)
        .map(
          (id) => ShiftAssignment(shiftId: id, workerId: _suggestedWorkers[id]),
        )
        .toList();
    if (pairs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Run SUGGEST first to pick workers'),
          backgroundColor: BauhausDesign.warning,
        ),
      );
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isActing = true);
    try {
      final result = await _repo.assignShifts(
        assignments: pairs,
        organizationId: widget.organizationId,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bulkShiftsAssigned(
              result.successfulCount.toString(),
              result.failedCount.toString(),
            ),
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedShifts.clear();
        _suggestedWorkers.clear();
        _suggestedWorkerNames.clear();
      });
      await _loadShifts();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }
}

// ============================================================================
// Bulk Messaging Tab
// ============================================================================

class _BulkMessagingTab extends ConsumerStatefulWidget {
  final String organizationId;

  const _BulkMessagingTab({required this.organizationId});

  @override
  ConsumerState<_BulkMessagingTab> createState() => _BulkMessagingTabState();
}

class _BulkMessagingTabState extends ConsumerState<_BulkMessagingTab> {
  final Set<String> _selectedRecipients = {};
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final Set<String> _selectedChannels = {'push'};
  bool _isLoading = true;
  bool _isActing = false;
  String? _error;
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final apiMethod = ref.read(app_providers.apiMethodProvider);
      final users = await apiMethod.fetchUserData();
      if (!mounted) return;
      setState(() {
        _users = users.where((u) => u.email.trim().isNotEmpty).toList();
        _selectedRecipients.removeWhere(
          (id) => _users.every((u) => u.id != id),
        );
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  BulkActionsRepository get _repo =>
      BulkActionsRepository(ref.read(app_providers.apiMethodProvider));

  List<MessageChannel> get _channels => _selectedChannels
      .map(
        (c) => MessageChannel.values.firstWhere(
          (m) => m.name == c,
          orElse: () => MessageChannel.push,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipients
          const Text(
            'Recipients',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          _buildRecipientSelector(),
          const SizedBox(height: 24),

          // Channels
          const Text(
            'Channels',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('Push'),
                selected: _selectedChannels.contains('push'),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedChannels.add('push');
                    } else {
                      _selectedChannels.remove('push');
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('SMS'),
                selected: _selectedChannels.contains('sms'),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedChannels.add('sms');
                    } else {
                      _selectedChannels.remove('sms');
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('Email'),
                selected: _selectedChannels.contains('email'),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedChannels.add('email');
                    } else {
                      _selectedChannels.remove('email');
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Subject
          TextField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Message
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 24),

          // Actions
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 520;
              final sendButton = ElevatedButton.icon(
                onPressed: (_canSend() && !_isActing)
                    ? () => _sendMessages()
                    : null,
                icon: const Icon(Icons.send),
                label: const Text('SEND NOW'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              );
              final scheduleButton = OutlinedButton.icon(
                onPressed: (_canSend() && !_isActing)
                    ? () => _scheduleMessages()
                    : null,
                icon: const Icon(Icons.schedule),
                label: const Text('SCHEDULE'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              );

              if (isCompact) {
                return Column(
                  children: [
                    SizedBox(width: double.infinity, child: sendButton),
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, child: scheduleButton),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: sendButton),
                  const SizedBox(width: 16),
                  Expanded(child: scheduleButton),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientSelector() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (_error != null) {
      return _buildTabError(_error!, _loadUsers);
    }
    if (_users.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(AppLocalizations.of(context)!.noTeamMembersFound),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: BauhausDesign.neutral),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: _users.map((user) {
          final isSelected = _selectedRecipients.contains(user.id);
          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedRecipients.add(user.id);
                } else {
                  _selectedRecipients.remove(user.id);
                }
              });
            },
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        }).toList(),
      ),
    );
  }

  bool _canSend() {
    return _selectedRecipients.isNotEmpty &&
        _messageController.text.isNotEmpty &&
        _selectedChannels.isNotEmpty;
  }

  Future<void> _sendMessages() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isActing = true);
    try {
      final result = await _repo.sendMessages(
        recipientIds: _selectedRecipients.toList(),
        organizationId: widget.organizationId,
        subject: _subjectController.text,
        message: _messageController.text,
        channels: _channels,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.bulkMessagesSent(result.sentCount.toString())),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedRecipients.clear();
        _subjectController.clear();
        _messageController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _scheduleMessages() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !mounted) return;
    final scheduledFor = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final l10n = AppLocalizations.of(context)!;
    setState(() => _isActing = true);
    try {
      final result = await _repo.scheduleMessages(
        recipientIds: _selectedRecipients.toList(),
        organizationId: widget.organizationId,
        subject: _subjectController.text,
        message: _messageController.text,
        channels: _channels,
        scheduledFor: scheduledFor,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bulkMessagesScheduled(result.scheduledCount.toString()),
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedRecipients.clear();
        _subjectController.clear();
        _messageController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }
}
