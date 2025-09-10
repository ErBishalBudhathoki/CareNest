import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const LoadingIndicator({
    Key? key,
    this.size = 24.0,
    this.color,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColors.colorPrimary,
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.colorFontSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ]
      ],
    );
  }
}
