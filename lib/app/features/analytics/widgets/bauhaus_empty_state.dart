import 'package:flutter/material.dart';
import '../theme/bauhaus_theme.dart';
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
      color: BauhausTheme.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: BauhausTheme.black, width: 2),
                color: const Color(0xFFEEEEEE),
              ),
              child: const Center(
                child: Icon(Icons.info_outline, color: BauhausTheme.black),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message.toUpperCase(),
              style: BauhausTheme.subHeaderStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
