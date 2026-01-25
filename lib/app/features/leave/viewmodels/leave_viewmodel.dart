import 'package:carenest/app/features/leave/providers/leave_providers.dart';
import 'package:carenest/app/features/leave/repositories/leave_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveViewModel extends ChangeNotifier {
  final Ref _ref;
  final String _userEmail;

  LeaveViewModel(this._ref, this._userEmail);

  LeaveRepository get _repository => _ref.read(leaveRepositoryProvider);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<dynamic> _holidays = [];
  List<dynamic> get holidays => _holidays;

  Future<void> refresh() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.wait([
        _ref.refresh(leaveBalancesProvider(_userEmail).future),
        _ref.refresh(leaveRequestsProvider(_userEmail).future),
      ]);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitRequest({
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    required double totalHours,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.submitLeaveRequest(
        userEmail: _userEmail,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        totalHours: totalHours,
      );

      if (result['success'] == true) {
        await refresh();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Failed to submit request';
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadForecast(DateTime targetDate) async {
    await _ref.read(leaveForecastProvider.notifier).fetchForecast(_userEmail, targetDate);
  }

  Future<double> calculateLeaveHours(DateTime startDate, DateTime endDate) async {
    try {
      // Get organizationId from shared prefs or user provider if needed
      // For now passing null as backend handles null for global holidays
      // Ideally we should get it from User provider
      final result = await _repository.calculateLeaveHours(
        startDate: startDate,
        endDate: endDate,
      );
      
      if (result['success'] == true && result['data'] != null) {
        final data = result['data'];
        return (data['totalHours'] as num).toDouble();
      }
      return 0.0;
    } catch (e) {
      debugPrint('Error calculating hours: $e');
      return 0.0;
    }
  }

  Future<void> fetchHolidays({String? organizationId}) async {
    try {
      _holidays = await _repository.getHolidays(organizationId: organizationId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching holidays: $e');
    }
  }
}

final leaveViewModelProvider = ChangeNotifierProvider.family<LeaveViewModel, String>((ref, email) {
  return LeaveViewModel(ref, email);
});
