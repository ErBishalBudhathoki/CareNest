

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUIService {
  static const MethodChannel _channel = MethodChannel('com.bishal.invoice/system_ui');
  
  /// Hide system UI (navigation bar and status bar) for immersive experience
  static Future<void> hideSystemUI() async {
    try {
      debugPrint('SystemUI: Calling hideSystemUI');
      await _channel.invokeMethod('hideSystemUI');
      debugPrint('SystemUI: hideSystemUI called successfully');
    } on PlatformException catch (e) {
      debugPrint('Failed to hide system UI: ${e.message}');
    }
  }
  
  /// Show system UI (navigation bar and status bar)
  static Future<void> showSystemUI() async {
    try {
      debugPrint('SystemUI: Calling showSystemUI');
      await _channel.invokeMethod('showSystemUI');
      debugPrint('SystemUI: showSystemUI called successfully');
    } on PlatformException catch (e) {
      debugPrint('Failed to show system UI: ${e.message}');
    }
  }
}