import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/material.dart';

class CardLabelTextWidget extends StatelessWidget {
  final IconData iconData;
  final String label;
  final String text;

  const CardLabelTextWidget(this.iconData, this.label, this.text, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: ModernSaasDesign.space2,
        horizontal: ModernSaasDesign.space2,
      ),
      margin: const EdgeInsets.only(bottom: ModernSaasDesign.space2),
      decoration: BoxDecoration(
        color: ModernSaasDesign.background.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.space2),
            decoration: BoxDecoration(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
            ),
            child: Icon(
              iconData,
              color: ModernSaasDesign.primary,
              size: isSmallScreen ? 18 : 22,
            ),
          ),
          const SizedBox(width: ModernSaasDesign.space2),
          Flexible(
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
