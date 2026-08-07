import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import '../models/bank_details_state.dart';

enum BankDetailsScope { personal, organization }

class BankDetailsViewModel extends Notifier<BankDetailsState> {
  final BankDetailsScope scope;
  late final ApiMethod _apiMethod;

  BankDetailsViewModel(this.scope);

  static const String bankNameKey = 'bankName';
  static const String accountNameKey = 'accountName';
  static const String bsbKey = 'bsb';
  static const String accountNumberKey = 'accountNumber';

  String get _bankNameStorageKey => '${scope.name}_$bankNameKey';
  String get _accountNameStorageKey => '${scope.name}_$accountNameKey';
  String get _bsbStorageKey => '${scope.name}_$bsbKey';
  String get _accountNumberStorageKey => '${scope.name}_$accountNumberKey';

  @override
  BankDetailsState build() {
    _apiMethod = ref.watch(apiMethodProvider);
    loadBankDetails();
    return const BankDetailsState();
  }

  /// Save bank details locally and attempt to sync to backend.
  Future<void> saveBankDetails({
    required String bankName,
    required String accountName,
    required String bsb,
    required String accountNumber,
  }) async {
    // Persist locally first for offline safety
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bankNameStorageKey, bankName);
    await prefs.setString(_accountNameStorageKey, accountName);
    await prefs.setString(_bsbStorageKey, bsb);
    await prefs.setString(_accountNumberStorageKey, accountNumber);

    // Validate before syncing to backend
    final inputsValid = _validateInputs(bsb, accountNumber);
    if (!inputsValid) {
      state = state.copyWith(
        errorMessage:
            'Please check BSB (XXX-XXX) and account number (6-10 digits).',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      late final Map<String, dynamic> response;
      if (scope == BankDetailsScope.organization) {
        final sharedUtils = SharedPreferencesUtils();
        await sharedUtils.init();
        final organizationId = sharedUtils.getOrganizationId();
        if (organizationId == null || organizationId.isEmpty) {
          state = state.copyWith(
            errorMessage: 'Missing organization context',
            isLoading: false,
          );
          return;
        }

        response = await _apiMethod.updateOrganizationDetails(organizationId, {
          'bankDetails': {
            'bankName': bankName.trim(),
            'accountName': accountName.trim(),
            'bsb': bsb.trim(),
            'accountNumber': accountNumber.trim(),
          },
        });
      } else {
        response = await _apiMethod.saveBankDetails(
          bankName: bankName,
          accountName: accountName,
          bsb: bsb,
          accountNumber: accountNumber,
        );
      }

      if (response['success'] != true) {
        state = state.copyWith(
          errorMessage:
              response['message']?.toString() ??
              'Failed to save bank details to server',
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          bankName: bankName,
          accountName: accountName,
          bsb: bsb,
          accountNumber: accountNumber,
          isLoading: false,
          errorMessage: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error saving bank details: $e',
        isLoading: false,
      );
    }
  }

  /// Load bank details from local storage, then attempt to fetch from backend.
  Future<void> loadBankDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final localBankName = prefs.getString(_bankNameStorageKey) ?? '';
    final localAccountName = prefs.getString(_accountNameStorageKey) ?? '';
    final localBsb = prefs.getString(_bsbStorageKey) ?? '';
    final localAccountNumber = prefs.getString(_accountNumberStorageKey) ?? '';

    state = state.copyWith(
      bankName: localBankName,
      accountName: localAccountName,
      bsb: localBsb,
      accountNumber: localAccountNumber,
    );

    // Try backend fetch to keep local state in sync
    try {
      state = state.copyWith(isLoading: true);

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
          final bankDetails = organization is Map
              ? organization['bankDetails']
              : null;

          if (organization is Map) {
            resolvedSuccess = true;
            resolvedData = Map<String, dynamic>.from(
              bankDetails is Map ? bankDetails : const {},
            );
          } else {
            resolvedError =
                response['message']?.toString() ??
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
        final serverBankName = (resolvedData['bankName'] ?? '').toString();
        final serverAccountName = (resolvedData['accountName'] ?? '')
            .toString();
        final serverBsb = (resolvedData['bsb'] ?? '').toString();
        final serverAccountNumber = (resolvedData['accountNumber'] ?? '')
            .toString();

        // Persist server values locally
        await prefs.setString(_bankNameStorageKey, serverBankName);
        await prefs.setString(_accountNameStorageKey, serverAccountName);
        await prefs.setString(_bsbStorageKey, serverBsb);
        await prefs.setString(_accountNumberStorageKey, serverAccountNumber);

        state = state.copyWith(
          bankName: serverBankName,
          accountName: serverAccountName,
          bsb: serverBsb,
          accountNumber: serverAccountNumber,
          isLoading: false,
          errorMessage: null,
        );
      } else {
        state = state.copyWith(isLoading: false);
        if (resolvedError != null && resolvedError.isNotEmpty) {
          state = state.copyWith(errorMessage: resolvedError);
        }
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error loading bank details: $e',
        isLoading: false,
      );
    }
  }

  /// Validate user inputs for BSB and account number formats.
  bool _validateInputs(String bsb, String accountNumber) {
    final cleanBsb = bsb.trim().replaceAll('-', '');
    final acc = accountNumber.trim();
    final bsbRegex = RegExp(r'^\d{6}$');
    final accRegex = RegExp(r'^\d{6,10}$');
    return bsbRegex.hasMatch(cleanBsb) && accRegex.hasMatch(acc);
  }
}

final bankDetailsViewModelProvider =
    NotifierProvider.family<
      BankDetailsViewModel,
      BankDetailsState,
      BankDetailsScope
    >((scope) => BankDetailsViewModel(scope));
