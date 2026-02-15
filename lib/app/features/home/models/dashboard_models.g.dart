// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodaySummaryImpl _$$TodaySummaryImplFromJson(Map<String, dynamic> json) =>
    _$TodaySummaryImpl(
      appointmentsToday: (json['appointmentsToday'] as num).toInt(),
      workersOnShift: (json['workersOnShift'] as num).toInt(),
      revenueToday: (json['revenueToday'] as num).toDouble(),
      pendingApprovals: (json['pendingApprovals'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      completedAppointments:
          (json['completedAppointments'] as num?)?.toInt() ?? 0,
      cancelledAppointments:
          (json['cancelledAppointments'] as num?)?.toInt() ?? 0,
      activeWorkers: (json['activeWorkers'] as num?)?.toInt() ?? 0,
      availableWorkers: (json['availableWorkers'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TodaySummaryImplToJson(_$TodaySummaryImpl instance) =>
    <String, dynamic>{
      'appointmentsToday': instance.appointmentsToday,
      'workersOnShift': instance.workersOnShift,
      'revenueToday': instance.revenueToday,
      'pendingApprovals': instance.pendingApprovals,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'completedAppointments': instance.completedAppointments,
      'cancelledAppointments': instance.cancelledAppointments,
      'activeWorkers': instance.activeWorkers,
      'availableWorkers': instance.availableWorkers,
    };

_$WorkerLocationImpl _$$WorkerLocationImplFromJson(Map<String, dynamic> json) =>
    _$WorkerLocationImpl(
      workerId: json['workerId'] as String,
      workerName: json['workerName'] as String,
      workerEmail: json['workerEmail'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      status: $enumDecode(_$WorkerStatusEnumMap, json['status']),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      currentAppointmentId: json['currentAppointmentId'] as String?,
      currentClientName: json['currentClientName'] as String?,
      nextAppointmentId: json['nextAppointmentId'] as String?,
      nextAppointmentTime: json['nextAppointmentTime'] as String?,
      speed: (json['speed'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WorkerLocationImplToJson(
        _$WorkerLocationImpl instance) =>
    <String, dynamic>{
      'workerId': instance.workerId,
      'workerName': instance.workerName,
      'workerEmail': instance.workerEmail,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': _$WorkerStatusEnumMap[instance.status]!,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'currentAppointmentId': instance.currentAppointmentId,
      'currentClientName': instance.currentClientName,
      'nextAppointmentId': instance.nextAppointmentId,
      'nextAppointmentTime': instance.nextAppointmentTime,
      'speed': instance.speed,
      'heading': instance.heading,
    };

const _$WorkerStatusEnumMap = {
  WorkerStatus.available: 'available',
  WorkerStatus.enRoute: 'enRoute',
  WorkerStatus.atAppointment: 'atAppointment',
  WorkerStatus.onBreak: 'onBreak',
  WorkerStatus.offline: 'offline',
};

_$QuickActionImpl _$$QuickActionImplFromJson(Map<String, dynamic> json) =>
    _$QuickActionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      count: (json['count'] as num).toInt(),
      type: $enumDecode(_$QuickActionTypeEnumMap, json['type']),
      route: json['route'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$QuickActionImplToJson(_$QuickActionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'count': instance.count,
      'type': _$QuickActionTypeEnumMap[instance.type]!,
      'route': instance.route,
      'metadata': instance.metadata,
    };

const _$QuickActionTypeEnumMap = {
  QuickActionType.approveTimesheets: 'approveTimesheets',
  QuickActionType.reviewExpenses: 'reviewExpenses',
  QuickActionType.assignShifts: 'assignShifts',
  QuickActionType.sendMessages: 'sendMessages',
  QuickActionType.viewReports: 'viewReports',
  QuickActionType.manageCompliance: 'manageCompliance',
};

_$ComplianceAlertImpl _$$ComplianceAlertImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceAlertImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ComplianceAlertTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      count: (json['count'] as num).toInt(),
      severity: $enumDecode(_$ComplianceSeverityEnumMap, json['severity']),
      dueDate: DateTime.parse(json['dueDate'] as String),
      affectedWorkerIds: (json['affectedWorkerIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      actionRoute: json['actionRoute'] as String?,
    );

Map<String, dynamic> _$$ComplianceAlertImplToJson(
        _$ComplianceAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ComplianceAlertTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'count': instance.count,
      'severity': _$ComplianceSeverityEnumMap[instance.severity]!,
      'dueDate': instance.dueDate.toIso8601String(),
      'affectedWorkerIds': instance.affectedWorkerIds,
      'actionRoute': instance.actionRoute,
    };

const _$ComplianceAlertTypeEnumMap = {
  ComplianceAlertType.expiringCertifications: 'expiringCertifications',
  ComplianceAlertType.missingDocuments: 'missingDocuments',
  ComplianceAlertType.overdueTraining: 'overdueTraining',
  ComplianceAlertType.expiredInsurance: 'expiredInsurance',
  ComplianceAlertType.pendingScreening: 'pendingScreening',
};

const _$ComplianceSeverityEnumMap = {
  ComplianceSeverity.low: 'low',
  ComplianceSeverity.medium: 'medium',
  ComplianceSeverity.high: 'high',
  ComplianceSeverity.critical: 'critical',
};

_$RevenueDataPointImpl _$$RevenueDataPointImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueDataPointImpl(
      date: DateTime.parse(json['date'] as String),
      revenue: (json['revenue'] as num).toDouble(),
      expenses: (json['expenses'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$$RevenueDataPointImplToJson(
        _$RevenueDataPointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'revenue': instance.revenue,
      'expenses': instance.expenses,
      'profit': instance.profit,
      'label': instance.label,
    };

_$RevenueComparisonImpl _$$RevenueComparisonImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueComparisonImpl(
      todayRevenue: (json['todayRevenue'] as num).toDouble(),
      yesterdayRevenue: (json['yesterdayRevenue'] as num).toDouble(),
      weekToDateRevenue: (json['weekToDateRevenue'] as num).toDouble(),
      monthToDateRevenue: (json['monthToDateRevenue'] as num).toDouble(),
      todayVsYesterdayPercent:
          (json['todayVsYesterdayPercent'] as num).toDouble(),
      weekVsLastWeekPercent: (json['weekVsLastWeekPercent'] as num).toDouble(),
      monthVsLastMonthPercent:
          (json['monthVsLastMonthPercent'] as num).toDouble(),
      todayTrend: $enumDecode(_$TrendDirectionEnumMap, json['todayTrend']),
      weekTrend: $enumDecode(_$TrendDirectionEnumMap, json['weekTrend']),
      monthTrend: $enumDecode(_$TrendDirectionEnumMap, json['monthTrend']),
      last7Days: (json['last7Days'] as List<dynamic>)
          .map((e) => RevenueDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      last30Days: (json['last30Days'] as List<dynamic>)
          .map((e) => RevenueDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RevenueComparisonImplToJson(
        _$RevenueComparisonImpl instance) =>
    <String, dynamic>{
      'todayRevenue': instance.todayRevenue,
      'yesterdayRevenue': instance.yesterdayRevenue,
      'weekToDateRevenue': instance.weekToDateRevenue,
      'monthToDateRevenue': instance.monthToDateRevenue,
      'todayVsYesterdayPercent': instance.todayVsYesterdayPercent,
      'weekVsLastWeekPercent': instance.weekVsLastWeekPercent,
      'monthVsLastMonthPercent': instance.monthVsLastMonthPercent,
      'todayTrend': _$TrendDirectionEnumMap[instance.todayTrend]!,
      'weekTrend': _$TrendDirectionEnumMap[instance.weekTrend]!,
      'monthTrend': _$TrendDirectionEnumMap[instance.monthTrend]!,
      'last7Days': instance.last7Days,
      'last30Days': instance.last30Days,
    };

const _$TrendDirectionEnumMap = {
  TrendDirection.up: 'up',
  TrendDirection.down: 'down',
  TrendDirection.flat: 'flat',
};

_$DashboardStateImpl _$$DashboardStateImplFromJson(Map<String, dynamic> json) =>
    _$DashboardStateImpl(
      todaySummary: json['todaySummary'] == null
          ? null
          : TodaySummary.fromJson(json['todaySummary'] as Map<String, dynamic>),
      workerLocations: (json['workerLocations'] as List<dynamic>?)
          ?.map((e) => WorkerLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      quickActions: (json['quickActions'] as List<dynamic>?)
          ?.map((e) => QuickAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      complianceAlerts: (json['complianceAlerts'] as List<dynamic>?)
          ?.map((e) => ComplianceAlert.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenueComparison: json['revenueComparison'] == null
          ? null
          : RevenueComparison.fromJson(
              json['revenueComparison'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
      lastRefreshed: json['lastRefreshed'] == null
          ? null
          : DateTime.parse(json['lastRefreshed'] as String),
    );

Map<String, dynamic> _$$DashboardStateImplToJson(
        _$DashboardStateImpl instance) =>
    <String, dynamic>{
      'todaySummary': instance.todaySummary,
      'workerLocations': instance.workerLocations,
      'quickActions': instance.quickActions,
      'complianceAlerts': instance.complianceAlerts,
      'revenueComparison': instance.revenueComparison,
      'isLoading': instance.isLoading,
      'error': instance.error,
      'lastRefreshed': instance.lastRefreshed?.toIso8601String(),
    };
