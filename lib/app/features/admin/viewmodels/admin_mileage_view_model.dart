import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/trip.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class AdminMileageViewModel extends ChangeNotifier {
  final ApiMethod _apiMethod;
  List<Trip> _trips = [];
  bool _isLoading = false;
  String? _error;

  // Filter state
  String _filterStatus = 'ALL'; // 'ALL', 'PENDING', 'APPROVED', 'REJECTED'

  List<Trip> get trips => _trips;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get filterStatus => _filterStatus;

  List<Trip> get filteredTrips {
    if (_filterStatus == 'ALL') return _trips;
    return _trips.where((t) => t.status == _filterStatus).toList();
  }

  AdminMileageViewModel(this._apiMethod) {
    fetchTrips();
  }

  void setFilter(String status) {
    _filterStatus = status;
    notifyListeners();
  }

  Future<void> fetchTrips() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Using GET with query params if filters needed
      String endpoint = 'api/trips';
      if (_filterStatus != 'ALL') {
        endpoint += '?status=$_filterStatus';
      }

      final response = await _apiMethod.get(endpoint);

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'];
        _trips = data.map((json) => Trip.fromJson(json)).toList();
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
        'api/trips/$tripId',
        body: {'status': status},
      );

      if (response != null && response['success'] == true) {
        // Optimistic update
        final index = _trips.indexWhere((t) => t.id == tripId);
        if (index != -1) {
          _trips[index] = _trips[index].copyWith(status: status);
          notifyListeners();
        }
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
        'api/trips/$tripId',
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
