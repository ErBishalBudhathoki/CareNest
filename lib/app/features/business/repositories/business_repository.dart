import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/business_model.dart';

final businessRepositoryProvider = Provider<BusinessRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return BusinessRepository(apiMethod);
});

class BusinessRepository {
  final ApiMethod _apiMethod;

  BusinessRepository(this._apiMethod);

  Future<void> addBusiness(Map<String, dynamic> businessData) async {
    final response = await _apiMethod.post('addBusiness', body: businessData);

    if (response['statusCode'] != 201 && response['success'] != true) {
      throw Exception(response['message'] ?? 'Failed to add business');
    }
  }

  Future<List<BusinessModel>> getBusinesses(String organizationId) async {
    final response = await _apiMethod.get('businesses/$organizationId');

    if (response['statusCode'] == 200 || response['success'] == true) {
      final List<dynamic> list = response['businesses'] ?? [];
      return list.map((e) => BusinessModel.fromJson(e)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch businesses');
    }
  }
}
