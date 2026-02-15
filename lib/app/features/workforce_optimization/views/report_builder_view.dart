import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

class ReportBuilderView extends ConsumerStatefulWidget {
  const ReportBuilderView({super.key});

  @override
  ConsumerState<ReportBuilderView> createState() => _ReportBuilderViewState();
}

class _ReportBuilderViewState extends ConsumerState<ReportBuilderView> {
  final List<String> _selectedMetrics = [];
  String _selectedFormat = 'PDF';
  String _selectedPeriod = 'Last 30 Days';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Report Builder',
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
            _buildMetricSelection(),
            const SizedBox(height: 24),
            _buildFormatSelection(),
            const SizedBox(height: 24),
            _buildPeriodSelection(),
            const SizedBox(height: 24),
            _buildTemplates(),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorSecondary, AppColors.colorSecondary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorSecondary.withOpacity(0.3),
            blurRadius: 12,
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
              color: AppColors.colorWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppColors.colorWhite,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Custom Reports',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorWhite,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Build and export custom analytics',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricSelection() {
    final metrics = [
      {'name': 'Workforce Planning', 'icon': Icons.people_outline},
      {'name': 'Resource Allocation', 'icon': Icons.assignment_outlined},
      {'name': 'Performance Analytics', 'icon': Icons.trending_up},
      {'name': 'Quality Assurance', 'icon': Icons.verified_outlined},
      {'name': 'Business Intelligence', 'icon': Icons.business_center_outlined},
      {'name': 'Revenue Forecast', 'icon': Icons.attach_money},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Metrics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
            children: metrics.map((metric) {
              final name = metric['name'] as String;
              final icon = metric['icon'] as IconData;
              final isSelected = _selectedMetrics.contains(name);

              return CheckboxListTile(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedMetrics.add(name);
                    } else {
                      _selectedMetrics.remove(name);
                    }
                  });
                },
                title: Row(
                  children: [
                    Icon(icon, size: 20, color: AppColors.colorPrimary),
                    const SizedBox(width: 12),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.colorFontPrimary,
                      ),
                    ),
                  ],
                ),
                activeColor: AppColors.colorPrimary,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFormatSelection() {
    final formats = ['PDF', 'Excel', 'CSV', 'JSON'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Export Format',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
            children: formats.map((format) {
              return RadioListTile<String>(
                value: format,
                groupValue: _selectedFormat,
                onChanged: (value) {
                  setState(() {
                    _selectedFormat = value!;
                  });
                },
                title: Text(
                  format,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                activeColor: AppColors.colorPrimary,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelection() {
    final periods = [
      'Last 7 Days',
      'Last 30 Days',
      'Last 90 Days',
      'Last 12 Months',
      'Custom Range',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time Period',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
            children: periods.map((period) {
              return RadioListTile<String>(
                value: period,
                groupValue: _selectedPeriod,
                onChanged: (value) {
                  setState(() {
                    _selectedPeriod = value!;
                  });
                },
                title: Text(
                  period,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
                activeColor: AppColors.colorPrimary,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTemplates() {
    final templates = [
      {
        'name': 'Executive Summary',
        'description': 'High-level KPIs and insights',
        'icon': Icons.business_center,
        'color': AppColors.colorBlue,
      },
      {
        'name': 'Operational Report',
        'description': 'Detailed workforce metrics',
        'icon': Icons.assessment,
        'color': AppColors.colorGreen,
      },
      {
        'name': 'Financial Analysis',
        'description': 'Revenue and profitability',
        'icon': Icons.attach_money,
        'color': AppColors.colorOrange,
      },
      {
        'name': 'Quality Report',
        'description': 'Quality and compliance metrics',
        'icon': Icons.verified,
        'color': AppColors.colorPurple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Templates',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: templates.length,
          itemBuilder: (context, index) {
            final template = templates[index];
            return _buildTemplateCard(
              name: template['name'] as String,
              description: template['description'] as String,
              icon: template['icon'] as IconData,
              color: template['color'] as Color,
              onTap: () {
                // TODO: Load template
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTemplateCard({
    required String name,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2), width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF666666),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _selectedMetrics.isEmpty
                ? null
                : () {
                    // TODO: Generate report
                    Get.snackbar(
                      'Report Generated',
                      'Your report is being generated in $_selectedFormat format',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.colorSuccess,
                      colorText: AppColors.colorWhite,
                    );
                  },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Generate Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              foregroundColor: AppColors.colorWhite,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Schedule report
            },
            icon: const Icon(Icons.schedule),
            label: const Text('Schedule Report'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.colorPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.colorPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
