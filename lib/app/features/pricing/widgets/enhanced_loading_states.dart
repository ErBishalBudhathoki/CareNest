import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';

/// Enhanced loading states for better user feedback
class EnhancedLoadingStates {
  /// Skeleton loading for cards
  static Widget buildSkeletonCard() {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(width: 100, height: 16),
          SizedBox(height: AppDimens.paddingSmall),
          _buildShimmerBox(width: 60, height: 24),
          SizedBox(height: AppDimens.paddingMedium),
          _buildShimmerBox(width: 150, height: 12),
        ],
      ),
    );
  }

  /// Shimmer effect for loading placeholders
  static Widget _buildShimmerBox(
      {required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.colorGrey200,
        borderRadius: BorderRadius.circular(4),
      ),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer(
        duration: 1500.ms, color: AppColors.colorWhite.withOpacity(0.1));
  }

  /// Error state with retry option
  static Widget buildErrorState({
    required String message,
    VoidCallback? onRetry,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingXLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.colorWarning,
          ),
          SizedBox(height: AppDimens.paddingLarge),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: AppDimens.fontSizeXMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.paddingSmall),
          Text(
            message,
            style: TextStyle(
              fontSize: AppDimens.fontSizeNormal,
              color: AppColors.colorFontSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: AppDimens.paddingLarge),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh),
              label: Text('Try Again'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                foregroundColor: AppColors.colorWhite,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingLarge,
                  vertical: AppDimens.paddingMedium,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: Offset(0.8, 0.8));
  }

  /// Empty state with call-to-action
  static Widget buildEmptyState({
    required String title,
    required String message,
    IconData? icon,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingXLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.inbox_outlined,
            size: 64,
            color: AppColors.colorGrey400,
          ),
          SizedBox(height: AppDimens.paddingLarge),
          Text(
            title,
            style: TextStyle(
              fontSize: AppDimens.fontSizeXMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.paddingSmall),
          Text(
            message,
            style: TextStyle(
              fontSize: AppDimens.fontSizeNormal,
              color: AppColors.colorFontSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (onAction != null && actionLabel != null) ...[
            SizedBox(height: AppDimens.paddingLarge),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: Icon(Icons.add),
              label: Text(actionLabel),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                foregroundColor: AppColors.colorWhite,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingLarge,
                  vertical: AppDimens.paddingMedium,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}
