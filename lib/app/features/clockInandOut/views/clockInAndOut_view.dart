import 'dart:async';

import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/widgets/platform_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/config/environment.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class ClockInAndOutView extends ConsumerStatefulWidget {
  final String email;

  const ClockInAndOutView({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<ClockInAndOutView> createState() => _ClockInAndOutViewState();
}

class _ClockInAndOutViewState extends ConsumerState<ClockInAndOutView> {
  static const bool _enableLiveLocationStream = bool.fromEnvironment(
    'ENABLE_LIVE_LOCATION_STREAM',
    defaultValue: false,
  );

  Position? _currentPosition;
  bool _isLoading = true;
  String? _locationError;
  StreamSubscription<Position>? _positionSubscription;
  bool? _isLocationServiceEnabled;
  LocationPermission? _locationPermission;
  DateTime? _lastLocationUpdateAt;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _locationError = null;
      });
    }

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      _isLocationServiceEnabled = serviceEnabled;
      if (!serviceEnabled) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _locationError =
                'Location services are off. Please enable GPS to load your current location.';
          });
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      _locationPermission = permission;
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        _locationPermission = permission;
        if (permission == LocationPermission.denied) {
          debugPrint('Location permission denied');
          if (mounted) {
            setState(() {
              _isLoading = false;
              _locationError =
                  'Location permission denied. Allow permission to show your current location.';
            });
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permission permanently denied');
        if (mounted) {
          setState(() {
            _isLoading = false;
            _locationError =
                'Location permission is permanently denied. Open app settings to allow location.';
          });
        }
        return;
      }

      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 15),
          ),
        );
      } catch (e) {
        debugPrint('Primary location fetch failed, trying last known: $e');
        position = await Geolocator.getLastKnownPosition();
      }

      if (position == null) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _locationError =
                'Unable to get current location. Please try again in an open area.';
          });
        }
        return;
      }

      setState(() {
        _currentPosition = position;
        _isLoading = false;
        _locationError = null;
        _lastLocationUpdateAt = DateTime.now();
      });
      if (_enableLiveLocationStream) {
        _startLocationUpdates();
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _locationError = 'Error getting location: $e';
        });
      }
    }
  }

  void _startLocationUpdates() {
    _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((position) {
      if (!mounted) return;
      setState(() {
        _currentPosition = position;
        _locationError = null;
        _lastLocationUpdateAt = DateTime.now();
      });
    }, onError: (Object error) {
      debugPrint('Location stream error: $error');
    });
  }

  Future<void> _openLocationSettings() async {
    final opened = await Geolocator.openLocationSettings();
    if (opened) {
      await _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: Stack(
        children: [
          // Map Section
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _buildMapSection(),
          ),

          // Content Section
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Section with Back Button and Total Hours
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space4),
                  child: Row(
                    children: [
                      // Back Button
                      Padding(
                        padding:
                            const EdgeInsets.only(right: BauhausDesign.space3),
                        child: BauhausIconButton(
                          icon: Icons.arrow_back,
                          onPressed: () => Navigator.pop(context),
                          variant: BauhausActionVariant.neutral,
                        ),
                      ),

                      // Total Work Hours Card
                      Expanded(
                        child: BauhausCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space4,
                            vertical: BauhausDesign.space3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total work hours today',
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      color: BauhausDesign.textDark,
                                    ),
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  // final timerService = ref.watch(timerServiceProvider); // Not used directly in text
                                  return Text(
                                    '0:00',
                                    style: BauhausDesign.getTextTheme(context)
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: BauhausDesign.primary,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Swipeable Scheduled Items Area
                Expanded(
                  child: Stack(
                    children: [
                      if (kDebugMode && !AppConfig.isProduction)
                        Positioned(
                          top: BauhausDesign.space3,
                          left: BauhausDesign.space4,
                          right: BauhausDesign.space4,
                          child: _buildDebugDiagnosticsCard(),
                        ),
                      // Fixed Bottom Section with White Background
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: BauhausDesign.surfaceWhite,
                            border: const Border(
                              top: BorderSide(
                                color: BauhausDesign.neutral,
                                width: 2,
                              ),
                            ),
                            boxShadow: const [BauhausDesign.shadowHard],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: BauhausDesign.space6),
                              // Nothing scheduled text
                              Text(
                                'Nothing scheduled today',
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                              const SizedBox(height: BauhausDesign.space6),

                              // Clock In Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: BauhausDesign.space4),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final timer =
                                        ref.watch(timerServiceProvider);
                                    return GestureDetector(
                                      onTap: () {
                                        if (timer.isRunning) {
                                          timer.stop();
                                        } else {
                                          timer.start();
                                        }
                                      },
                                      child: Container(
                                        width: 180,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: timer.isRunning
                                              ? BauhausDesign.error
                                              : BauhausDesign.primary,
                                          border: Border.all(
                                            color: BauhausDesign.neutral,
                                            width: BauhausDesign.borderThick,
                                          ),
                                          boxShadow: const [
                                            BauhausDesign.shadowHardLg,
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              timer.isRunning
                                                  ? Icons.stop_circle_outlined
                                                  : Icons.play_circle_outline,
                                              color: BauhausDesign.surfaceWhite,
                                              size: 48,
                                            ),
                                            const SizedBox(
                                                height: BauhausDesign.space2),
                                            Text(
                                              timer.isRunning
                                                  ? 'Clock out'
                                                  : 'Clock in',
                                              style: BauhausDesign.getTextTheme(
                                                      context)
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: BauhausDesign
                                                        .surfaceWhite,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Bottom Cards
                              Padding(
                                padding:
                                    const EdgeInsets.all(BauhausDesign.space4),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildActionCard(
                                        context,
                                        'My requests',
                                        Icons.check_circle_outline,
                                        BauhausDesign.warning,
                                        () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => RequestsView(
                                              email: widget.email,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: BauhausDesign.space4),
                                    Expanded(
                                      child: _buildActionCard(
                                        context,
                                        'Timesheet',
                                        Icons.calendar_today,
                                        BauhausDesign.secondary,
                                        () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TimesheetView(
                                              email: widget.email,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    if (_isLoading) {
      return const BauhausLoadingState(message: 'Locating...');
    }

    if (_currentPosition == null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Keep map visible with a fallback center while location is being resolved.
          const PlatformMapWidget(
            center: LatLng(-33.8688, 151.2093), // Sydney fallback
            zoom: 10.5,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(BauhausDesign.space6),
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                boxShadow: const [BauhausDesign.shadowSoft],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _locationError ?? 'Location unavailable',
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(color: BauhausDesign.textDark),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Wrap(
                    spacing: BauhausDesign.space2,
                    runSpacing: BauhausDesign.space2,
                    alignment: WrapAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: _getCurrentLocation,
                        child: const Text('Retry'),
                      ),
                      OutlinedButton(
                        onPressed: _openLocationSettings,
                        child: const Text('Open Location Settings'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return PlatformMapWidget(
      center: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      zoom: 16.0,
    );
  }

  Widget _buildDebugDiagnosticsCard() {
    final lat = _currentPosition?.latitude;
    final lng = _currentPosition?.longitude;
    final locationLine = lat != null && lng != null
        ? 'lat: ${lat.toStringAsFixed(6)}, lng: ${lng.toStringAsFixed(6)}'
        : 'lat/lng: unavailable';
    final serviceLine =
        'serviceEnabled: ${_isLocationServiceEnabled == true ? 'true' : _isLocationServiceEnabled == false ? 'false' : 'unknown'}';
    final permissionLine =
        'permission: ${_locationPermission?.name ?? 'unknown'}';
    final streamLine =
        'streamActive: ${_positionSubscription != null} (liveStreamEnabled: $_enableLiveLocationStream)';
    final lastUpdateLine = _lastLocationUpdateAt == null
        ? 'lastUpdate: n/a'
        : 'lastUpdate: ${_lastLocationUpdateAt!.toIso8601String()}';

    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEBUG MAP DIAGNOSTICS',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            locationLine,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          Text(
            serviceLine,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          Text(
            permissionLine,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          Text(
            streamLine,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          Text(
            lastUpdateLine,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          if (_locationError != null) ...[
            const SizedBox(height: BauhausDesign.space1),
            Text(
              'locationError: $_locationError',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.error,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
          const SizedBox(height: BauhausDesign.space1),
          Text(
            'Map auth hint: If lat/lng updates but tiles are blank, verify Maps SDK for Android key restriction matches SHA1 + package `com.bishal.invoice.dev`.',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon,
      Color iconColor, VoidCallback onTap) {
    return BauhausCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
          vertical: BauhausDesign.space4, horizontal: BauhausDesign.space4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
