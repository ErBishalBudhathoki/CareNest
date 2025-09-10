import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class PlatformMapWidget extends StatelessWidget {
  final LatLng center;
  final double zoom;

  const PlatformMapWidget({
    Key? key,
    required this.center,
    required this.zoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return apple_maps.AppleMap(
        initialCameraPosition: apple_maps.CameraPosition(
          target: apple_maps.LatLng(center.latitude, center.longitude),
          zoom: zoom,
        ),
        annotations: {
          apple_maps.Annotation(
            annotationId: apple_maps.AnnotationId('current_location'),
            position: apple_maps.LatLng(center.latitude, center.longitude),
          ),
        },
      );
    } else {
      return google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(center.latitude, center.longitude),
          zoom: zoom,
        ),
        markers: {
          google_maps.Marker(
            markerId: const google_maps.MarkerId('current_location'),
            position: google_maps.LatLng(center.latitude, center.longitude),
          ),
        },
      );
    }
  }
}

// Custom LatLng class to avoid platform-specific dependencies in the main code
class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);
}