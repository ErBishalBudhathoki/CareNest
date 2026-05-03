import 'dart:async';

import 'package:carenest/app/features/clockInandOut/providers/today_work_hours_provider.dart';
import 'package:carenest/app/features/worker/viewmodels/worker_dashboard_viewmodel.dart';
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
import 'package:intl/intl.dart';

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
  late final PageController _pageController;
  int _currentDayOffset = 0;

  DateTime get _selectedDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + _currentDayOffset);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentDayOffset) {
        setState(() => _currentDayOffset = page);
      }
    });
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _buildMapSection(),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BauhausDesign.space4, BauhausDesign.space2,
                    BauhausDesign.space4, 0,
                  ),
                  child: BauhausIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                    variant: BauhausActionVariant.neutral,
                  ),
                ),
                _buildTotalHoursHero(),
                if (kDebugMode && !AppConfig.isProduction)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
                    child: _buildDebugDiagnosticsCard(),
                  ),
                const SizedBox(height: BauhausDesign.space2),
                _buildDayNavigation(),
                const SizedBox(height: BauhausDesign.space3),
                Expanded(child: _buildShiftCards()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BauhausDesign.space4, BauhausDesign.space3,
                    BauhausDesign.space4, BauhausDesign.space6,
                  ),
                  child: _buildActionButtons(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalHoursHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4, vertical: BauhausDesign.space2),
      child: Consumer(
        builder: (context, ref, child) {
          final hoursAsync = ref.watch(todayWorkHoursProvider(widget.email));
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('TOTAL TODAY',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted, letterSpacing: 2.0)),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                hoursAsync.when(
                  data: (hours) => hours.toStringAsFixed(1),
                  loading: () => '--',
                  error: (_, __) => '--',
                ),
                style: BauhausDesign.getTextTheme(context).displayLarge?.copyWith(
                      fontWeight: FontWeight.w900, color: BauhausDesign.primary, height: 1.0),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text('HOURS WORKED',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.w900, color: BauhausDesign.textDark)),
              const SizedBox(height: BauhausDesign.space2),
              Container(width: 40, height: 3, color: BauhausDesign.neutral),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDayNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BauhausIconButton(
            icon: Icons.chevron_left,
            onPressed: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            variant: BauhausActionVariant.neutral, isSmall: true,
          ),
          const SizedBox(width: BauhausDesign.space4),
          Text(DateFormat('EEE dd MMM').format(_selectedDate).toUpperCase(),
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w900, color: BauhausDesign.textDark)),
          const SizedBox(width: BauhausDesign.space4),
          BauhausIconButton(
            icon: Icons.chevron_right,
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            variant: BauhausActionVariant.neutral, isSmall: true,
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCards() {
    return Consumer(
      builder: (context, ref, child) {
        final dashboardAsync = ref.watch(workerDashboardViewModelProvider);
        return dashboardAsync.when(
          loading: () => const BauhausLoadingState(message: 'Loading shifts...'),
          error: (error, _) => BauhausErrorState(
            message: error.toString(),
            onRetry: () => ref.read(workerDashboardViewModelProvider.notifier).refresh(),
          ),
          data: (dashboard) {
            return PageView(
              controller: _pageController,
              children: [
                _buildDayShiftList(dashboard.todayShifts, -1),
                _buildDayShiftList(dashboard.todayShifts, 0),
                _buildDayShiftList(dashboard.todayShifts, 1),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDayShiftList(List<dynamic> allShifts, int dayOffset) {
    final targetDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + dayOffset);
    final shifts = allShifts.where((shift) {
      final shiftDate = shift.startTime is DateTime
          ? shift.startTime as DateTime
          : DateTime.tryParse(shift.startTime?.toString() ?? '');
      if (shiftDate == null) return dayOffset == 0;
      return shiftDate.year == targetDate.year && shiftDate.month == targetDate.month && shiftDate.day == targetDate.day;
    }).toList();

    if (shifts.isEmpty) {
      return ListView(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: const BauhausEmptyState(icon: Icons.event_busy, title: 'No shifts scheduled', message: 'No shifts found for this date.'),
        ),
      ]);
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      itemCount: shifts.length,
      separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space2),
      itemBuilder: (context, index) => _buildShiftCard(shifts[index]),
    );
  }

  Widget _buildShiftCard(dynamic shift) {
    final startTime = _formatShiftTime(shift.startTime);
    final endTime = _formatShiftTime(shift.endTime);
    final duration = shift.durationHours?.toStringAsFixed(1) ?? '0.0';
    // ShiftModel.status is ShiftStatus enum, extract its string value
    final statusCode = shift.status?.value?.toString() ?? 'pending';
    final clientName = shift.clientName as String? ?? 'Unknown Client';
    // ShiftModel has no 'role' field; use employeeName instead
    final employeeName = shift.employeeName as String? ?? 'Shift';
    final breakMin = shift.breakDuration ?? 0;

    Color borderColor;
    switch (statusCode.toLowerCase()) {
      case 'active':
      case 'in_progress':
        borderColor = BauhausDesign.primary;
        break;
      case 'completed':
        borderColor = BauhausDesign.success;
        break;
      case 'cancelled':
        borderColor = BauhausDesign.neutral;
        break;
      default:
        borderColor = BauhausDesign.warning;
    }

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
          top: const BorderSide(color: BauhausDesign.neutral, width: 2),
          right: const BorderSide(color: BauhausDesign.neutral, width: 2),
          bottom: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$startTime — $endTime',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w900, color: BauhausDesign.textDark)),
          const SizedBox(height: BauhausDesign.space1),
          Text('$employeeName · ${duration}h · ${breakMin}m break',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textMuted)),
          const SizedBox(height: BauhausDesign.space1),
          Text('Client: $clientName',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textMuted)),
        ],
      ),
    );
  }

  String _formatShiftTime(dynamic time) {
    if (time is DateTime) return DateFormat('h:mm a').format(time);
    if (time is String) {
      final parsed = DateTime.tryParse(time);
      if (parsed != null) return DateFormat('h:mm a').format(parsed);
      return time;
    }
    return '--:--';
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RequestsView(email: widget.email))),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.accent,
                border: Border.all(color: BauhausDesign.neutral, width: BauhausDesign.borderThick),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline, color: BauhausDesign.textDark, size: 28),
                  const SizedBox(height: BauhausDesign.space2),
                  Text('REQUESTS', style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w900, color: BauhausDesign.textDark)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: BauhausDesign.space4),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TimesheetView(email: widget.email))),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary,
                border: Border.all(color: BauhausDesign.neutral, width: BauhausDesign.borderThick),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, color: BauhausDesign.textLight, size: 28),
                  const SizedBox(height: BauhausDesign.space2),
                  Text('TIMESHEET', style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w900, color: BauhausDesign.textLight)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    if (_isLoading) return const BauhausLoadingState(message: 'Locating...');
    if (_currentPosition == null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          const PlatformMapWidget(center: LatLng(-33.8688, 151.2093), zoom: 10.5),
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
                  Text(_locationError ?? 'Location unavailable', textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(color: BauhausDesign.textDark)),
                  const SizedBox(height: BauhausDesign.space3),
                  Wrap(spacing: BauhausDesign.space2, runSpacing: BauhausDesign.space2, alignment: WrapAlignment.center, children: [
                    OutlinedButton(onPressed: _getCurrentLocation, child: const Text('Retry')),
                    OutlinedButton(onPressed: _openLocationSettings, child: const Text('Open Location Settings')),
                  ]),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return PlatformMapWidget(
      center: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 16.0);
  }

  Widget _buildDebugDiagnosticsCard() {
    final lat = _currentPosition?.latitude;
    final lng = _currentPosition?.longitude;
    final locationLine = lat != null && lng != null
        ? 'lat: ${lat.toStringAsFixed(6)}, lng: ${lng.toStringAsFixed(6)}'
        : 'lat/lng: unavailable';
    final serviceLine = 'serviceEnabled: ${_isLocationServiceEnabled == true ? 'true' : _isLocationServiceEnabled == false ? 'false' : 'unknown'}';
    final permissionLine = 'permission: ${_locationPermission?.name ?? 'unknown'}';
    final streamLine = 'streamActive: ${_positionSubscription != null} (liveStreamEnabled: $_enableLiveLocationStream)';
    final lastUpdateLine = _lastLocationUpdateAt == null ? 'lastUpdate: n/a' : 'lastUpdate: ${_lastLocationUpdateAt!.toIso8601String()}';

    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DEBUG MAP DIAGNOSTICS', style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark, fontWeight: FontWeight.bold)),
          const SizedBox(height: BauhausDesign.space1),
          Text(locationLine, style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textDark)),
          Text(serviceLine, style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textDark)),
          Text(permissionLine, style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textDark)),
          Text(streamLine, style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textDark)),
          Text(lastUpdateLine, style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textDark)),
          if (_locationError != null) ...[
            const SizedBox(height: BauhausDesign.space1),
            Text('locationError: $_locationError', style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.error, fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: BauhausDesign.space1),
          Text('Map auth hint: If lat/lng updates but tiles are blank, verify Maps SDK for Android key restriction matches SHA1 + package `com.bishal.invoice.dev`.',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(color: BauhausDesign.textDark)),
        ],
      ),
    );
  }
}
