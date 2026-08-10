import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color baseColor; // The primary color for this card theme
  final VoidCallback? onTap;
  final String actionLabel;

  const BauhausActionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.baseColor,
    required this.onTap,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    final actionColor = isEnabled ? baseColor : BauhausDesign.neutral;
    final actionTextColor = isEnabled
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.surfaceLight;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.textDark, width: 3),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.textDark,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space2),
                      decoration: BoxDecoration(
                        color: actionColor.withValues(alpha: 0.2), // Light tint
                        border: Border.all(
                          color: actionColor, // Bold color border
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: actionColor, // Bold color icon
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  description,
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(color: BauhausDesign.textDark, height: 1.5),
                ),
                const SizedBox(height: BauhausDesign.space5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space4,
                      vertical: BauhausDesign.space2,
                    ),
                    decoration: BoxDecoration(
                      color: actionColor,
                      border: Border.all(
                        color: BauhausDesign.textDark,
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: BauhausDesign.textDark,
                          offset: Offset(2, 2),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      actionLabel.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context).labelMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: actionTextColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
