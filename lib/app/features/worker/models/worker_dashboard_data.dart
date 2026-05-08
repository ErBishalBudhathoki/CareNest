import 'package:carenest/app/features/schedule/models/shift_model.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/teams/models/team_models.dart';

/// Worker Dashboard Data Model
/// Contains aggregated data for the worker dashboard view
///
/// Synchronized with backend response from /api/worker/dashboard
class WorkerDashboardData {
  /// Active timer (clock-in status) if worker is currently clocked in
  final Map<String, dynamic>? activeTimer;

  /// Today's scheduled shifts
  final List<ShiftModel> todayShifts;

  /// Next upcoming shift (could be today or in the future)
  final ShiftModel? nextShift;

  /// Past assigned shifts (most recent first)
  final List<ShiftModel> pastAssignedShifts;

  /// Recent expenses (last 3) submitted by the worker
  final List<ExpenseModel> recentExpenses;

  /// Current leave balances (annual, sick, personal, etc.)
  final List<WorkerLeaveBalance> leaveBalances;

  /// Active emergency broadcasts for the worker's teams
  final List<EmergencyBroadcast> activeBroadcasts;

  const WorkerDashboardData({
    this.activeTimer,
    this.todayShifts = const [],
    this.nextShift,
    this.pastAssignedShifts = const [],
    this.recentExpenses = const [],
    this.leaveBalances = const [],
    this.activeBroadcasts = const [],
  });

  /// Create from backend JSON response
  ///
  /// Expected backend structure:
  /// ```json
  /// {
  ///   "success": true,
  ///   "code": "DASHBOARD_FETCHED",
  ///   "data": {
  ///     "activeTimer": {...} | null,
  ///     "todayShifts": [...],
  ///     "nextShift": {...} | null,
  ///     "pastAssignedShifts": [...],
  ///     "recentExpenses": [...],
  ///     "leaveBalances": [...]
  ///   }
  /// }
  /// ```
  factory WorkerDashboardData.fromJson(Map<String, dynamic> json) {
    try {
      return WorkerDashboardData(
        activeTimer: json['activeTimer'] as Map<String, dynamic>?,
        todayShifts: _parseShiftList(json['todayShifts']),
        nextShift: _parseShift(json['nextShift']),
        pastAssignedShifts: _parseShiftList(json['pastAssignedShifts']),
        recentExpenses: _parseExpenseList(json['recentExpenses']),
        leaveBalances: _parseLeaveBalances(json['leaveBalances']),
        activeBroadcasts: _parseBroadcastList(json['activeBroadcasts']),
      );
    } catch (e, stackTrace) {
      // Log error for debugging
      print('Error parsing WorkerDashboardData: $e');
      print('Stack trace: $stackTrace');
      print('JSON received: $json');

      // Return empty dashboard data instead of throwing
      return const WorkerDashboardData();
    }
  }

  /// Parse list of shifts with error handling
  static List<ShiftModel> _parseShiftList(dynamic shiftsJson) {
    if (shiftsJson == null) return [];
    if (shiftsJson is! List) return [];

    try {
      return shiftsJson
          .map((e) {
            try {
              return ShiftModel.fromJson(e as Map<String, dynamic>);
            } catch (e) {
              print('Error parsing shift: $e');
              return null;
            }
          })
          .whereType<ShiftModel>() // Filter out null values
          .toList();
    } catch (e) {
      print('Error parsing shift list: $e');
      return [];
    }
  }

  /// Parse single shift with error handling
  static ShiftModel? _parseShift(dynamic shiftJson) {
    if (shiftJson == null) return null;

    try {
      return ShiftModel.fromJson(shiftJson as Map<String, dynamic>);
    } catch (e) {
      print('Error parsing shift: $e');
      return null;
    }
  }

  /// Parse list of expenses with error handling
  static List<ExpenseModel> _parseExpenseList(dynamic expensesJson) {
    if (expensesJson == null) return [];
    if (expensesJson is! List) return [];

    try {
      return expensesJson
          .map((e) {
            try {
              return ExpenseModel.fromJson(e as Map<String, dynamic>);
            } catch (e) {
              print('Error parsing expense: $e');
              return null;
            }
          })
          .whereType<ExpenseModel>() // Filter out null values
          .toList();
    } catch (e) {
      print('Error parsing expense list: $e');
      return [];
    }
  }

  /// Parse list of leave balances with error handling
  static List<WorkerLeaveBalance> _parseLeaveBalances(dynamic balancesJson) {
    if (balancesJson == null) return [];
    if (balancesJson is! List) return [];

    try {
      return balancesJson
          .map((e) {
            try {
              return WorkerLeaveBalance.fromJson(e as Map<String, dynamic>);
            } catch (e) {
              print('Error parsing leave balance: $e');
              return null;
            }
          })
          .whereType<WorkerLeaveBalance>() // Filter out null values
          .toList();
    } catch (e) {
      print('Error parsing leave balance list: $e');
      return [];
    }
  }

  /// Parse list of emergency broadcasts with error handling
  static List<EmergencyBroadcast> _parseBroadcastList(dynamic broadcastsJson) {
    if (broadcastsJson == null) return [];
    if (broadcastsJson is! List) return [];

    try {
      return broadcastsJson
          .map((e) {
            try {
              return EmergencyBroadcast.fromJson(e as Map<String, dynamic>);
            } catch (e) {
              print('Error parsing emergency broadcast: $e');
              return null;
            }
          })
          .whereType<EmergencyBroadcast>() // Filter out null values
          .toList();
    } catch (e) {
      print('Error parsing emergency broadcast list: $e');
      return [];
    }
  }

  /// Helper getters
  bool get hasActiveTimer => activeTimer != null;
  bool get hasTodayShifts => todayShifts.isNotEmpty;
  bool get hasNextShift => nextShift != null;
  bool get hasPastAssignedShifts => pastAssignedShifts.isNotEmpty;
  bool get hasRecentExpenses => recentExpenses.isNotEmpty;
  bool get hasLeaveBalances => leaveBalances.isNotEmpty;

  /// Check if worker is currently clocked in
  bool get isClockedIn =>
      activeTimer != null && activeTimer!['endTime'] == null;
}

/// Worker Leave Balance Model
/// Represents a single leave type balance for a worker
class WorkerLeaveBalance {
  final String id;
  final String userId;
  final String userEmail;
  final String leaveType;
  final double currentBalance;
  final double accruedHours;
  final double usedHours;
  final DateTime? lastAccrualDate;
  final DateTime? expiryDate;

  const WorkerLeaveBalance({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.leaveType,
    required this.currentBalance,
    this.accruedHours = 0.0,
    this.usedHours = 0.0,
    this.lastAccrualDate,
    this.expiryDate,
  });

  /// Create from backend JSON response
  ///
  /// Backend sends:
  /// ```json
  /// {
  ///   "id": "...",  // Transformed from _id by toJSON
  ///   "userId": "...",
  ///   "userEmail": "worker@example.com",
  ///   "leaveType": "annual",
  ///   "currentBalance": 76.0,
  ///   "accruedHours": 152.0,
  ///   "usedHours": 76.0,
  ///   "lastAccrualDate": "2026-02-01T00:00:00.000Z",
  ///   "expiryDate": null
  /// }
  /// ```
  factory WorkerLeaveBalance.fromJson(Map<String, dynamic> json) {
    return WorkerLeaveBalance(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      userEmail: json['userEmail']?.toString() ?? 'unknown',
      leaveType: json['leaveType']?.toString() ?? 'unknown',
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0.0,
      accruedHours: (json['accruedHours'] as num?)?.toDouble() ?? 0.0,
      usedHours: (json['usedHours'] as num?)?.toDouble() ?? 0.0,
      lastAccrualDate: _parseDateTime(json['lastAccrualDate']),
      expiryDate: _parseDateTime(json['expiryDate']),
    );
  }

  /// Parse DateTime from various formats (ISO 8601 string, DateTime object, timestamp)
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;

    try {
      if (value is DateTime) return value;
      if (value is String) return DateTime.parse(value);
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      return null;
    } catch (e) {
      print('Error parsing DateTime: $e, value: $value');
      return null;
    }
  }

  /// Convert to JSON for API requests (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'leaveType': leaveType,
      'currentBalance': currentBalance,
      'accruedHours': accruedHours,
      'usedHours': usedHours,
      if (lastAccrualDate != null)
        'lastAccrualDate': lastAccrualDate!.toIso8601String(),
      if (expiryDate != null) 'expiryDate': expiryDate!.toIso8601String(),
    };
  }

  /// Helper getters
  String get displayName {
    switch (leaveType.toLowerCase()) {
      case 'annual':
        return 'Annual Leave';
      case 'sick':
        return 'Sick Leave';
      case 'personal':
        return 'Personal/Carer\'s Leave';
      case 'longservice':
        return 'Long Service Leave';
      default:
        return leaveType;
    }
  }

  /// Convert hours to days (assuming 7.6 hours per day - standard Australian full-time)
  double get balanceInDays => currentBalance / 7.6;
  double get accruedInDays => accruedHours / 7.6;
  double get usedInDays => usedHours / 7.6;

  /// Check if balance is low (less than 1 week = 38 hours for full-time)
  bool get isLowBalance => currentBalance < 38.0;

  /// Check if balance is expiring soon (within 3 months)
  bool get isExpiringSoon {
    if (expiryDate == null) return false;
    final threeMonthsFromNow = DateTime.now().add(const Duration(days: 90));
    return expiryDate!.isBefore(threeMonthsFromNow);
  }
}
