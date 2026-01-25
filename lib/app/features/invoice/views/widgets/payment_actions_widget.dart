import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import '../../models/invoice_model.dart';
import '../../viewmodels/payment_viewmodel.dart';

class PaymentActionsWidget extends ConsumerWidget {
  final InvoiceModel invoice;
  final String invoiceId;

  const PaymentActionsWidget({
    super.key,
    required this.invoice,
    required this.invoiceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = invoice.payment;
    final balanceDue = payment?.balanceDue ?? invoice.totalAmount;
    final isPaid = payment?.status == 'paid';

    return Container(
      decoration: BauhausTheme.blockDecoration,
      padding: BauhausTheme.blockPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PAYMENT STATUS', style: BauhausTheme.labelStyle),
              _buildStatusBadge(payment?.status ?? 'pending'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Balance Due', style: BauhausTheme.bodyStyle),
              Text(
                '\$${balanceDue.toStringAsFixed(2)}',
                style: BauhausTheme.headerStyle.copyWith(color: BauhausTheme.red),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (!isPaid)
            Row(
              children: [
                Expanded(
                  child: _BauhausButton(
                    label: 'PAY NOW',
                    color: BauhausTheme.blue,
                    onTap: () {
                      // Trigger Stripe Payment Flow
                      // ref.read(paymentViewModelProvider.notifier).createPaymentIntent(...)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Starting Payment Flow...')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _BauhausButton(
                    label: 'RECORD',
                    color: BauhausTheme.white,
                    textColor: BauhausTheme.black,
                    onTap: () {
                      _showRecordPaymentDialog(context, ref);
                    },
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showCreditNoteDialog(context, ref),
              child: Text('Issue Credit Note',
                  style: BauhausTheme.labelStyle.copyWith(decoration: TextDecoration.underline)),
            ),
          ),
          if (payment?.transactions.isNotEmpty ?? false) ...[
            const SizedBox(height: 24),
            Text('HISTORY', style: BauhausTheme.labelStyle),
            const SizedBox(height: 8),
            ...payment!.transactions.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.date.toString().split(' ')[0], style: BauhausTheme.bodyStyle),
                      Text('\$${t.amount.toStringAsFixed(2)} (${t.method})', style: BauhausTheme.bodyStyle),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'paid':
        color = Colors.green; // Or Bauhaus green if defined, using generic for now
        break;
      case 'partial':
        color = BauhausTheme.yellow;
        break;
      case 'overdue':
        color = BauhausTheme.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: BauhausTheme.black, width: 2),
      ),
      child: Text(
        status.toUpperCase(),
        style: BauhausTheme.labelStyle.copyWith(color: Colors.white),
      ),
    );
  }

  void _showRecordPaymentDialog(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Record Payment', style: BauhausTheme.headerStyle),
        content: TextField(
          controller: amountController,
          decoration: const InputDecoration(labelText: 'Amount'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: BauhausTheme.bodyStyle),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null) {
                ref.read(paymentViewModelProvider.notifier).recordPayment(
                      invoiceId: invoiceId,
                      amount: amount,
                      method: 'manual',
                      notes: 'Recorded manually via app',
                    );
                Navigator.pop(context);
              }
            },
            child: Text('SAVE', style: BauhausTheme.bodyStyle),
          ),
        ],
      ),
    );
  }

  void _showCreditNoteDialog(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Issue Credit Note', style: BauhausTheme.headerStyle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'Reason'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: BauhausTheme.bodyStyle),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null) {
                ref.read(paymentViewModelProvider.notifier).issueCreditNote({
                  'originalInvoiceId': invoiceId,
                  'amount': amount,
                  'reason': reasonController.text,
                  'creditNoteNumber': 'CN-${DateTime.now().millisecondsSinceEpoch}',
                  'organizationId': 'ORG-123', // TODO: Get from provider
                });
                Navigator.pop(context);
              }
            },
            child: Text('ISSUE', style: BauhausTheme.bodyStyle),
          ),
        ],
      ),
    );
  }
}

class _BauhausButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _BauhausButton({
    required this.label,
    required this.color,
    this.textColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausTheme.black, width: 2),
        ),
        child: Text(
          label,
          style: BauhausTheme.bodyStyle.copyWith(color: textColor, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
