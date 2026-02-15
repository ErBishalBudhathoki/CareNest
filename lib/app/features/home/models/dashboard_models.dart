import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

/// Today's summary data
@freezed
class TodaySummary with _$TodaySummary {
  const factory TodaySummary({
    required int appointmentsToday,
    required int workersOnShift,
    required double revenueToday,
    required int pendingApprovals,
    required DateTime lastUpdated,
    @Default(0) int completedAppointments,
    @Default(0) int cancelledAppointments,
    @Default(0) int activeWorkers,
    @Default(0) int availableWorkers,
  }) = _TodaySummary;

  factory TodaySummary.fromJson(Map<String, dynamic> json) =>
      _$TodaySummaryFromJson(json);
}

/// Worker location data for live map
@freezed
class WorkerLocation with _$WorkerLocation {
  const factory WorkerLocation({
    required String workerId,
    required String workerName,
    required String workerEmail,
    required double latitude,
    required double longitude,
    required WorkerStatus status,
    required DateTime lastUpdated,
    String? currentAppointmentId,
    String? currentClientName,
    String? nextAppointmentId,
    String? nextAppointmentTime,
    double? speed,
    double? heading,
  }) = _WorkerLocation;

  factory WorkerLocation.fromJson(Map<String, dynamic> json) =>
      _$WorkerLocationFromJson(json);
}

/// Worker status enum
enum WorkerStatus {
  available,
  enRoute,
  atAppointment,
  onBreak,
  offline,
}

/// Quick action item
@freezed
class QuickAction with _$QuickAction {
  const factory QuickAction({
    required String id,
    required String title,
    required String icon,
    required int count,
    required QuickActionType type,
    String? route,
    Map<String, dynamic>? metadata,
  }) = _QuickAction;

  factory QuickAction.fromJson(Map<String, dynamic> json) =>
      _$QuickActionFromJson(json);
}

/// Quick action types
enum QuickActionType {
  approveTimesheets,
  reviewExpenses,
  assignShifts,
  sendMessages,
  viewReports,
  manageCompliance,
}

/// Compliance alert
@freezed
class ComplianceAlert with _$ComplianceAlert {
  const factory ComplianceAlert({
    required String id,
    required ComplianceAlertType type,
    required String title,
    required String description,
    required int count,
    required ComplianceSeverity severity,
    required DateTime dueDate,
    List<String>? affectedWorkerIds,
    String? actionRoute,
  }) = _ComplianceAlert;

  factory ComplianceAlert.fromJson(Map<String, dynamic> json) =>
      _$ComplianceAlertFromJson(json);
}

/// Compliance alert types
enum ComplianceAlertType {
  expiringCertifications,
  missingDocuments,
  overdueTraining,
  expiredInsurance,
  pendingScreening,
}

/// Compliance severity levels
enum ComplianceSeverity {
  low,
  medium,
  high,
  critical,
}

/// Revenue chart data point
@freezed
class RevenueDataPoint with _$RevenueDataPoint {
  const factory RevenueDataPoint({
    required DateTime date,
    required double revenue,
    required double expenses,
    required double profit,
    String? label,
  }) = _RevenueDataPoint;

  factory RevenueDataPoint.fromJson(Map<String, dynamic> json) =>
      _$RevenueDataPointFromJson(json);
}

/// Revenue comparison data
@freezed
class RevenueComparison with _$RevenueComparison {
  const factory RevenueComparison({
    required double todayRevenue,
    required double yesterdayRevenue,
    required double weekToDateRevenue,
    required double monthToDateRevenue,
    required double todayVsYesterdayPercent,
    required double weekVsLastWeekPercent,
    required double monthVsLastMonthPercent,
    required TrendDirection todayTrend,
    required TrendDirection weekTrend,
    required TrendDirection monthTrend,
    required List<RevenueDataPoint> last7Days,
    required List<RevenueDataPoint> last30Days,
  }) = _RevenueComparison;

  factory RevenueComparison.fromJson(Map<String, dynamic> json) =>
      _$RevenueComparisonFromJson(json);
}

/// Trend direction
enum TrendDirection {
  up,
  down,
  flat,
}

/// Dashboard state combining all widget data
@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    TodaySummary? todaySummary,
    List<WorkerLocation>? workerLocations,
    List<QuickAction>? quickActions,
    List<ComplianceAlert>? complianceAlerts,
    RevenueComparison? revenueComparison,
    @Default(false) bool isLoading,
    String? error,
    DateTime? lastRefreshed,
  }) = _DashboardState;

  factory DashboardState.fromJson(Map<String, dynamic> json) =>
      _$DashboardStateFromJson(json);

  factory DashboardState.initial() {
    return const DashboardState(
      isLoading: true,
    );
  }
}
