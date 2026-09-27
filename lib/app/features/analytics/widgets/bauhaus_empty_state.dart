import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'bauhaus_container.dart';

class BauhausEmptyState extends StatelessWidget {
  final String message;
  final double height;

  const BauhausEmptyState({
    super.key,
    required this.message,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausContainer(
      height: height,
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Center(
                child: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface, // Ensure visible text
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
