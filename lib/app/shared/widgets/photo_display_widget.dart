

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
    // debugPrint("\n\nphotoData: $photoData\n\n");
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: photoData != null
            ? DecorationImage(
                image: MemoryImage(photoData!),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage('assets/icons/profile_placeholder.png'),
                fit: BoxFit.cover,
              ),
        border: Border.all(color: const Color(0xFF14B8A6), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
