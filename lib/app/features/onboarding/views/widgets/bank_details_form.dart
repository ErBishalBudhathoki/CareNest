import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/bauhaus_widgets.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../providers/onboarding_providers.dart';

class BankDetailsForm extends ConsumerStatefulWidget {
  final String status;
  final String? bankName;
  final String? accountName;
  final String? bsb;
  final String? accountNumber;
  final VoidCallback onComplete;

  const BankDetailsForm({
    super.key,
    required this.status,
    this.bankName,
    this.accountName,
    this.bsb,
    this.accountNumber,
    required this.onComplete,
  });

  @override
  ConsumerState<BankDetailsForm> createState() => _BankDetailsFormState();
}

class _BankDetailsFormState extends ConsumerState<BankDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _bankNameController;
  late final TextEditingController _accountNameController;
  late final TextEditingController _bsbController;
  late final TextEditingController _accountNumberController;

  @override
  void initState() {
    super.initState();
    _bankNameController = TextEditingController(text: widget.bankName);
    _accountNameController = TextEditingController(text: widget.accountName);
    _bsbController = TextEditingController(text: widget.bsb);
    _accountNumberController = TextEditingController(
      text: widget.accountNumber,
    );
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNameController.dispose();
    _bsbController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausTextField(
            controller: _bankNameController,
            label: 'Bank Name',
            hintText: 'e.g. Commonwealth Bank',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),
          BauhausTextField(
            controller: _accountNameController,
            label: 'Account Name',
            hintText: 'Full name on the account',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),
          BauhausTextField(
            controller: _bsbController,
            label: 'BSB',
            hintText: 'XXX-XXX',
            keyboardType: TextInputType.number,
            validator: _bsbValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
              _BSBFormatter(),
            ],
          ),
          const SizedBox(height: 16),
          BauhausTextField(
            controller: _accountNumberController,
            label: 'Account Number',
            hintText: '1234 5678',
            keyboardType: TextInputType.number,
            validator: _accountNumberValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
              _AccountNumberFormatter(),
            ],
          ),
          const SizedBox(height: 24),
          ButtonWidget(buttonText: 'Save & Continue', onPressed: _submit),
        ],
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _bsbValidator(String? value) {
    final digits = (value ?? '').replaceAll('-', '');
    if (digits.isEmpty) return 'Required';
    if (digits.length != 6) return 'BSB must be 6 digits';
    return null;
  }

  String? _accountNumberValidator(String? value) {
    final digits = (value ?? '').replaceAll(' ', '');
    if (digits.isEmpty) return 'Required';
    if (digits.length != 8) return 'Must be exactly 8 digits';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(onboardingViewModelProvider.notifier)
        .updateStep('bankDetails', {
          'bankName': _bankNameController.text.trim(),
          'accountName': _accountNameController.text.trim(),
          'bsb': _bsbController.text.trim(),
          'accountNumber': _accountNumberController.text.trim(),
          'currentStep': 3,
        });

    widget.onComplete();
  }
}

class _BSBFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll('-', '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write('-');
      }
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _AccountNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(' ', '');
    if (digits.length <= 4) {
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    }
    final formatted = '${digits.substring(0, 4)} ${digits.substring(4)}';
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
