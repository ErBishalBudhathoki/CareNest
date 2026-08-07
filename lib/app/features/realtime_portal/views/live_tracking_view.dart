import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/realtime_tracking_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/services/websocket_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Live Tracking View
/// Real-time worker location tracking with map
class LiveTrackingView extends ConsumerStatefulWidget {
  const LiveTrackingView({super.key});

  @override
  ConsumerState<LiveTrackingView> createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends ConsumerState<LiveTrackingView> {
  static const String _developmentSocketUrl = 'http://localhost:3000';

  GoogleMapController? _mapController;
  final WebSocketService _wsService = WebSocketService();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      return;
    }
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    _wsService.connect(
      serverUrl: _developmentSocketUrl,
      userId: 'client-123',
      userType: 'client',
      token: 'auth-token',
    );

    _wsService.onLocationUpdate = (location) {
      ref
          .read(realtimeTrackingViewModelProvider.notifier)
          .handleLocationUpdate(location);
      _updateMarker(location.latitude, location.longitude);
    };

    _wsService.onGeofenceEvent = (event) {
      ref
          .read(realtimeTrackingViewModelProvider.notifier)
          .handleGeofenceEvent(event);
      _showGeofenceAlert(event.event);
    };
  }

  void _updateMarker(double lat, double lng) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('worker'),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'Worker Location'),
        ),
      };
    });

    // Animate camera to new position
    _mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }

  void _showGeofenceAlert(String event) {
    String message = '';
    IconData icon = Icons.info;
    Color color = AppColors.colorPrimary;

    switch (event) {
      case 'approaching':
        message = 'Worker is approaching your location';
        icon = Icons.directions_walk;
        color = AppColors.colorWarning;
        break;
      case 'arrived':
        message = 'Worker has arrived at your location';
        icon = Icons.check_circle;
        color = AppColors.colorSuccess;
        break;
      case 'departed':
        message = 'Worker has left your location';
        icon = Icons.exit_to_app;
        color = AppColors.error;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location Update',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _wsService.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      return Scaffold(
        backgroundColor: AppColors.colorBackground,
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          elevation: 0,
          title: const Text(
            'Live Insights',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_off_rounded,
                    color: AppColors.colorPrimary,
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Live insights are not available in this App Store build.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorFontPrimary,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'The production socket endpoint is not enabled yet, so this screen is hidden from reviewers and users until it is fully configured.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.colorFontSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final state = ref.watch(realtimeTrackingViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Live Insights',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (state.isTracking)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.colorSuccess,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.circle, color: Colors.white, size: 8),
                  SizedBox(width: 6),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Map
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(
                        37.7749,
                        -122.4194,
                      ), // Default: San Francisco
                      zoom: 14,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  ),
                ),

                // Info Panel
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: state.liveLocation != null
                        ? _buildLocationInfo(state)
                        : _buildNoTracking(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildLocationInfo(state) {
    final location = state.liveLocation!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ETA Card
          if (location.eta != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.colorPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.colorPrimary,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Arrival',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666), // BauhausDesign.textMuted
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${location.eta} minutes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // Distance
          if (location.distance != null)
            _buildInfoRow(
              icon: Icons.straighten,
              label: 'Distance',
              value: '${(location.distance! / 1000).toStringAsFixed(1)} km',
            ),
          const SizedBox(height: 12),

          // Status
          _buildInfoRow(
            icon: Icons.info_outline,
            label: 'Status',
            value: location.status ?? 'En Route',
          ),
          const SizedBox(height: 12),

          // Accuracy
          _buildInfoRow(
            icon: Icons.gps_fixed,
            label: 'Accuracy',
            value: '${location.accuracy.toStringAsFixed(0)}m',
          ),
          const SizedBox(height: 12),

          // Last Updated
          _buildInfoRow(
            icon: Icons.update,
            label: 'Last Updated',
            value: _formatTime(location.timestamp),
          ),
        ],
      ),
    );
  }

  Widget _buildNoTracking() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: Color(0xFF666666), // BauhausDesign.textMuted
          ),
          const SizedBox(height: 16),
          Text(
            'No Active Insights',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Insights will start when worker begins journey',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666), // BauhausDesign.textMuted
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color(0xFF666666),
          size: 20,
        ), // BauhausDesign.textMuted
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666), // BauhausDesign.textMuted
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontPrimary,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${diff.inHours}h ago';
    }
  }
}
