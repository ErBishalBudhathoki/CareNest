import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausClientHeader extends StatelessWidget {
  final String clientName;
  final String status;
  final VoidCallback? onMapTap;

  const BauhausClientHeader({
    super.key,
    required this.clientName,
    this.status = 'ACTIVE',
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BauhausDesign.accent, // Yellow background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: BauhausDesign.textDark,
                          border: Border.all(
                            color: BauhausDesign.textDark,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.surfaceLight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        clientName.toUpperCase(),
                        style: GoogleFonts.oswald(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onMapTap != null)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onMapTap,
                      child: Container(
                        width: 56,
                        height: 56,
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
                        child: const Icon(
                          Icons.map_outlined,
                          color: BauhausDesign.textDark,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Decorative bottom border
          Container(
            height: 4,
            width: double.infinity,
            color: BauhausDesign.textDark,
          ),
        ],
      ),
    );
  }
}
