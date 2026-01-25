import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausInfoBlock extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const BauhausInfoBlock({
    super.key,
    required this.label,
    required this.value,
    this.icon = Icons.info_outline,
    this.iconColor = BauhausDesign.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: BauhausDesign.backgroundLight,
              border: const Border(
                bottom: BorderSide(color: BauhausDesign.textDark, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconColor,
                    border: Border.all(color: BauhausDesign.textDark, width: 2),
                  ),
                  child:
                      Icon(icon, size: 16, color: BauhausDesign.surfaceLight),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label.toUpperCase(),
                    style: GoogleFonts.oswald(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: BauhausDesign.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
