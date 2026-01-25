import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../viewmodels/payroll_export_viewmodel.dart';

class AdminPayrollExportView extends ConsumerStatefulWidget {
  final String organizationId;

  const AdminPayrollExportView({
    super.key,
    required this.organizationId,
  });

  @override
  ConsumerState<AdminPayrollExportView> createState() =>
      _AdminPayrollExportViewState();
}

class _AdminPayrollExportViewState extends ConsumerState<AdminPayrollExportView> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 14));
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(payrollExportViewModelProvider);

    // Listen for errors
    ref.listen<AsyncValue<void>>(payrollExportViewModelProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
      final prevLoading = previous?.isLoading ?? false;
      if (!next.isLoading && !next.hasError && prevLoading) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Export generated successfully'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'PAYROLL EXPORT',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Pay Period',
              style: BauhausDesign.getTextTheme(context).headlineMedium,
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Choose the date range for the payroll export.',
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
            const SizedBox(height: BauhausDesign.space8),

            // Date Range Picker Card
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Column(
                children: [
                  _buildDateSelector(
                    context,
                    label: 'START DATE',
                    date: _startDate,
                    onTap: () => _selectDate(context, true),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  const Icon(Icons.arrow_downward, color: BauhausDesign.neutral),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildDateSelector(
                    context,
                    label: 'END DATE',
                    date: _endDate,
                    onTap: () => _selectDate(context, false),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Export Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: BauhausDesign.textDark, // Ensure textDark on light/primary
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    side: const BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                  elevation: 0,
                ),
                onPressed: state.isLoading
                    ? null
                    : () {
                        ref
                            .read(payrollExportViewModelProvider.notifier)
                            .exportPayroll(
                              startDate: _startDate,
                              endDate: _endDate,
                              organizationId: widget.organizationId,
                            );
                      },
                child: state.isLoading
                    ? const CircularProgressIndicator(color: BauhausDesign.textDark)
                    : Text(
                        'EXPORT CSV',
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context,
      {required String label, required DateTime date, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          color: BauhausDesign.backgroundLight,
          border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.neutral,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM dd, yyyy').format(date),
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
            const Icon(Icons.calendar_today, color: BauhausDesign.textDark),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.textDark,
              surface: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
          if (_startDate.isAfter(_endDate)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }
}
