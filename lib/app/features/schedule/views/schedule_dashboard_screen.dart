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
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:intl/intl.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/app/features/mileage/models/trip_model.dart';
import 'package:carenest/app/features/mileage/repositories/mileage_repository.dart';

/// Schedule Dashboard Screen with Bauhaus styling
class ScheduleDashboardScreen extends ConsumerStatefulWidget {
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
  ConsumerState<ScheduleDashboardScreen> createState() =>
      _ScheduleDashboardScreenState();
}

class _ScheduleDashboardScreenState
    extends ConsumerState<ScheduleDashboardScreen> {
  late final ApiMethod _api;

  List<ShiftModel> _shifts = [];
  bool _isLoading = true;
  String? _error;
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'all'; // all, pending, approved, completed
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _loadShifts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadShifts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Get shifts for the current week
      final startOfWeek = _selectedDate.subtract(
        Duration(days: _selectedDate.weekday - 1),
      );
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
          _error =
              response['error']?.toString() ??
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

          if (context.mounted) {
            if (result['success'] == true) {
              Navigator.of(context).pop();
              _loadShifts();
              _showSuccessSnackbar(
                AppLocalizations.of(context)!.shiftAssignedSuccessfully,
              );
            } else {
              _showErrorSnackbar(
                result['error']?.toString() ??
                    AppLocalizations.of(context)!.failedToAssignShift,
              );
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
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
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
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                message,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
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
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildBauhausAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
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
    return AppBar(
      backgroundColor: BauhausDesign.secondary,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: BauhausIconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icons.arrow_back,
        variant: BauhausActionVariant.ghost,
      ),
      title: Text(
        AppLocalizations.of(context)!.scheduleTitle,
        style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: BauhausDesign.space2),
          child: _buildFilterDropdown(),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: Theme.of(context).colorScheme.outline,
          height: 2,
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFilter,
          isDense: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          items: [
            DropdownMenuItem(
              value: 'all',
              child: Text(
                AppLocalizations.of(context)!.allShifts,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ),
            DropdownMenuItem(
              value: 'pending',
              child: Text(
                AppLocalizations.of(context)!.statusPendingShift,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ),
            DropdownMenuItem(
              value: 'approved',
              child: Text(
                AppLocalizations.of(context)!.statusApprovedShift,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ),
            DropdownMenuItem(
              value: 'completed',
              child: Text(
                AppLocalizations.of(context)!.statusCompletedShift,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(
            BauhausDesign.space4,
            BauhausDesign.space3,
            BauhausDesign.space4,
            0,
          ),
          child: BauhausSearchBar(
            controller: _searchController,
            hintText: AppLocalizations.of(context)!.searchShiftsHint,
            onChanged: (value) => setState(() => _searchQuery = value.trim()),
            onClear: () => setState(() {
              _searchQuery = '';
              _searchController.clear();
            }),
          ),
        ),
        Expanded(
          child: _shifts.isEmpty ? _buildEmptyState() : _buildShiftsList(),
        ),
      ],
    );
  }

  Widget _buildWeekNavigator() {
    final startOfWeek = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final dateFormat = DateFormat(
      'MMM d',
      AppLocalizations.of(context)!.localeName,
    );

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
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
                style: BauhausDesign.getTextTheme(context).titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
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
        actionLabel: widget.isAdmin
            ? AppLocalizations.of(context)!.createShift
            : null,
        onAction: widget.isAdmin ? _showCreateShiftDialog : null,
      ),
    );
  }

  Widget _buildShiftsList() {
    // Text search across employee/client names and emails
    final query = _searchQuery.toLowerCase();
    final visibleShifts = query.isEmpty
        ? _shifts
        : _shifts.where((shift) {
            return (shift.employeeName ?? '').toLowerCase().contains(query) ||
                (shift.employeeEmail ?? '').toLowerCase().contains(query) ||
                (shift.clientName ?? '').toLowerCase().contains(query) ||
                (shift.clientEmail ?? '').toLowerCase().contains(query);
          }).toList();

    // Group shifts by date
    final groupedShifts = <String, List<ShiftModel>>{};
    for (final shift in visibleShifts) {
      final dateKey = DateFormat('yyyy-MM-dd').format(shift.startTime);
      groupedShifts.putIfAbsent(dateKey, () => []).add(shift);
    }

    final sortedDates = groupedShifts.keys.toList()..sort();

    if (sortedDates.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space8),
          child: BauhausEmptyState(
            title: AppLocalizations.of(context)!.noMatchingShifts,
            message: AppLocalizations.of(context)!.noMatchingShiftsMessage,
            icon: Icons.search_off,
          ),
        ),
      );
    }

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
    final isToday =
        DateFormat('yyyy-MM-dd').format(date) ==
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
            DateFormat(
              'EEE, MMM d',
              AppLocalizations.of(context)!.localeName,
            ).format(date),
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.surface,
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
              color: BauhausDesign.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.accent),
            ),
            child: Text(
              'TODAY',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildShiftCard(ShiftModel shift) {
    final timeFormat = DateFormat(
      'h:mm a',
      AppLocalizations.of(context)!.localeName,
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                // Time column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeFormat.format(shift.startTime),
                      style: BauhausDesign.getTextTheme(context).titleMedium
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    Text(
                      timeFormat.format(shift.endTime),
                      style: BauhausDesign.getTextTheme(context).bodySmall
                          ?.copyWith(
                            color: BauhausDesign.accent,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),

                // Vertical divider
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3,
                  ),
                  width: 2,
                  height: 40,
                  decoration: BoxDecoration(color: statusColor),
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
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: shift.employeeEmail != null
                                  ? Theme.of(context).colorScheme.onSurface
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
                  text:
                      shift.status.value[0].toUpperCase() +
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
            if (widget.isAdmin &&
                shift.status != ShiftStatus.completed &&
                shift.status != ShiftStatus.cancelled) ...[
              const SizedBox(height: BauhausDesign.space3),
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Cancel & bill',
                      icon: Icons.cancel_outlined,
                      variant: BauhausActionVariant.warning,
                      isSmall: true,
                      onPressed: () => _showCancellationDialog(shift),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Provider travel',
                      icon: Icons.route_outlined,
                      variant: BauhausActionVariant.secondary,
                      isSmall: true,
                      onPressed: () => _showProviderTravelDialog(shift),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _disposeAfterDialog(List<VoidCallback> disposers) {
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      for (final dispose in disposers) {
        dispose();
      }
    });
  }

  Future<void> _showCancellationDialog(ShiftModel shift) async {
    final now = DateTime.now();
    final noticeHours = shift.startTime.difference(now).inMinutes / 60.0;
    final noticeController = TextEditingController(
      text: (noticeHours < 0 ? 0 : noticeHours).toStringAsFixed(1),
    );
    String reason = 'NSCC';
    bool isSaving = false;
    String? error;
    final api = ref.read(app_providers.apiMethodProvider);

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.cancelAndBill),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${shift.clientName ?? shift.clientEmail ?? 'Participant'} · '
                '${DateFormat('d MMM, h:mm a').format(shift.startTime)}',
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: reason,
                decoration: InputDecoration(
                  labelText: 'Cancellation reason',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'NSCC',
                    child: Text(AppLocalizations.of(context)!.nsccShortNotice),
                  ),
                  DropdownMenuItem(
                    value: 'NSDH',
                    child: Text(AppLocalizations.of(context)!.nsdhDidNotShow),
                  ),
                ],
                onChanged: isSaving
                    ? null
                    : (value) => setDialogState(() => reason = value ?? 'NSCC'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noticeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Notice (hours)',
                  border: OutlineInputBorder(),
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(
                  error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: isSaving
                  ? null
                  : () => Navigator.of(dialogContext).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            FilledButton(
              onPressed: isSaving
                  ? null
                  : () async {
                      setDialogState(() {
                        isSaving = true;
                        error = null;
                      });
                      final response = await api.createCancellationCharge(
                        shiftId: shift.id,
                        reason: reason,
                        noticeHours: double.tryParse(
                          noticeController.text.trim(),
                        ),
                      );
                      if (!dialogContext.mounted) return;
                      if (response['success'] == true) {
                        Navigator.of(dialogContext).pop(true);
                        final data = response['data'];
                        final billable = data is Map ? data['billable'] : null;
                        final amount = data is Map
                            ? (data['amount'] as num?)?.toDouble()
                            : null;
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                billable == true
                                    ? 'Cancellation invoiced'
                                          '${amount != null ? ' · \$${amount.toStringAsFixed(2)}' : ''}.'
                                    : response['message']?.toString() ??
                                          'Shift cancelled. No fee applied.',
                              ),
                            ),
                          );
                        }
                      } else {
                        setDialogState(() {
                          isSaving = false;
                          error =
                              response['message']?.toString() ??
                              'Cancellation billing failed.';
                        });
                      }
                    },
              child: Text(AppLocalizations.of(context)!.billCancellation),
            ),
          ],
        ),
      ),
    );

    _disposeAfterDialog([noticeController.dispose]);
    if (result == true) await _loadShifts();
  }

  Future<Map<String, String>?> _findTravelSupportItem(ShiftModel shift) async {
    if (shift.supportItems.isEmpty) return null;
    final supportNumber = shift.supportItems.first.itemNumber;
    final parts = supportNumber.split('_');
    final category = parts.isNotEmpty ? parts[0] : '';
    final registrationGroup = parts.length > 2 ? parts[2] : '';
    final api = ref.read(app_providers.apiMethodProvider);
    final items = await api.getAllSupportItems();

    for (final item in items) {
      final name = (item['supportItemName'] ?? item['Support Item Name'] ?? '')
          .toString()
          .toLowerCase();
      if (!name.contains('provider travel') || !name.contains('non-labour')) {
        continue;
      }
      final number =
          (item['supportItemNumber'] ?? item['Support Item Number'] ?? '')
              .toString();
      final itemParts = number.split('_');
      if (category.isNotEmpty &&
          itemParts.isNotEmpty &&
          itemParts[0] != category) {
        continue;
      }
      if (registrationGroup.isNotEmpty &&
          itemParts.length > 2 &&
          itemParts[2] != registrationGroup) {
        continue;
      }
      return {
        'number': number,
        'name': (item['supportItemName'] ?? item['Support Item Name'] ?? '')
            .toString(),
      };
    }
    // Core-support catalogues follow the pattern
    // <category>_799_<registrationGroup>_1_1 for non-labour travel. Use it as a
    // fallback when the catalog list is paginated or the travel row is absent.
    if (category.isNotEmpty && registrationGroup.isNotEmpty) {
      return {
        'number': '${category}_799_${registrationGroup}_1_1',
        'name': 'Provider travel - non-labour costs',
      };
    }
    return null;
  }

  Future<void> _showProviderTravelDialog(ShiftModel shift) async {
    if (shift.employeeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.assignWorkerBeforeBillingTravel)),
      );
      return;
    }

    final repo = ref.read(mileageRepositoryProvider);
    List<Trip> trips = const [];
    try {
      final start = shift.startTime.subtract(const Duration(days: 1));
      final end = shift.endTime.add(const Duration(days: 1));
      trips = await repo.getTrips(
        shift.employeeId!,
        startDate: DateFormat('yyyy-MM-dd').format(start),
        endDate: DateFormat('yyyy-MM-dd').format(end),
      );
    } catch (e) {
      debugPrint('Provider travel: failed to load trips: $e');
    }

    final matched = trips.where((trip) {
      if (trip.status.toUpperCase() != 'APPROVED') return false;
      if (!trip.isReimbursable) return false;
      if (shift.clientId != null &&
          trip.clientId != null &&
          trip.clientId != shift.clientId) {
        return false;
      }
      return true;
    }).toList();

    Map<String, String>? travelItem;
    try {
      travelItem = await _findTravelSupportItem(shift);
    } catch (e) {
      debugPrint('Provider travel: support item lookup failed: $e');
    }
    if (!mounted) return;

    final selected = matched.map((trip) => trip.id).toSet();
    final selectedKm = matched
        .where((trip) => selected.contains(trip.id))
        .fold<double>(0, (sum, trip) => sum + trip.distance);
    final kmController = TextEditingController(
      text: selectedKm.toStringAsFixed(2),
    );
    final minutesController = TextEditingController(text: '0');
    final nonLabourController = TextEditingController(
      text: travelItem?['number'] ?? '',
    );
    final labourController = TextEditingController();
    bool isSaving = false;
    String? error;
    final api = ref.read(app_providers.apiMethodProvider);

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          void recalculateKm() {
            final total = matched
                .where((trip) => selected.contains(trip.id))
                .fold<double>(0, (sum, trip) => sum + trip.distance);
            kmController.text = total.toStringAsFixed(2);
          }

          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.providerTravel),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${matched.length} approved trip(s) found for this worker.',
                    ),
                    if (matched.isNotEmpty)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 180),
                        child: ListView(
                          shrinkWrap: true,
                          children: matched
                              .map(
                                (trip) => CheckboxListTile(
                                  dense: true,
                                  value: selected.contains(trip.id),
                                  title: Text(
                                    '${trip.startLocation} → ${trip.endLocation}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    '${DateFormat('d MMM').format(trip.date)} · '
                                    '${trip.distance.toStringAsFixed(2)} km',
                                  ),
                                  onChanged: isSaving
                                      ? null
                                      : (value) {
                                          setDialogState(() {
                                            if (value == true) {
                                              selected.add(trip.id);
                                            } else {
                                              selected.remove(trip.id);
                                            }
                                            recalculateKm();
                                          });
                                        },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: kmController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Km',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: minutesController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Travel minutes (optional)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nonLabourController,
                      decoration: const InputDecoration(
                        labelText: 'Non-labour travel support item',
                        hintText: '01_799_...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: labourController,
                      decoration: const InputDecoration(
                        labelText: 'Labour travel support item (optional)',
                        hintText: 'Required only when billing minutes',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (travelItem == null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'No matching provider-travel item was found for this '
                        'support category. Enter the NDIS item number manually.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    if (error != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        setDialogState(() {
                          isSaving = true;
                          error = null;
                        });
                        final response = await api
                            .createProviderTravelFromTrips(
                              shiftId: shift.id,
                              minutes:
                                  double.tryParse(
                                    minutesController.text.trim(),
                                  ) ??
                                  0,
                              labourSupportNumber: labourController.text.trim(),
                              nonLabourSupportNumber: nonLabourController.text
                                  .trim(),
                              nonLabourSupportName: travelItem?['name'],
                            );
                        if (!dialogContext.mounted) return;
                        if (response['success'] == true) {
                          Navigator.of(dialogContext).pop(true);
                          if (mounted) {
                            final data = response['data'];
                            final amount = data is Map
                                ? (data['amount'] as num?)?.toDouble()
                                : null;
                            final km = data is Map
                                ? (data['km'] as num?)?.toDouble()
                                : null;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Provider travel invoiced from approved trips'
                                  '${km != null ? ' · ${km.toStringAsFixed(2)} km' : ''}'
                                  '${amount != null ? ' · \$${amount.toStringAsFixed(2)}' : ''}.',
                                ),
                              ),
                            );
                          }
                        } else {
                          setDialogState(() {
                            isSaving = false;
                            error =
                                response['message']?.toString() ??
                                'Automatic travel billing failed.';
                          });
                        }
                      },
                child: Text(AppLocalizations.of(context)!.autoBillTrips),
              ),
              TextButton(
                onPressed: isSaving
                    ? null
                    : () => Navigator.of(dialogContext).pop(false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              FilledButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        setDialogState(() {
                          isSaving = true;
                          error = null;
                        });
                        final response = await api.createProviderTravelCharge(
                          shiftId: shift.id,
                          km: double.tryParse(kmController.text.trim()) ?? 0,
                          minutes:
                              double.tryParse(minutesController.text.trim()) ??
                              0,
                          nonLabourSupportNumber: nonLabourController.text
                              .trim(),
                          nonLabourSupportName: travelItem?['name'],
                          labourSupportNumber: labourController.text.trim(),
                        );
                        if (!dialogContext.mounted) return;
                        if (response['success'] == true) {
                          Navigator.of(dialogContext).pop(true);
                          if (mounted) {
                            final data = response['data'];
                            final amount = data is Map
                                ? (data['amount'] as num?)?.toDouble()
                                : null;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Provider travel invoiced'
                                  '${amount != null ? ' · \$${amount.toStringAsFixed(2)}' : ''}.',
                                ),
                              ),
                            );
                          }
                        } else {
                          setDialogState(() {
                            isSaving = false;
                            error =
                                response['message']?.toString() ??
                                'Provider travel billing failed.';
                          });
                        }
                      },
                child: Text(AppLocalizations.of(context)!.billTravel),
              ),
            ],
          );
        },
      ),
    );

    _disposeAfterDialog([
      kmController.dispose,
      minutesController.dispose,
      nonLabourController.dispose,
      labourController.dispose,
    ]);
    if (result == true) await _loadShifts();
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
class _CreateShiftDialog extends ConsumerStatefulWidget {
  final String organizationId;
  final VoidCallback onCreated;

  const _CreateShiftDialog({
    required this.organizationId,
    required this.onCreated,
  });

  @override
  ConsumerState<_CreateShiftDialog> createState() => _CreateShiftDialogState();
}

class _CreateShiftDialogState extends ConsumerState<_CreateShiftDialog> {
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

      final api = ref.read(app_providers.apiMethodProvider);
      final clientsFuture = api.getClientsByOrganizationId(
        widget.organizationId,
      );
      final employeesFuture = api.getOrganizationEmployees(
        widget.organizationId,
      );

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
            debugPrint(
              'No clients found in response. Raw result: ${results[0]}',
            );
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
        final api = ref.read(app_providers.apiMethodProvider);
        final allClients = await api.fetchClientData();
        if (mounted) {
          setState(() {
            _clients = allClients
                .map(
                  (c) => {
                    'firstName': c.clientFirstName,
                    'lastName': c.clientLastName,
                    'email': c.clientEmail,
                    'phone': c.clientPhone,
                    '_id': c.id,
                  },
                )
                .toList();
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

    final normalizedEndDateTime = endDateTime.isBefore(startDateTime)
        ? endDateTime.add(const Duration(days: 1))
        : endDateTime;

    if (!normalizedEndDateTime.isAfter(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.startBeforeEnd),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final Map<String, dynamic> shiftData = {
      'organizationId': widget.organizationId,
      'clientEmail': _selectedClientEmail,
      'startTime': startDateTime.toIso8601String(),
      'endTime': normalizedEndDateTime.toIso8601String(),
      'notes': _notesController.text.trim(),
      'status': _selectedEmployeeEmail != null ? 'approved' : 'pending',
    };

    if (_selectedEmployeeEmail != null) {
      shiftData['employeeEmail'] = _selectedEmployeeEmail;
    }

    final api = ref.read(app_providers.apiMethodProvider);
    final result = await api.createShift(shiftData);

    if (mounted) {
      setState(() => _isLoading = false);

      if (result['success'] == true) {
        widget.onCreated();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['error']?.toString() ??
                  AppLocalizations.of(context)!.failedToCreateShift,
            ),
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
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
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
                    color: BauhausDesign.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(color: BauhausDesign.error),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: BauhausDesign.error,
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Text(
                          'No clients found for this organization.',
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).bodyMedium?.copyWith(color: BauhausDesign.error),
                        ),
                      ),
                    ],
                  ),
                )
              else
                DropdownButtonFormField<String>(
                  initialValue: _selectedClientEmail,
                  decoration:
                      BauhausDesign.inputDecoration(
                        context,
                        AppLocalizations.of(context)!.clientEmailLabel,
                      ).copyWith(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                      ),
                  items: _clients
                      .map((client) {
                        final name =
                            '${client['firstName']} ${client['lastName']}';
                        final email =
                            client['email'] as String?; // Handle potential null
                        if (email == null) return null; // Skip if email is null

                        return DropdownMenuItem<String>(
                          value: email,
                          child: Text(
                            '$name ($email)',
                            overflow: TextOverflow.ellipsis,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                          ),
                        );
                      })
                      .whereType<DropdownMenuItem<String>>()
                      .toList(), // Filter out nulls
                  onChanged: (value) =>
                      setState(() => _selectedClientEmail = value),
                  validator: (value) => value == null
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  dropdownColor: Theme.of(context).colorScheme.surface,
                ),
              const SizedBox(height: BauhausDesign.space4),
              if (!_isFetchingData) ...[
                DropdownButtonFormField<String>(
                  initialValue: _selectedEmployeeEmail,
                  decoration:
                      BauhausDesign.inputDecoration(
                        context,
                        'Assign Employee (Optional)',
                      ).copyWith(
                        prefixIcon: Icon(
                          Icons.badge,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                      ),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text(AppLocalizations.of(context)!.unassigned),
                    ),
                    ..._employees.map(
                      (emp) {
                        final name = '${emp['firstName']} ${emp['lastName']}';
                        final email =
                            emp['email'] as String?; // Handle potential null
                        if (email == null) return null; // Skip if email is null

                        return DropdownMenuItem<String>(
                          value: email,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                          ),
                        );
                      },
                    ).whereType<DropdownMenuItem<String>>(), // Filter out nulls
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedEmployeeEmail = value),
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  dropdownColor: Theme.of(context).colorScheme.surface,
                ),
                const SizedBox(height: BauhausDesign.space4),
              ],
              const SizedBox(height: BauhausDesign.space4),
              Text(
                AppLocalizations.of(context)!.dateTimeLabel,
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: BauhausDesign.space2),
              GestureDetector(
                onTap: () async {
                  final date = await showBauhausDatePicker(
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
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        DateFormat(
                          'MMM dd, yyyy',
                          AppLocalizations.of(context)!.localeName,
                        ).format(_selectedDate),
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
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
                    child: Text(
                      AppLocalizations.of(context)!.cancelButton,
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
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
    String label,
    TimeOfDay time,
    Function(TimeOfDay) onChanged,
  ) {
    return GestureDetector(
      onTap: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) {
            return Theme(data: Theme.of(context), child: child!);
          },
        );
        if (newTime != null) {
          onChanged(newTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: BauhausDesign.space2),
            Text(
              time.format(context),
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
