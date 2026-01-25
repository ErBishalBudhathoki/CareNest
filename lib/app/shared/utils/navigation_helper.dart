
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class NavigationHelper {
  /// Opens the native maps application with directions to the specified address.
  ///
  /// On iOS, it attempts to open Apple Maps first, falling back to Google Maps.
  /// On Android, it opens Google Maps.
  ///
  /// Returns [true] if successful, [false] otherwise.
  static Future<bool> openDirectionsToAddress(String address) async {
    if (address.isEmpty) return false;

    final encodedAddress = Uri.encodeComponent(address);
    Uri? primaryUri;
    Uri? fallbackUri;

    if (Platform.isIOS) {
      // Apple Maps
      primaryUri = Uri.parse('https://maps.apple.com/?daddr=$encodedAddress');
      // Google Maps fallback for iOS
      fallbackUri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$encodedAddress');
    } else {
      // Google Maps for Android
      primaryUri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$encodedAddress');
    }

    try {
      if (await canLaunchUrl(primaryUri)) {
        await launchUrl(primaryUri, mode: LaunchMode.externalApplication);
        return true;
      } else if (fallbackUri != null && await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        return true;
      }
    } catch (e) {
      // Log error if needed
      print('Error launching maps: $e');
    }

    return false;
  }
}
