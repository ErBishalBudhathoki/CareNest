import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../models/trip.dart';

part 'admin_mileage_state.freezed.dart';
part 'admin_mileage_state.g.dart';

@freezed
abstract class AdminMileageState with _$AdminMileageState {
  const AdminMileageState._(); // Custom getters require a private constructor

  const factory AdminMileageState({
    @Default([]) List<Trip> trips,
    @Default({}) Map<String, Map<String, dynamic>> rawTripsById,
    @Default(false) bool isLoading,
    String? error,
    @Default('PENDING')
    String filterStatus, // 'ALL', 'PENDING', 'APPROVED', 'REJECTED'
  }) = _AdminMileageState;

  int get pendingTripsCount =>
      trips.where((trip) => trip.status == 'PENDING').length;

  List<Trip> get filteredTrips {
    if (filterStatus == 'ALL') return trips;
    return trips.where((t) => t.status == filterStatus).toList();
  }

  factory AdminMileageState.fromJson(Map<String, dynamic> json) =>
      _$AdminMileageStateFromJson(json);
}
