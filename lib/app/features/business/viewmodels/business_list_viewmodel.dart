import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/business/models/business_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BusinessListStatus { initial, loading, loaded, error, empty }

class BusinessListViewModel extends ChangeNotifier {
  final ApiMethod _apiMethod;
  final Ref _ref;

  BusinessListViewModel(this._ref) : _apiMethod = _ref.read(apiMethodProvider);

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

      final organizationId = _ref.read(organizationIdProvider);

      if (organizationId == null || organizationId.isEmpty) {
        _status = BusinessListStatus.error;
        _errorMessage = "Organization ID not found";
        notifyListeners();
        return;
      }

      final rawBusinesses = await _apiMethod.getBusinesses(organizationId);

      _businesses =
          rawBusinesses.map((json) => BusinessModel.fromJson(json)).toList();

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
}

final businessListViewModelProvider =
    ChangeNotifierProvider((ref) => BusinessListViewModel(ref));
