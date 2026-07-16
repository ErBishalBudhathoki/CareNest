import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/repositories/timesheet_repository.dart';
import 'package:carenest/app/features/worker/models/worker_dashboard_data.dart';
import 'package:carenest/app/features/worker/repositories/worker_repository.dart';
import 'package:carenest/app/features/worker/viewmodels/worker_dashboard_viewmodel.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

// ---------------------------------------------------------------------------
// Geolocator mock
// ---------------------------------------------------------------------------

class MockGeolocatorPlatform extends GeolocatorPlatform {
  @override
  Future<bool> isLocationServiceEnabled() async => true;

  @override
  Future<LocationPermission> checkPermission() async =>
      LocationPermission.always;

  @override
  Future<LocationPermission> requestPermission() async =>
      LocationPermission.always;

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    return Position(
      longitude: -122.4194,
      latitude: 37.7749,
      timestamp: DateTime.now(),
      accuracy: 10.0,
      altitude: 0.0,
      altitudeAccuracy: 5.0,
      heading: 0.0,
      headingAccuracy: 5.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }

  @override
  Future<Position?> getLastKnownPosition({
    bool forceLocationManager = false,
  }) async =>
      null;

  @override
  Future<bool> openLocationSettings() async => false;
}

// ---------------------------------------------------------------------------
// Fake dashboard data
// ---------------------------------------------------------------------------

const _fakeDashboardData = WorkerDashboardData(
  activeTimer: null,
  todayShifts: [],
  nextShift: null,
  pastAssignedShifts: [],
  recentExpenses: [],
  leaveBalances: [],
);

class MockWorkerRepository extends WorkerRepository {
  MockWorkerRepository() : super(ApiMethod());

  @override
  Future<WorkerDashboardData> getDashboardData() async => _fakeDashboardData;
}

class FakeDashboardViewModel extends WorkerDashboardViewModel {
  FakeDashboardViewModel() : super(MockWorkerRepository());
}

// Stub repository that returns empty timesheets without needing SharedPreferences
class _StubTimesheetRepository extends TimesheetRepository {
  _StubTimesheetRepository() : super(ApiMethod());

  @override
  Future<List<TimesheetEntry>> fetchTimesheets({
    required String email,
    required DateTime startDate,
    required DateTime endDate,
  }) async =>
      [];
}

// ---------------------------------------------------------------------------
// Test helpers
// ---------------------------------------------------------------------------

Widget buildTestApp() {
  return ProviderScope(
    overrides: [
      workerDashboardViewModelProvider
          .overrideWith((ref) => FakeDashboardViewModel()),
      timesheetRepositoryProvider
          .overrideWithValue(_StubTimesheetRepository()),
    ],
    child: const MediaQuery(
      data: MediaQueryData(disableAnimations: true),
      child: MaterialApp(home: ClockInAndOutView(email: 'test@example.com')),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late GeolocatorPlatform originalGeolocatorPlatform;

  setUpAll(() {
    originalGeolocatorPlatform = GeolocatorPlatform.instance;
  });

  setUp(() {
    GeolocatorPlatform.instance = MockGeolocatorPlatform();
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first.physicalSize = const Size(1080, 1920);
    binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter/platform_views'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'create') {
          return 1;
        }
        return null;
      },
    );
  });

  tearDown(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first.resetPhysicalSize();
    binding.platformDispatcher.views.first.resetDevicePixelRatio();
    GeolocatorPlatform.instance = originalGeolocatorPlatform;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter/platform_views'),
      null,
    );
  });

  group('ClockInAndOutView', () {
    testWidgets('renders total hours hero section', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('TOTAL TODAY'), findsOneWidget);
      expect(find.text('HOURS WORKED'), findsOneWidget);
    });

    testWidgets('renders day navigation with arrows', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('renders action buttons', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('REQUESTS'), findsOneWidget);
      expect(find.text('TIMESHEET'), findsOneWidget);
    });

    testWidgets('does not render clock in/out button', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Clock in'), findsNothing);
      expect(find.text('Clock out'), findsNothing);
    });

    testWidgets('renders back button', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
