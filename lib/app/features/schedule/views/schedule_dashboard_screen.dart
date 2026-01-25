// Schedule Dashboard Screen
// Main scheduling interface with Bauhaus design system
//
// @file lib/app/features/schedule/views/schedule_dashboard_screen.dart

import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/schedule/widgets/smart_assign_dialog.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Schedule Dashboard Screen with Bauhaus styling
class ScheduleDashboardScreen extends StatefulWidget {
  final String organizationId;
  final String? userEmail;
  final bool isAdmin;

  const ScheduleDashboardScreen({
    super.key,
    required this.organizationId,
    this.userEmail,
    this.isAdmin = false,
  });

  @override
  State<ScheduleDashboardScreen> createState() =>
      _ScheduleDashboardScreenState();
}

class _ScheduleDashboardScreenState extends State<ScheduleDashboardScreen> {
  final ApiMethod _api = ApiMethod();

  List<ShiftModel> _shifts = [];
  bool _isLoading = true;
  String? _error;
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'all'; // all, pending, approved, completed

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
      // Get shifts for the current week
      final startOfWeek =
          _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 7));

      final response = await _api.getScheduleShifts(
        organizationId: widget.organizationId,
        startDate: startOfWeek,
        endDate: endOfWeek,
        status: _selectedFilter == 'all' ? null : _selectedFilter,
      );

      if (response['success'] == true) {
        final shiftsData = response['data'] as List<dynamic>? ?? [];
        setState(() {
          _shifts = shiftsData
              .map((e) => ShiftModel.fromJson(e as Map<String, dynamic>))
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = response['error']?.toString() ??
              AppLocalizations.of(context)!.failedToLoadShifts;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error loading shifts: $e';
        _isLoading = false;
      });
    }
  }

  void _showCreateShiftDialog() {
    showDialog(
      context: context,
      builder: (context) => _CreateShiftDialog(
        organizationId: widget.organizationId,
        onCreated: () {
          Navigator.of(context).pop();
          _loadShifts();
        },
      ),
    );
  }

  void _showSmartAssignDialog(ShiftModel shift) {
    showDialog(
      context: context,
      builder: (context) => SmartAssignDialog(
        organizationId: widget.organizationId,
        shift: shift,
        onAssigned: (employeeEmail) async {
          // Update shift with selected employee
          final result = await _api.updateShift(shift.id, {
            'employeeEmail': employeeEmail,
            'status': 'approved',
          });

          if (mounted) {
            if (result['success'] == true) {
              Navigator.of(context).pop();
              _loadShifts();
              _showSuccessSnackbar(
                  AppLocalizations.of(context)!.shiftAssignedSuccessfully);
            } else {
              _showErrorSnackbar(result['error']?.toString() ??
                  AppLocalizations.of(context)!.failedToAssignShift);
            }
          }
        },
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: BauhausDesign.surfaceWhite),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.surfaceWhite,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
        backgroundColor: BauhausDesign.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 1.5),
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: BauhausDesign.surfaceWhite),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.surfaceWhite,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
        backgroundColor: BauhausDesign.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildBauhausAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : _error != null
              ? _buildErrorState()
              : _buildContent(),
      floatingActionButton: widget.isAdmin
          ? BauhausActionButton(
              onPressed: _showCreateShiftDialog,
              icon: Icons.add,
              text: AppLocalizations.of(context)!.createButton,
              variant: BauhausActionVariant.primary,
            )
          : null,
    );
  }

  PreferredSizeWidget _buildBauhausAppBar() {
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
                BauhausIconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.arrow_back,
                  variant: BauhausActionVariant.ghost,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.scheduleTitle,
                  style: BauhausDesign.getTextTheme(context).displaySmall,
                ),
                const Spacer(),
                _buildFilterDropdown(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFilter,
          isDense: true,
          icon:
              const Icon(Icons.arrow_drop_down, color: BauhausDesign.textDark),
          items: [
            DropdownMenuItem(
                value: 'all',
                child: Text(AppLocalizations.of(context)!.allShifts,
                    style: BauhausDesign.getTextTheme(context).bodyMedium)),
            DropdownMenuItem(
                value: 'pending',
                child: Text(AppLocalizations.of(context)!.statusPendingShift,
                    style: BauhausDesign.getTextTheme(context).bodyMedium)),
            DropdownMenuItem(
                value: 'approved',
                child: Text(AppLocalizations.of(context)!.statusApprovedShift,
                    style: BauhausDesign.getTextTheme(context).bodyMedium)),
            DropdownMenuItem(
                value: 'completed',
                child: Text(AppLocalizations.of(context)!.statusCompletedShift,
                    style: BauhausDesign.getTextTheme(context).bodyMedium)),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedFilter = value);
              _loadShifts();
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: BauhausEmptyState(
        title: AppLocalizations.of(context)!.failedToLoadShifts,
        message: _error ?? AppLocalizations.of(context)!.unknownError,
        icon: Icons.error_outline,
        actionLabel: AppLocalizations.of(context)!.retryButton,
        onAction: _loadShifts,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildWeekNavigator(),
        Expanded(
          child: _shifts.isEmpty ? _buildEmptyState() : _buildShiftsList(),
        ),
      ],
    );
  }

  Widget _buildWeekNavigator() {
    final startOfWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final dateFormat = DateFormat('MMM d');

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
      ),
      child: Row(
        children: [
          BauhausIconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 7));
              });
              _loadShifts();
            },
            icon: Icons.chevron_left,
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
          Expanded(
            child: Center(
              child: Text(
                '${dateFormat.format(startOfWeek)} - ${dateFormat.format(endOfWeek)}',
                style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                      color: BauhausDesign.textDark,
                    ),
              ),
            ),
          ),
          BauhausIconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 7));
              });
              _loadShifts();
            },
            icon: Icons.chevron_right,
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: BauhausEmptyState(
        title: AppLocalizations.of(context)!.noShiftsScheduled,
        message: AppLocalizations.of(context)!.createShiftToStart,
        icon: Icons.calendar_today,
        actionLabel:
            widget.isAdmin ? AppLocalizations.of(context)!.createShift : null,
        onAction: widget.isAdmin ? _showCreateShiftDialog : null,
      ),
    );
  }

  Widget _buildShiftsList() {
    // Group shifts by date
    final groupedShifts = <String, List<ShiftModel>>{};
    for (final shift in _shifts) {
      final dateKey = DateFormat('yyyy-MM-dd').format(shift.startTime);
      groupedShifts.putIfAbsent(dateKey, () => []).add(shift);
    }

    final sortedDates = groupedShifts.keys.toList()..sort();

    return RefreshIndicator(
      onRefresh: _loadShifts,
      color: BauhausDesign.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final dateKey = sortedDates[index];
          final dayShifts = groupedShifts[dateKey]!;
          final date = DateTime.parse(dateKey);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(date),
              const SizedBox(height: BauhausDesign.space2),
              ...dayShifts.map((shift) => _buildShiftCard(shift)),
              const SizedBox(height: BauhausDesign.space4),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    final isToday = DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3,
            vertical: BauhausDesign.space1,
          ),
          decoration: BoxDecoration(
            color: isToday ? BauhausDesign.primary : BauhausDesign.secondary,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            boxShadow: const [BauhausDesign.shadowHardXs],
          ),
          child: Text(
            DateFormat('EEE, MMM d').format(date),
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.surfaceWhite,
                ),
          ),
        ),
        if (isToday) ...[
          const SizedBox(width: BauhausDesign.space2),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.accent),
            ),
            child: Text(
              'TODAY',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildShiftCard(ShiftModel shift) {
    final timeFormat = DateFormat('h:mm a');
    final statusColor = _getStatusColor(shift.status);

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: BauhausCard(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        onTap: () {
          if (widget.isAdmin && shift.employeeEmail == null) {
            _showSmartAssignDialog(shift);
          }
        },
        child: Row(
          children: [
            // Time column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeFormat.format(shift.startTime),
                  style: BauhausDesign.getTextTheme(context).titleMedium,
                ),
                Text(
                  timeFormat.format(shift.endTime),
                  style: BauhausDesign.getTextTheme(context).bodySmall,
                ),
              ],
            ),

            // Vertical divider
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: BauhausDesign.space3),
              width: 2,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),

            // Details column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shift.clientName ??
                        shift.clientEmail ??
                        AppLocalizations.of(context)!.noClient,
                    style: BauhausDesign.getTextTheme(context).bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    shift.employeeName ??
                        shift.employeeEmail ??
                        AppLocalizations.of(context)!.unassigned,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: shift.employeeEmail != null
                              ? BauhausDesign.neutral
                              : BauhausDesign.primary,
                          fontWeight: shift.employeeEmail != null
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),

            // Status badge
            BauhausChip(
              text: shift.status.value[0].toUpperCase() +
                  shift.status.value.substring(1),
              color: statusColor,
              isSmall: true,
            ),

            if (widget.isAdmin && shift.employeeEmail == null)
              const Padding(
                padding: EdgeInsets.only(left: BauhausDesign.space2),
                child: Icon(
                  Icons.auto_awesome,
                  color: BauhausDesign.accent,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ShiftStatus status) {
    switch (status) {
      case ShiftStatus.pending:
        return BauhausDesign.accent;
      case ShiftStatus.approved:
        return BauhausDesign.secondary;
      case ShiftStatus.completed:
        return BauhausDesign.success;
      case ShiftStatus.cancelled:
        return BauhausDesign.error;
    }
  }
}

/// Create Shift Dialog with Bauhaus styling
class _CreateShiftDialog extends StatefulWidget {
  final String organizationId;
  final VoidCallback onCreated;

  const _CreateShiftDialog({
    required this.organizationId,
    required this.onCreated,
  });

  @override
  State<_CreateShiftDialog> createState() => _CreateShiftDialogState();
}

class _CreateShiftDialogState extends State<_CreateShiftDialog> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);
  bool _isLoading = false;
  
  List<Map<String, dynamic>> _clients = [];
  List<dynamic> _employees = [];
  bool _isFetchingData = true;
  String? _selectedClientEmail;
  String? _selectedEmployeeEmail;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      debugPrint('Fetching data for Organization ID: ${widget.organizationId}');
      
      final clientsFuture = ApiMethod().getClientsByOrganizationId(widget.organizationId);
      final employeesFuture = ApiMethod().getOrganizationEmployees(widget.organizationId);

      final results = await Future.wait([clientsFuture, employeesFuture]);
      
      if (mounted) {
        setState(() {
          _clients = (results[0] as List<Map<String, dynamic>>).map((c) {
            // Normalize keys to standard format
            return {
              'firstName': c['firstName'] ?? c['clientFirstName'],
              'lastName': c['lastName'] ?? c['clientLastName'],
              'email': c['email'] ?? c['clientEmail'],
              '_id': c['_id'] ?? c['id'],
            };
          }).toList();
          
          debugPrint('Clients fetched: ${_clients.length}');
          if (_clients.isNotEmpty) {
            debugPrint('First client data: ${_clients.first}');
          } else {
             debugPrint('No clients found in response. Raw result: ${results[0]}');
          }
          
          final empResult = results[1] as Map<String, dynamic>;
          if (empResult['success'] == true) {
            _employees = empResult['employees'] as List<dynamic>;
            debugPrint('Employees fetched: ${_employees.length}');
          } else {
            debugPrint('Failed to fetch employees: ${empResult['message']}');
          }
          
          _isFetchingData = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      // If direct fetch fails, try alternative method to get all clients
      try {
        final allClients = await ApiMethod().fetchClientData();
        if (mounted) {
           setState(() {
             _clients = allClients.map((c) => {
               'firstName': c.clientFirstName,
               'lastName': c.clientLastName,
               'email': c.clientEmail,
               'phone': c.clientPhone,
               '_id': c.id,
             }).toList();
             _isFetchingData = false;
           });
        }
      } catch (retryError) {
        debugPrint('Retry fetch failed: $retryError');
        if (mounted) {
          setState(() => _isFetchingData = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _createShift() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClientEmail == null) return;

    setState(() => _isLoading = true);

    final startDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _startTime.hour,
      _startTime.minute,
    );

    final endDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    final Map<String, dynamic> shiftData = {
      'organizationId': widget.organizationId,
      'clientEmail': _selectedClientEmail,
      'startTime': startDateTime.toIso8601String(),
      'endTime': endDateTime.toIso8601String(),
      'notes': _notesController.text.trim(),
      'status': _selectedEmployeeEmail != null ? 'approved' : 'pending',
    };

    if (_selectedEmployeeEmail != null) {
      shiftData['employeeEmail'] = _selectedEmployeeEmail;
    }

    final result = await ApiMethod().createShift(shiftData);

    if (mounted) {
      setState(() => _isLoading = false);

      if (result['success'] == true) {
        widget.onCreated();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['error']?.toString() ??
                AppLocalizations.of(context)!.failedToCreateShift),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.createNewShift,
                style: BauhausDesign.getTextTheme(context).displaySmall,
              ),
              const SizedBox(height: BauhausDesign.space4),
              if (_isFetchingData)
                const Center(child: CircularProgressIndicator())
              else if (_clients.isEmpty)
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(color: BauhausDesign.error),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: BauhausDesign.error),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Text(
                          'No clients found for this organization.',
                          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                DropdownButtonFormField<String>(
                  value: _selectedClientEmail,
                  decoration: BauhausDesign.inputDecoration(
                    AppLocalizations.of(context)!.clientEmailLabel,
                  ).copyWith(
                    prefixIcon: const Icon(Icons.person, color: BauhausDesign.textMuted),
                    filled: true,
                    fillColor: BauhausDesign.surfaceWhite,
                  ),
                  items: _clients.map((client) {
                    final name = '${client['firstName']} ${client['lastName']}';
                    final email = client['email'] as String?; // Handle potential null
                    if (email == null) return null; // Skip if email is null

                    return DropdownMenuItem<String>(
                      value: email,
                      child: Text(
                        '$name ($email)',
                        overflow: TextOverflow.ellipsis,
                        style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    );
                  }).whereType<DropdownMenuItem<String>>().toList(), // Filter out nulls
                  onChanged: (value) => setState(() => _selectedClientEmail = value),
                  validator: (value) => value == null
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: BauhausDesign.neutral),
                  style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                  ),
                  dropdownColor: BauhausDesign.surfaceWhite,
                ),
              const SizedBox(height: BauhausDesign.space4),
              if (!_isFetchingData) ...[
                DropdownButtonFormField<String>(
                  value: _selectedEmployeeEmail,
                  decoration: BauhausDesign.inputDecoration(
                    'Assign Employee (Optional)',
                  ).copyWith(
                    prefixIcon: const Icon(Icons.badge, color: BauhausDesign.textMuted),
                    filled: true,
                    fillColor: BauhausDesign.surfaceWhite,
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('Unassigned'),
                    ),
                    ..._employees.map((emp) {
                      final name = '${emp['firstName']} ${emp['lastName']}';
                      final email = emp['email'] as String?; // Handle potential null
                      if (email == null) return null; // Skip if email is null

                      return DropdownMenuItem<String>(
                        value: email,
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.textDark,
                          ),
                        ),
                      );
                    }).whereType<DropdownMenuItem<String>>(), // Filter out nulls
                  ],
                  onChanged: (value) => setState(() => _selectedEmployeeEmail = value),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: BauhausDesign.neutral),
                  style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                  ),
                  dropdownColor: BauhausDesign.surfaceWhite,
                ),
                const SizedBox(height: BauhausDesign.space4),
              ],
              const SizedBox(height: BauhausDesign.space4),
              Text(
                AppLocalizations.of(context)!.dateTimeLabel,
                style:
                    BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: BauhausDesign.primary,
                            onPrimary: BauhausDesign.surfaceWhite,
                            surface: BauhausDesign.surfaceLight,
                            onSurface: BauhausDesign.textDark,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    border: Border.all(color: BauhausDesign.neutral),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: BauhausDesign.textMuted),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(DateFormat('MMM dd, yyyy').format(_selectedDate),
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(color: BauhausDesign.textDark)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Row(
                children: [
                  Expanded(
                    child: _buildTimePicker(
                      AppLocalizations.of(context)!.startLabel,
                      _startTime,
                      (time) => setState(() => _startTime = time),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: _buildTimePicker(
                      AppLocalizations.of(context)!.endLabel,
                      _endTime,
                      (time) => setState(() => _endTime = time),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausTextField(
                controller: _notesController,
                label: AppLocalizations.of(context)!.notesLabel,
                hintText: AppLocalizations.of(context)!.additionalDetailsHint,
                maxLines: 3,
              ),
              const SizedBox(height: BauhausDesign.space6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.cancelButton,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(color: BauhausDesign.neutral)),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!.createShift,
                    onPressed: _isLoading ? null : _createShift,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(
      String label, TimeOfDay time, Function(TimeOfDay) onChanged) {
    return GestureDetector(
      onTap: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: BauhausDesign.primary, // clock hand color
                  onPrimary: BauhausDesign.surfaceWhite,
                  surface: BauhausDesign.surfaceLight, // background color
                  onSurface: BauhausDesign.textDark, // text color
                ),
              ),
              child: child!,
            );
          },
        );
        if (newTime != null) {
          onChanged(newTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausDesign.neutral),
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time,
                size: 16, color: BauhausDesign.textMuted),
            const SizedBox(width: BauhausDesign.space2),
            Text(time.format(context),
                style: BauhausDesign.getTextTheme(context)
                    .bodyMedium
                    ?.copyWith(color: BauhausDesign.textDark)),
          ],
        ),
      ),
    );
  }
}
