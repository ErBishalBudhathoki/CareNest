import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminMileageViewModel {
  void approveTrip(String id) {}
  void rejectTrip(String id, String reason) {}
  void flagTrip(String id) {}
}

final adminMileageViewModelProvider = Provider((ref) => AdminMileageViewModel());
