import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

class SmartExpenseDashboard extends StatefulWidget {
  final String? organizationId;

  const SmartExpenseDashboard({
    super.key,
    this.organizationId,
  });

  @override
  State<SmartExpenseDashboard> createState() => _SmartExpenseDashboardState();
}

class _SmartExpenseDashboardState extends State<SmartExpenseDashboard> {
  final bool _isLoading = false;

  // Mock data
  final int _scannedReceipts = 45;
  final int _autoCategorized = 42;
  final int _policyViolations = 3;
  final double _totalAmount = 1234.56;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.textDark,
        title: Text(
          'SMART EXPENSE MANAGEMENT',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.surfaceWhite),
      ),
      body: _isLoading
          ? const Center(child: BauhausLoadingState())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards
                  _buildStatsSection(),
                  const SizedBox(height: 32),

                  // Feature Cards
                  BauhausSectionHeader(title: 'EXPENSE TOOLS'),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Scan Receipt',
                    description: 'Use OCR to extract receipt data',
                    icon: Icons.camera_alt_outlined,
                    color: BauhausDesign.primary,
                    onTap: _scanReceipt,
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Categorize Expense',
                    description: 'AI-powered expense categorization',
                    icon: Icons.category_outlined,
                    color: BauhausDesign.secondary,
                    onTap: _categorizeExpense,
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Policy Check',
                    description: 'Validate against expense policy',
                    icon: Icons.policy_outlined,
                    color: BauhausDesign.warning,
                    onTap: _checkPolicy,
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Calculate Mileage',
                    description: 'GPS-based mileage calculation',
                    icon: Icons.route_outlined,
                    color: BauhausDesign.success,
                    onTap: _calculateMileage,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(title: 'EXPENSE OVERVIEW'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                label: 'Scanned',
                value: '$_scannedReceipts',
                icon: Icons.receipt_outlined,
                color: BauhausDesign.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                label: 'Auto-Categorized',
                value: '$_autoCategorized',
                icon: Icons.auto_awesome_outlined,
                color: BauhausDesign.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                label: 'Violations',
                value: '$_policyViolations',
                icon: Icons.warning_outlined,
                color: BauhausDesign.warning,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                label: 'Total',
                value: '\$${_totalAmount.toStringAsFixed(2)}',
                icon: Icons.attach_money_outlined,
                color: BauhausDesign.success,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context).labelSmall,
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return BauhausCard(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: BauhausDesign.getTextTheme(context).bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, color: BauhausDesign.textDark),
            ],
          ),
        ),
      ),
    );
  }

  void _scanReceipt() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening camera for receipt scan...')),
    );
  }

  void _categorizeExpense() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Categorizing expense...')),
    );
  }

  void _checkPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checking expense policy...')),
    );
  }

  void _calculateMileage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calculating mileage...')),
    );
  }
}
