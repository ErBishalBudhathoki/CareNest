import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/providers/expense_provider.dart';
import 'package:carenest/app/features/expenses/views/add_expense_view.dart';
import '../presentation/widgets/enhanced_file_viewer_widget.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          l10n.expensesDetailsTitle,
          style: BauhausDesign.getTextTheme(
            context,
          ).headlineMedium?.copyWith(color: BauhausDesign.surfaceWhite),
        ),
        backgroundColor: BauhausDesign.primary,
        iconTheme: IconThemeData(color: BauhausDesign.surfaceWhite),
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
                    context,
                    true,
                  ); // Return to list with refresh flag
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
                    SnackBar(
                      content: Text(l10n.expenseApprovedSnack),
                      backgroundColor: BauhausDesign.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusMd,
                        ),
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                    true,
                  ); // Return to list with refresh flag
                }
              } else if (value == 'reject') {
                await ref
                    .read(expenseProvider.notifier)
                    .rejectExpense(expense.id, adminEmail);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.expenseRejectedSnack),
                      backgroundColor: BauhausDesign.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusMd,
                        ),
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                    true,
                  ); // Return to list with refresh flag
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              if (expense.status == 'pending')
                PopupMenuItem<String>(
                  value: 'approve',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: BauhausDesign.success),
                      SizedBox(width: 8),
                      Text(l10n.approveAction),
                    ],
                  ),
                ),
              if (expense.status == 'pending')
                PopupMenuItem<String>(
                  value: 'reject',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: BauhausDesign.error),
                      SizedBox(width: 8),
                      Text(l10n.rejectAction),
                    ],
                  ),
                ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: BauhausDesign.error),
                    SizedBox(width: 8),
                    Text(l10n.deleteAction),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Badge
              _buildStatusBadge(context, expense.status),
              SizedBox(height: 16.0),

              // Main Card
              BauhausCard(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).headlineMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            currencyFormat.format(expense.amount),
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(color: BauhausDesign.primary),
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
                        BauhausChip(
                          label: expense.category,
                          icon: Icons.category,
                          variant: BauhausChipVariant.outlined,
                        ),
                        BauhausChip(
                          label: dateFormat.format(expense.date),
                          icon: Icons.calendar_today,
                          variant: BauhausChipVariant.outlined,
                        ),
                        if (expense.isRecurring)
                          BauhausChip(
                            label: expense.recurringFrequency != null
                                ? expense.recurringFrequency![0].toUpperCase() +
                                      expense.recurringFrequency!.substring(1)
                                : 'Recurring',
                            icon: Icons.repeat,
                            variant: BauhausChipVariant.info,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description
                    if (expense.description != null &&
                        expense.description!.isNotEmpty) ...[
                      Text(
                        l10n.expenseDescriptionLabel,
                        style: BauhausDesign.getTextTheme(context).labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        expense.description!,
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Receipt Files
                    if (_hasReceiptFiles()) ...[
                      Text(
                        l10n.attachedFilesLabel,
                        style: BauhausDesign.getTextTheme(context).labelLarge,
                      ),
                      const SizedBox(height: 8),
                      EnhancedFileViewerWidget(
                        filePaths: _getReceiptFiles(),
                        description: _getFileDescription(),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Divider
                    const Divider(color: BauhausDesign.neutral),
                    const SizedBox(height: 8),

                    // Metadata
                    _buildInfoRow(
                      context,
                      l10n.submittedByLabel,
                      expense.submittedBy,
                    ),
                    const SizedBox(height: 8),
                    if (expense.approvedBy != null) ...[
                      _buildInfoRow(
                        context,
                        l10n.reviewedByLabel,
                        expense.approvedBy!,
                      ),
                      const SizedBox(height: 8),
                    ],
                    _buildInfoRow(
                      context,
                      l10n.createdLabel,
                      dateFormat.format(expense.createdAt),
                    ),
                    if (expense.updatedAt != null) ...[
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        context,
                        l10n.lastUpdatedLabel,
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

  Widget _buildStatusBadge(BuildContext context, String status) {
    print(status); // Debug print to ensure status is being read
    final l10n = AppLocalizations.of(context)!;
    BauhausChipVariant variant;
    String text;
    IconData icon;

    switch (status) {
      case 'approved':
        variant = BauhausChipVariant.success;
        icon = Icons.check_circle;
        text = l10n.approved;
        break;
      case 'rejected':
        variant = BauhausChipVariant.error;
        icon = Icons.cancel;
        text = l10n.statusRejected;
        break;
      case 'pending':
      default:
        variant = BauhausChipVariant.warning;
        icon = Icons.pending;
        text = l10n.statsPendingApproval;
        break;
    }

    return BauhausChip(label: text, icon: icon, variant: variant);
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textMuted,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(
            l10n.deleteExpenseTitle,
            style: BauhausDesign.getTextTheme(context).headlineMedium,
          ),
          content: Text(
            l10n.deleteExpenseMessage,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
          actions: [
            BauhausActionButton(
              onPressed: () => Navigator.of(context).pop(),
              text: l10n.cancelButton,
              variant: BauhausActionVariant.ghost,
            ),
            BauhausActionButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await ref
                    .read(expenseProvider.notifier)
                    .deleteExpense(expense.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.expenseDeletedSnack),
                      backgroundColor: BauhausDesign.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusMd,
                        ),
                      ),
                    ),
                  );
                  Navigator.pop(
                    context,
                    true,
                  ); // Return to list with refresh flag
                }
              },
              text: l10n.deleteButton,
              variant: BauhausActionVariant.danger,
            ),
          ],
        );
      },
    );
  }
}
