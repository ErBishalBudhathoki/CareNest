import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repositories/appointment_repository.dart';

final appointmentViewModelProvider =
    StateNotifierProvider.autoDispose<AppointmentViewModel, AppointmentState>(
        (ref) {
  final repository = ref.watch(appointmentRepositoryProvider);
  return AppointmentViewModel(repository);
});

class AppointmentState {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic>? assignmentResult;

  const AppointmentState({
    this.isLoading = false,
    this.errorMessage,
    this.assignmentResult,
  });

  AppointmentState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? assignmentResult,
  }) {
    return AppointmentState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage, // Null resets error if not provided? No, explicit.
      assignmentResult: assignmentResult ?? this.assignmentResult,
    );
  }
}

class AppointmentViewModel extends StateNotifier<AppointmentState> {
  final AppointmentRepository _repository;

  AppointmentViewModel(this._repository) : super(const AppointmentState());

  Future<Map<String, dynamic>> assignClientToUser({
    required String userEmail,
    required String clientEmail,
    required List<String> dateList,
    required List<String> startTimeList,
    required List<String> endTimeList,
    required List<String> breakList,
    required Map<String, dynamic> ndisItem,
    required List<bool> highIntensityList,
    List<Map<String, dynamic>>? scheduleWithNdisItems,
  }) async {
    state = state.copyWith(
        isLoading: true, errorMessage: null, assignmentResult: null);
    try {
      final result = await _repository.assignClientToUser(
        userEmail: userEmail,
        clientEmail: clientEmail,
        dateList: dateList,
        startTimeList: startTimeList,
        endTimeList: endTimeList,
        breakList: breakList,
        ndisItem: ndisItem,
        highIntensityList: highIntensityList,
        scheduleWithNdisItems: scheduleWithNdisItems,
      );

      state = state.copyWith(isLoading: false, assignmentResult: result);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      // Rethrow so UI can handle if it wants, or return error map
      return {'success': false, 'message': e.toString()};
    }
  }
}
