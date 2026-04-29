import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/expense_model.dart';
import '../providers/expense_provider.dart';
import '../../client/models/client_model.dart';
import '../../client/providers/client_provider.dart';
import '../presentation/widgets/enhanced_file_attachment_widget.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AddExpenseView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String? organizationName;
  final String? initialCategory;
  final ExpenseModel?
      expenseToEdit; // If provided, we're editing an existing expense
  final List<String>? initialReceiptFilePaths;
  final String? initialTitle;
  final double? initialAmount;
  final DateTime? initialDate;
  final String? initialDescription;

  const AddExpenseView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    this.organizationName,
    this.initialCategory,
    this.expenseToEdit,
    this.initialReceiptFilePaths,
    this.initialTitle,
    this.initialAmount,
    this.initialDate,
    this.initialDescription,
  });

  @override
  ConsumerState<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends ConsumerState<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  String _selectedCategory = 'Office';
  DateTime _selectedDate = DateTime.now();
  bool _isRecurring = false;
  String _recurringFrequency = 'monthly';
  Patient? _selectedClient;
  List<File> _receiptFiles = [];
  String _fileDescription = '';

  bool _isSubmitting = false;

  final List<String> _categories = [
    'Office',
    'Travel',
    'Meals',
    'Software',
    'Hardware',
    'Utilities',
    'Rent',
    'Salaries',
    'Marketing',
    'Other',
  ];

  final List<String> _frequencies = [
    'daily',
    'weekly',
    'monthly',
    'yearly',
  ];

  @override
  void initState() {
    super.initState();

    // Fetch clients when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(clientProvider.notifier)
          .fetchClientsByOrganization(widget.organizationId);
    });

    // If a quick category was provided, preselect it (when not editing)
    if (widget.expenseToEdit == null && widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory!;
    }

    // Initialize from OCR/quick capture if provided
    if (widget.expenseToEdit == null) {
      if (widget.initialTitle != null) {
        _titleController.text = widget.initialTitle!;
      }
      if (widget.initialAmount != null) {
        _amountController.text = widget.initialAmount!.toStringAsFixed(2);
      }
      if (widget.initialDate != null) {
        _selectedDate = widget.initialDate!;
      }
      if (widget.initialDescription != null) {
        _descriptionController.text = widget.initialDescription!;
      }
      if (widget.initialReceiptFilePaths != null) {
        _receiptFiles = widget.initialReceiptFilePaths!.map((path) => File(path)).toList();
      }
    }

    // If editing an existing expense, populate the form
    if (widget.expenseToEdit != null) {
      _titleController.text = widget.expenseToEdit!.title;
      _amountController.text = widget.expenseToEdit!.amount.toString();
      _descriptionController.text = widget.expenseToEdit!.description ?? '';
      _selectedCategory = widget.expenseToEdit!.category;
      _selectedDate = widget.expenseToEdit!.date;
      _isRecurring = widget.expenseToEdit!.isRecurring;
      _recurringFrequency =
          widget.expenseToEdit!.recurringFrequency ?? 'monthly';
      // Load existing receipt files if available
      if (widget.expenseToEdit!.receiptFiles != null &&
          widget.expenseToEdit!.receiptFiles!.isNotEmpty) {
        _receiptFiles = widget.expenseToEdit!.receiptFiles!
            .map((url) => File(url))
            .toList();
      } else if (widget.expenseToEdit!.receiptPhotos != null &&
          widget.expenseToEdit!.receiptPhotos!.isNotEmpty) {
        // Backward compatibility for receiptPhotos
        _receiptFiles = widget.expenseToEdit!.receiptPhotos!
            .map((url) => File(url))
            .toList();
      } else if (widget.expenseToEdit!.receiptUrl != null) {
        // Backward compatibility for single receiptUrl
        _receiptFiles = [File(widget.expenseToEdit!.receiptUrl!)];
      }
      _fileDescription = widget.expenseToEdit!.fileDescription ??
          widget.expenseToEdit!.photoDescription ??
          '';
      // Note: Client selection for existing expense would need clientId to email mapping
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isImageFile(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitExpense() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final double amount = double.parse(_amountController.text);

        // Handle receipt files if provided
        List<String>? receiptFiles;
        List<String>? receiptPhotos; // For backward compatibility
        if (_receiptFiles.isNotEmpty) {
          // Show upload progress for multiple files
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            BauhausDesign.surfaceWhite),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(l10n.expenseUploadProgress(_receiptFiles.length)),
                  ],
                ),
                backgroundColor: BauhausDesign.info,
                duration:
                    const Duration(seconds: 30), // Longer duration for uploads
              ),
            );
          }

          // Store local file paths (the repository will handle the actual upload)
          receiptFiles = _receiptFiles.map((file) => file.path).toList();
          // Extract only image files for backward compatibility
          receiptPhotos = _receiptFiles
              .where((file) => _isImageFile(file.path))
              .map((file) => file.path)
              .toList();
        }

        final ExpenseModel expense = ExpenseModel(
          id: widget.expenseToEdit?.id ?? const Uuid().v4(),
          title: _titleController.text,
          amount: amount,
          category: _selectedCategory,
          date: _selectedDate,
          description: _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
          receiptUrl: receiptPhotos?.isNotEmpty == true
              ? receiptPhotos!.first
              : null, // Backward compatibility
          receiptPhotos: receiptPhotos,
          receiptFiles: receiptFiles,
          photoDescription:
              receiptPhotos?.isNotEmpty == true && _fileDescription.isNotEmpty
                  ? _fileDescription
                  : null, // Backward compatibility
          fileDescription: _fileDescription.isEmpty ? null : _fileDescription,
          status: widget.expenseToEdit?.status ?? 'pending',
          submittedBy: widget.adminEmail,
          approvedBy: widget.expenseToEdit?.approvedBy,
          createdAt: widget.expenseToEdit?.createdAt ?? DateTime.now(),
          updatedAt: widget.expenseToEdit != null ? DateTime.now() : null,
          isRecurring: _isRecurring,
          recurringFrequency: _isRecurring ? _recurringFrequency : null,
          organizationId: widget.organizationId,
          clientId:
              _selectedClient?.id, // Use MongoDB ObjectId instead of email
        );

        if (widget.expenseToEdit != null) {
          // Update existing expense
          await ref.read(expenseProvider.notifier).updateExpense(expense);
          if (mounted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: BauhausDesign.surfaceWhite),
                    SizedBox(width: 8),
                    Text(l10n.expenseUpdateSuccess),
                  ],
                ),
                backgroundColor: BauhausDesign.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                ),
              ),
            );
            Navigator.pop(context, true);
          }
        } else {
          // Add new expense
          await ref.read(expenseProvider.notifier).addExpense(expense);
          if (mounted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: BauhausDesign.surfaceWhite),
                    SizedBox(width: 8),
                    Text(l10n.expenseSubmitSuccess),
                  ],
                ),
                backgroundColor: BauhausDesign.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                ),
              ),
            );
            Navigator.pop(context, true);
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show detailed error message
          String errorMessage = l10n.expenseSubmitGenericError;
          if (e.toString().contains('upload')) {
            errorMessage = l10n.expenseUploadError;
          } else if (e.toString().contains('network')) {
            errorMessage = l10n.expenseNetworkError;
          } else if (e.toString().contains('size')) {
            errorMessage = l10n.expenseSizeError;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error, color: BauhausDesign.surfaceWhite),
                  SizedBox(width: 8),
                  Expanded(child: Text(errorMessage)),
                ],
              ),
              backgroundColor: BauhausDesign.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              ),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: l10n.expenseRetryButton,
                textColor: BauhausDesign.surfaceWhite,
                onPressed: () => _submitExpense(),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.expenseToEdit != null
              ? l10n.editExpenseTitle
              : l10n.addExpenseTitle,
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
              ),
        ),
        backgroundColor: BauhausDesign.primary,
        iconTheme: IconThemeData(color: BauhausDesign.surfaceWhite),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: BauhausCard(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.expenseDetailsTitle,
                    style: BauhausDesign.getTextTheme(context)
                        .headlineMedium
                        ?.copyWith(
                          color: BauhausDesign.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24.0),
                  BauhausTextField(
                    controller: _titleController,
                    label: l10n.expenseTitleLabel,
                    hintText: l10n.expenseTitleHint,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.expenseTitleError;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  BauhausTextField(
                    controller: _amountController,
                    label: l10n.expenseAmountLabel,
                    hintText: l10n.expenseAmountHint,
                    keyboardType: TextInputType.number,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('\$ ',
                          style:
                              BauhausDesign.getTextTheme(context).bodyMedium),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.expenseAmountError;
                      }
                      if (double.tryParse(value) == null) {
                        return l10n.expenseAmountInvalid;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    style: BauhausDesign.getTextTheme(context).bodyMedium,
                    dropdownColor: BauhausDesign.surfaceWhite,
                    decoration:
                        BauhausDesign.inputDecoration(l10n.expenseCategoryLabel)
                            .copyWith(
                      labelText: l10n.expenseCategoryLabel,
                      prefixIcon: const Icon(Icons.category,
                          color: BauhausDesign.textMuted),
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Consumer(
                    builder: (context, ref, child) {
                      final clients = ref.watch(clientsListProvider);
                      final isLoading = ref.watch(clientsLoadingProvider);
                      final error = ref.watch(clientErrorProvider);

                      if (error != null) {
                        return Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: BauhausDesign.error.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusMd),
                            border: Border.all(
                                color: BauhausDesign.error.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error, color: BauhausDesign.error),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  l10n.expenseClientError(error.toString()),
                                  style: BauhausDesign.getTextTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                        color: BauhausDesign.error,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return DropdownButtonFormField<Patient>(
                        value: _selectedClient,
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                        dropdownColor: BauhausDesign.surfaceWhite,
                        decoration: BauhausDesign.inputDecoration(
                                l10n.expenseClientLabel)
                            .copyWith(
                          labelText: l10n.expenseClientLabel,
                          prefixIcon: const Icon(Icons.person,
                              color: BauhausDesign.textMuted),
                          suffixIcon: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: BauhausDesign.primary,
                                  ),
                                )
                              : null,
                        ),
                        hint: Text(
                          l10n.expenseClientHint,
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                        ),
                        items: clients.map((client) {
                          return DropdownMenuItem<Patient>(
                            value: client,
                            child: Text(
                              client.displayName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: isLoading
                            ? null
                            : (Patient? value) {
                                setState(() {
                                  _selectedClient = value;
                                });
                              },
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: BauhausTextField(
                        controller: TextEditingController(
                          text:
                              DateFormat('MMM dd, yyyy').format(_selectedDate),
                        ),
                        label: l10n.expenseDateLabel,
                        prefixIcon: const Icon(Icons.calendar_today,
                            color: BauhausDesign.textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  BauhausTextField(
                    controller: _descriptionController,
                    label: l10n.expenseDescriptionLabel,
                    hintText: l10n.expenseDescriptionHint,
                    prefixIcon: const Icon(Icons.description,
                        color: BauhausDesign.textMuted),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16.0),
                  SwitchListTile(
                    title: Text(
                      l10n.expenseRecurringLabel,
                      style: BauhausDesign.getTextTheme(context).labelLarge,
                    ),
                    value: _isRecurring,
                    activeColor: BauhausDesign.primary,
                    onChanged: (value) {
                      setState(() {
                        _isRecurring = value;
                      });
                    },
                    subtitle: Text(
                      l10n.expenseRecurringSubtitle,
                      style: BauhausDesign.getTextTheme(context).bodySmall,
                    ),
                  ),
                  if (_isRecurring) ...[
                    const SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _recurringFrequency,
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                      dropdownColor: BauhausDesign.surfaceWhite,
                      decoration: BauhausDesign.inputDecoration(
                              l10n.expenseFrequencyLabel)
                          .copyWith(
                        labelText: l10n.expenseFrequencyLabel,
                        prefixIcon: const Icon(Icons.repeat,
                            color: BauhausDesign.textMuted),
                      ),
                      items: _frequencies.map((frequency) {
                        return DropdownMenuItem<String>(
                          value: frequency,
                          child: Text(
                            frequency[0].toUpperCase() + frequency.substring(1),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _recurringFrequency = value!;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 16),
                  EnhancedFileAttachmentWidget(
                    initialFiles: _receiptFiles,
                    onFilesSelected: (List<File> files) {
                      setState(() {
                        _receiptFiles = files;
                      });
                    },
                    description: _fileDescription,
                    onDescriptionChanged: (String description) {
                      setState(() {
                        _fileDescription = description;
                      });
                    },
                    maxFiles: 5,
                  ),
                  const SizedBox(height: 24.0),
                  BauhausActionButton(
                    onPressed: _isSubmitting ? null : _submitExpense,
                    text: _isSubmitting
                        ? (_receiptFiles.isNotEmpty
                            ? l10n.expenseButtonUploading
                            : l10n.expenseButtonSubmitting)
                        : (widget.expenseToEdit != null
                            ? l10n.expenseButtonUpdate
                            : l10n.expenseButtonSubmit),
                    variant: BauhausActionVariant.primary,
                    icon: _isSubmitting ? null : Icons.save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
