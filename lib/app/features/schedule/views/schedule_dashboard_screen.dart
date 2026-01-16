// Schedule Dashboard Screen
// Main scheduling interface with Bauhaus design system
//
// @file lib/app/features/schedule/views/schedule_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/schedule/widgets/smart_assign_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

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
  State<ScheduleDashboardScreen> createState() => _ScheduleDashboardScreenState();
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
      final startOfWeek = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
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
          _error = response['error']?.toString() ?? 'Failed to load shifts';
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
          
          if (result['success'] == true) {
            Navigator.of(context).pop();
            _loadShifts();
            _showSuccessSnackbar('Shift assigned successfully');
          } else {
            _showErrorSnackbar(result['error']?.toString() ?? 'Failed to assign shift');
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
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
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
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
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
          ? const Center(child: CircularProgressIndicator(color: BauhausDesign.primary))
          : _error != null
              ? _buildErrorState()
              : _buildContent(),
      floatingActionButton: widget.isAdmin
          ? Container(
              decoration: BoxDecoration(
                color: BauhausDesign.primary,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                boxShadow: [BauhausDesign.shadowHard],
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: FloatingActionButton(
                onPressed: _showCreateShiftDialog,
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add, size: 28),
              ),
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
            padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  'Schedule',
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
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
          icon: const Icon(Icons.arrow_drop_down, color: BauhausDesign.textDark),
          items: const [
            DropdownMenuItem(value: 'all', child: Text('All Shifts')),
            DropdownMenuItem(value: 'pending', child: Text('Pending')),
            DropdownMenuItem(value: 'approved', child: Text('Approved')),
            DropdownMenuItem(value: 'completed', child: Text('Completed')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedFilter = value);
              _loadShifts();
            }
          },
          style: GoogleFonts.inter(
            fontSize: 14,
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BauhausDesign.cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.error, width: 1.5),
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: BauhausDesign.error,
                  size: 48,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'Failed to Load Shifts',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                _error ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: BauhausDesign.neutral,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausButton(
                text: 'Retry',
                onPressed: _loadShifts,
                icon: Icons.refresh,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildWeekNavigator(),
        Expanded(
          child: _shifts.isEmpty
              ? _buildEmptyState()
              : _buildShiftsList(),
        ),
      ],
    );
  }

  Widget _buildWeekNavigator() {
    final startOfWeek = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
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
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 7));
              });
              _loadShifts();
            },
            icon: const Icon(Icons.chevron_left, color: BauhausDesign.textDark),
            style: IconButton.styleFrom(
              backgroundColor: BauhausDesign.backgroundLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                side: const BorderSide(color: BauhausDesign.neutral),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${dateFormat.format(startOfWeek)} - ${dateFormat.format(endOfWeek)}',
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 7));
              });
              _loadShifts();
            },
            icon: const Icon(Icons.chevron_right, color: BauhausDesign.textDark),
            style: IconButton.styleFrom(
              backgroundColor: BauhausDesign.backgroundLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                side: const BorderSide(color: BauhausDesign.neutral),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BauhausDesign.cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.accent, width: 1.5),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: BauhausDesign.accent,
                  size: 48,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'No Shifts Scheduled',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                'Create a new shift to get started',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: BauhausDesign.neutral,
                ),
              ),
              if (widget.isAdmin) ...[
                const SizedBox(height: BauhausDesign.space4),
                BauhausButton(
                  text: 'Create Shift',
                  onPressed: _showCreateShiftDialog,
                  icon: Icons.add,
                ),
              ],
            ],
          ),
        ),
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
            boxShadow: [BauhausDesign.shadowHardXs],
          ),
          child: Text(
            DateFormat('EEE, MMM d').format(date),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
                letterSpacing: 0.5,
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
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 1.5),
          boxShadow: [BauhausDesign.shadowHardSm],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (widget.isAdmin && shift.employeeEmail == null) {
                _showSmartAssignDialog(shift);
              }
            },
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            child: Padding(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Row(
                children: [
                  // Time column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeFormat.format(shift.startTime),
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                      Text(
                        timeFormat.format(shift.endTime),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: BauhausDesign.neutral,
                        ),
                      ),
                    ],
                  ),
                  
                  // Vertical divider
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: BauhausDesign.space3),
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
                          shift.clientName ?? shift.clientEmail ?? 'No Client',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          shift.employeeName ?? shift.employeeEmail ?? 'Unassigned',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: shift.employeeEmail != null
                                ? BauhausDesign.neutral
                                : BauhausDesign.primary,
                            fontWeight: shift.employeeEmail != null
                                ? FontWeight.normal
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Status badge
                  _buildStatusBadge(shift.status),
                  
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
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ShiftStatus status) {
    final color = _getStatusColor(status);
    final label = status.value[0].toUpperCase() + status.value.substring(1);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.3,
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
  final _clientController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);
  bool _isLoading = false;

  @override
  void dispose() {
    _clientController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _createShift() async {
    if (!_formKey.currentState!.validate()) return;

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

    final result = await ApiMethod().createShift({
      'organizationId': widget.organizationId,
      'clientEmail': _clientController.text.trim(),
      'startTime': startDateTime.toIso8601String(),
      'endTime': endDateTime.toIso8601String(),
      'notes': _notesController.text.trim(),
      'status': 'pending',
    });

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      widget.onCreated();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['error']?.toString() ?? 'Failed to create shift'),
          backgroundColor: BauhausDesign.error,
        ),
      );
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
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(BauhausDesign.space6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space2),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                        border: Border.all(color: BauhausDesign.primary),
                      ),
                      child: const Icon(
                        Icons.add_circle_outline,
                        color: BauhausDesign.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Text(
                      'Create New Shift',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: BauhausDesign.space6),
                
                // Client Email Field
                TextFormField(
                  controller: _clientController,
                  decoration: BauhausDesign.inputDecoration.copyWith(
                    labelText: 'Client Email',
                    labelStyle: GoogleFonts.inter(color: BauhausDesign.textDark),
                    prefixIcon: const Icon(Icons.person_outline, color: BauhausDesign.neutral),
                  ),
                  style: GoogleFonts.inter(color: BauhausDesign.textDark),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Client email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: BauhausDesign.space4),
                
                // Date Picker
                _buildDatePicker(),
                
                const SizedBox(height: BauhausDesign.space4),
                
                // Time Pickers
                Row(
                  children: [
                    Expanded(child: _buildTimePicker('Start', _startTime, (t) => setState(() => _startTime = t))),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(child: _buildTimePicker('End', _endTime, (t) => setState(() => _endTime = t))),
                  ],
                ),
                
                const SizedBox(height: BauhausDesign.space4),
                
                // Notes Field
                TextFormField(
                  controller: _notesController,
                  decoration: BauhausDesign.inputDecoration.copyWith(
                    labelText: 'Notes (Optional)',
                    labelStyle: GoogleFonts.inter(color: BauhausDesign.textDark),
                    prefixIcon: const Icon(Icons.notes, color: BauhausDesign.neutral),
                  ),
                  style: GoogleFonts.inter(color: BauhausDesign.textDark),
                  maxLines: 2,
                ),
                
                const SizedBox(height: BauhausDesign.space6),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: BauhausDesign.secondaryButtonStyle,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.secondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: BauhausButton(
                        text: _isLoading ? 'Creating...' : 'Create Shift',
                        onPressed: _isLoading ? null : _createShift,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          setState(() => _selectedDate = date);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          color: BauhausDesign.backgroundLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: BauhausDesign.neutral, size: 20),
            const SizedBox(width: BauhausDesign.space3),
            Text(
              DateFormat('EEE, MMM d, yyyy').format(_selectedDate),
              style: GoogleFonts.inter(
                fontSize: 14,
                color: BauhausDesign.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: BauhausDesign.backgroundLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: BauhausDesign.neutral,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              time.format(context),
              style: GoogleFonts.oswald(
                fontSize: 16,
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
