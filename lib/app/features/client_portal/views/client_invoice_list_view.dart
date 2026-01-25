import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../viewmodels/client_invoice_viewmodel.dart';
import '../models/client_portal_models.dart';
import 'client_invoice_detail_view.dart';

class ClientInvoiceListView extends ConsumerWidget {
  const ClientInvoiceListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesState = ref.watch(clientInvoicesProvider);

    return invoicesState.when(
      data: (invoices) {
        if (invoices.isEmpty) {
          return Center(
            child: Text(
              'No invoices found',
              style: BauhausDesign.getTextTheme(context).bodyLarge,
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          itemCount: invoices.length,
          separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
          itemBuilder: (context, index) {
            final invoice = invoices[index];
            return _InvoiceCard(invoice: invoice);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(
          'Error loading invoices: $e',
          style: TextStyle(color: BauhausDesign.error),
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  final ClientInvoice invoice;

  const _InvoiceCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final status = invoice.workflow['status'] as String? ?? 'Unknown';
    final total = invoice.financialSummary['totalAmount'] ?? 0.0;
    
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = BauhausDesign.success;
        break;
      case 'paid':
        statusColor = BauhausDesign.success;
        break;
      case 'overdue':
        statusColor = BauhausDesign.error;
        break;
      case 'disputed':
        statusColor = BauhausDesign.warning;
        break;
      default:
        statusColor = BauhausDesign.neutral;
    }

    return Container(
      decoration: BauhausDesign.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ClientInvoiceDetailView(invoiceId: invoice.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      invoice.invoiceNumber,
                      style: BauhausDesign.getTextTheme(context).headlineMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: BauhausDesign.space3,
                          vertical: BauhausDesign.space1),
                      decoration: BauhausDesign.chipDecoration(
                          selected: true, color: statusColor),
                      child: Text(
                        status.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  'Due Date: ${invoice.financialSummary['dueDate'] ?? 'N/A'}',
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
