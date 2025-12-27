import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../shared/widgets/flushbar_widget.dart';
import '../../../shared/widgets/confirmation_alert_dialog_widget.dart';
import '../viewmodels/bank_details_viewmodel.dart';

class BankDetailsView extends StatelessWidget {
  const BankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BankDetailsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bank Details'),
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        body: Consumer<BankDetailsViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[700]!, Colors.blue[500]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.account_balance,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Banking Information',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Securely store your account details',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildModernTextField(
                            controller: viewModel.bankNameController,
                            label: 'Bank Name',
                            icon: Icons.account_balance,
                            hint: 'e.g., Commonwealth Bank',
                          ),

                          const SizedBox(height: 20),

                          _buildModernTextField(
                            controller: viewModel.accountNameController,
                            label: 'Account Name',
                            icon: Icons.person_outline,
                            hint: 'Full name as shown on account',
                          ),

                          const SizedBox(height: 20),

                          _buildModernTextField(
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

                          const SizedBox(height: 20),

                          _buildModernTextField(
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

                          const SizedBox(height: 32),

                          // Save Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () {
                                      _showSaveConfirmation(context, viewModel);
                                    },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save_outlined, size: 22),
                                  SizedBox(width: 8),
                                  Text(
                                    'Save Bank Details',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Security Notice
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.blue[100]!,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue[700],
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Your information is encrypted and securely stored',
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 12,
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildModernTextField({
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 15,
            ),
            prefixIcon: Icon(icon, color: Colors.blue[600], size: 22),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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
///
/// Keeps only the last 4 digits and prefixes with bullets (••••).
/// Non-digit characters are stripped; returns '—' if empty.
String _maskAccountNumber(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return '—';
  final last4 =
      digits.length > 4 ? digits.substring(digits.length - 4) : digits;
  return '•••• $last4';
}

/// Shows a modal confirmation before saving bank details.
/// Builds a summary with bank name, masked account number, and BSB.
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
        confirmColor: Colors.blue[700],
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
      backgroundColor: Colors.redAccent,
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
      backgroundColor: Colors.greenAccent,
    );
  }
}
