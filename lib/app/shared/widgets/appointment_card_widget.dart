import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'card_label_text_widget.dart';
import 'package:iconsax/iconsax.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String currentUserEmail;
  final String currentClientEmail;

  final IconData iconData;
  final String label;
  final String text;

  final IconData iconData1;
  final String label1;
  final String text1;

  final IconData iconData2;
  final String label2;
  final String text2;

  final IconData iconData3;
  final String label3;
  final String text3;

  const AppointmentCard({
    super.key,
    required this.currentClientEmail,
    required this.currentUserEmail,
    required this.title,
    required this.iconData,
    required this.label,
    required this.text,
    required this.iconData1,
    required this.label1,
    required this.text1,
    required this.iconData2,
    required this.label2,
    required this.text2,
    required this.iconData3,
    required this.label3,
    required this.text3,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Container(
      height: screenSize.height * 0.42,
      decoration: BoxDecoration(
        gradient: ModernSaasDesign.cardGradient,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radius2xl),
        border: Border.all(
          color: ModernSaasDesign.primary.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: ModernSaasDesign.shadowLg,
      ),
      child: Padding(
        padding: const EdgeInsets.all(ModernSaasDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern header with icon
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: ModernSaasDesign.space3,
                vertical: ModernSaasDesign.space2,
              ),
              decoration: BoxDecoration(
                color: ModernSaasDesign.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(ModernSaasDesign.space2),
                    decoration: BoxDecoration(
                      color: ModernSaasDesign.primary,
                      borderRadius:
                          BorderRadius.circular(ModernSaasDesign.radiusSm),
                    ),
                    child: Icon(
                      Iconsax.calendar_1,
                      color: ModernSaasDesign.textOnPrimary,
                      size: isSmallScreen ? 16 : 20,
                    ),
                  ),
                  const SizedBox(width: ModernSaasDesign.space2),
                  Text(
                    title,
                    style: (isSmallScreen
                            ? ModernSaasDesign.headlineSmall
                            : ModernSaasDesign.headlineMedium)
                        .copyWith(
                      color: ModernSaasDesign.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ModernSaasDesign.space3),
            _buildModernCardItem(iconData, label, text, isSmallScreen),
            const SizedBox(height: ModernSaasDesign.space2),
            _buildModernCardItem(iconData1, label1, text1, isSmallScreen),
            const SizedBox(height: ModernSaasDesign.space2),
            _buildModernCardItem(iconData2, label2, text2, isSmallScreen),
            const SizedBox(height: ModernSaasDesign.space2),
            _buildModernCardItem(iconData3, label3, text3, isSmallScreen),
            const SizedBox(height: ModernSaasDesign.space3),
            Consumer(builder: (context, ref, _) {
              return Container(
                height: isSmallScreen ? 48 : 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: ModernSaasDesign.primaryGradient,
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusLg),
                  boxShadow: ModernSaasDesign.shadowMd,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusLg),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientAndAppointmentDetails(
                            userEmail: currentUserEmail,
                            clientEmail: currentClientEmail,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ModernSaasDesign.space3,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.eye,
                            color: ModernSaasDesign.textOnPrimary,
                            size: isSmallScreen ? 18 : 20,
                          ),
                          const SizedBox(width: ModernSaasDesign.space2),
                          Text(
                            'View Details',
                            style: (isSmallScreen
                                    ? ModernSaasDesign.labelLarge
                                    : ModernSaasDesign.headlineSmall)
                                .copyWith(
                              color: ModernSaasDesign.textOnPrimary,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: ModernSaasDesign.space2),
                          Icon(
                            Iconsax.arrow_right_3,
                            color: ModernSaasDesign.textOnPrimary,
                            size: isSmallScreen ? 16 : 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Modern card item with improved design
  Widget _buildModernCardItem(
      IconData icon, String label, String text, bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.all(ModernSaasDesign.space3),
      decoration: BoxDecoration(
        color: ModernSaasDesign.background.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
        border: Border.all(
          color: ModernSaasDesign.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
            ),
            child: Icon(
              icon,
              color: ModernSaasDesign.primary,
              size: isSmallScreen ? 16 : 18,
            ),
          ),
          const SizedBox(width: ModernSaasDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: (isSmallScreen
                          ? ModernSaasDesign.labelMedium
                          : ModernSaasDesign.labelLarge)
                      .copyWith(
                    color: ModernSaasDesign.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: (isSmallScreen
                          ? ModernSaasDesign.bodyMedium
                          : ModernSaasDesign.bodyLarge)
                      .copyWith(
                    color: ModernSaasDesign.textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
