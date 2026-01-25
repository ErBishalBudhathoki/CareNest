import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/leave/models/leave_balance.dart';
import 'package:carenest/app/features/leave/models/leave_request_model.dart';

class LeaveRepository {
  final ApiMethod _apiMethod;

  LeaveRepository(this._apiMethod);

  Future<LeaveBalance?> getLeaveBalances(String userEmail) async {
    final response = await _apiMethod.getLeaveBalances(userEmail);
    if (response['success'] == true && response['balances'] != null) {
      return LeaveBalance.fromJson(response['balances']);
    }
    return null;
  }

  Future<List<LeaveRequest>> getUserLeaveRequests(String userEmail) async {
    final response = await _apiMethod.getUserLeaveRequests(userEmail);
    if (response['success'] == true && response['requests'] != null) {
      final List<dynamic> requests = response['requests'];
      return requests.map((json) => LeaveRequest.fromJson(json)).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> submitLeaveRequest({
    required String userEmail,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    required double totalHours,
  }) async {
    return await _apiMethod.submitLeaveRequest(
      userEmail: userEmail,
      leaveType: leaveType,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      totalHours: totalHours,
    );
  }

  Future<Map<String, dynamic>> getLeaveForecast(
      String userEmail, DateTime targetDate) async {
    return await _apiMethod.getLeaveForecast(userEmail, targetDate);
  }

  Future<Map<String, dynamic>> calculateLeaveHours({
    required DateTime startDate,
    required DateTime endDate,
    String? organizationId,
  }) async {
    return await _apiMethod.calculateLeaveHours(
      startDate: startDate.toIso8601String(),
      endDate: endDate.toIso8601String(),
      organizationId: organizationId,
    );
  }

  Future<List<dynamic>> getHolidays({String? organizationId}) async {
    final response = await _apiMethod.getHolidays(organizationId: organizationId);
    if (response['success'] == true && response['data'] != null) {
      return response['data'];
    }
    return [];
  }
}
