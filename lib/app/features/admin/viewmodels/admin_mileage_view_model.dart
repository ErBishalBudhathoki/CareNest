import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/trip.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class AdminMileageViewModel extends ChangeNotifier {
  final ApiMethod _apiMethod;
  List<Trip> _trips = [];
  Map<String, Map<String, dynamic>> _rawTripsById = {};
  bool _isLoading = false;
  String? _error;

  // Filter state
  String _filterStatus = 'PENDING'; // 'ALL', 'PENDING', 'APPROVED', 'REJECTED'

  List<Trip> get trips => _trips;
  Map<String, Map<String, dynamic>> get rawTripsById => _rawTripsById;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get filterStatus => _filterStatus;
  int get pendingTripsCount =>
      _trips.where((trip) => trip.status == 'PENDING').length;

  List<Trip> get filteredTrips {
    if (_filterStatus == 'ALL') return _trips;
    return _trips.where((t) => t.status == _filterStatus).toList();
  }

  AdminMileageViewModel(this._apiMethod) {
    fetchTrips();
  }

  void setFilter(String status) {
    if (_filterStatus == status) return;
    _filterStatus = status;
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Using GET with query params if filters needed
      String endpoint = 'trips';
      if (_filterStatus != 'ALL') {
        endpoint += '?status=$_filterStatus';
      }

      final response = await _apiMethod.get(endpoint);

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'];
        _rawTripsById = {};
        for (final item in data) {
          if (item is! Map) continue;
          final map = Map<String, dynamic>.from(item);
          final id = (map['_id'] ?? map['id'])?.toString();
          if (id != null && id.isNotEmpty) {
            _rawTripsById[id] = map;
          }
        }
        _trips = data.whereType<Map>().map((json) {
          final map = Map<String, dynamic>.from(json);
          map['status'] =
              (map['status'] ?? map['adminApprovalStatus'] ?? 'PENDING')
                  .toString()
                  .toUpperCase();
          return Trip.fromJson(map);
        }).toList();
      } else {
        _error = response['message'] ?? 'Failed to fetch trips';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
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
        final index = _trips.indexWhere((t) => t.id == tripId);
        if (index != -1) {
          _trips[index] = _trips[index].copyWith(status: status);
          if (_rawTripsById[tripId] != null) {
            _rawTripsById[tripId]!['status'] = status;
            _rawTripsById[tripId]!['adminApprovalStatus'] = status;
          }
          notifyListeners();
        }
        // Re-sync list from backend to avoid stale status/filter mismatches.
        await fetchTrips();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTripDetails(
      String tripId, double distance, String? clientId) async {
    try {
      final response = await _apiMethod.patch(
        'trips/$tripId',
        body: {
          'distance': distance,
          'clientId': clientId,
        },
      );

      if (response != null && response['success'] == true) {
        // Refresh list to get updated calculations (billable/reimbursable)
        await fetchTrips();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}

final adminMileageViewModelProvider =
    ChangeNotifierProvider<AdminMileageViewModel>((ref) {
  return AdminMileageViewModel(ref.read(app_providers.apiMethodProvider));
});
