import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class PlatformMapWidget extends StatefulWidget {
  final LatLng center;
  final double zoom;
  final List<LatLng> routePoints;
  final LatLng? startMarker;
  final LatLng? endMarker;
  final bool showMyLocation;

  const PlatformMapWidget({
    super.key,
    required this.center,
    required this.zoom,
    this.routePoints = const [],
    this.startMarker,
    this.endMarker,
    this.showMyLocation = true,
  });

  @override
  State<PlatformMapWidget> createState() => _PlatformMapWidgetState();
}

class _PlatformMapWidgetState extends State<PlatformMapWidget> {
  google_maps.GoogleMapController? _googleController;

  @override
  void didUpdateWidget(covariant PlatformMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final centerChanged = oldWidget.center.latitude != widget.center.latitude ||
        oldWidget.center.longitude != widget.center.longitude;

    if (_googleController == null) return;

    final routeChanged =
        oldWidget.routePoints.length != widget.routePoints.length;

    if (routeChanged && widget.routePoints.length > 1) {
      final bounds = _computeBounds(widget.routePoints);
      if (bounds != null) {
        _googleController!.animateCamera(
          google_maps.CameraUpdate.newLatLngBounds(bounds, 48),
        );
        return;
      }
    }

    if (centerChanged) {
      _googleController!.animateCamera(
        google_maps.CameraUpdate.newCameraPosition(
          google_maps.CameraPosition(
            target: google_maps.LatLng(
              widget.center.latitude,
              widget.center.longitude,
            ),
            zoom: widget.zoom,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _googleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasRoute = widget.routePoints.length > 1;
    final start = widget.startMarker;
    final end = widget.endMarker;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final annotations = <apple_maps.Annotation>{};
      if (start != null) {
        annotations.add(
          apple_maps.Annotation(
            annotationId: apple_maps.AnnotationId('route_start'),
            position: apple_maps.LatLng(start.latitude, start.longitude),
          ),
        );
      }
      if (end != null) {
        annotations.add(
          apple_maps.Annotation(
            annotationId: apple_maps.AnnotationId('route_end'),
            position: apple_maps.LatLng(end.latitude, end.longitude),
          ),
        );
      }
      if (annotations.isEmpty) {
        annotations.add(
          apple_maps.Annotation(
            annotationId: apple_maps.AnnotationId('current_location'),
            position: apple_maps.LatLng(
              widget.center.latitude,
              widget.center.longitude,
            ),
          ),
        );
      }

      final polylines = hasRoute
          ? <apple_maps.Polyline>{
              apple_maps.Polyline(
                polylineId: apple_maps.PolylineId('tracked_route'),
                color: const Color(0xFF4C46C6),
                width: 6,
                points: widget.routePoints
                    .map((p) => apple_maps.LatLng(p.latitude, p.longitude))
                    .toList(),
              ),
            }
          : null;

      return apple_maps.AppleMap(
        initialCameraPosition: apple_maps.CameraPosition(
          target: apple_maps.LatLng(
              widget.center.latitude, widget.center.longitude),
          zoom: widget.zoom,
        ),
        myLocationEnabled: widget.showMyLocation,
        annotations: annotations,
        polylines: polylines,
      );
    } else {
      final markers = <google_maps.Marker>{};
      if (start != null) {
        markers.add(
          google_maps.Marker(
            markerId: const google_maps.MarkerId('route_start'),
            position: google_maps.LatLng(start.latitude, start.longitude),
          ),
        );
      }
      if (end != null) {
        markers.add(
          google_maps.Marker(
            markerId: const google_maps.MarkerId('route_end'),
            position: google_maps.LatLng(end.latitude, end.longitude),
          ),
        );
      }
      if (markers.isEmpty) {
        markers.add(
          google_maps.Marker(
            markerId: const google_maps.MarkerId('current_location'),
            position: google_maps.LatLng(
              widget.center.latitude,
              widget.center.longitude,
            ),
          ),
        );
      }

      final polylines = hasRoute
          ? <google_maps.Polyline>{
              google_maps.Polyline(
                polylineId: const google_maps.PolylineId('tracked_route'),
                color: const Color(0xFF4C46C6),
                width: 6,
                points: widget.routePoints
                    .map((p) => google_maps.LatLng(p.latitude, p.longitude))
                    .toList(),
              ),
            }
          : const <google_maps.Polyline>{};

      return google_maps.GoogleMap(
        liteModeEnabled: false,
        myLocationEnabled: widget.showMyLocation,
        myLocationButtonEnabled: widget.showMyLocation,
        onMapCreated: (controller) {
          _googleController = controller;
          if (widget.routePoints.length > 1) {
            final bounds = _computeBounds(widget.routePoints);
            if (bounds != null) {
              controller.animateCamera(
                google_maps.CameraUpdate.newLatLngBounds(bounds, 48),
              );
            }
          }
        },
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
              widget.center.latitude, widget.center.longitude),
          zoom: widget.zoom,
        ),
        markers: markers,
        polylines: polylines,
      );
    }
  }

  google_maps.LatLngBounds? _computeBounds(List<LatLng> points) {
    if (points.isEmpty) return null;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final p in points) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }

    // Avoid invalid zero-area bounds.
    if (minLat == maxLat) {
      minLat -= 0.0008;
      maxLat += 0.0008;
    }
    if (minLng == maxLng) {
      minLng -= 0.0008;
      maxLng += 0.0008;
    }

    return google_maps.LatLngBounds(
      southwest: google_maps.LatLng(minLat, minLng),
      northeast: google_maps.LatLng(maxLat, maxLng),
    );
  }
}

// Custom LatLng class to avoid platform-specific dependencies in the main code
class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);
}
