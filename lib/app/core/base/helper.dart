// Helper method to build info rows
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:flutter/cupertino.dart';

Widget buildInfoRow(
    IconData icon, String label, String text, bool isSmallScreen) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: isSmallScreen ? 18 : 24),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen
                    ? AppDimens.fontSizeSmall
                    : AppDimens.fontSizeNormal,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: isSmallScreen
                    ? AppDimens.fontSizeSmall
                    : AppDimens.fontSizeNormal,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
