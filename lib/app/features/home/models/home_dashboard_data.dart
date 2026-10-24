import 'package:carenest/app/features/teams/models/team_models.dart';

/// Home Dashboard Data Model
///
/// Dedicated data structure for the EmployeeHomeView.
/// Decoupled from the worker dashboard to allow home-specific logic and UI.
class HomeDashboardData {
  /// Active emergency broadcasts for the user's teams
  final List<EmergencyBroadcast> activeBroadcasts;

  /// Upcoming appointments (processed from raw backend data)
  final List<Map<String, dynamic>> upcomingAppointments;

  /// True when the appointment feed could not be loaded (network/5xx). The UI
  /// must offer a retry instead of showing "no upcoming shifts", which is what
  /// an empty list would otherwise imply.
  final bool shiftsUnavailable;

  /// Optional message describing why the appointment feed failed.
  final String? shiftsErrorMessage;

  /// True when this snapshot came from the persisted cache because the live
  /// fetch failed (offline or server outage).
  final bool isStale;

  /// When the cached snapshot was captured.
  final DateTime? lastSyncedAt;

  const HomeDashboardData({
    this.activeBroadcasts = const [],
    this.upcomingAppointments = const [],
    this.shiftsUnavailable = false,
    this.shiftsErrorMessage,
    this.isStale = false,
    this.lastSyncedAt,
  });

  /// Create a copy with modified fields
  HomeDashboardData copyWith({
    List<EmergencyBroadcast>? activeBroadcasts,
    List<Map<String, dynamic>>? upcomingAppointments,
    bool? shiftsUnavailable,
    String? shiftsErrorMessage,
    bool? isStale,
    DateTime? lastSyncedAt,
  }) {
    return HomeDashboardData(
      activeBroadcasts: activeBroadcasts ?? this.activeBroadcasts,
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
      shiftsUnavailable: shiftsUnavailable ?? this.shiftsUnavailable,
      shiftsErrorMessage: shiftsErrorMessage ?? this.shiftsErrorMessage,
      isStale: isStale ?? this.isStale,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }
}
