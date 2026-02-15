import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/payroll/viewmodels/advanced_payroll_viewmodel.dart';

class AdvancedPayrollDashboard extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? userId;

  const AdvancedPayrollDashboard({
    super.key,
    this.organizationId,
    this.userId,
  });

  @override
  ConsumerState<AdvancedPayrollDashboard> createState() => _AdvancedPayrollDashboardState();
}

class _AdvancedPayrollDashboardState extends ConsumerState<AdvancedPayrollDashboard> {
  String _selectedPeriod = DateTime.now().toString().substring(0, 7); // YYYY-MM

  @override
  void initState() {
    super.initState();
    if (widget.organizationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadPayrollSummary();
      });
    }
  }

  void _loadPayrollSummary() {
    if (widget.organizationId != null) {
      ref.read(advancedPayrollViewModelProvider.notifier).getPayrollSummary(
            widget.organizationId!,
            _selectedPeriod,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(advancedPayrollViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.success,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'ADVANCED PAYROLL',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: BauhausLoadingState())
          : state.error != null
              ? Center(
                  child: BauhausEmptyState(
                    title: 'Error',
                    message: state.error!,
                    icon: Icons.error_outline,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Period Selector
                      BauhausCard(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month, color: BauhausDesign.success),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pay Period',
                                      style: BauhausDesign.getTextTheme(context).titleMedium,
                                    ),
                                    Text(
                                      _selectedPeriod,
                                      style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                                            color: BauhausDesign.neutral,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              BauhausActionButton(
                                onPressed: () => _showPeriodPicker(context),
                                text: 'CHANGE',
                                variant: BauhausActionVariant.ghost,
                                isOutlined: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Payroll Summary
                      if (state.summary != null) ...[
                        BauhausSectionHeader(title: 'PAYROLL SUMMARY'),
                        const SizedBox(height: 16),
                        BauhausCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                _buildSummaryRow(
                                  'Total Employees',
                                  state.summary!.totalEmployees.toString(),
                                  Icons.people_outline,
                                ),
                                const Divider(height: 24),
                                _buildSummaryRow(
                                  'Gross Pay',
                                  '\$${state.summary!.totalGrossPay.toStringAsFixed(2)}',
                                  Icons.attach_money,
                                ),
                                const Divider(height: 24),
                                _buildSummaryRow(
                                  'Total Tax',
                                  '\$${state.summary!.totalTax.toStringAsFixed(2)}',
                                  Icons.account_balance,
                                ),
                                const Divider(height: 24),
                                _buildSummaryRow(
                                  'Net Pay',
                                  '\$${state.summary!.totalNetPay.toStringAsFixed(2)}',
                                  Icons.payments,
                                  isHighlight: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Actions
                      BauhausSectionHeader(title: 'ACTIONS'),
                      const SizedBox(height: 16),

                      // Calculate Payroll
                      BauhausCard(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.calculate_outlined,
                                size: 48,
                                color: BauhausDesign.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Calculate Payroll',
                                style: BauhausDesign.getTextTheme(context).titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Calculate payroll with award rates and penalties',
                                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                                      color: BauhausDesign.neutral,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              BauhausActionButton(
                                onPressed: () => _calculatePayroll(),
                                text: 'CALCULATE',
                                icon: Icons.play_arrow,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Generate Payslips
                      BauhausCard(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.receipt_long_outlined,
                                size: 48,
                                color: BauhausDesign.secondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Generate Payslips',
                                style: BauhausDesign.getTextTheme(context).titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Generate payslips for all employees',
                                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                                      color: BauhausDesign.neutral,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              BauhausActionButton(
                                onPressed: () => _generatePayslips(),
                                text: 'GENERATE',
                                icon: Icons.description,
                                variant: BauhausActionVariant.secondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Export Data
                      BauhausCard(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.cloud_upload_outlined,
                                size: 48,
                                color: BauhausDesign.warning,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Export to Xero/MYOB',
                                style: BauhausDesign.getTextTheme(context).titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Export payroll data for accounting software',
                                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                                      color: BauhausDesign.neutral,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              BauhausActionButton(
                                onPressed: state.isExporting ? null : () => _exportPayroll(),
                                text: state.isExporting ? 'EXPORTING...' : 'EXPORT',
                                icon: Icons.upload_file,
                                variant: BauhausActionVariant.warning,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon, {bool isHighlight = false}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isHighlight ? BauhausDesign.success : BauhausDesign.neutral).withOpacity(0.1),
            border: Border.all(
              color: isHighlight ? BauhausDesign.success : BauhausDesign.neutral,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: isHighlight ? BauhausDesign.success : BauhausDesign.neutral,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
        ),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isHighlight ? BauhausDesign.success : BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }

  void _showPeriodPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Pay Period'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter period (YYYY-MM):'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: '2026-02',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() => _selectedPeriod = value);
                _loadPayrollSummary();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
        ],
      ),
    );
  }

  Future<void> _calculatePayroll() async {
    if (widget.organizationId == null) return;

    await ref.read(advancedPayrollViewModelProvider.notifier).calculatePayroll({
      'organizationId': widget.organizationId,
      'period': _selectedPeriod,
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payroll calculated successfully'),
          backgroundColor: BauhausDesign.success,
        ),
      );
      _loadPayrollSummary();
    }
  }

  Future<void> _generatePayslips() async {
    if (widget.organizationId == null) return;

    final success = await ref.read(advancedPayrollViewModelProvider.notifier).generatePayslips(
          widget.organizationId!,
          _selectedPeriod,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Payslips generated successfully' : 'Failed to generate payslips'),
          backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
        ),
      );
    }
  }

  Future<void> _exportPayroll() async {
    if (widget.organizationId == null) return;

    final success = await ref.read(advancedPayrollViewModelProvider.notifier).exportPayrollData({
      'organizationId': widget.organizationId,
      'period': _selectedPeriod,
      'format': 'xero', // or 'myob'
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Payroll data exported successfully' : 'Failed to export payroll data'),
          backgroundColor: success ? BauhausDesign.success : BauhausDesign.error,
        ),
      );
    }
  }
}
