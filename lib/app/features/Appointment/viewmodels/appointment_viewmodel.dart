import '../repositories/appointment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentViewModelProvider =
    NotifierProvider.autoDispose<AppointmentViewModel, AppointmentState>(
      AppointmentViewModel.new,
    );

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
      errorMessage: errorMessage,
      assignmentResult: assignmentResult ?? this.assignmentResult,
    );
  }
}

class AppointmentViewModel extends Notifier<AppointmentState> {
  late final AppointmentRepository _repository;

  @override
  AppointmentState build() {
    _repository = ref.watch(appointmentRepositoryProvider);
    return const AppointmentState();
  }

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
      isLoading: true,
      errorMessage: null,
      assignmentResult: null,
    );
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
      return {'success': false, 'message': e.toString()};
    }
  }
}
