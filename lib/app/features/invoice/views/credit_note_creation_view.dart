import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditNoteCreationView extends ConsumerStatefulWidget {
  final String invoiceId;
  final String invoiceNumber;
  final double totalAmount;
  final double balanceDue;

  const CreditNoteCreationView({
    super.key,
    required this.invoiceId,
    required this.invoiceNumber,
    required this.totalAmount,
    required this.balanceDue,
  });

  @override
  ConsumerState<CreditNoteCreationView> createState() =>
      _CreditNoteCreationViewState();
}

class _CreditNoteCreationViewState
    extends ConsumerState<CreditNoteCreationView> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isFullRefund = false;

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _handleFullRefundChange(bool? value) {
    setState(() {
      _isFullRefund = value ?? false;
      if (_isFullRefund) {
        _amountController.text = widget.balanceDue.toStringAsFixed(2);
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid amount')));
      return;
    }

    if (amount > widget.balanceDue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Amount cannot exceed balance due (\$${widget.balanceDue.toStringAsFixed(2)})',
          ),
        ),
      );
      return;
    }

    try {
      await ref.read(paymentViewModelProvider.notifier).issueCreditNote({
        'invoiceId': widget.invoiceId,
        'amount': amount,
        'reason': _reasonController.text,
        'isFullRefund': _isFullRefund,
      });

      if (mounted) {
        Navigator.of(context).pop(true); // Return success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credit note issued successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paymentViewModelProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBarWidget(title: 'Issue Credit Note'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BauhausCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice #${widget.invoiceNumber}',
                      style: BauhausDesign.getTextTheme(context).titleMedium,
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                        Text(
                          '\$${widget.totalAmount.toStringAsFixed(2)}',
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Balance Due:',
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                        Text(
                          '\$${widget.balanceDue.toStringAsFixed(2)}',
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.error,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Row(
                children: [
                  Checkbox(
                    value: _isFullRefund,
                    onChanged: _handleFullRefundChange,
                    activeColor: BauhausDesign.primary,
                  ),
                  Text(
                    'Full Refund (Balance Due)',
                    style: BauhausDesign.getTextTheme(context).bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              BauhausTextField(
                controller: _amountController,
                label: 'Credit Amount',
                prefixIcon: const Icon(
                  Icons.attach_money,
                  color: BauhausDesign.textMuted,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                enabled: !_isFullRefund,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (double.tryParse(val) == null) return 'Invalid number';
                  return null;
                },
              ),
              const SizedBox(height: BauhausDesign.space3),
              BauhausTextField(
                controller: _reasonController,
                label: 'Reason',
                prefixIcon: const Icon(
                  Icons.notes,
                  color: BauhausDesign.textMuted,
                ),
                maxLines: 3,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: BauhausDesign.space6),
              SizedBox(
                width: double.infinity,
                child: BauhausActionButton(
                  text: 'Issue Credit Note',
                  onPressed: isLoading ? null : _submit,
                  isLoading: isLoading,
                  variant: BauhausActionVariant.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
