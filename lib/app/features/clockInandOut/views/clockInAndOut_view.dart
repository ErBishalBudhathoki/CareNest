import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/widgets/platform_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

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
  Position? _currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permission permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
      setState(() => _isLoading = false);
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
                      // Fixed Bottom Section with White Background
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: BauhausDesign.surfaceWhite,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(BauhausDesign.radiusLg),
                              topRight: Radius.circular(BauhausDesign.radiusLg),
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
                                          shape: BoxShape.circle,
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
      return Center(
        child: Text(
          'Location unavailable',
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
      );
    }

    double offsetLatitude = _currentPosition!.latitude - 0.0025;

    return PlatformMapWidget(
      center: LatLng(offsetLatitude, _currentPosition!.longitude),
      zoom: 16.0,
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
