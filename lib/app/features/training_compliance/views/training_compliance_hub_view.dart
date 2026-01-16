import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/features/training_compliance/views/certifications_view.dart';
import 'package:carenest/app/features/training_compliance/views/training_modules_view.dart';
import 'package:carenest/app/features/training_compliance/views/compliance_checklist_view.dart';


class TrainingComplianceHubView extends ConsumerWidget {
  const TrainingComplianceHubView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  children: [
                    _buildNavCard(
                      context,
                      title: 'Certifications',
                      subtitle: 'Upload and manage your certifications',
                      icon: Icons.card_membership,
                      color: BauhausDesign.primary,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CertificationsView())),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildNavCard(
                      context,
                      title: 'Training Modules',
                      subtitle: 'Complete mandatory training',
                      icon: Icons.school,
                      color: BauhausDesign.secondary,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TrainingModulesView())),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildNavCard(
                      context,
                      title: 'Compliance Checklists',
                      subtitle: 'Daily and weekly compliance checks',
                      icon: Icons.checklist,
                      color: BauhausDesign.accent,
                      textColor: BauhausDesign.textDark,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComplianceChecklistView())),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border(bottom: BorderSide(color: BauhausDesign.neutral, width: 2)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Text(
            'Training & Compliance',
            style: BauhausDesign.getTextTheme(context).headlineLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    Color textColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: textColor),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              title,
              style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(color: textColor),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              subtitle,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(color: textColor.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }
}
