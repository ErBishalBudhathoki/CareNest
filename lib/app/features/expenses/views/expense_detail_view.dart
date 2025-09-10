import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/providers/expense_provider.dart';
import 'package:carenest/app/features/expenses/views/add_expense_view.dart';
import '../presentation/widgets/enhanced_file_viewer_widget.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

class ExpenseDetailView extends ConsumerWidget {
  final ExpenseModel expense;
  final String adminEmail;
  final String organizationId;
  final String? organizationName;

  const ExpenseDetailView({
    super.key,
    required this.expense,
    required this.adminEmail,
    required this.organizationId,
    this.organizationName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Details',
          style: ModernSaasDesign.headlineSmall.copyWith(
            color: ModernSaasDesign.textOnPrimary,
          ),
        ),
        backgroundColor: ModernSaasDesign.primary,
        iconTheme: IconThemeData(color: ModernSaasDesign.textOnPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpenseView(
                    adminEmail: adminEmail,
                    organizationId: organizationId,
                    organizationName: organizationName,
                    expenseToEdit: expense,
                  ),
                ),
              ).then((updated) {
                if (updated == true) {
                  Navigator.pop(
                      context, true); // Return to list with refresh flag
                }
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'delete') {
                _showDeleteConfirmation(context, ref);
              } else if (value == 'approve') {
                await ref
                    .read(expenseProvider.notifier)
                    .approveExpense(expense.id, adminEmail);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Expense approved')),
                  );
                  Navigator.pop(
                      context, true); // Return to list with refresh flag
                }
              } else if (value == 'reject') {
                await ref
                    .read(expenseProvider.notifier)
                    .rejectExpense(expense.id, adminEmail);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Expense rejected')),
                  );
                  Navigator.pop(
                      context, true); // Return to list with refresh flag
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              if (expense.status == 'pending')
                const PopupMenuItem<String>(
                  value: 'approve',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                      SizedBox(width: 8),
                      Text('Approve'),
                    ],
                  ),
                ),
              if (expense.status == 'pending')
                const PopupMenuItem<String>(
                  value: 'reject',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: ModernSaasDesign.error),
                      SizedBox(width: 8),
                      Text('Reject'),
                    ],
                  ),
                ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: ModernSaasDesign.error),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ModernSaasDesign.primary,
              ModernSaasDesign.background,
              ModernSaasDesign.background,
            ],
            stops: [0.0, 0.1, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ModernSaasDesign.space5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Badge
                _buildStatusBadge(expense.status),
                SizedBox(height: ModernSaasDesign.space4),

                // Main Card
                ModernCard(
                  padding: EdgeInsets.all(ModernSaasDesign.space5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expense.title,
                            style: ModernSaasDesign.headlineLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ModernSaasDesign.space3),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              currencyFormat.format(expense.amount ?? 0.0),
                              style: ModernSaasDesign.headlineLarge.copyWith(
                                color: ModernSaasDesign.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Category and Date
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            label: Text(
                              expense.category,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: ModernSaasDesign.neutral100,
                            avatar: const Icon(
                              Icons.category,
                              size: 16,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                          Chip(
                            label: Text(
                              dateFormat.format(expense.date),
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: ModernSaasDesign.neutral100,
                            avatar: const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                          if (expense.isRecurring)
                            Chip(
                              label: Text(
                                expense.recurringFrequency != null
                                    ? expense.recurringFrequency![0]
                                            .toUpperCase() +
                                        expense.recurringFrequency!.substring(1)
                                    : 'Recurring',
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: ModernSaasDesign.neutral100,
                              avatar: const Icon(
                                Icons.repeat,
                                size: 16,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Description
                      if (expense.description != null &&
                          expense.description!.isNotEmpty) ...[
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ModernSaasDesign.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          expense.description!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Receipt Files
                      if (_hasReceiptFiles()) ...[
                        const Text(
                          'Attached Files',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ModernSaasDesign.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        EnhancedFileViewerWidget(
                          filePaths: _getReceiptFiles(),
                          description: _getFileDescription(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Divider
                      const Divider(),
                      const SizedBox(height: 8),

                      // Metadata
                      _buildInfoRow('Submitted by', expense.submittedBy),
                      const SizedBox(height: 8),
                      if (expense.approvedBy != null) ...[
                        _buildInfoRow('Reviewed by', expense.approvedBy!),
                        const SizedBox(height: 8),
                      ],
                      _buildInfoRow(
                        'Created',
                        dateFormat.format(expense.createdAt),
                      ),
                      if (expense.updatedAt != null) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          'Last updated',
                          dateFormat.format(expense.updatedAt!),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasReceiptFiles() {
    return (expense.receiptFiles != null && expense.receiptFiles!.isNotEmpty) ||
        (expense.receiptPhotos != null && expense.receiptPhotos!.isNotEmpty) ||
        (expense.receiptUrl != null && expense.receiptUrl!.isNotEmpty);
  }

  List<String> _getReceiptFiles() {
    // Priority: receiptFiles > receiptPhotos > receiptUrl
    if (expense.receiptFiles != null && expense.receiptFiles!.isNotEmpty) {
      return expense.receiptFiles!;
    } else if (expense.receiptPhotos != null &&
        expense.receiptPhotos!.isNotEmpty) {
      return expense.receiptPhotos!;
    } else if (expense.receiptUrl != null && expense.receiptUrl!.isNotEmpty) {
      return [expense.receiptUrl!];
    }
    return [];
  }

  String? _getFileDescription() {
    return expense.fileDescription ?? expense.photoDescription;
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    IconData icon;
    String text;

    switch (status) {
      case 'approved':
        color = ModernSaasDesign.success;
        icon = Icons.check_circle;
        text = 'Approved';
        break;
      case 'rejected':
        color = ModernSaasDesign.error;
        icon = Icons.cancel;
        text = 'Rejected';
        break;
      case 'pending':
      default:
        color = ModernSaasDesign.warning;
        icon = Icons.pending;
        text = 'Pending Approval';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            color: ModernSaasDesign.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const Text(
            'Are you sure you want to delete this expense? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await ref
                    .read(expenseProvider.notifier)
                    .deleteExpense(expense.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Expense deleted')),
                  );
                  Navigator.pop(
                      context, true); // Return to list with refresh flag
                }
              },
              style:
                  TextButton.styleFrom(foregroundColor: ModernSaasDesign.error),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
