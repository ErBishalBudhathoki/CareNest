import 'package:carenest/app/features/leave/viewmodels/leave_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:intl/intl.dart';

class LeaveRequestForm extends ConsumerStatefulWidget {
  final String userEmail;

  const LeaveRequestForm({super.key, required this.userEmail});

  @override
  ConsumerState<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends ConsumerState<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedLeaveType;
  DateTimeRange? _selectedDateRange;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _totalHoursController = TextEditingController();

  final List<String> _leaveTypes = [
    'Annual Leave',
    'Personal / Carer\'s Leave',
    'Long Service Leave',
    'Unpaid Leave',
    'Compassionate Leave'
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    _totalHoursController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedLeaveType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a leave type')));
      return;
    }
    if (_selectedDateRange == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select dates')));
      return;
    }

    final viewModel = ref.read(leaveViewModelProvider(widget.userEmail).notifier);
    final success = await viewModel.submitRequest(
      leaveType: _selectedLeaveType!,
      startDate: _selectedDateRange!.start,
      endDate: _selectedDateRange!.end,
      reason: _reasonController.text,
      totalHours: double.tryParse(_totalHoursController.text) ?? 0.0,
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Leave request submitted')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ref.read(leaveViewModelProvider(widget.userEmail)).errorMessage ?? 'Failed to submit')));
      }
    }
  }

  Future<void> _calculateHours() async {
    if (_selectedDateRange != null) {
      final viewModel = ref.read(leaveViewModelProvider(widget.userEmail).notifier);
      final hours = await viewModel.calculateLeaveHours(
        _selectedDateRange!.start,
        _selectedDateRange!.end,
      );
      if (mounted) {
        _totalHoursController.text = hours.toStringAsFixed(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(leaveViewModelProvider(widget.userEmail));

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.newRequestTitle,
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        centerTitle: true,
        elevation: 0,
        leading: BauhausIconButton(
          icon: Icons.close,
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(AppLocalizations.of(context)!.leaveTypeLabel),
              const SizedBox(height: BauhausDesign.space1),
              DropdownButtonFormField<String>(
                value: _selectedLeaveType,
                decoration: BauhausDesign.inputDecoration(AppLocalizations.of(context)!.selectLeaveTypeHint),
                dropdownColor: BauhausDesign.surfaceWhite,
                items: _leaveTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type,
                        style: BauhausDesign.getTextTheme(context).bodyMedium),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedLeaveType = val),
              ),
              const SizedBox(height: BauhausDesign.space4),
              _buildLabel(AppLocalizations.of(context)!.datesLabel),
              const SizedBox(height: BauhausDesign.space1),
              InkWell(
                onTap: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: BauhausDesign.primary,
                            onPrimary: BauhausDesign.surfaceWhite,
                            onSurface: BauhausDesign.textDark,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDateRange = picked;
                    });
                    await _calculateHours();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDateRange == null
                            ? AppLocalizations.of(context)!.selectDateRangeLabel
                            : "${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}",
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                              color: _selectedDateRange == null
                                  ? BauhausDesign.textMuted
                                  : BauhausDesign.textDark,
                            ),
                      ),
                      const Icon(Icons.calendar_today,
                          color: BauhausDesign.textMuted),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausTextField(
                controller: _totalHoursController,
                label: AppLocalizations.of(context)!.totalHoursEstimatedLabel,
                hintText: "0.00",
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'Please enter total hours';
                  return null;
                },
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausTextField(
                controller: _reasonController,
                label: AppLocalizations.of(context)!.reasonLabel,
                hintText: AppLocalizations.of(context)!.reasonHint,
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'Please enter a reason';
                  return null;
                },
              ),
              const SizedBox(height: BauhausDesign.space6),
              BauhausActionButton(
                text: AppLocalizations.of(context)!.submitRequestButton,
                onPressed: viewModel.isLoading ? null : _submitRequest,
                isLoading: viewModel.isLoading,
                variant: BauhausActionVariant.success,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
