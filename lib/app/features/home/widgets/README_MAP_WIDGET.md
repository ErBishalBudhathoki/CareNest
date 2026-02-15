# Live Worker Map Widget

## Overview

The Live Worker Map Widget provides real-time visualization of worker locations with interactive features for workforce management.

---

## Features

### 🗺️ Interactive Map
- **Google Maps** on Android
- **Apple Maps** on iOS (via Google Maps Flutter)
- Pinch to zoom, pan, rotate
- Smooth animations
- Custom styling support

### 📍 Worker Markers
- **Color-coded by status**:
  - 🟢 Green: Available
  - 🔵 Blue: En Route
  - 🟠 Yellow: At Appointment
  - 🟠 Orange: On Break
  - 🔴 Red: Offline
- Tap to view details
- Custom marker icons
- Info windows

### 🎛️ Map Controls
- **Toggle Views**: Switch between map and list
- **Zoom Controls**: In/out buttons
- **Fit All**: Auto-zoom to show all workers
- **My Location**: Center on user location
- **Compass**: Auto-enabled for orientation

### 📋 Worker Info Card
- Selected worker details
- Current status and client
- Next appointment time
- Action buttons:
  - View full details
  - Call worker

### 📱 List View
- Alternative to map view
- Scrollable worker list
- Status indicators
- Tap to focus on map
- Quick access to info

---

## Usage

### Basic Implementation

```dart
import 'package:carenest/app/features/home/widgets/live_worker_map_widget_full.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// In your widget
LiveWorkerMapWidgetFull(
  workerLocations: workerLocations,
  isLoading: false,
  onWorkerTap: (worker) {
    // Handle worker tap
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerDetailsView(worker: worker),
      ),
    );
  },
  initialCenter: LatLng(-37.8136, 144.9631), // Melbourne
  initialZoom: 12.0,
)
```

### With Riverpod

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    
    return dashboardState.when(
      data: (state) => LiveWorkerMapWidgetFull(
        workerLocations: state.workerLocations,
        isLoading: false,
        onWorkerTap: (worker) {
          // Handle tap
        },
      ),
      loading: () => LiveWorkerMapWidgetFull(isLoading: true),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

### Full Example

```dart
import 'package:flutter/material.dart';
import 'package:carenest/app/features/home/widgets/live_worker_map_widget_full.dart';
import 'package:carenest/app/features/home/models/dashboard_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WorkerMapScreen extends StatefulWidget {
  @override
  _WorkerMapScreenState createState() => _WorkerMapScreenState();
}

class _WorkerMapScreenState extends State<WorkerMapScreen> {
  List<WorkerLocation> _workers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  Future<void> _loadWorkers() async {
    // Fetch from API
    final workers = await fetchWorkerLocations();
    setState(() {
      _workers = workers;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Locations'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadWorkers,
          ),
        ],
      ),
      body: LiveWorkerMapWidgetFull(
        workerLocations: _workers,
        isLoading: _isLoading,
        onWorkerTap: (worker) {
          showModalBottomSheet(
            context: context,
            builder: (context) => WorkerDetailsSheet(worker: worker),
          );
        },
        initialCenter: LatLng(-37.8136, 144.9631),
        initialZoom: 12.0,
      ),
    );
  }
}
```

---

## Properties

### Required
None - all properties are optional

### Optional

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `workerLocations` | `List<WorkerLocation>?` | `null` | List of worker locations to display |
| `isLoading` | `bool` | `false` | Show loading indicator |
| `onWorkerTap` | `Function(WorkerLocation)?` | `null` | Callback when worker is tapped |
| `initialCenter` | `LatLng?` | First worker or Melbourne | Initial map center |
| `initialZoom` | `double` | `12.0` | Initial zoom level (3-21) |

---

## Worker Location Model

```dart
class WorkerLocation {
  final String workerId;
  final String workerName;
  final String workerEmail;
  final double latitude;
  final double longitude;
  final WorkerStatus status;
  final DateTime lastUpdated;
  final String? currentAppointmentId;
  final String? currentClientName;
  final String? nextAppointmentId;
  final String? nextAppointmentTime;
  final double? speed;
  final double? heading;
}

enum WorkerStatus {
  available,
  enRoute,
  atAppointment,
  onBreak,
  offline,
}
```

---

## Customization

### Custom Marker Icons

Replace default markers with custom icons:

```dart
// 1. Add marker images to assets
flutter:
  assets:
    - assets/markers/available.png
    - assets/markers/en_route.png
    - assets/markers/at_appointment.png

// 2. Load custom markers
Future<BitmapDescriptor> _loadMarkerIcon(String path) async {
  return await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(48, 48)),
    path,
  );
}

// 3. Use in marker creation
final marker = Marker(
  markerId: MarkerId(worker.workerId),
  position: LatLng(worker.latitude, worker.longitude),
  icon: await _loadMarkerIcon('assets/markers/available.png'),
);
```

### Custom Map Style

Apply custom styling to the map:

```dart
// 1. Create map style JSON
final String mapStyle = '''
[
  {
    "featureType": "poi",
    "stylers": [{"visibility": "off"}]
  },
  {
    "featureType": "transit",
    "stylers": [{"visibility": "off"}]
  }
]
''';

// 2. Apply to map
GoogleMap(
  onMapCreated: (controller) {
    controller.setMapStyle(mapStyle);
  },
)
```

### Custom Info Window

Create custom info windows:

```dart
// Override _buildWorkerInfoCard() method
Widget _buildWorkerInfoCard() {
  return Positioned(
    bottom: 16,
    left: 16,
    right: 16,
    child: YourCustomInfoCard(worker: _selectedWorker),
  );
}
```

---

## Real-time Updates

### Periodic Updates

```dart
Timer.periodic(Duration(seconds: 30), (timer) async {
  final updatedLocations = await fetchWorkerLocations();
  setState(() {
    workerLocations = updatedLocations;
  });
});
```

### WebSocket Updates

```dart
final channel = WebSocketChannel.connect(
  Uri.parse('wss://api.example.com/worker-locations'),
);

channel.stream.listen((data) {
  final location = WorkerLocation.fromJson(jsonDecode(data));
  setState(() {
    // Update specific worker
    final index = workerLocations.indexWhere(
      (w) => w.workerId == location.workerId,
    );
    if (index != -1) {
      workerLocations[index] = location;
    }
  });
});
```

### Firebase Realtime Database

```dart
final ref = FirebaseDatabase.instance.ref('worker-locations');

ref.onValue.listen((event) {
  final data = event.snapshot.value as Map;
  final locations = data.entries.map((e) => 
    WorkerLocation.fromJson(e.value)
  ).toList();
  
  setState(() {
    workerLocations = locations;
  });
});
```

---

## Performance Optimization

### Marker Clustering

For many workers (>100), use marker clustering:

```dart
dependencies:
  google_maps_cluster_manager: ^3.0.0

// Implement clustering
final ClusterManager _clusterManager = ClusterManager(
  items,
  _updateMarkers,
  markerBuilder: _markerBuilder,
);
```

### Debounce Updates

Prevent excessive re-renders:

```dart
Timer? _debounceTimer;

void _updateWorkerLocation(WorkerLocation location) {
  _debounceTimer?.cancel();
  _debounceTimer = Timer(Duration(milliseconds: 500), () {
    setState(() {
      // Update location
    });
  });
}
```

### Limit Visible Markers

Only show workers in viewport:

```dart
void _filterVisibleWorkers(LatLngBounds bounds) {
  final visible = workerLocations.where((worker) {
    return bounds.contains(
      LatLng(worker.latitude, worker.longitude),
    );
  }).toList();
  
  _updateMarkers(visible);
}
```

---

## Testing

### Mock Data

```dart
final mockWorkers = [
  WorkerLocation(
    workerId: '1',
    workerName: 'John Smith',
    workerEmail: 'john@example.com',
    latitude: -37.8136,
    longitude: 144.9631,
    status: WorkerStatus.available,
    lastUpdated: DateTime.now(),
  ),
  WorkerLocation(
    workerId: '2',
    workerName: 'Jane Doe',
    workerEmail: 'jane@example.com',
    latitude: -37.8200,
    longitude: 144.9700,
    status: WorkerStatus.enRoute,
    lastUpdated: DateTime.now(),
    currentClientName: 'Client A',
  ),
];
```

### Simulate Movement

```dart
Timer.periodic(Duration(seconds: 2), (timer) {
  setState(() {
    mockWorkers[0] = mockWorkers[0].copyWith(
      latitude: mockWorkers[0].latitude + 0.001,
      longitude: mockWorkers[0].longitude + 0.001,
    );
  });
});
```

---

## Troubleshooting

### Map Not Showing

1. Check API key in `AndroidManifest.xml`
2. Verify Maps SDK is enabled in Google Cloud
3. Check internet connection
4. Ensure permissions are granted

### Markers Not Appearing

1. Verify worker locations have valid lat/lng
2. Check markers are added to `Set<Marker>`
3. Ensure `setState()` is called after updates
4. Verify zoom level shows markers

### Performance Issues

1. Limit number of markers (< 100)
2. Implement marker clustering
3. Debounce location updates
4. Use `shouldRebuild` optimization

### Permission Denied

1. Check permissions in manifest/Info.plist
2. Request permissions at runtime
3. Handle permission denial gracefully
4. Provide fallback UI

---

## Best Practices

### 1. Request Permissions Early

```dart
@override
void initState() {
  super.initState();
  _requestLocationPermission();
}
```

### 2. Handle Errors Gracefully

```dart
try {
  final locations = await fetchWorkerLocations();
  setState(() => workerLocations = locations);
} catch (e) {
  showErrorSnackbar('Failed to load worker locations');
}
```

### 3. Provide Loading States

```dart
if (isLoading) {
  return Center(child: CircularProgressIndicator());
}
```

### 4. Cache Map Tiles

```dart
// Google Maps automatically caches tiles
// No additional configuration needed
```

### 5. Optimize for Battery

```dart
// Use appropriate location accuracy
LocationSettings(
  accuracy: LocationAccuracy.balanced, // Not 'best'
  distanceFilter: 10, // Update every 10 meters
);
```

---

## Resources

- [Google Maps Flutter Documentation](https://pub.dev/packages/google_maps_flutter)
- [Setup Guide](../../../docs/MAP_INTEGRATION_SETUP.md)
- [Geolocator Plugin](https://pub.dev/packages/geolocator)
- [Google Maps Platform](https://developers.google.com/maps)

---

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review setup documentation
3. Check plugin GitHub issues
4. Contact development team

---

**Last Updated**: February 12, 2026
