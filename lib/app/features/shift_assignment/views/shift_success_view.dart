import 'package:carenest/app/features/Appointment/widgets/shift_details_widget.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'SHIFT DETAILS',
          style: GoogleFonts.oswald(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 4,
            color: BauhausDesign.neutral,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.success.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.success, width: 2),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space2),
                    decoration: BoxDecoration(
                      color: BauhausDesign.success,
                      border: Border.all(color: BauhausDesign.neutral, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: BauhausDesign.textLight,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      'ASSIGNMENT SUCCESSFUL!',
                      style: textTheme.headlineLarge?.copyWith(
                        color: BauhausDesign.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),

            // Assignment Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceLight,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    context,
                    label: 'EMPLOYEE',
                    value: userEmail,
                    icon: Icons.person,
                    color: BauhausDesign.secondary,
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Container(height: 2, color: BauhausDesign.neutral.withOpacity(0.2)),
                  const SizedBox(height: BauhausDesign.space3),
                  _buildDetailRow(
                    context,
                    label: 'CLIENT',
                    value: clientEmail,
                    icon: Icons.business,
                    color: BauhausDesign.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),

            // Assigned Shifts Header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space2,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.textDark,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
              ),
              child: Text(
                'ASSIGNED SHIFTS',
                style: GoogleFonts.oswald(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textLight,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),

            // Shift Details
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: ShiftDetailsWidget(shiftData: shiftData),
              ),
            ),
          ],
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
            color: color.withOpacity(0.1),
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
                style: GoogleFonts.oswald(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.neutral,
                  letterSpacing: 1,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark,
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
