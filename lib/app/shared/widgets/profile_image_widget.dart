import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../utils/image_utils.dart';

/// Unified profile image widget that handles different image sources
///
/// Provides consistent styling and behavior for profile images across the app
/// Supports base64 images, network URLs, Uint8List data, and asset fallbacks
class ProfileImageWidget extends StatelessWidget {
  /// Image data as Uint8List (highest priority)
  final Uint8List? photoData;

  /// Image data as base64 string (medium priority)
  final String? imageData;

  /// Network image URL (lowest priority)
  final String? imageUrl;

  /// Size of the profile image (width and height)
  final double size;

  /// Asset path for fallback image
  final String fallbackAsset;

  /// Border width for the circular border
  final double borderWidth;

  /// Border color for the circular border
  final Color borderColor;

  /// Background color for the container
  final Color? surfaceColor;

  /// Shadow elevation for the container
  final double elevation;

  /// Shadow color for the container
  final Color shadowColor;

  /// Callback when the image is tapped
  final VoidCallback? onTap;

  /// Whether to show a loading indicator
  final bool showLoading;

  /// Custom error widget builder
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  const ProfileImageWidget({
    super.key,
    this.photoData,
    this.imageData,
    this.imageUrl,
    this.size = 50.0,
    this.fallbackAsset = 'assets/icons/profile_placeholder.png',
    this.borderWidth = 2.0,
    this.borderColor = Colors.white,
    this.surfaceColor,
    this.elevation = 4.0,
    this.shadowColor = Colors.black26,
    this.onTap,
    this.showLoading = true,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: surfaceColor ?? Colors.grey[100],
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          boxShadow: elevation > 0
              ? [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: elevation * 2,
                    offset: Offset(0, elevation),
                  ),
                ]
              : null,
        ),
        child: ClipOval(
          child: _buildImageContent(context),
        ),
      ),
    );
  }

  /// Builds the image content based on available data sources
  ///
  /// Priority order: photoData > imageData > imageUrl > fallback asset
  Widget _buildImageContent(BuildContext context) {
    // Debug logging for image processing
    // debugPrint('ProfileImageWidget: Processing image - '
    //     'photoData: ${photoData != null ? '${photoData!.length} bytes' : 'null'}, '
    //     'imageData: ${imageData != null ? 'provided' : 'null'}, '
    //     'imageUrl: ${imageUrl ?? 'null'}');

    // Priority 1: Use photoData if available
    if (photoData != null) {
      return _buildMemoryImage(photoData!);
    }

    // Priority 2: Use base64 imageData if available and valid
    if (imageData != null && ImageUtils.isValidBase64Image(imageData)) {
      final decodedData = ImageUtils.decodeBase64Image(imageData);
      if (decodedData != null) {
        return _buildMemoryImage(decodedData);
      }
    }

    // Priority 3: Use network imageUrl if available and valid
    if (imageUrl != null && ImageUtils.isNetworkUrl(imageUrl)) {
      return _buildNetworkImage(imageUrl!);
    }

    // Priority 4: Use imageData as network URL if it's a valid URL
    if (imageData != null && ImageUtils.isNetworkUrl(imageData)) {
      return _buildNetworkImage(imageData!);
    }

    // Fallback: Use asset image
    return _buildAssetImage();
  }

  /// Builds an image from memory data (Uint8List)
  Widget _buildMemoryImage(Uint8List data) {
    // debugPrint(
    //     'ProfileImageWidget: Loading memory image (${data.length} bytes)');

    return Image.memory(
      data,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        ImageErrorHandler.logImageError('Memory Image', error, stackTrace);
        return _buildErrorWidget(context, error);
      },
    );
  }

  /// Builds an image from network URL
  Widget _buildNetworkImage(String url) {
    // debugPrint('ProfileImageWidget: Loading network image from: $url');

    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      loadingBuilder: showLoading
          ? (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return ImageErrorHandler.buildLoadingWidget(
                size: size,
              );
            }
          : null,
      errorBuilder: (context, error, stackTrace) {
        ImageErrorHandler.logImageError('Network Image', error, stackTrace);
        return _buildErrorWidget(context, error);
      },
    );
  }

  /// Builds an image from asset path
  Widget _buildAssetImage() {
    // debugPrint('ProfileImageWidget: Loading fallback asset: $fallbackAsset');

    return Image.asset(
      fallbackAsset,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        ImageErrorHandler.logImageError('Asset Image', error, stackTrace);
        return _buildErrorWidget(context, error);
      },
    );
  }

  /// Builds error widget when image loading fails
  Widget _buildErrorWidget(BuildContext context, Object error) {
    if (errorBuilder != null) {
      return errorBuilder!(context, error);
    }

    return ImageErrorHandler.buildErrorWidget(
      size: size,
    );
  }
}

/// Specialized profile image widget for employee status cards
///
/// Extends ProfileImageWidget with employee-specific styling and behavior
class EmployeeProfileImage extends ProfileImageWidget {
  /// Employee name for accessibility and debugging
  final String? employeeName;

  /// Whether the employee is currently active
  final bool isActive;

  /// Status indicator color
  final Color? statusColor;

  /// Filename for the image (for debugging and metadata)
  final String? filename;

  const EmployeeProfileImage({
    super.key,
    required String? profileImage,
    super.photoData,
    this.employeeName,
    this.isActive = false,
    this.statusColor,
    this.filename,
    super.size,
    super.onTap,
  }) : super(
          imageData: profileImage,
          borderColor: Colors.white,
          borderWidth: 2.0,
          elevation: 4.0,
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),

        // Status indicator
        if (statusColor != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Specialized profile image widget for admin dashboard
///
/// Extends ProfileImageWidget with admin-specific styling
class AdminProfileImage extends ProfileImageWidget {
  const AdminProfileImage({
    super.key,
    required String email,
    required super.photoData,
    super.size = 60.0,
    super.onTap,
  }) : super(
          borderColor: Colors.white,
          borderWidth: 3.0,
          elevation: 6.0,
          shadowColor: Colors.black38,
        );
}