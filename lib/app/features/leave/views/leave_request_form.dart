import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LeaveRequestForm extends ConsumerStatefulWidget {
  final String userEmail;

  const LeaveRequestForm({super.key, required this.userEmail});

  @override
  ConsumerState<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends ConsumerState<LeaveRequestForm> {
  final ApiMethod apiMethod = ApiMethod();
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedLeaveType;
  DateTimeRange? _selectedDateRange;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _totalHoursController = TextEditingController();
  
  bool _isLoading = false;

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a leave type')));
      return;
    }
    if (_selectedDateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select dates')));
      return;
    }

    setState(() => _isLoading = true);

    final result = await apiMethod.submitLeaveRequest(
      userEmail: widget.userEmail,
      leaveType: _selectedLeaveType!,
      startDate: _selectedDateRange!.start,
      endDate: _selectedDateRange!.end,
      reason: _reasonController.text,
      totalHours: double.tryParse(_totalHoursController.text) ?? 0.0,
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request submitted')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Failed to submit')));
      }
    }
  }

  void _calculateHours() {
    if (_selectedDateRange != null) {
      final days = _selectedDateRange!.duration.inDays + 1;
      // Simple assumption: 7.6 hours per day for full time
      // This should ideally be smarter or user-editable
      final hours = days * 7.6;
      _totalHoursController.text = hours.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: Text(
          'NEW REQUEST',
          style: GoogleFonts.oswald(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: BauhausDesign.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.textDark, height: 2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("LEAVE TYPE"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedLeaveType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: BauhausDesign.surfaceLight,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BauhausDesign.textDark, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BauhausDesign.primary, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                dropdownColor: BauhausDesign.surfaceLight,
                items: _leaveTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type, style: GoogleFonts.inter(color: BauhausDesign.textDark)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedLeaveType = val),
              ),

              const SizedBox(height: 24),
              _buildLabel("DATES"),
              const SizedBox(height: 8),
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
                            primary: BauhausDesign.textDark,
                            onPrimary: BauhausDesign.surfaceLight,
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
                      _calculateHours();
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: BauhausDesign.textDark, width: 2),
                    color: BauhausDesign.surfaceLight,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDateRange == null
                            ? "Select Date Range"
                            : "${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}",
                        style: GoogleFonts.inter(
                          color: _selectedDateRange == null ? BauhausDesign.neutral : BauhausDesign.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: BauhausDesign.textDark),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              _buildLabel("TOTAL HOURS (ESTIMATED)"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _totalHoursController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: GoogleFonts.inter(color: BauhausDesign.textDark),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: BauhausDesign.surfaceLight,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BauhausDesign.textDark, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BauhausDesign.primary, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: "0.00",
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter total hours';
                  return null;
                },
              ),

              const SizedBox(height: 24),
              _buildLabel("REASON"),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                style: GoogleFonts.inter(color: BauhausDesign.textDark),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: BauhausDesign.surfaceLight,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BauhausDesign.textDark, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: BauhausDesign.primary, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: "Reason for leave...",
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter a reason';
                  return null;
                },
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BauhausDesign.success,
                    foregroundColor: BauhausDesign.textDark, // High contrast
                    shape: const RoundedRectangleBorder(),
                    side: const BorderSide(color: BauhausDesign.textDark, width: 2),
                    elevation: 0,
                  ),
                  onPressed: _isLoading ? null : _submitRequest,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: BauhausDesign.textDark)
                      : Text(
                          "SUBMIT REQUEST",
                          style: GoogleFonts.oswald(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                ),
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
      style: GoogleFonts.oswald(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: BauhausDesign.textDark,
      ),
    );
  }
}
