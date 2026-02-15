import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

class FinancialIntelligenceDashboard extends ConsumerWidget {
  const FinancialIntelligenceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Financial Intelligence',
          style: TextStyle(
            color: AppColors.colorWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.colorWhite),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildFeatureGrid(context),
            const SizedBox(height: 24),
            _buildQuickStats(),
            const SizedBox(height: 24),
            _buildRecentInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.analytics_outlined,
              color: AppColors.colorPrimary,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Advanced Financial Intelligence',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'AI-powered revenue forecasting & predictive analytics',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666), // BauhausDesign.textMuted
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      {
        'title': 'Revenue Forecasting',
        'subtitle': '95% accuracy ML predictions',
        'icon': Icons.trending_up,
        'color': AppColors.colorBlue,
        'route': '/financial-intelligence/revenue-forecasting',
      },
      {
        'title': 'Pricing Optimization',
        'subtitle': 'Dynamic pricing & A/B testing',
        'icon': Icons.attach_money,
        'color': AppColors.colorGreen,
        'route': '/financial-intelligence/pricing',
      },
      {
        'title': 'Billing Automation',
        'subtitle': '90% error reduction',
        'icon': Icons.receipt_long,
        'color': AppColors.colorOrange,
        'route': '/financial-intelligence/billing',
      },
      {
        'title': 'Cash Flow Management',
        'subtitle': '60-day forecasting',
        'icon': Icons.account_balance_wallet,
        'color': AppColors.colorPurple,
        'route': '/financial-intelligence/cashflow',
      },
      {
        'title': 'Financial Analytics',
        'subtitle': 'Real-time dashboards & KPIs',
        'icon': Icons.bar_chart,
        'color': AppColors.colorBlue,
        'route': '/financial-intelligence/analytics',
      },
      {
        'title': 'Budget Management',
        'subtitle': 'AI-assisted planning',
        'icon': Icons.account_balance,
        'color': AppColors.colorGreen,
        'route': '/financial-intelligence/budget',
      },
      {
        'title': 'Payment Processing',
        'subtitle': 'Smart routing & fraud detection',
        'icon': Icons.payment,
        'color': AppColors.colorOrange,
        'route': '/financial-intelligence/payments',
      },
      {
        'title': 'Compliance & Audit',
        'subtitle': 'Automated compliance checking',
        'icon': Icons.verified_user,
        'color': AppColors.colorPurple,
        'route': '/financial-intelligence/compliance',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _buildFeatureCard(
          title: feature['title'] as String,
          subtitle: feature['subtitle'] as String,
          icon: feature['icon'] as IconData,
          color: feature['color'] as Color,
          onTap: () {
            // Navigate to feature detail view
            // Get.toNamed(feature['route'] as String);
          },
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666), // BauhausDesign.textMuted
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Stats',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Forecast Accuracy',
                  value: '95%',
                  icon: Icons.check_circle,
                  color: AppColors.colorGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  label: 'Revenue Growth',
                  value: '+15%',
                  icon: Icons.trending_up,
                  color: AppColors.colorBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Error Reduction',
                  value: '90%',
                  icon: Icons.verified,
                  color: AppColors.colorOrange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  label: 'Time Saved',
                  value: '20h/wk',
                  icon: Icons.schedule,
                  color: AppColors.colorPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF666666), // BauhausDesign.textMuted
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Insights',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            title: 'Revenue forecast updated',
            subtitle: 'Q1 projections show 12% growth',
            icon: Icons.trending_up,
            color: AppColors.colorGreen,
            time: '2 hours ago',
          ),
          const Divider(height: 24),
          _buildInsightItem(
            title: 'Pricing optimization complete',
            subtitle: '15% revenue increase potential identified',
            icon: Icons.attach_money,
            color: AppColors.colorBlue,
            time: '5 hours ago',
          ),
          const Divider(height: 24),
          _buildInsightItem(
            title: 'Cash flow alert',
            subtitle: 'Projected shortfall in 30 days',
            icon: Icons.warning_amber,
            color: AppColors.colorOrange,
            time: '1 day ago',
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String time,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorFontPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666), // BauhausDesign.textMuted
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF666666), // BauhausDesign.textMuted
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
