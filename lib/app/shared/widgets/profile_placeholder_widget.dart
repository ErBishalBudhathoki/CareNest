import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePlaceholder extends StatelessWidget {
  final String firstName;
  final String lastName;

  const ProfilePlaceholder({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // removed explicit width to avoid forcing overflow in AppBar title
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome back',
            style: ModernSaasDesign.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          Text(
            '$firstName $lastName',
            style: ModernSaasDesign.headlineSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
