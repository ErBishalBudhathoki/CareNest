import 'package:carenest/app/features/Appointment/widgets/shift_details_widget.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// View displayed after a successful shift assignment
///
/// Shows assignment confirmation with employee/client details and shift information.
/// Uses Bauhaus design system for consistent styling.
class ShiftSuccessView extends StatelessWidget {
  final String userEmail;
  final String clientEmail;
  final Map<String, dynamic> shiftData;

  const ShiftSuccessView({
    super.key,
    required this.userEmail,
    required this.clientEmail,
    required this.shiftData,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildBauhausAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                // Opaque fill: a translucent one lets the opaque zero-blur
                // black `shadowHardXs` bleed through and render the row black.
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(color: BauhausDesign.success, width: 2),
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space2),
                    decoration: BoxDecoration(
                      color: BauhausDesign.success,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.assignmentSuccessfulCaps,
                      style: textTheme.headlineLarge?.copyWith(
                        color: BauhausDesign.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    context,
                    label: AppLocalizations.of(context)!.employeeLabel,
                    value: userEmail,
                    icon: Icons.person,
                    color: BauhausDesign.secondary,
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    height: 2,
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  _buildDetailRow(
                    context,
                    label: AppLocalizations.of(context)!.clientLabel,
                    value: clientEmail,
                    icon: Icons.business,
                    color: BauhausDesign.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: Text(
                AppLocalizations.of(context)!.assignedShifts.toUpperCase(),
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 220),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: ShiftDetailsWidget(shiftData: shiftData),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildBauhausAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.shiftDetails.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context).displaySmall
                      ?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  letterSpacing: 1,
                ),
              ),
              Text(
                value,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
