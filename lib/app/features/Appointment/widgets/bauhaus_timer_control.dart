import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausTimerControl extends StatelessWidget {
  final bool isRunning;
  final String formattedTime;
  final VoidCallback onToggle;
  final bool isForCurrentClient;

  const BauhausTimerControl({
    super.key,
    required this.isRunning,
    required this.formattedTime,
    required this.onToggle,
    this.isForCurrentClient = true,
  });

  @override
  Widget build(BuildContext context) {
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
          )
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: BauhausDesign.textDark, // Black Header
            ),
            child: Text(
              "SHIFT TIMER CONTROL",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: BauhausDesign.surfaceLight,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Digital Display
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  decoration: BoxDecoration(
                    color: isRunning
                        ? BauhausDesign.success.withOpacity(0.1)
                        : BauhausDesign.neutral.withOpacity(0.1),
                    border: Border.all(
                      color: isRunning
                          ? BauhausDesign.success
                          : BauhausDesign.neutral,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    formattedTime,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Big Button
                if (isForCurrentClient)
                  SizedBox(
                    width: double.infinity,
                    height: 64, // Big touch target
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRunning
                            ? BauhausDesign.error
                            : BauhausDesign.success,
                        foregroundColor: BauhausDesign.surfaceLight,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(), // Rectangle
                        side: const BorderSide(
                            color: BauhausDesign.textDark, width: 3),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: onToggle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isRunning ? Icons.stop : Icons.play_arrow,
                            size: 32,
                            color: BauhausDesign
                                .textDark, // Dark icon for contrast
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isRunning ? "STOP SHIFT" : "START SHIFT",
                            style: GoogleFonts.oswald(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark, // Dark text
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: BauhausDesign.warning.withOpacity(0.2),
                      border:
                          Border.all(color: BauhausDesign.warning, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: BauhausDesign.textDark),
                        const SizedBox(width: 12),
                        Text(
                          "TIMER ACTIVE ELSEWHERE",
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
