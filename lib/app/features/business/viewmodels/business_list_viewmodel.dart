import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/business/models/business_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BusinessListStatus { initial, loading, loaded, error, empty }

class BusinessListViewModel extends Notifier<int> {
  late final ApiMethod _apiMethod;

  @override
  int build() {
    _apiMethod = ref.watch(apiMethodProvider);
    return 0;
  }

  void notifyListeners() {
    state = state + 1;
  }

  BusinessListStatus _status = BusinessListStatus.initial;
  BusinessListStatus get status => _status;

  List<BusinessModel> _businesses = [];
  List<BusinessModel> get businesses => _businesses;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadBusinesses() async {
    try {
      _status = BusinessListStatus.loading;
      notifyListeners();

      var organizationId = ref.read(organizationIdProvider);
      if (organizationId == null || organizationId.isEmpty) {
        final prefs = ref.read(sharedPreferencesProvider);
        await prefs.init();
        organizationId = prefs.getOrganizationId();
      }

      if (organizationId == null || organizationId.isEmpty) {
        _status = BusinessListStatus.error;
        _errorMessage = "Organization ID not found";
        notifyListeners();
        return;
      }

      final rawBusinesses = await _apiMethod.getBusinesses(organizationId);

      _businesses = rawBusinesses
          .map((json) => BusinessModel.fromJson(json))
          .toList();

      if (_businesses.isEmpty) {
        _status = BusinessListStatus.empty;
      } else {
        _status = BusinessListStatus.loaded;
      }
    } catch (e) {
      debugPrint('Error loading businesses: $e');
      _status = BusinessListStatus.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void refresh() {
    loadBusinesses();
  }

  Future<Map<String, dynamic>> updateBusiness({
    required String businessId,
    required String businessName,
    required String businessEmail,
    required String businessPhone,
    required String businessAddress,
    required String businessCity,
    required String businessState,
    required String businessZip,
    required String userEmail,
    required String organizationId,
  }) async {
    final response = await _apiMethod.updateBusiness(
      businessId: businessId,
      businessName: businessName,
      businessEmail: businessEmail,
      businessPhone: businessPhone,
      businessAddress: businessAddress,
      businessCity: businessCity,
      businessState: businessState,
      businessZip: businessZip,
      userEmail: userEmail,
      organizationId: organizationId,
    );

    if (response['success'] == true) {
      await loadBusinesses();
      return response;
    }

    throw Exception(response['message'] ?? 'Failed to update business');
  }

  Future<Map<String, dynamic>> deleteBusiness({
    required String businessId,
    required String userEmail,
    required String organizationId,
  }) async {
    final response = await _apiMethod.deleteBusiness(
      businessId: businessId,
      userEmail: userEmail,
      organizationId: organizationId,
    );

    if (response['success'] == true) {
      await loadBusinesses();
      return response;
    }

    throw Exception(response['message'] ?? 'Failed to delete business');
  }
}

final businessListViewModelProvider =
    NotifierProvider<BusinessListViewModel, int>(BusinessListViewModel.new);
