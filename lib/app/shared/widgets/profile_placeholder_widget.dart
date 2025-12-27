import 'package:flutter/material.dart';

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
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          Text(
            '$firstName $lastName',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
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
