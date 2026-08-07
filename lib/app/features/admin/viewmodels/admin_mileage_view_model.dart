import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/trip.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../models/admin_mileage_state.dart';

class AdminMileageViewModel extends Notifier<AdminMileageState> {
  late final ApiMethod _apiMethod;

  @override
  AdminMileageState build() {
    _apiMethod = ref.watch(app_providers.apiMethodProvider);
    fetchTrips();
    return const AdminMileageState();
  }

  void setFilter(String status) {
    if (state.filterStatus == status) return;
    state = state.copyWith(filterStatus: status);
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Using GET with query params if filters needed
      String endpoint = 'trips';
      if (state.filterStatus != 'ALL') {
        endpoint += '?status=${state.filterStatus}';
      }

      final response = await _apiMethod.get(endpoint);

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'];
        final Map<String, Map<String, dynamic>> rawTripsById = {};
        for (final item in data) {
          if (item is! Map) continue;
          final map = Map<String, dynamic>.from(item);
          final id = (map['_id'] ?? map['id'])?.toString();
          if (id != null && id.isNotEmpty) {
            rawTripsById[id] = map;
          }
        }
        final trips = data.whereType<Map>().map((json) {
          final map = Map<String, dynamic>.from(json);
          map['status'] =
              (map['status'] ?? map['adminApprovalStatus'] ?? 'PENDING')
                  .toString()
                  .toUpperCase();
          return Trip.fromJson(map);
        }).toList();

        state = state.copyWith(
          trips: trips,
          rawTripsById: rawTripsById,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          error: response['message'] ?? 'Failed to fetch trips',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<bool> updateTripStatus(String tripId, String status) async {
    try {
      final response = await _apiMethod.patch(
        'trips/$tripId/status',
        body: {'status': status},
      );

      if (response != null && response['success'] == true) {
        // Optimistic update for immediate UI feedback
        final index = state.trips.indexWhere((t) => t.id == tripId);
        if (index != -1) {
          final updatedTrips = List<Trip>.from(state.trips);
          updatedTrips[index] = updatedTrips[index].copyWith(status: status);

          final updatedRawTrips = Map<String, Map<String, dynamic>>.from(
            state.rawTripsById,
          );
          if (updatedRawTrips[tripId] != null) {
            updatedRawTrips[tripId]!['status'] = status;
            updatedRawTrips[tripId]!['adminApprovalStatus'] = status;
          }

          state = state.copyWith(
            trips: updatedTrips,
            rawTripsById: updatedRawTrips,
          );
        }
        // Re-sync list from backend to avoid stale status/filter mismatches.
        await fetchTrips();
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> updateTripDetails(
    String tripId,
    double distance,
    String? clientId,
  ) async {
    try {
      final response = await _apiMethod.patch(
        'trips/$tripId',
        body: {'distance': distance, 'clientId': clientId},
      );

      if (response != null && response['success'] == true) {
        // Refresh list to get updated calculations (billable/reimbursable)
        await fetchTrips();
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
}

final adminMileageViewModelProvider =
    NotifierProvider<AdminMileageViewModel, AdminMileageState>(
      AdminMileageViewModel.new,
    );
