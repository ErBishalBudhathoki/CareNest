import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

class ComplianceAutomationDashboard extends StatefulWidget {
  final String? organizationId;

  const ComplianceAutomationDashboard({super.key, this.organizationId});

  @override
  State<ComplianceAutomationDashboard> createState() =>
      _ComplianceAutomationDashboardState();
}

class _ComplianceAutomationDashboardState
    extends State<ComplianceAutomationDashboard> {
  final bool _isLoading = false;

  // Mock data
  final int _complianceScore = 87;
  final String _riskLevel = 'low';
  final int _expiringDocs = 3;
  final int _criticalIssues = 0;
  final int _warnings = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.textDark,
        title: Text(
          'COMPLIANCE AUTOMATION',
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
                  BauhausSectionHeader(title: 'COMPLIANCE TOOLS'),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Run Compliance Scan',
                    description: 'Scan all workers for compliance issues',
                    icon: Icons.scanner_outlined,
                    color: BauhausDesign.primary,
                    onTap: _runComplianceScan,
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Expiring Documents',
                    description: 'View documents expiring soon',
                    icon: Icons.warning_amber_outlined,
                    color: BauhausDesign.warning,
                    onTap: _viewExpiringDocuments,
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'Generate Report',
                    description: 'Create compliance audit report',
                    icon: Icons.description_outlined,
                    color: BauhausDesign.secondary,
                    onTap: _generateReport,
                  ),
                  const SizedBox(height: 16),

                  _buildFeatureCard(
                    title: 'View Trends',
                    description: 'Analyze compliance trends over time',
                    icon: Icons.trending_up_outlined,
                    color: BauhausDesign.success,
                    onTap: _viewTrends,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      _ComplianceStatItem(
        label: 'Score',
        value: '$_complianceScore%',
        icon: Icons.verified_user_outlined,
        color: _getScoreColor(_complianceScore),
      ),
      _ComplianceStatItem(
        label: 'Risk Level',
        value: _riskLevel.toUpperCase(),
        icon: Icons.shield_outlined,
        color: _getRiskColor(_riskLevel),
      ),
      _ComplianceStatItem(
        label: 'Expiring',
        value: '$_expiringDocs',
        icon: Icons.schedule_outlined,
        color: BauhausDesign.warning,
      ),
      _ComplianceStatItem(
        label: 'Critical',
        value: '$_criticalIssues',
        icon: Icons.error_outline,
        color: BauhausDesign.error,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(title: 'COMPLIANCE OVERVIEW'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 860 ? 2 : 1;
            final cardWidth = columns == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - 16) / 2;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: stats
                  .map(
                    (stat) => SizedBox(
                      width: cardWidth,
                      child: _buildStatCard(
                        label: stat.label,
                        value: stat.value,
                        icon: stat.icon,
                        color: stat.color,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
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
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelSmall?.copyWith(color: BauhausDesign.textDark),
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: BauhausDesign.getTextTheme(context).headlineMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 500;
              final leadingIcon = Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, color: color, size: 24),
              );

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        leadingIcon,
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward,
                          color: BauhausDesign.textDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title.toUpperCase(),
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(color: BauhausDesign.textDark),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  leadingIcon,
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.toUpperCase(),
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).bodySmall?.copyWith(color: BauhausDesign.textDark),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: BauhausDesign.textDark,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 85) return BauhausDesign.success;
    if (score >= 70) return BauhausDesign.warning;
    return BauhausDesign.error;
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return BauhausDesign.success;
      case 'medium':
        return BauhausDesign.warning;
      case 'high':
      case 'critical':
        return BauhausDesign.error;
      default:
        return BauhausDesign.neutral;
    }
  }

  void _runComplianceScan() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Running compliance scan...')));
  }

  void _viewExpiringDocuments() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading expiring documents...')),
    );
  }

  void _generateReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generating compliance report...')),
    );
  }

  void _viewTrends() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading compliance trends...')),
    );
  }
}

class _ComplianceStatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  _ComplianceStatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}
