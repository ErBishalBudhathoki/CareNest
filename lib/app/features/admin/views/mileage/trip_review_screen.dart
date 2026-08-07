import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/admin/viewmodels/admin_mileage_view_model.dart';
import 'package:carenest/app/shared/widgets/platform_map_widget.dart';

class TripReviewScreen extends ConsumerStatefulWidget {
  final String tripId;

  const TripReviewScreen({super.key, required this.tripId});

  @override
  ConsumerState<TripReviewScreen> createState() => _TripReviewScreenState();
}

class _TripReviewScreenState extends ConsumerState<TripReviewScreen> {
  late TextEditingController _distanceController;
  late TextEditingController _clientIdController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _distanceController = TextEditingController();
    _clientIdController = TextEditingController();
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(adminMileageViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);

    // Find trip in list (assuming it's loaded)
    final trip = viewModel.trips.firstWhere(
      (t) => t.id == widget.tripId,
      orElse: () => throw Exception('Trip not found'),
    );
    final rawTrip = viewModel.rawTripsById[trip.id];
    final routePoints = _extractRoutePoints(rawTrip, trip);
    final startPoint = routePoints.isNotEmpty ? routePoints.first : null;
    final endPoint = routePoints.isNotEmpty ? routePoints.last : null;
    final status = _normalizeStatus(
      trip.status,
      rawTrip?['adminApprovalStatus'],
    );
    final updatedAt = _tryParseDate(rawTrip?['updatedAt']?.toString());

    // Initialize controllers if not editing and values differ (simple sync)
    if (!_isEditing) {
      if (_distanceController.text.isEmpty)
        _distanceController.text = trip.distance.toString();
      if (_clientIdController.text.isEmpty)
        _clientIdController.text = trip.clientId ?? '';
    }

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'REVIEW TRIP',
          style: textTheme.displaySmall?.copyWith(
            color: BauhausDesign.textDark,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.neutral),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                // Reset values on cancel
                if (!_isEditing) {
                  _distanceController.text = trip.distance.toString();
                  _clientIdController.text = trip.clientId ?? '';
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Placeholder (Geometric)
            ClipRRect(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                child: routePoints.length >= 2
                    ? PlatformMapWidget(
                        center: endPoint!,
                        zoom: 14,
                        routePoints: routePoints,
                        startMarker: startPoint,
                        endMarker: endPoint,
                        showMyLocation: false,
                      )
                    : Container(
                        color: BauhausDesign.neutral.withOpacity(0.08),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.map,
                              size: 48,
                              color: BauhausDesign.neutral,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'MAP VISUALIZATION',
                              style: textTheme.labelLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'No tracked route data on this trip',
                              style: textTheme.bodySmall?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            if (routePoints.length >= 2)
              Text(
                'Tracked route points: ${routePoints.length}',
                style: textTheme.bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
              ),
            const SizedBox(height: BauhausDesign.space6),
            _buildDecisionBanner(context, status: status, updatedAt: updatedAt),
            const SizedBox(height: BauhausDesign.space6),

            // Details Form
            _buildLabel(context, 'EMPLOYEE'),
            Text(
              '${trip.employee?.firstName} ${trip.employee?.lastName}',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: BauhausDesign.space4),

            _buildLabel(context, 'DATE'),
            Text(
              trip.date.toString().split(' ')[0],
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: BauhausDesign.space4),

            _buildLabel(context, 'DISTANCE (MILES)'),
            if (_isEditing)
              TextField(
                controller: _distanceController,
                decoration: BauhausDesign.inputDecoration(''),
                keyboardType: TextInputType.number,
                style: textTheme.bodyLarge,
              )
            else
              Text('${trip.distance} mi', style: textTheme.headlineLarge),

            const SizedBox(height: BauhausDesign.space4),

            _buildLabel(context, 'CLIENT ID'),
            if (_isEditing)
              TextField(
                controller: _clientIdController,
                decoration: BauhausDesign.inputDecoration(''),
                style: textTheme.bodyLarge,
              )
            else
              Text(trip.clientId ?? 'N/A', style: textTheme.headlineLarge),

            const SizedBox(height: BauhausDesign.space6),

            // Actions
            if (_isEditing)
              BauhausButton(
                text: 'SAVE CHANGES',
                backgroundColor: BauhausDesign.accent,
                textColor: BauhausDesign.textDark,
                onPressed: () async {
                  final success = await ref
                      .read(adminMileageViewModelProvider.notifier)
                      .updateTripDetails(
                        trip.id,
                        double.tryParse(_distanceController.text) ??
                            trip.distance,
                        _clientIdController.text.isEmpty
                            ? null
                            : _clientIdController.text,
                      );
                  if (success) {
                    setState(() => _isEditing = false);
                  }
                },
              )
            else
              Row(
                children: [
                  Expanded(
                    child: BauhausButton(
                      text: status == 'REJECTED' ? 'MARK REJECTED' : 'REJECT',
                      backgroundColor: BauhausDesign.primary, // Red
                      onPressed: () async {
                        final success = await ref
                            .read(adminMileageViewModelProvider.notifier)
                            .updateTripStatus(trip.id, 'REJECTED');
                        if (!mounted) return;
                        if (success) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Trip rejected successfully'),
                            ),
                          );
                        } else {
                          final message =
                              ref.read(adminMileageViewModelProvider).error ??
                              'Failed to reject trip';
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: BauhausButton(
                      text: status == 'APPROVED' ? 'MARK APPROVED' : 'APPROVE',
                      backgroundColor: BauhausDesign.secondary, // Blue
                      onPressed: () async {
                        final success = await ref
                            .read(adminMileageViewModelProvider.notifier)
                            .updateTripStatus(trip.id, 'APPROVED');
                        if (!mounted) return;
                        if (success) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Trip approved successfully'),
                            ),
                          );
                        } else {
                          final message =
                              ref.read(adminMileageViewModelProvider).error ??
                              'Failed to approve trip';
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
          color: BauhausDesign.neutral.withOpacity(0.6),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDecisionBanner(
    BuildContext context, {
    required String status,
    DateTime? updatedAt,
  }) {
    final textTheme = BauhausDesign.getTextTheme(context);
    final statusColor = _getStatusColor(status);
    String decisionText;
    if (status == 'APPROVED') {
      decisionText = 'Decision: Approved';
    } else if (status == 'REJECTED') {
      decisionText = 'Decision: Rejected';
    } else {
      decisionText = 'Decision: Pending';
    }
    final subtitle = updatedAt == null
        ? 'No decision timestamp available'
        : 'Updated: ${updatedAt.toLocal().toString().split('.').first}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: statusColor,
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  decisionText,
                  style: textTheme.bodyLarge?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _normalizeStatus(String? status, dynamic rawStatus) {
    final value = (status ?? rawStatus ?? 'PENDING').toString().toUpperCase();
    if (value == 'APPROVED' || value == 'REJECTED' || value == 'PENDING') {
      return value;
    }
    return 'PENDING';
  }

  DateTime? _tryParseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'APPROVED':
        return BauhausDesign.secondary;
      case 'REJECTED':
        return BauhausDesign.primary;
      case 'PENDING':
      default:
        return BauhausDesign.accent;
    }
  }

  List<LatLng> _extractRoutePoints(
    Map<String, dynamic>? tripData,
    dynamic tripModel,
  ) {
    final points = <LatLng>[];

    final route = tripData?['routePath'];
    if (route is List) {
      for (final item in route) {
        final point = _parseCoordinateObject(item);
        if (point != null) {
          points.add(point);
        }
      }
    }

    if (points.length >= 2) {
      return _dedupeSequential(points);
    }

    final startPoint =
        _parseCoordinateObject(tripData?['startCoordinates']) ??
        _tryParseCoordinateString(tripModel.startLocation as String?);
    final endPoint =
        _parseCoordinateObject(tripData?['endCoordinates']) ??
        _tryParseCoordinateString(tripModel.endLocation as String?);

    if (startPoint != null) points.add(startPoint);
    if (endPoint != null) points.add(endPoint);

    return _dedupeSequential(points);
  }

  LatLng? _parseCoordinateObject(dynamic value) {
    if (value is! Map) return null;
    final map = Map<String, dynamic>.from(value);
    final lat = double.tryParse(map['lat']?.toString() ?? '');
    final lng = double.tryParse(map['lng']?.toString() ?? '');
    if (lat == null || lng == null) return null;
    return LatLng(lat, lng);
  }

  LatLng? _tryParseCoordinateString(String? value) {
    if (value == null) return null;
    final parts = value.split(',');
    if (parts.length != 2) return null;
    final lat = double.tryParse(parts[0].trim());
    final lng = double.tryParse(parts[1].trim());
    if (lat == null || lng == null) return null;
    return LatLng(lat, lng);
  }

  List<LatLng> _dedupeSequential(List<LatLng> points) {
    if (points.isEmpty) return points;
    final deduped = <LatLng>[points.first];
    for (final point in points.skip(1)) {
      final previous = deduped.last;
      if (previous.latitude != point.latitude ||
          previous.longitude != point.longitude) {
        deduped.add(point);
      }
    }
    return deduped;
  }
}
