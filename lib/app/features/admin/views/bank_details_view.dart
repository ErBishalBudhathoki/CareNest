import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import '../../../shared/widgets/flushbar_widget.dart';
import '../../../shared/widgets/confirmation_alert_dialog_widget.dart';
import '../viewmodels/bank_details_viewmodel.dart';
import '../models/bank_details_state.dart';

class BankDetailsView extends ConsumerStatefulWidget {
  final BankDetailsScope scope;

  const BankDetailsView({
    super.key,
    this.scope = BankDetailsScope.personal,
  });

  @override
  ConsumerState<BankDetailsView> createState() => _BankDetailsViewState();
}

class _BankDetailsViewState extends ConsumerState<BankDetailsView> {
  late final TextEditingController bankNameController;
  late final TextEditingController accountNameController;
  late final TextEditingController bsbController;
  late final TextEditingController accountNumberController;

  @override
  void initState() {
    super.initState();
    final initialState = ref.read(bankDetailsViewModelProvider(widget.scope));
    bankNameController = TextEditingController(text: initialState.bankName);
    accountNameController = TextEditingController(text: initialState.accountName);
    bsbController = TextEditingController(text: initialState.bsb);
    accountNumberController = TextEditingController(text: initialState.accountNumber);
  }

  @override
  void dispose() {
    bankNameController.dispose();
    accountNameController.dispose();
    bsbController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }

  bool get _isOrganizationScope => widget.scope == BankDetailsScope.organization;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bankDetailsViewModelProvider(widget.scope));

    ref.listen<BankDetailsState>(
      bankDetailsViewModelProvider(widget.scope),
      (previous, next) {
        if (previous == null || (previous.isLoading && !next.isLoading)) {
          if (bankNameController.text.isEmpty && next.bankName.isNotEmpty) {
            bankNameController.text = next.bankName;
          }
          if (accountNameController.text.isEmpty && next.accountName.isNotEmpty) {
            accountNameController.text = next.accountName;
          }
          if (bsbController.text.isEmpty && next.bsb.isNotEmpty) {
            bsbController.text = next.bsb;
          }
          if (accountNumberController.text.isEmpty && next.accountNumber.isNotEmpty) {
            accountNumberController.text = next.accountNumber;
          }
        }
      },
    );

    final detailsListenable = Listenable.merge([
      bankNameController,
      accountNameController,
      bsbController,
      accountNumberController,
    ]);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        titleSpacing: BauhausDesign.space4,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BANK DETAILS',
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: BauhausDesign.textDark,
                    letterSpacing: 1.2,
                  ),
            ),
            Text(
              _isOrganizationScope
                  ? 'Invoice payout destination'
                  : 'Your payroll destination',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            color: BauhausDesign.neutral,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 980;
            final horizontalPadding = constraints.maxWidth >= 1280
                ? BauhausDesign.space10
                : BauhausDesign.space6;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                BauhausDesign.space6,
                horizontalPadding,
                BauhausDesign.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(context),
                  const SizedBox(height: BauhausDesign.space6),
                  isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: _buildFormSection(context, state),
                            ),
                            const SizedBox(width: BauhausDesign.space6),
                            Expanded(
                              flex: 5,
                              child: AnimatedBuilder(
                                animation: detailsListenable,
                                builder: (context, _) {
                                  return _buildSummarySection(context);
                                },
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFormSection(context, state),
                            const SizedBox(height: BauhausDesign.space6),
                            AnimatedBuilder(
                              animation: detailsListenable,
                              builder: (context, _) {
                                return _buildSummarySection(context);
                              },
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
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
                    horizontal: BauhausDesign.space5,
                    vertical: BauhausDesign.space5,
                  ),
                  child: Text(
                    _isOrganizationScope
                        ? 'SET PAYOUT ACCOUNT'
                        : 'SET MY BANK ACCOUNT',
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
                width: 76,
                height: 76,
                color: BauhausDesign.accent,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.account_balance,
                  color: BauhausDesign.textDark,
                  size: 32,
                ),
              ),
            ],
          ),
          Container(height: 2, color: BauhausDesign.neutral),
          Container(
            width: double.infinity,
            color: BauhausDesign.surfaceWhite,
            padding: const EdgeInsets.all(BauhausDesign.space5),
            child: Text(
              _isOrganizationScope
                  ? 'This organization account appears on invoices and is used for payout exports.'
                  : 'This personal account is used for your payroll and reimbursement payouts.',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(BuildContext context, BankDetailsState state) {
    final errorMessage = state.errorMessage?.trim();

    return Container(
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
              horizontal: BauhausDesign.space5,
              vertical: BauhausDesign.space4,
            ),
            child: Text(
              'ACCOUNT INPUTS',
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldBlock(
                  context: context,
                  controller: bankNameController,
                  label: 'Bank Name',
                  hint: 'e.g., Commonwealth Bank',
                  icon: Icons.account_balance_outlined,
                  labelColor: BauhausDesign.accent,
                ),
                const SizedBox(height: BauhausDesign.space5),
                _buildFieldBlock(
                  context: context,
                  controller: accountNameController,
                  label: 'Account Name',
                  hint: 'Full name as shown on account',
                  icon: Icons.person_outline,
                  labelColor: BauhausDesign.secondary,
                  darkLabel: true,
                ),
                const SizedBox(height: BauhausDesign.space5),
                _buildFieldBlock(
                  context: context,
                  controller: bsbController,
                  label: 'BSB',
                  hint: '000-000',
                  icon: Icons.tag,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                    _BSBFormatter(),
                  ],
                  labelColor: BauhausDesign.primary,
                  darkLabel: true,
                ),
                const SizedBox(height: BauhausDesign.space5),
                _buildFieldBlock(
                  context: context,
                  controller: accountNumberController,
                  label: 'Account Number',
                  hint: '6-10 digits',
                  icon: Icons.numbers,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  labelColor: BauhausDesign.surfaceOffWhite,
                ),
                const SizedBox(height: BauhausDesign.space5),
                _buildFormatRules(context),
                const SizedBox(height: BauhausDesign.space6),
                SizedBox(
                  width: double.infinity,
                  child: BauhausActionButton(
                    onPressed: state.isLoading
                        ? null
                        : () => _showSaveConfirmation(context),
                    text: 'Save Bank Details',
                    icon: Icons.save_outlined,
                    variant: BauhausActionVariant.primary,
                    isLoading: state.isLoading,
                  ),
                ),
                if (errorMessage != null && errorMessage.isNotEmpty) ...[
                  const SizedBox(height: BauhausDesign.space4),
                  _buildInlineError(context, errorMessage),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    final bankName = bankNameController.text.trim();
    final accountName = accountNameController.text.trim();
    final bsb = bsbController.text.trim();
    final accountNumber = accountNumberController.text.trim();

    final hasBankName = bankName.isNotEmpty;
    final hasAccountName = accountName.isNotEmpty;
    final hasBsb = RegExp(r'^\d{3}-\d{3}$').hasMatch(bsb);
    final hasAccountNumber = RegExp(r'^\d{6,10}$').hasMatch(accountNumber);
    final completed = [hasBankName, hasAccountName, hasBsb, hasAccountNumber]
        .where((v) => v)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                      color: BauhausDesign.accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space3,
                      ),
                      child: Text(
                        _isOrganizationScope
                            ? 'LIVE ORG SUMMARY'
                            : 'LIVE PERSONAL SUMMARY',
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
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
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
                    _buildSummaryRow(
                      context,
                      label: 'Bank',
                      value: hasBankName ? bankName : 'Not set',
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildSummaryRow(
                      context,
                      label: 'Account Name',
                      value: hasAccountName ? accountName : 'Not set',
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildSummaryRow(
                      context,
                      label: 'BSB',
                      value: hasBsb ? bsb : 'Format required',
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _buildSummaryRow(
                      context,
                      label: 'Account',
                      value: hasAccountNumber
                          ? _maskAccountNumber(accountNumber)
                          : 'Format required',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: BauhausDesign.space5),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceOffWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                color: BauhausDesign.secondary,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: BauhausDesign.surfaceWhite,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  'Credentials are encrypted before transmission and stored securely. '
                  'Only masked account details are shown in this UI.',
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                            height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldBlock({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    required Color labelColor,
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
                  letterSpacing: 0.7,
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
              filled: true,
              fillColor: BauhausDesign.backgroundLight,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
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

  Widget _buildSummaryRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            color: BauhausDesign.backgroundLight,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space3,
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
                vertical: BauhausDesign.space3,
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

  Widget _buildFormatRules(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: BauhausDesign.textDark,
            size: 20,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REQUIREMENTS',
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  '• BSB: exactly 6 digits (XXX-XXX format is auto-applied)\n'
                  '• Account: 6 to 10 digits\n'
                  '• Check details carefully—wrong info delays payouts.',
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(
                        color: BauhausDesign.textMuted,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineError(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.error.withOpacity(0.1),
        border: Border.all(color: BauhausDesign.error, width: 2),
      ),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: BauhausDesign.error,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              message,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.error,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveConfirmation(BuildContext context) {
    final maskedAcc = _maskAccountNumber(accountNumberController.text);
    final bankName = bankNameController.text.trim();
    final bsb = bsbController.text.trim();

    final displayBank = bankName.isNotEmpty ? bankName : 'Bank details';
    final displayBsb = bsb.isNotEmpty ? bsb : '—';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return ConfirmationAlertDialog(
          title: 'Confirm save',
          content:
              '$displayBank\nAccount: $maskedAcc\nBSB: $displayBsb\n\nProceed to save these details?',
          confirmText: 'Save',
          cancelText: 'Cancel',
          confirmColor: BauhausDesign.primary,
          confirmAction: () {
            Navigator.of(dialogContext).pop();
            _handleSaveWithAlerts(context);
          },
        );
      },
    );
  }

  Future<void> _handleSaveWithAlerts(BuildContext context) async {
    await ref.read(bankDetailsViewModelProvider(widget.scope).notifier).saveBankDetails(
      bankName: bankNameController.text,
      accountName: accountNameController.text,
      bsb: bsbController.text,
      accountNumber: accountNumberController.text,
    );

    final currentState = ref.read(bankDetailsViewModelProvider(widget.scope));
    final flush = FlushBarWidget();

    if (currentState.errorMessage != null) {
      flush.flushBar(
        context: context,
        title: 'Save failed',
        message: '${currentState.errorMessage}\nYour changes are saved locally.',
        backgroundColor: BauhausDesign.error,
      );
    } else {
      final maskedAcc = _maskAccountNumber(currentState.accountNumber);
      final bankName = currentState.bankName.trim();
      final bsb = currentState.bsb.trim();

      final displayBank = bankName.isNotEmpty ? bankName : 'Bank details';
      final displayBsb = bsb.isNotEmpty ? bsb : '—';

      flush.flushBar(
        context: context,
        title: widget.scope == BankDetailsScope.organization
            ? 'Organization bank details saved'
            : 'Bank details saved',
        message: '$displayBank • Account $maskedAcc • BSB $displayBsb',
        backgroundColor: BauhausDesign.success,
      );
    }
  }

  String _maskAccountNumber(String val) {
    final clean = val.trim();
    if (clean.length < 4) return '****';
    final end = clean.substring(clean.length - 4);
    final mask = '*' * (clean.length - 4);
    return '$mask$end';
  }
}

class _BSBFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('-', '');
    if (text.isEmpty) return newValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3) buffer.write('-');
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
