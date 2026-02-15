import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/multi_org_rollup_model.dart';

final multiOrgRepositoryProvider = Provider<MultiOrgRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return MultiOrgRepository(apiMethod);
});

class MultiOrgRepository {
  final ApiMethod _apiMethod;

  MultiOrgRepository(this._apiMethod);

  /// Get multi-organization rollup statistics
  Future<List<MultiOrgRollup>> getRollup() async {
    final response = await _apiMethod.get('multiorg/rollup');

    if (response['success'] == true) {
      final List<dynamic> data = response['data'] ?? [];
      return data.map((e) => MultiOrgRollup.fromJson(e)).toList();
    } else {
      throw Exception(
          response['message'] ?? 'Failed to fetch multi-org rollup');
    }
  }
}
