import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

class InvoiceAIDashboard extends StatelessWidget {
  final String? organizationId;

  const InvoiceAIDashboard({
    super.key,
    this.organizationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.textDark,
        title: Text(
          'SMART INVOICING',
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.surfaceWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            BauhausCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withOpacity(0.1),
                        border: Border.all(
                          color: BauhausDesign.primary,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: BauhausDesign.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI-POWERED INVOICING',
                            style: BauhausDesign.getTextTheme(context)
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Automated validation, error detection, and payment predictions',
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: BauhausDesign.neutral,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'ERRORS DETECTED',
                    value: '3',
                    icon: Icons.error_outline,
                    color: BauhausDesign.error,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'AUTO-GENERATED',
                    value: '24',
                    icon: Icons.auto_awesome,
                    color: BauhausDesign.success,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'AVG PAYMENT',
                    value: '28d',
                    icon: Icons.schedule,
                    color: BauhausDesign.secondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'ACCURACY',
                    value: '96%',
                    icon: Icons.check_circle_outline,
                    color: BauhausDesign.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Features Section
            BauhausSectionHeader(title: 'FEATURES'),
            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              title: 'Auto-Generate Invoices',
              description: 'Automatically create invoices from completed appointments',
              icon: Icons.receipt_long,
              color: BauhausDesign.primary,
              onTap: () {
                _showAutoGenerateDialog(context);
              },
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              title: 'Error Detection',
              description: 'AI-powered validation to catch billing errors',
              icon: Icons.search,
              color: BauhausDesign.warning,
              onTap: () {
                _showErrorDetectionDialog(context);
              },
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              title: 'Payment Predictions',
              description: 'Predict when clients will pay based on history',
              icon: Icons.trending_up,
              color: BauhausDesign.secondary,
              onTap: () {
                _showPaymentPredictionDialog(context);
              },
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              title: 'Smart Reminders',
              description: 'Optimal timing for payment reminders',
              icon: Icons.notifications_active,
              color: BauhausDesign.success,
              onTap: () {
                _showSmartRemindersDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
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
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, color: color, size: 28),
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
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.neutral,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                color: BauhausDesign.neutral,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAutoGenerateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AUTO-GENERATE INVOICES'),
        content: const Text(
          'This feature will automatically generate invoices from completed appointments. '
          'Please select a date range to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Auto-generate feature requires appointment data'),
                ),
              );
            },
            child: const Text('CONTINUE'),
          ),
        ],
      ),
    );
  }

  void _showErrorDetectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ERROR DETECTION'),
        content: const Text(
          'AI will scan your invoices for common errors like incorrect amounts, '
          'missing fields, and tax calculation issues.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPaymentPredictionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PAYMENT PREDICTIONS'),
        content: const Text(
          'Based on client payment history, we predict when invoices will be paid '
          'and identify high-risk late payments.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSmartRemindersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SMART REMINDERS'),
        content: const Text(
          'AI determines the optimal time to send payment reminders based on '
          'client behavior and payment patterns.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
