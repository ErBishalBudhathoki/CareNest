import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/workforce_optimization/utils/workforce_export_helper.dart';

class ReportBuilderView extends ConsumerStatefulWidget {
  const ReportBuilderView({super.key});

  @override
  ConsumerState<ReportBuilderView> createState() => _ReportBuilderViewState();
}

class _ReportBuilderViewState extends ConsumerState<ReportBuilderView> {
  final List<String> _selectedMetrics = [];
  String _selectedFormat = 'PDF';
  String _selectedPeriod = 'Last 30 Days';
  String? _selectedTemplate;

  static const Map<String, List<String>> _templateMetrics = {
    'Executive Summary': [
      'Business Intelligence',
      'Revenue Forecast',
      'Performance Analytics',
    ],
    'Operational Report': [
      'Workforce Planning',
      'Resource Allocation',
      'Performance Analytics',
    ],
    'Financial Analysis': ['Revenue Forecast', 'Business Intelligence'],
    'Quality Report': ['Quality Assurance', 'Performance Analytics'],
  };

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
          onPressed: () => Navigator.pop(context),
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
          colors: [
            AppColors.colorSecondary,
            AppColors.colorSecondary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorSecondary.withValues(alpha: 0.3),
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
              color: AppColors.colorWhite.withValues(alpha: 0.2),
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
                  style: TextStyle(fontSize: 14, color: AppColors.colorWhite),
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
    // Excel omitted: no spreadsheet package in scope; CSV opens in Excel.
    final formats = ['PDF', 'CSV', 'JSON'];

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
          child: RadioGroup<String>(
            groupValue: _selectedFormat,
            onChanged: (value) {
              setState(() {
                _selectedFormat = value!;
              });
            },
            child: Column(
              children: formats.map((format) {
                return RadioListTile<String>(
                  value: format,
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
          child: RadioGroup<String>(
            groupValue: _selectedPeriod,
            onChanged: (value) {
              setState(() {
                _selectedPeriod = value!;
              });
            },
            child: Column(
              children: periods.map((period) {
                return RadioListTile<String>(
                  value: period,
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
              selected: _selectedTemplate == (template['name'] as String),
              onTap: () {
                setState(() {
                  _selectedTemplate = template['name'] as String;
                  _selectedMetrics
                    ..clear()
                    ..addAll(
                      _templateMetrics[template['name'] as String] ?? const [],
                    );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${template['name']} template applied'),
                  ),
                );
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
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppColors.colorPrimary
                : color.withValues(alpha: 0.2),
            width: selected ? 3 : 2,
          ),
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
                color: color.withValues(alpha: 0.1),
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
              style: const TextStyle(fontSize: 11, color: Color(0xFF666666)),
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
                : () => _generateReport(),
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
      ],
    );
  }

  /// Builds the report locally in the selected format and shares it.
  /// Scheduled delivery needs a backend scheduler, so only manual
  /// generation is offered here.
  Future<void> _generateReport() async {
    final stamp = WorkforceExportHelper.fileTimestamp();
    final period = _selectedPeriod;
    final generatedAt = DateTime.now().toIso8601String();
    try {
      String? path;
      if (_selectedFormat == 'JSON') {
        final content = jsonEncode({
          'generatedAt': generatedAt,
          'period': period,
          'template': _selectedTemplate,
          'metrics': _selectedMetrics,
        });
        path = await WorkforceExportHelper.shareTextFile(
          filename: 'workforce-report-$stamp.json',
          content: content,
        );
      } else if (_selectedFormat == 'PDF') {
        final doc = pw.Document();
        doc.addPage(
          pw.Page(
            build: (context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(text: 'Workforce Report'),
                pw.Text('Period: $period'),
                pw.Text('Generated: $generatedAt'),
                pw.SizedBox(height: 16),
                pw.TableHelper.fromTextArray(
                  headers: const ['Metric'],
                  data: _selectedMetrics.map((m) => [m]).toList(),
                ),
              ],
            ),
          ),
        );
        path = await WorkforceExportHelper.shareBytes(
          filename: 'workforce-report-$stamp.pdf',
          bytes: await doc.save(),
        );
      } else {
        final csv = WorkforceExportHelper.toCsv(const [
          'metric',
          'period',
          'generated_at',
        ], _selectedMetrics.map((m) => [m, period, generatedAt]).toList());
        path = await WorkforceExportHelper.shareTextFile(
          filename: 'workforce-report-$stamp.csv',
          content: csv,
        );
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            path == null ? 'Report export failed' : 'Report shared',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Report export failed')));
    }
  }
}
