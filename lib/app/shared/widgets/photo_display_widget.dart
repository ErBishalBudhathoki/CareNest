import 'package:flutter/material.dart';
import 'dart:typed_data';

class PhotoDisplayWidget extends StatelessWidget {
  final String email;
  final double size;
  final Uint8List? photoData;

  const PhotoDisplayWidget({
    required this.email,
    this.size = 100.0,
    this.photoData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // debugPrint("\n\nphotoData: $photoData\n\n");
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: photoData != null
            ? DecorationImage(image: MemoryImage(photoData!), fit: BoxFit.cover)
            : const DecorationImage(
                image: AssetImage('assets/icons/profile_placeholder.png'),
                fit: BoxFit.cover,
              ),
        border: Border.all(color: colorScheme.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.15),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
