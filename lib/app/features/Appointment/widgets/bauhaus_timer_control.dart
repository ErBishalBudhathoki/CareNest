import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
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
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface, // Black Header
            ),
            child: Text(
              "SHIFT TIMER CONTROL",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Digital Display
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  decoration: BoxDecoration(
                    color: isRunning
                        ? BauhausDesign.success.withValues(alpha: 0.1)
                        : Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.1),
                    border: Border.all(
                      color: isRunning
                          ? BauhausDesign.success
                          : Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    formattedTime,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
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
                        foregroundColor: isRunning
                            ? Theme.of(context).colorScheme.onError
                            : Theme.of(context).colorScheme.onSecondary,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(), // Rectangle
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 3,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: onToggle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isRunning ? Icons.stop : Icons.play_arrow,
                            size: 32,
                            color: isRunning
                                ? Theme.of(context).colorScheme.onError
                                : Theme.of(context).colorScheme.onSecondary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isRunning ? "STOP SHIFT" : "START SHIFT",
                            style: GoogleFonts.oswald(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isRunning
                                  ? Theme.of(context).colorScheme.onError
                                  : Theme.of(context).colorScheme.onSecondary,
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
                      color: BauhausDesign.warning.withValues(alpha: 0.2),
                      border: Border.all(
                        color: BauhausDesign.warning,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "TIMER ACTIVE ELSEWHERE",
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
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
