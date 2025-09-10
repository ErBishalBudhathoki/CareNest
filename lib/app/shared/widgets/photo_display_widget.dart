import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/foundation.dart';

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
        border: Border.all(color: ModernSaasDesign.accent, width: 2),
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
