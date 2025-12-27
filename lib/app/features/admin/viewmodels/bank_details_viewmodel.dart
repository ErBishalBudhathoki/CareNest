import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/backend/api_method.dart';

/// ViewModel for managing bank details inputs and persistence.
/// - Holds text controllers for bank details fields.
/// - Persists values locally via SharedPreferences.
/// - Syncs with backend using ApiMethod.
class BankDetailsViewModel extends ChangeNotifier {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController bsbController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  final ApiMethod _apiMethod = ApiMethod();

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

  BankDetailsViewModel() {
    loadBankDetails();
  }

  /// Save bank details locally and attempt to sync to backend.
  /// Persists to SharedPreferences regardless; backend sync only if inputs are valid.
  Future<void> saveBankDetails() async {
    // Persist locally first for offline safety
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(bankNameKey, bankNameController.text);
    await prefs.setString(accountNameKey, accountNameController.text);
    await prefs.setString(bsbKey, bsbController.text);
    await prefs.setString(accountNumberKey, accountNumberController.text);

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
      final response = await _apiMethod.saveBankDetails(
        bankName: bankNameController.text,
        accountName: accountNameController.text,
        bsb: bsbController.text,
        accountNumber: accountNumberController.text,
      );

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
    bankNameController.text = prefs.getString(bankNameKey) ?? '';
    accountNameController.text = prefs.getString(accountNameKey) ?? '';
    bsbController.text = prefs.getString(bsbKey) ?? '';
    accountNumberController.text = prefs.getString(accountNumberKey) ?? '';
    notifyListeners();

    // Try backend fetch to keep local state in sync
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiMethod.getBankDetails();
      if (response['success'] == true && response['data'] is Map) {
        final data = Map<String, dynamic>.from(response['data']);
        bankNameController.text = (data['bankName'] ?? '').toString();
        accountNameController.text = (data['accountName'] ?? '').toString();
        bsbController.text = (data['bsb'] ?? '').toString();
        accountNumberController.text = (data['accountNumber'] ?? '').toString();

        // Persist server values locally
        await prefs.setString(bankNameKey, bankNameController.text);
        await prefs.setString(accountNameKey, accountNameController.text);
        await prefs.setString(bsbKey, bsbController.text);
        await prefs.setString(accountNumberKey, accountNumberController.text);
      } else if (response['success'] == false) {
        _errorMessage = response['message']?.toString();
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
    final bsb = bsbController.text.trim();
    final acc = accountNumberController.text.trim();
    final bsbRegex = RegExp(r'^\d{3}-\d{3}$');
    final accRegex = RegExp(r'^\d{6,10}$');
    return bsbRegex.hasMatch(bsb) && accRegex.hasMatch(acc);
  }
}
