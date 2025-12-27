
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

/// Business addition status enum
enum AddBusinessStatus { idle, processing, success, error }

/// ViewModel for handling business addition logic
/// Follows MVVM pattern by keeping only business logic and state management
class AddBusinessViewModel extends ChangeNotifier {
  final ApiMethod _apiMethod = ApiMethod();
  final Ref _ref;

  AddBusinessViewModel(this._ref);

  // Status notifier for UI to react to state changes
  final ValueNotifier<AddBusinessStatus> addBusinessStatus =
      ValueNotifier<AddBusinessStatus>(AddBusinessStatus.idle);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Adds business with provided data
  /// Returns success/error status without handling UI
  Future<void> addBusiness(Map<String, String> businessData) async {
    try {
      // Set processing status
      addBusinessStatus.value = AddBusinessStatus.processing;
      _errorMessage = null;

      // Call API to add business
      final response = await _addBusinessToApi(businessData);

      // Update status based on response
      if (response == "success") {
        addBusinessStatus.value = AddBusinessStatus.success;
      } else {
        _errorMessage = "Failed to add business. Please try again.";
        addBusinessStatus.value = AddBusinessStatus.error;
      }
    } catch (e) {
      _errorMessage = "An unexpected error occurred: ${e.toString()}";
      addBusinessStatus.value = AddBusinessStatus.error;
    }
  }

  /// Private method to handle API call
  Future<String> _addBusinessToApi(Map<String, String> businessData) async {
    // Get current user's email and organization ID from providers
    final userEmail = _ref.read(userEmailProvider);
    final organizationId = _ref.read(organizationIdProvider);

    // Debug prints to check what values we're getting
    debugPrint('🔍 DEBUG AddBusiness: userEmail from provider: $userEmail');
    debugPrint(
        '🔍 DEBUG AddBusiness: organizationId from provider: $organizationId');

    final response = await _apiMethod.addBusiness(
      businessData['businessName'] ?? '',
      businessData['businessEmail'] ?? '',
      businessData['businessPhone'] ?? '',
      businessData['businessAddress'] ?? '',
      businessData['businessCity'] ?? '',
      businessData['businessState'] ?? '',
      businessData['businessZip'] ?? '',
      organizationId: organizationId,
      userEmail: userEmail,
    );

    // Check if response contains error
    if (response != null && response['error'] != null) {
      return 'error';
    }

    // If no error and response is not null, consider it success
    if (response != null && response['message'] != null) {
      return 'success';
    }

    return 'success'; // Default to success if response is valid
  }

  /// Resets the status to idle
  void resetStatus() {
    addBusinessStatus.value = AddBusinessStatus.idle;
    _errorMessage = null;
  }

  @override
  void dispose() {
    addBusinessStatus.dispose();
    super.dispose();
  }
}
