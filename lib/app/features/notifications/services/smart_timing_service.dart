import 'package:flutter/foundation.dart';
import '../models/notification_preferences.dart';

/// Service for optimizing notification send times based on user engagement
class SmartTimingService {
  static final SmartTimingService _instance = SmartTimingService._internal();
  factory SmartTimingService() => _instance;
  SmartTimingService._internal();

  // User engagement patterns (in-memory cache)
  final Map<String, UserEngagementPattern> _engagementPatterns = {};

  /// Get optimal send time for a notification
  Future<SmartTimingRecommendation> getOptimalSendTime({
    required String userId,
    required NotificationCategory category,
    required NotificationPriority priority,
    required QuietHours quietHours,
  }) async {
    // For urgent notifications, send immediately
    if (priority == NotificationPriority.urgent) {
      return SmartTimingRecommendation(
        userId: userId,
        category: category,
        recommendedTime: DateTime.now(),
        confidence: 1.0,
        reason: 'Urgent priority - send immediately',
      );
    }

    // Get user engagement pattern
    final pattern = await _getUserEngagementPattern(userId);

    // Calculate optimal time based on pattern
    final now = DateTime.now();
    final optimalTime = _calculateOptimalTime(
      now: now,
      pattern: pattern,
      category: category,
      priority: priority,
      quietHours: quietHours,
    );

    return SmartTimingRecommendation(
      userId: userId,
      category: category,
      recommendedTime: optimalTime.time,
      confidence: optimalTime.confidence,
      reason: optimalTime.reason,
      metadata: {
        'currentHour': now.hour,
        'optimalHour': optimalTime.time.hour,
        'delayMinutes': optimalTime.time.difference(now).inMinutes,
      },
    );
  }

  /// Record user engagement with a notification
  Future<void> recordEngagement({
    required String userId,
    required NotificationCategory category,
    required DateTime sentAt,
    required DateTime? readAt,
    required DateTime? actionedAt,
  }) async {
    final pattern = await _getUserEngagementPattern(userId);

    // Update engagement statistics
    pattern.totalNotifications++;

    if (readAt != null) {
      pattern.readNotifications++;
      final responseTime = readAt.difference(sentAt).inMinutes;
      pattern.averageResponseTimeMinutes =
          (pattern.averageResponseTimeMinutes *
                  (pattern.readNotifications - 1) +
              responseTime) /
          pattern.readNotifications;

      // Track hourly engagement
      final hour = sentAt.hour;
      pattern.hourlyEngagement[hour] =
          (pattern.hourlyEngagement[hour] ?? 0) + 1;
    }

    if (actionedAt != null) {
      pattern.actionedNotifications++;
    }

    // Track category-specific engagement
    pattern.categoryEngagement[category] =
        (pattern.categoryEngagement[category] ?? 0) + 1;

    _engagementPatterns[userId] = pattern;

    // In production, persist to backend
    await _persistEngagementPattern(userId, pattern);
  }

  Future<UserEngagementPattern> _getUserEngagementPattern(String userId) async {
    // Check cache
    if (_engagementPatterns.containsKey(userId)) {
      return _engagementPatterns[userId]!;
    }

    // In production, fetch from backend
    // For now, return default pattern
    final pattern = UserEngagementPattern.defaultPattern(userId);
    _engagementPatterns[userId] = pattern;
    return pattern;
  }

  OptimalTimeResult _calculateOptimalTime({
    required DateTime now,
    required UserEngagementPattern pattern,
    required NotificationCategory category,
    required NotificationPriority priority,
    required QuietHours quietHours,
  }) {
    // Find peak engagement hours
    final peakHours = _findPeakEngagementHours(pattern);

    // Check if we're in quiet hours
    if (quietHours.enabled && _isInQuietHours(now, quietHours)) {
      // Wait until quiet hours end
      final quietHoursEnd = _getQuietHoursEnd(now, quietHours);
      return OptimalTimeResult(
        time: quietHoursEnd,
        confidence: 0.7,
        reason: 'Delayed until quiet hours end',
      );
    }

    // For high priority, send within next peak hour
    if (priority == NotificationPriority.high) {
      final nextPeakHour = _findNextPeakHour(now, peakHours, quietHours);
      if (nextPeakHour.difference(now).inHours < 2) {
        return OptimalTimeResult(
          time: nextPeakHour,
          confidence: 0.85,
          reason: 'Scheduled for next peak engagement hour',
        );
      }
    }

    // For medium/low priority, wait for optimal engagement time
    final optimalHour = _findOptimalHour(now, peakHours, quietHours);
    return OptimalTimeResult(
      time: optimalHour,
      confidence: 0.9,
      reason: 'Scheduled for optimal engagement time based on user patterns',
    );
  }

  List<int> _findPeakEngagementHours(UserEngagementPattern pattern) {
    if (pattern.hourlyEngagement.isEmpty) {
      // Default peak hours: 9 AM, 12 PM, 6 PM
      return [9, 12, 18];
    }

    // Sort hours by engagement count
    final sortedHours = pattern.hourlyEngagement.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Return top 3 hours
    return sortedHours.take(3).map((e) => e.key).toList();
  }

  bool _isInQuietHours(DateTime time, QuietHours quietHours) {
    if (!quietHours.enabled) return false;
    if (!quietHours.daysOfWeek.contains(time.weekday % 7)) return false;

    final startParts = quietHours.startTime.split(':');
    final endParts = quietHours.endTime.split(':');

    final startHour = int.parse(startParts[0]);
    final startMinute = int.parse(startParts[1]);
    final endHour = int.parse(endParts[0]);
    final endMinute = int.parse(endParts[1]);

    final currentMinutes = time.hour * 60 + time.minute;
    final startMinutes = startHour * 60 + startMinute;
    final endMinutes = endHour * 60 + endMinute;

    if (startMinutes < endMinutes) {
      // Same day (e.g., 14:00 - 18:00)
      return currentMinutes >= startMinutes && currentMinutes < endMinutes;
    } else {
      // Crosses midnight (e.g., 22:00 - 08:00)
      return currentMinutes >= startMinutes || currentMinutes < endMinutes;
    }
  }

  DateTime _getQuietHoursEnd(DateTime now, QuietHours quietHours) {
    final endParts = quietHours.endTime.split(':');
    final endHour = int.parse(endParts[0]);
    final endMinute = int.parse(endParts[1]);

    var endTime = DateTime(now.year, now.month, now.day, endHour, endMinute);

    // If end time is before current time, it's tomorrow
    if (endTime.isBefore(now)) {
      endTime = endTime.add(const Duration(days: 1));
    }

    return endTime;
  }

  DateTime _findNextPeakHour(
    DateTime now,
    List<int> peakHours,
    QuietHours quietHours,
  ) {
    // Find next peak hour that's not in quiet hours
    for (final hour in peakHours) {
      var candidateTime = DateTime(now.year, now.month, now.day, hour, 0);

      // If hour has passed today, try tomorrow
      if (candidateTime.isBefore(now)) {
        candidateTime = candidateTime.add(const Duration(days: 1));
      }

      if (!_isInQuietHours(candidateTime, quietHours)) {
        return candidateTime;
      }
    }

    // Fallback: send in 1 hour
    return now.add(const Duration(hours: 1));
  }

  DateTime _findOptimalHour(
    DateTime now,
    List<int> peakHours,
    QuietHours quietHours,
  ) {
    // Try to find the next peak hour
    final nextPeak = _findNextPeakHour(now, peakHours, quietHours);

    // If next peak is more than 12 hours away, send sooner
    if (nextPeak.difference(now).inHours > 12) {
      // Find next non-quiet hour
      var candidateTime = now.add(const Duration(hours: 1));
      while (_isInQuietHours(candidateTime, quietHours)) {
        candidateTime = candidateTime.add(const Duration(hours: 1));
      }
      return candidateTime;
    }

    return nextPeak;
  }

  Future<void> _persistEngagementPattern(
    String userId,
    UserEngagementPattern pattern,
  ) async {
    // In production, save to backend
    debugPrint('Persisting engagement pattern for user: $userId');
  }
}

/// User engagement pattern data
class UserEngagementPattern {
  final String userId;
  int totalNotifications;
  int readNotifications;
  int actionedNotifications;
  double averageResponseTimeMinutes;
  Map<int, int> hourlyEngagement; // hour -> count
  Map<NotificationCategory, int> categoryEngagement;

  UserEngagementPattern({
    required this.userId,
    this.totalNotifications = 0,
    this.readNotifications = 0,
    this.actionedNotifications = 0,
    this.averageResponseTimeMinutes = 0,
    Map<int, int>? hourlyEngagement,
    Map<NotificationCategory, int>? categoryEngagement,
  }) : hourlyEngagement = hourlyEngagement ?? {},
       categoryEngagement = categoryEngagement ?? {};

  factory UserEngagementPattern.defaultPattern(String userId) {
    return UserEngagementPattern(
      userId: userId,
      hourlyEngagement: {
        9: 10, // 9 AM
        12: 15, // 12 PM
        18: 12, // 6 PM
      },
    );
  }

  double get readRate =>
      totalNotifications > 0 ? readNotifications / totalNotifications : 0;

  double get actionRate =>
      totalNotifications > 0 ? actionedNotifications / totalNotifications : 0;
}

/// Result of optimal time calculation
class OptimalTimeResult {
  final DateTime time;
  final double confidence;
  final String reason;

  OptimalTimeResult({
    required this.time,
    required this.confidence,
    required this.reason,
  });
}
