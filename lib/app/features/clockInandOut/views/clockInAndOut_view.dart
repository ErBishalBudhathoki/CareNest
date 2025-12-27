import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/widgets/platform_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_view.dart';

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
          return;
        }
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      // Back Button
                      Container(
                        margin: EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      // Total Work Hours Card
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                24.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1F2937)
                                    .withOpacity(0.1),
                                blurRadius: 8.0 +
                                    4.0,
                                offset: Offset(0, 4.0),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total work hours today',
                                style: const TextStyle(fontSize: 14).copyWith(
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final timerService =
                                      ref.watch(timerServiceProvider);
                                  return Text(
                                    '0:00',
                                    style: const TextStyle(fontSize: 14).copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1F2937),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(24.0),
                              topRight:
                                  Radius.circular(24.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 24.0),
                              // Nothing scheduled text
                              Text(
                                'Nothing scheduled today',
                                style: const TextStyle(fontSize: 14).copyWith(
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                              SizedBox(height: 24.0),
                              // Clock In Button
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final timer =
                                        ref.watch(timerServiceProvider);
                                    return Container(
                                      width: 200,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF667EEA),
                                      ),
                                      child: Material(
                                        color: Colors.white
                                            .withOpacity(0.1),
                                        child: InkWell(
                                          customBorder: const CircleBorder(),
                                          onTap: () {
                                            if (timer.isRunning) {
                                              timer.stop();
                                            } else {
                                              timer.start();
                                            }
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.timer_outlined,
                                                color: Colors.white,
                                                size: 48,
                                              ),
                                              SizedBox(
                                                  height:
                                                      8.0),
                                              Text(
                                                timer.isRunning
                                                    ? 'Clock out'
                                                    : 'Clock in',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Bottom Cards
                              Padding(
                                padding:
                                    EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildActionCard(
                                        'My requests',
                                        Icons.check_circle_outline,
                                        Colors.orange,
                                        () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => RequestsView(
                                              email: widget.email,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    Expanded(
                                      child: _buildActionCard(
                                        'Timesheet',
                                        Icons.calendar_today,
                                        Colors.blue,
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
                              SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ),

                      // Scheduled Items Panel (when swiped up)
                      // DraggableScrollableSheet(
                      //   initialChildSize: 0.1,
                      //   minChildSize: 0.1,
                      //   maxChildSize: 0.6,
                      //   builder: (context, scrollController) {
                      //     return Container(
                      //       decoration: const BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(30),
                      //           topRight: Radius.circular(30),
                      //         ),
                      //       ),
                      //       child: SingleChildScrollView(
                      //         controller: scrollController,
                      //         child: Column(
                      //           children: [
                      //             // Drag Handle
                      //             Container(
                      //               margin: const EdgeInsets.symmetric(
                      //                   vertical: 12),
                      //               width: 40,
                      //               height: 4,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.grey[300],
                      //                 borderRadius: BorderRadius.circular(2),
                      //               ),
                      //             ),
                      //             // Add your scheduled items here
                      //             ListView.builder(
                      //               shrinkWrap: true,
                      //               physics:
                      //                   const NeverScrollableScrollPhysics(),
                      //               itemCount:
                      //                   0, // Replace with actual scheduled items count
                      //               itemBuilder: (context, index) {
                      //                 return Container(); // Replace with actual scheduled item widget
                      //               },
                      //             ),
                      //             // Spacer to ensure content can be scrolled up
                      //             SizedBox(
                      //                 height:
                      //                     MediaQuery.of(context).size.height *
                      //                         0.8),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
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

  // Widget _buildMapSection() {
  //   if (_isLoading) {
  //     return const Center(child: CircularProgressIndicator());
  //   }
  //
  //   if (_currentPosition == null) {
  //     return const Center(child: Text('Location unavailable'));
  //   }
  //
  //   // Calculate the offset to move the marker to 30% from the top of the screen
  //   double offsetLatitude =
  //       _currentPosition!.latitude - 0.0025; // Adjust this value as needed
  //
  //   return FlutterMap(
  //     options: MapOptions(
  //       center: LatLng(offsetLatitude,
  //           _currentPosition!.longitude), // Shift the map center upward
  //       zoom: 16.0, // Adjust the zoom level for better visibility
  //     ),
  //     children: [
  //       TileLayer(
  //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //         userAgentPackageName: 'com.bishal.invoice',
  //       ),
  //       MarkerLayer(
  //         markers: [
  //           Marker(
  //             point: LatLng(
  //                 _currentPosition!.latitude, _currentPosition!.longitude),
  //             child: Container(
  //               width: 20,
  //               height: 20,
  //               decoration: BoxDecoration(
  //                 color: Colors.blue,
  //                 shape: BoxShape.circle,
  //                 border: Border.all(color: Colors.white, width: 2),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMapSection() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentPosition == null) {
      return const Center(child: Text('Location unavailable'));
    }

    double offsetLatitude = _currentPosition!.latitude - 0.0025;

    return PlatformMapWidget(
      center: LatLng(offsetLatitude, _currentPosition!.longitude),
      zoom: 16.0,
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, Color iconColor, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F2937).withOpacity(0.1),
            blurRadius: 8.0 + 4.0,
            spreadRadius: 0,
            offset: Offset(0, 4.0),
          ),
        ],
      ),
      child: Material(
        color: Colors.white.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 32),
                SizedBox(height: 12.0),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14).copyWith(
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
