import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/onboarding_providers.dart';
import '../../../../shared/constants/bauhaus_design.dart';
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
    _accountNumberController =
        TextEditingController(text: widget.accountNumber);
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
    final detailsListenable = Listenable.merge([
      _bankNameController,
      _accountNameController,
      _bsbController,
      _accountNumberController,
    ]);

    return Form(
      key: _formKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 680;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroHeader(context),
              const SizedBox(height: BauhausDesign.space5),
              Container(
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: BauhausDesign.textDark,
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space3,
                      ),
                      child: Text(
                        'ACCOUNT DETAILS',
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(BauhausDesign.space4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldBlock(
                            context: context,
                            controller: _bankNameController,
                            label: 'Bank Name',
                            hint: 'e.g., Commonwealth Bank',
                            icon: Icons.account_balance_outlined,
                            labelColor: BauhausDesign.accent,
                            validator: _requiredValidator,
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          _buildFieldBlock(
                            context: context,
                            controller: _accountNameController,
                            label: 'Account Name',
                            hint: 'Full name on account',
                            icon: Icons.person_outline,
                            labelColor: BauhausDesign.secondary,
                            darkLabel: true,
                            validator: _requiredValidator,
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          stacked
                              ? Column(
                                  children: [
                                    _buildFieldBlock(
                                      context: context,
                                      controller: _bsbController,
                                      label: 'BSB',
                                      hint: 'XXX-XXX',
                                      icon: Icons.tag,
                                      labelColor: BauhausDesign.primary,
                                      darkLabel: true,
                                      keyboardType: TextInputType.number,
                                      validator: _bsbValidator,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(6),
                                        _BSBFormatter(),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: BauhausDesign.space4),
                                    _buildFieldBlock(
                                      context: context,
                                      controller: _accountNumberController,
                                      label: 'Account Number',
                                      hint: '6-10 digits',
                                      icon: Icons.numbers,
                                      labelColor: BauhausDesign.surfaceOffWhite,
                                      keyboardType: TextInputType.number,
                                      validator: _accountNumberValidator,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildFieldBlock(
                                        context: context,
                                        controller: _bsbController,
                                        label: 'BSB',
                                        hint: 'XXX-XXX',
                                        icon: Icons.tag,
                                        labelColor: BauhausDesign.primary,
                                        darkLabel: true,
                                        keyboardType: TextInputType.number,
                                        validator: _bsbValidator,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(6),
                                          _BSBFormatter(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: BauhausDesign.space4),
                                    Expanded(
                                      flex: 2,
                                      child: _buildFieldBlock(
                                        context: context,
                                        controller: _accountNumberController,
                                        label: 'Account Number',
                                        hint: '6-10 digits',
                                        icon: Icons.numbers,
                                        labelColor:
                                            BauhausDesign.surfaceOffWhite,
                                        keyboardType: TextInputType.number,
                                        validator: _accountNumberValidator,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: BauhausDesign.space4),
                          _buildRulesBlock(context),
                          const SizedBox(height: BauhausDesign.space5),
                          SizedBox(
                            width: double.infinity,
                            child: BauhausActionButton(
                              text: 'Save & Continue',
                              icon: Icons.arrow_forward_rounded,
                              onPressed: _submit,
                              variant: BauhausActionVariant.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space5),
              AnimatedBuilder(
                animation: detailsListenable,
                builder: (context, _) => _buildSummaryBlock(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    final isCompleted = widget.status.toLowerCase() == 'completed';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: BauhausDesign.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space4,
                    vertical: BauhausDesign.space4,
                  ),
                  child: Text(
                    'BANK DETAILS',
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          color: BauhausDesign.surfaceWhite,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                  ),
                ),
              ),
              Container(
                width: 62,
                height: 62,
                color: BauhausDesign.accent,
                alignment: Alignment.center,
                child: Icon(
                  isCompleted ? Icons.check_rounded : Icons.account_balance,
                  size: 30,
                  color: BauhausDesign.textDark,
                ),
              ),
            ],
          ),
          Container(height: 2, color: BauhausDesign.neutral),
          Container(
            width: double.infinity,
            color: BauhausDesign.surfaceWhite,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Text(
              'Provide your payment account so payroll can be processed correctly.',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldBlock({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color labelColor,
    required String? Function(String?) validator,
    bool darkLabel = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: labelColor,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardXs],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3,
            vertical: BauhausDesign.space2,
          ),
          child: Text(
            label.toUpperCase(),
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: darkLabel
                      ? BauhausDesign.surfaceWhite
                      : BauhausDesign.textDark,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatters,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                        color: BauhausDesign.textMuted,
                      ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                child: Icon(
                  icon,
                  color: BauhausDesign.textDark,
                  size: 20,
                ),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorStyle:
                  BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                        color: BauhausDesign.error,
                        fontWeight: FontWeight.w700,
                      ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space4,
                vertical: BauhausDesign.space4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRulesBlock(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            color: BauhausDesign.secondary,
            alignment: Alignment.center,
            child: const Icon(
              Icons.rule,
              color: BauhausDesign.surfaceWhite,
              size: 18,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              'BSB format: XXX-XXX. Account number: 6-10 digits.',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBlock(BuildContext context) {
    final bankName = _bankNameController.text.trim();
    final accountName = _accountNameController.text.trim();
    final bsb = _normalizedBsb(_bsbController.text);
    final accountNumber = _accountNumberController.text.trim();

    final checks = <bool>[
      bankName.isNotEmpty,
      accountName.isNotEmpty,
      RegExp(r'^\d{3}-\d{3}$').hasMatch(bsb),
      RegExp(r'^\d{6,10}$').hasMatch(accountNumber),
    ];
    final completed = checks.where((c) => c).length;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: BauhausDesign.accent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space4,
                    vertical: BauhausDesign.space3,
                  ),
                  child: Text(
                    'SUMMARY',
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
              ),
              Container(
                color: BauhausDesign.textDark,
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space4,
                  vertical: BauhausDesign.space3,
                ),
                child: Text(
                  '$completed/4',
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ),
            ],
          ),
          Container(height: 2, color: BauhausDesign.neutral),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                _summaryRow(
                    context, 'Bank', bankName.isEmpty ? 'Not set' : bankName),
                const SizedBox(height: BauhausDesign.space2),
                _summaryRow(context, 'Account Name',
                    accountName.isEmpty ? 'Not set' : accountName),
                const SizedBox(height: BauhausDesign.space2),
                _summaryRow(context, 'BSB',
                    RegExp(r'^\d{3}-\d{3}$').hasMatch(bsb) ? bsb : 'Invalid'),
                const SizedBox(height: BauhausDesign.space2),
                _summaryRow(
                    context,
                    'Account',
                    RegExp(r'^\d{6,10}$').hasMatch(accountNumber)
                        ? _maskAccount(accountNumber)
                        : 'Invalid'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        color: BauhausDesign.surfaceWhite,
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            color: BauhausDesign.backgroundLight,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space2,
              ),
              child: Text(
                value,
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  String _normalizedBsb(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 6) return value.trim();
    return '${digits.substring(0, 3)}-${digits.substring(3, 6)}';
  }

  String? _bsbValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    final normalized = _normalizedBsb(value);
    if (!RegExp(r'^\d{3}-\d{3}$').hasMatch(normalized)) {
      return 'Invalid format (XXX-XXX)';
    }
    return null;
  }

  String? _accountNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    if (!RegExp(r'^\d{6,10}$').hasMatch(value.trim())) {
      return 'Must be 6-10 digits';
    }
    return null;
  }

  String _maskAccount(String input) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return '—';
    final last4 =
        digits.length > 4 ? digits.substring(digits.length - 4) : digits;
    return '•••• $last4';
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final normalizedBsb = _normalizedBsb(_bsbController.text);
      await ref.read(onboardingViewModelProvider.notifier).updateStep(
        'bankDetails',
        {
          'bankName': _bankNameController.text.trim(),
          'accountName': _accountNameController.text.trim(),
          'bsb': normalizedBsb,
          'accountNumber': _accountNumberController.text.trim(),
          'currentStep': 3,
        },
      );
      widget.onComplete();
    }
  }
}

class _BSBFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final clipped = digits.length > 6 ? digits.substring(0, 6) : digits;
    if (clipped.length <= 3) {
      return TextEditingValue(
        text: clipped,
        selection: TextSelection.collapsed(offset: clipped.length),
      );
    }

    final formatted = '${clipped.substring(0, 3)}-${clipped.substring(3)}';
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
