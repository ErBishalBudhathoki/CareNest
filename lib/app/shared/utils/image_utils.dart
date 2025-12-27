import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Utility class for handling image processing operations
/// Provides centralized methods for image decoding, validation, and error handling
class ImageUtils {
  /// Decodes a base64 encoded image string to Uint8List
  /// 
  /// Handles both data URI format (data:image/...) and raw base64 strings
  /// Returns null if decoding fails or input is invalid
  static Uint8List? decodeBase64Image(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      debugPrint('ImageUtils: Base64 string is null or empty');
      return null;
    }
    
    try {
      String base64Data = base64String;
      
      // Handle data URI format (data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...)
      if (base64String.startsWith('data:image')) {
        final parts = base64String.split(',');
        if (parts.length != 2) {
          debugPrint('ImageUtils: Invalid data URI format');
          return null;
        }
        base64Data = parts[1];
      }
      
      return base64Decode(base64Data);
    } catch (e) {
      debugPrint('ImageUtils: Error decoding base64 image: $e');
      return null;
    }
  }
  
  /// Validates if a string is a valid base64 encoded image
  /// 
  /// Checks for proper base64 format, data URI structure, and minimum size
  static bool isValidBase64Image(String? imageString) {
    if (imageString == null || imageString.isEmpty) return false;
    
    try {
      Uint8List? decodedData;
      
      if (imageString.startsWith('data:image')) {
        final parts = imageString.split(',');
        if (parts.length != 2) return false;
        
        // Validate MIME type
        final mimeType = parts[0];
        if (!mimeType.contains('image/')) return false;
        
        // Try to decode the base64 part
        decodedData = base64Decode(parts[1]);
      } else {
        // Try to decode as raw base64
        decodedData = base64Decode(imageString);
      }
      
      // Check minimum size - reject tiny placeholder images (less than 500 bytes)
      if (decodedData.length < 500) {
        debugPrint('ImageUtils: Image too small (${decodedData.length} bytes), likely a placeholder');
        return false;
      }
      
      return decodedData != null;
    } catch (e) {
      return false;
    }
  }
  
  /// Checks if a string represents a network URL
  /// 
  /// Returns true if the string starts with http:// or https://
  static bool isNetworkUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return url.startsWith('http://') || url.startsWith('https://');
  }
  
  /// Gets the appropriate image widget based on image data type
  /// 
  /// Handles base64 images, network URLs, and Uint8List data
  /// Returns appropriate Image widget or null if invalid
  static Widget? getImageWidget({
    String? imageUrl,
    Uint8List? imageData,
    String? base64Image,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    // Priority: imageData > base64Image > imageUrl
    if (imageData != null) {
      return Image.memory(
        imageData,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('ImageUtils: Error loading memory image: $error');
          return ImageErrorHandler.buildErrorWidget(
            size: width ?? height ?? 50.0,
          );
        },
      );
    }
    
    if (base64Image != null && isValidBase64Image(base64Image)) {
      final decodedData = decodeBase64Image(base64Image);
      if (decodedData != null) {
        return Image.memory(
          decodedData,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('ImageUtils: Error loading base64 image: $error');
            return ImageErrorHandler.buildErrorWidget(
              size: width ?? height ?? 50.0,
            );
          },
        );
      }
    }
    
    if (imageUrl != null && isNetworkUrl(imageUrl)) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('ImageUtils: Error loading network image: $error');
          return ImageErrorHandler.buildErrorWidget(
            size: width ?? height ?? 50.0,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: width,
            height: height,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    }
    
    return null;
  }
}

/// Error handler for image-related operations
/// Provides centralized error logging and fallback widgets
class ImageErrorHandler {
  /// Logs image-related errors with context information
  /// 
  /// Provides structured error logging for debugging purposes
  static void logImageError(String context, dynamic error, [StackTrace? stackTrace]) {
    debugPrint('ImageError in $context: $error');
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }
    // TODO: Add crash analytics reporting if needed
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, context: context);
  }
  
  /// Creates a standardized error widget for image loading failures
  /// 
  /// Returns a circular container with person icon as fallback
  static Widget buildErrorWidget({
    double size = 50.0,
    Color? surfaceColor,
    Color? iconColor,
    IconData icon = Icons.person,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: surfaceColor ?? Colors.grey[300],
      ),
      child: Icon(
        icon,
        size: size * 0.6,
        color: iconColor ?? Colors.grey[600],
      ),
    );
  }
  
  /// Creates a loading widget for image operations
  /// 
  /// Returns a circular progress indicator with consistent styling
  static Widget buildLoadingWidget({
    double size = 50.0,
    Color? surfaceColor,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: surfaceColor ?? Colors.grey[100],
      ),
      child: Center(
        child: SizedBox(
          width: size * 0.5,
          height: size * 0.5,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}