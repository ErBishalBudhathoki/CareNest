import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/onboarding_providers.dart';
import '../../../../shared/constants/bauhaus_design.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/bauhaus_widgets.dart';

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
    _accountNumberController = TextEditingController(text: widget.accountNumber);
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
          Text(
            'Bank Details',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'Please provide your bank account details for salary payments.',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 24),
          BauhausTextField(
            controller: _bankNameController,
            label: 'Bank Name',
            hintText: 'Enter Bank Name',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            controller: _accountNameController,
            label: 'Account Name',
            hintText: 'Enter Account Name',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                child: BauhausTextField(
                  controller: _bsbController,
                  label: 'BSB',
                  hintText: 'XXX-XXX',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    if (!RegExp(r'^\d{3}-?\d{3}$').hasMatch(value)) return 'Invalid Format (XXX-XXX)';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                flex: 2,
                child: BauhausTextField(
                  controller: _accountNumberController,
                  label: 'Account Number',
                  hintText: 'Enter Account Number',
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            buttonText: 'Save & Continue',
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(onboardingViewModelProvider.notifier).updateStep(
        'bankDetails',
        {
          'bankName': _bankNameController.text,
          'accountName': _accountNameController.text,
          'bsb': _bsbController.text,
          'accountNumber': _accountNumberController.text,
          'currentStep': 3,
        },
      );
      widget.onComplete();
    }
  }
}
