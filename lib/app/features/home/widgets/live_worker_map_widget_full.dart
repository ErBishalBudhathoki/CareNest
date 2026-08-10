import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carenest/app/shared/theme/bauhaus_colors.dart';
import '../models/dashboard_models.dart';

class LiveWorkerMapWidgetFull extends StatefulWidget {
  final List<WorkerLocation>? workerLocations;
  final bool isLoading;
  final Function(WorkerLocation)? onWorkerTap;
  final LatLng? initialCenter;
  final double initialZoom;

  const LiveWorkerMapWidgetFull({
    super.key,
    this.workerLocations,
    this.isLoading = false,
    this.onWorkerTap,
    this.initialCenter,
    this.initialZoom = 12.0,
  });

  @override
  State<LiveWorkerMapWidgetFull> createState() =>
      _LiveWorkerMapWidgetFullState();
}

class _LiveWorkerMapWidgetFullState extends State<LiveWorkerMapWidgetFull> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  WorkerLocation? _selectedWorker;
  bool _showList = false;

  @override
  void initState() {
    super.initState();
    _updateMarkers();
  }

  @override
  void didUpdateWidget(LiveWorkerMapWidgetFull oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workerLocations != oldWidget.workerLocations) {
      _updateMarkers();
    }
  }

  void _updateMarkers() {
    if (widget.workerLocations == null) return;

    final markers = <Marker>{};

    for (final worker in widget.workerLocations!) {
      final marker = Marker(
        markerId: MarkerId(worker.workerId),
        position: LatLng(worker.latitude, worker.longitude),
        icon: _getMarkerIcon(worker.status),
        infoWindow: InfoWindow(
          title: worker.workerName,
          snippet: _getStatusLabel(worker.status),
          onTap: () => _onMarkerTap(worker),
        ),
        onTap: () => _onMarkerTap(worker),
      );
      markers.add(marker);
    }

    setState(() {
      _markers = markers;
    });
  }

  void _onMarkerTap(WorkerLocation worker) {
    setState(() {
      _selectedWorker = worker;
    });
    widget.onWorkerTap?.call(worker);
  }

  BitmapDescriptor _getMarkerIcon(WorkerStatus status) {
    // In production, use custom marker icons
    // For now, use default colored markers
    switch (status) {
      case WorkerStatus.available:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case WorkerStatus.enRoute:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case WorkerStatus.atAppointment:
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueYellow,
        );
      case WorkerStatus.onBreak:
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      case WorkerStatus.offline:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingState();
    }

    if (widget.workerLocations == null || widget.workerLocations!.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Stack(
              children: [
                _buildMap(),
                _buildMapControls(),
                if (_selectedWorker != null) _buildWorkerInfoCard(),
                if (_showList) _buildWorkerList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: BauhausColors.primaryYellow.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.map,
              color: BauhausColors.primaryYellow,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Live Worker Locations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: BauhausColors.textDark,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: BauhausColors.accentGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  '${widget.workerLocations!.length} active',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    final center =
        widget.initialCenter ??
        (widget.workerLocations!.isNotEmpty
            ? LatLng(
                widget.workerLocations!.first.latitude,
                widget.workerLocations!.first.longitude,
              )
            : const LatLng(-37.8136, 144.9631)); // Default: Melbourne

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: widget.initialZoom,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: true,
        onMapCreated: (controller) {
          _mapController = controller;
          _fitMarkersInView();
        },
        onTap: (_) {
          setState(() {
            _selectedWorker = null;
          });
        },
      ),
    );
  }

  Widget _buildMapControls() {
    return Positioned(
      right: 16,
      top: 16,
      child: Column(
        children: [
          // Toggle list view
          _buildControlButton(
            icon: _showList ? Icons.map : Icons.list,
            onTap: () {
              setState(() {
                _showList = !_showList;
              });
            },
            tooltip: _showList ? 'Show Map' : 'Show List',
          ),
          const SizedBox(height: 8),
          // Zoom in
          _buildControlButton(
            icon: Icons.add,
            onTap: () {
              _mapController?.animateCamera(CameraUpdate.zoomIn());
            },
            tooltip: 'Zoom In',
          ),
          const SizedBox(height: 8),
          // Zoom out
          _buildControlButton(
            icon: Icons.remove,
            onTap: () {
              _mapController?.animateCamera(CameraUpdate.zoomOut());
            },
            tooltip: 'Zoom Out',
          ),
          const SizedBox(height: 8),
          // Fit all markers
          _buildControlButton(
            icon: Icons.fit_screen,
            onTap: _fitMarkersInView,
            tooltip: 'Fit All',
          ),
          const SizedBox(height: 8),
          // My location
          _buildControlButton(
            icon: Icons.my_location,
            onTap: () {
              // In production, get user's current location
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(const LatLng(-37.8136, 144.9631)),
              );
            },
            tooltip: 'My Location',
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 20, color: BauhausColors.textDark),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkerInfoCard() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getStatusColor(_selectedWorker!.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedWorker!.workerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: BauhausColors.textDark,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      setState(() {
                        _selectedWorker = null;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: _getStatusColor(_selectedWorker!.status),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _getStatusLabel(_selectedWorker!.status),
                    style: TextStyle(
                      fontSize: 13,
                      color: _getStatusColor(_selectedWorker!.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (_selectedWorker!.currentClientName != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 14,
                      color: BauhausColors.textMedium,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Client: ${_selectedWorker!.currentClientName}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: BauhausColors.textMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (_selectedWorker!.nextAppointmentTime != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 14,
                      color: BauhausColors.textMedium,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Next: ${_selectedWorker!.nextAppointmentTime}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: BauhausColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to worker details
                        widget.onWorkerTap?.call(_selectedWorker!);
                      },
                      icon: const Icon(Icons.info_outline, size: 16),
                      label: const Text('View Details'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BauhausColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Call worker
                        // In production, integrate phone call
                      },
                      icon: const Icon(Icons.phone, size: 16),
                      label: const Text('Call'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: BauhausColors.primaryBlue,
                        side: const BorderSide(
                          color: BauhausColors.primaryBlue,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkerList() {
    return Positioned.fill(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Worker List',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: BauhausColors.textDark,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _showList = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.workerLocations!.length,
                itemBuilder: (context, index) {
                  final worker = widget.workerLocations![index];
                  return _buildWorkerListTile(worker);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerListTile(WorkerLocation worker) {
    final statusColor = _getStatusColor(worker.status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _showList = false;
              _selectedWorker = worker;
            });
            _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(worker.latitude, worker.longitude),
                15,
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: statusColor.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.workerName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: BauhausColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getStatusLabel(worker.status),
                        style: TextStyle(fontSize: 12, color: statusColor),
                      ),
                      if (worker.currentClientName != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          worker.currentClientName!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: BauhausColors.textMedium,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(Icons.location_on, color: statusColor, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fitMarkersInView() {
    if (widget.workerLocations == null || widget.workerLocations!.isEmpty) {
      return;
    }

    if (widget.workerLocations!.length == 1) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            widget.workerLocations!.first.latitude,
            widget.workerLocations!.first.longitude,
          ),
          15,
        ),
      );
      return;
    }

    double minLat = widget.workerLocations!.first.latitude;
    double maxLat = widget.workerLocations!.first.latitude;
    double minLng = widget.workerLocations!.first.longitude;
    double maxLng = widget.workerLocations!.first.longitude;

    for (final worker in widget.workerLocations!) {
      if (worker.latitude < minLat) minLat = worker.latitude;
      if (worker.latitude > maxLat) maxLat = worker.latitude;
      if (worker.longitude < minLng) minLng = worker.longitude;
      if (worker.longitude > maxLng) maxLng = worker.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  Widget _buildLoadingState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const SizedBox(
        height: 400,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const SizedBox(
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No active workers',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Worker locations will appear here',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(WorkerStatus status) {
    switch (status) {
      case WorkerStatus.available:
        return BauhausColors.accentGreen;
      case WorkerStatus.enRoute:
        return BauhausColors.primaryBlue;
      case WorkerStatus.atAppointment:
        return BauhausColors.primaryYellow;
      case WorkerStatus.onBreak:
        return BauhausColors.accentOrange;
      case WorkerStatus.offline:
        return Colors.grey;
    }
  }

  String _getStatusLabel(WorkerStatus status) {
    switch (status) {
      case WorkerStatus.available:
        return 'Available';
      case WorkerStatus.enRoute:
        return 'En Route';
      case WorkerStatus.atAppointment:
        return 'At Appointment';
      case WorkerStatus.onBreak:
        return 'On Break';
      case WorkerStatus.offline:
        return 'Offline';
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
