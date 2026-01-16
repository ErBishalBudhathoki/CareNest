import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color baseColor; // The primary color for this card theme
  final VoidCallback onTap;
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(
          color: BauhausDesign.textDark,
          width: 3,
        ),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: baseColor.withOpacity(0.2), // Light tint
                        border: Border.all(
                          color: baseColor, // Bold color border
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: baseColor, // Bold color icon
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: GoogleFonts.oswald(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: BauhausDesign.textDark,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: baseColor,
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
                      style: GoogleFonts.oswald(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign
                            .surfaceLight, // White text on bold color
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
