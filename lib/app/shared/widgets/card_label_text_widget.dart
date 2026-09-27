import 'package:flutter/material.dart';

class CardLabelTextWidget extends StatelessWidget {
  final IconData iconData;
  final String label;
  final String text;

  const CardLabelTextWidget(this.iconData, this.label, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              iconData,
              color: colorScheme.primary,
              size: isSmallScreen ? 18 : 22,
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:
                      (isSmallScreen
                              ? const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                              : const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ))
                          .copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style:
                      (isSmallScreen
                              ? const TextStyle(fontSize: 14)
                              : const TextStyle(fontSize: 16))
                          .copyWith(
                            color: colorScheme.onSurface,
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
