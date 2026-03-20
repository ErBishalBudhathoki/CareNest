import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

enum BankDetailsScope {
  personal,
  organization,
}

/// ViewModel for managing bank details inputs and persistence.
/// - Holds text controllers for bank details fields.
/// - Persists values locally via SharedPreferences.
/// - Syncs with backend using ApiMethod.
class BankDetailsViewModel extends ChangeNotifier {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController bsbController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  final ApiMethod _apiMethod;
  final BankDetailsScope scope;

  bool _isLoading = false;
  String? _errorMessage;

  /// Indicates if a save/load operation is in progress.
  bool get isLoading => _isLoading;

  /// Last error message from network operations, if any.
  String? get errorMessage => _errorMessage;

  static const String bankNameKey = 'bankName';
  static const String accountNameKey = 'accountName';
  static const String bsbKey = 'bsb';
  static const String accountNumberKey = 'accountNumber';

  String get _bankNameStorageKey => '${scope.name}_$bankNameKey';
  String get _accountNameStorageKey => '${scope.name}_$accountNameKey';
  String get _bsbStorageKey => '${scope.name}_$bsbKey';
  String get _accountNumberStorageKey => '${scope.name}_$accountNumberKey';

  BankDetailsViewModel({
    required ApiMethod apiMethod,
    this.scope = BankDetailsScope.personal,
  }) : _apiMethod = apiMethod {
    loadBankDetails();
  }

  /// Save bank details locally and attempt to sync to backend.
  /// Persists to SharedPreferences regardless; backend sync only if inputs are valid.
  Future<void> saveBankDetails() async {
    // Persist locally first for offline safety
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bankNameStorageKey, bankNameController.text);
    await prefs.setString(_accountNameStorageKey, accountNameController.text);
    await prefs.setString(_bsbStorageKey, bsbController.text);
    await prefs.setString(
      _accountNumberStorageKey,
      accountNumberController.text,
    );

    // Validate before syncing to backend
    final inputsValid = _validateInputs();
    if (!inputsValid) {
      _errorMessage =
          'Please check BSB (XXX-XXX) and account number (6-10 digits).';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      late final Map<String, dynamic> response;
      if (scope == BankDetailsScope.organization) {
        final sharedUtils = SharedPreferencesUtils();
        await sharedUtils.init();
        final organizationId = sharedUtils.getOrganizationId();
        if (organizationId == null || organizationId.isEmpty) {
          _errorMessage = 'Missing organization context';
          _isLoading = false;
          notifyListeners();
          return;
        }

        response = await _apiMethod.updateOrganizationDetails(
          organizationId,
          {
            'bankDetails': {
              'bankName': bankNameController.text.trim(),
              'accountName': accountNameController.text.trim(),
              'bsb': bsbController.text.trim(),
              'accountNumber': accountNumberController.text.trim(),
            },
          },
        );
      } else {
        response = await _apiMethod.saveBankDetails(
          bankName: bankNameController.text,
          accountName: accountNameController.text,
          bsb: bsbController.text,
          accountNumber: accountNumberController.text,
        );
      }

      if (response['success'] != true) {
        _errorMessage = response['message']?.toString() ??
            'Failed to save bank details to server';
      }
    } catch (e) {
      _errorMessage = 'Error saving bank details: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load bank details from local storage, then attempt to fetch from backend.
  /// If backend returns data, overrides local values and re-persists.
  Future<void> loadBankDetails() async {
    final prefs = await SharedPreferences.getInstance();
    bankNameController.text = prefs.getString(_bankNameStorageKey) ?? '';
    accountNameController.text = prefs.getString(_accountNameStorageKey) ?? '';
    bsbController.text = prefs.getString(_bsbStorageKey) ?? '';
    accountNumberController.text =
        prefs.getString(_accountNumberStorageKey) ?? '';
    notifyListeners();

    // Try backend fetch to keep local state in sync
    try {
      _isLoading = true;
      notifyListeners();

      Map<String, dynamic> resolvedData = const {};
      bool resolvedSuccess = false;
      String? resolvedError;

      if (scope == BankDetailsScope.organization) {
        final sharedUtils = SharedPreferencesUtils();
        await sharedUtils.init();
        final organizationId = sharedUtils.getOrganizationId();

        if (organizationId == null || organizationId.isEmpty) {
          resolvedError = 'Missing organization context';
        } else {
          final response = await _apiMethod.getOrganizationDetails(
            organizationId,
            forceRefresh: true,
          );
          final organization = response['organization'];
          final bankDetails =
              organization is Map ? organization['bankDetails'] : null;

          if (organization is Map) {
            resolvedSuccess = true;
            resolvedData = Map<String, dynamic>.from(
              bankDetails is Map ? bankDetails : const {},
            );
          } else {
            resolvedError = response['message']?.toString() ??
                response['error']?.toString() ??
                'Failed to fetch organization bank details';
          }
        }
      } else {
        final response = await _apiMethod.getBankDetails();
        if (response['success'] == true && response['data'] is Map) {
          resolvedSuccess = true;
          resolvedData = Map<String, dynamic>.from(response['data']);
        } else {
          resolvedError = response['message']?.toString();
        }
      }

      if (resolvedSuccess) {
        bankNameController.text = (resolvedData['bankName'] ?? '').toString();
        accountNameController.text =
            (resolvedData['accountName'] ?? '').toString();
        bsbController.text = (resolvedData['bsb'] ?? '').toString();
        accountNumberController.text =
            (resolvedData['accountNumber'] ?? '').toString();

        // Persist server values locally
        await prefs.setString(_bankNameStorageKey, bankNameController.text);
        await prefs.setString(
          _accountNameStorageKey,
          accountNameController.text,
        );
        await prefs.setString(_bsbStorageKey, bsbController.text);
        await prefs.setString(
          _accountNumberStorageKey,
          accountNumberController.text,
        );
      } else if (resolvedError != null && resolvedError.isNotEmpty) {
        _errorMessage = resolvedError;
      }
    } catch (e) {
      _errorMessage = 'Error loading bank details: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Validate user inputs for BSB and account number formats.
  bool _validateInputs() {
    final bsb = bsbController.text.trim().replaceAll('-', '');
    final acc = accountNumberController.text.trim();
    final bsbRegex = RegExp(r'^\d{6}$');
    final accRegex = RegExp(r'^\d{6,10}$');
    return bsbRegex.hasMatch(bsb) && accRegex.hasMatch(acc);
  }
}
