import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../viewmodels/payroll_viewmodel.dart';
import '../models/payroll_model.dart';

class PayrollDashboardView extends ConsumerStatefulWidget {
  const PayrollDashboardView({super.key});

  @override
  ConsumerState<PayrollDashboardView> createState() =>
      _PayrollDashboardViewState();
}

class _PayrollDashboardViewState extends ConsumerState<PayrollDashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(payrollViewModelProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(payrollViewModelProvider);
    final notifier = ref.read(payrollViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payroll Summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: notifier.fetchSummary,
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text('Error: ${state.errorMessage}'))
          : state.summary == null
          ? const Center(child: Text('No data available'))
          : _buildContent(context, state, notifier),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PayrollState state,
    PayrollViewModel notifier,
  ) {
    final summary = state.summary!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateSelector(context, state, notifier),
          const SizedBox(height: 16),
          _buildSummaryCards(summary),
          const SizedBox(height: 24),
          _buildBreakdownSection(summary),
          const SizedBox(height: 24),
          _buildActionButtons(notifier),
          const SizedBox(height: 24),
          const Text(
            'Employee Breakdown',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildEmployeeList(summary.employees),
        ],
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context,
    PayrollState state,
    PayrollViewModel notifier,
  ) {
    final range = state.selectedDateRange;
    final format = DateFormat('MMM dd, yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 16),
            if (range != null)
              Text(
                '${format.format(range.start)} - ${format.format(range.end)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                final newRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                  initialDateRange: range,
                );
                if (newRange != null) {
                  notifier.updateDateRange(newRange);
                }
              },
              child: const Text('Change Period'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(PayrollSummary summary) {
    return GridView.count(
      crossAxisCount: 2, // Simple responsive grid
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMetricCard(
          'Total Gross Pay',
          '\$${summary.summary.totalGrossPay.toStringAsFixed(2)}',
          Icons.attach_money,
          Colors.green,
        ),
        _buildMetricCard(
          'Total Hours',
          '${summary.summary.totalHours.toStringAsFixed(2)}h',
          Icons.access_time,
          Colors.blue,
        ),
        _buildMetricCard(
          'Tax Withheld',
          '\$${summary.summary.totalTax.toStringAsFixed(2)}',
          Icons.account_balance,
          Colors.orange,
        ),
        _buildMetricCard(
          'Superannuation',
          '\$${summary.summary.totalSuper.toStringAsFixed(2)}',
          Icons.trending_up,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownSection(PayrollSummary summary) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Earnings Breakdown',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBreakdownRow('Base Pay', summary.breakdown.basePay),
            _buildBreakdownRow(
              'Saturday Penalties',
              summary.breakdown.saturdayPenalties,
            ),
            _buildBreakdownRow(
              'Sunday Penalties',
              summary.breakdown.sundayPenalties,
            ),
            _buildBreakdownRow(
              'Public Holiday',
              summary.breakdown.publicHolidayPenalties,
            ),
            _buildBreakdownRow(
              'Night Shift',
              summary.breakdown.nightShiftPenalties,
            ),
            _buildBreakdownRow(
              'Overtime (First 2h)',
              summary.breakdown.overtimeFirst2h,
            ),
            _buildBreakdownRow(
              'Overtime (After 2h)',
              summary.breakdown.overtimeAfter2h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, double value) {
    if (value == 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(PayrollViewModel notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => notifier.exportData('csv'),
          icon: const Icon(Icons.download),
          label: const Text('Export CSV'),
        ),
        OutlinedButton.icon(
          onPressed: () => notifier.exportData('json'),
          icon: const Icon(Icons.code),
          label: const Text('Export JSON'),
        ),
      ],
    );
  }

  Widget _buildEmployeeList(List<PayrollEmployee> employees) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(child: Text(employee.name.substring(0, 1))),
            title: Text(employee.name),
            subtitle: Text('${employee.hoursWorked.toStringAsFixed(2)} hrs'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${employee.grossPay.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Tax: \$${employee.tax.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            onTap: () {
              // Show detailed view for employee (Modal or navigation)
              _showEmployeeDetails(context, employee);
            },
          ),
        );
      },
    );
  }

  void _showEmployeeDetails(BuildContext context, PayrollEmployee employee) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employee.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildBreakdownRow('Gross Pay', employee.grossPay),
            _buildBreakdownRow('Tax Withheld', employee.tax),
            _buildBreakdownRow('Superannuation', employee.superAmount),
            const Divider(),
            const Text(
              'Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildBreakdownRow('Base Pay', employee.breakdown.basePay),
            _buildBreakdownRow(
              'Saturday',
              employee.breakdown.saturdayPenalties,
            ),
            _buildBreakdownRow('Sunday', employee.breakdown.sundayPenalties),
            _buildBreakdownRow(
              'Overtime',
              employee.breakdown.overtimeFirst2h +
                  employee.breakdown.overtimeAfter2h,
            ),
            if (employee.anomalies.isNotEmpty) ...[
              const Divider(),
              const Text(
                'Anomalies:',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...employee.anomalies.map(
                (a) => Text(
                  '• ${a.description}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
