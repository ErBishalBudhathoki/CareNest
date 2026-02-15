import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import '../../../shared/widgets/flushbar_widget.dart';
import '../../../shared/widgets/confirmation_alert_dialog_widget.dart';
import '../viewmodels/bank_details_viewmodel.dart';

class BankDetailsView extends ConsumerWidget {
  const BankDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(app_providers.bankDetailsViewModelProvider);
    
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Bank Details',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        elevation: 0,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space6),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                        border: Border.all(
                          color: BauhausDesign.surfaceWhite.withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.account_balance,
                        color: BauhausDesign.surfaceWhite,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Banking Information',
                            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            'Securely store your account details',
                            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                                  color: BauhausDesign.surfaceWhite.withOpacity(0.9),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: BauhausDesign.space6),

              // Form Card
              BauhausCard(
                padding: const EdgeInsets.all(BauhausDesign.space6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBauhausTextField(
                      context: context,
                      controller: viewModel.bankNameController,
                      label: 'Bank Name',
                      icon: Icons.account_balance_outlined,
                      hint: 'e.g., Commonwealth Bank',
                    ),

                    const SizedBox(height: BauhausDesign.space4),

                    _buildBauhausTextField(
                      context: context,
                      controller: viewModel.accountNameController,
                      label: 'Account Name',
                      icon: Icons.person_outline,
                      hint: 'Full name as shown on account',
                    ),

                    const SizedBox(height: BauhausDesign.space4),

                    _buildBauhausTextField(
                      context: context,
                      controller: viewModel.bsbController,
                      label: 'BSB',
                      icon: Icons.tag,
                      hint: '000-000',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                        _BSBFormatter(),
                      ],
                    ),

                    const SizedBox(height: BauhausDesign.space4),

                    _buildBauhausTextField(
                      context: context,
                      controller: viewModel.accountNumberController,
                      label: 'Account Number',
                      icon: Icons.numbers,
                      hint: 'Enter account number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),

                    const SizedBox(height: BauhausDesign.space8),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: BauhausActionButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () {
                                _showSaveConfirmation(context, viewModel);
                              },
                        text: 'Save Bank Details',
                        icon: Icons.save_outlined,
                        variant: BauhausActionVariant.primary,
                        isLoading: viewModel.isLoading,
                      ),
                    ),

                    const SizedBox(height: BauhausDesign.space4),

                    // Security Notice
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                        border: Border.all(
                          color: BauhausDesign.secondary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: BauhausDesign.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: Text(
                              'Your information is encrypted and securely stored',
                              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBauhausTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: BauhausDesign.getTextTheme(context).bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
            prefixIcon: Icon(icon, color: BauhausDesign.neutral, size: 20),
            filled: true,
            fillColor: BauhausDesign.backgroundLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              borderSide: const BorderSide(color: BauhausDesign.neutral),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              borderSide: const BorderSide(color: BauhausDesign.neutral),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              borderSide: const BorderSide(color: BauhausDesign.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space3,
            ),
          ),
        ),
      ],
    );
  }
}

// Custom formatter for BSB (adds hyphen after 3 digits)
class _BSBFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('-', '');

    if (text.length <= 3) {
      return newValue.copyWith(text: text);
    }

    final formatted = '${text.substring(0, 3)}-${text.substring(3)}';

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Masks the account number for display.
String _maskAccountNumber(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return '—';
  final last4 =
      digits.length > 4 ? digits.substring(digits.length - 4) : digits;
  return '•••• $last4';
}

/// Shows a modal confirmation before saving bank details.
void _showSaveConfirmation(
  BuildContext context,
  BankDetailsViewModel viewModel,
) {
  // Dismiss keyboard before dialog
  FocusScope.of(context).unfocus();

  final maskedAcc = _maskAccountNumber(viewModel.accountNumberController.text);
  final bankName = viewModel.bankNameController.text.trim();
  final bsb = viewModel.bsbController.text.trim();

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
          _handleSaveWithAlerts(context, viewModel);
        },
      );
    },
  );
}

/// Executes save via ViewModel, then shows success/error flushbars.
Future<void> _handleSaveWithAlerts(
  BuildContext context,
  BankDetailsViewModel viewModel,
) async {
  await viewModel.saveBankDetails();

  final flush = FlushBarWidget();
  if (viewModel.errorMessage != null) {
    flush.flushBar(
      context: context,
      title: 'Save failed',
      message: '${viewModel.errorMessage}\nYour changes are saved locally.',
      backgroundColor: BauhausDesign.error,
    );
  } else {
    final maskedAcc =
        _maskAccountNumber(viewModel.accountNumberController.text);
    final bankName = viewModel.bankNameController.text.trim();
    final bsb = viewModel.bsbController.text.trim();

    final displayBank = bankName.isNotEmpty ? bankName : 'Bank details';
    final displayBsb = bsb.isNotEmpty ? bsb : '—';

    flush.flushBar(
      context: context,
      title: 'Bank details saved',
      message: '$displayBank • Account $maskedAcc • BSB $displayBsb',
      backgroundColor: BauhausDesign.success,
    );
  }
}
