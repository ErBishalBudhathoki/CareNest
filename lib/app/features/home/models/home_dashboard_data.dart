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

  const HomeDashboardData({
    this.activeBroadcasts = const [],
    this.upcomingAppointments = const [],
  });

  /// Create a copy with modified fields
  HomeDashboardData copyWith({
    List<EmergencyBroadcast>? activeBroadcasts,
    List<Map<String, dynamic>>? upcomingAppointments,
  }) {
    return HomeDashboardData(
      activeBroadcasts: activeBroadcasts ?? this.activeBroadcasts,
      upcomingAppointments: upcomingAppointments ?? this.upcomingAppointments,
    );
  }
}
