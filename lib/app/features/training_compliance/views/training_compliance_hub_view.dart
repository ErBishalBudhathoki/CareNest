import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/training_compliance/views/certifications_view.dart';
import 'package:carenest/app/features/training_compliance/views/training_modules_view.dart';
import 'package:carenest/app/features/training_compliance/views/compliance_checklist_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class TrainingComplianceHubView extends ConsumerWidget {
  const TrainingComplianceHubView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        title: Text(
          AppLocalizations.of(context)!.trainingComplianceTitle,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        children: [
          _buildNavCard(
            context,
            title: AppLocalizations.of(context)!.certificationsTitle,
            subtitle: AppLocalizations.of(context)!.certificationsSubtitle,
            icon: Icons.card_membership,
            color: BauhausDesign.primary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CertificationsView()),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildNavCard(
            context,
            title: AppLocalizations.of(context)!.trainingModulesTitle,
            subtitle: AppLocalizations.of(context)!.trainingModulesSubtitle,
            icon: Icons.school,
            color: BauhausDesign.secondary,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TrainingModulesView()),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildNavCard(
            context,
            title: AppLocalizations.of(context)!.complianceChecklistsTitle,
            subtitle: AppLocalizations.of(
              context,
            )!.complianceChecklistsSubtitle,
            icon: Icons.checklist,
            color: BauhausDesign.accent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ComplianceChecklistView(),
              ),
            ),
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 10, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.14),
                          border: Border.all(color: color, width: 2),
                        ),
                        child: Icon(icon, size: 22, color: color),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title.toUpperCase(),
                              style: BauhausDesign.getTextTheme(context)
                                  .labelLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: BauhausDesign.space1),
                            Text(
                              subtitle,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
