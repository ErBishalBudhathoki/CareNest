
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
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

class AddExpenseView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String? organizationName;
  final String? initialCategory;
  final ExpenseModel?
      expenseToEdit; // If provided, we're editing an existing expense

  const AddExpenseView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    this.organizationName,
    this.initialCategory,
    this.expenseToEdit,
  });

  @override
  ConsumerState<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends ConsumerState<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

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
              primary: const Color(0xFF667EEA),
              onPrimary: Colors.white,
              onSurface: const Color(0xFF1F2937),
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
                            Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('Uploading ${_receiptFiles.length} file(s)...'),
                  ],
                ),
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
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Expense updated successfully'),
                  ],
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
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Expense submitted successfully'),
                  ],
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
          String errorMessage = 'Failed to submit expense';
          if (e.toString().contains('upload')) {
            errorMessage =
                'File upload failed. Please check your internet connection and try again.';
          } else if (e.toString().contains('network')) {
            errorMessage =
                'Network error. Please check your connection and try again.';
          } else if (e.toString().contains('size')) {
            errorMessage =
                'One or more files are too large. Please reduce file size and try again.';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text(errorMessage)),
                ],
              ),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
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
      appBar: AppBar(
        title: Text(
          widget.expenseToEdit != null ? 'Edit Expense' : 'Add New Expense',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667EEA),
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.1, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ModernCard(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Expense Details',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600).copyWith(
                          color: const Color(0xFF667EEA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter expense title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter amount',
                          prefixText: '\$',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        style: TextStyle(color: const Color(0xFF1F2937)),
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                12.0),
                          ),
                          prefixIcon: const Icon(Icons.category),
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
                              padding:
                                  const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(
                                    12.0),
                                border: Border.all(
                                    color: Colors.red
                                        .withOpacity(0.1)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error,
                                      color: Colors.red),
                                  const SizedBox(
                                      width: 8.0),
                                  Expanded(
                                    child: Text(
                                      'Error loading clients: $error',
                                      style:
                                          const TextStyle(fontSize: 14).copyWith(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return DropdownButtonFormField<Patient>(
                            initialValue: _selectedClient,
                            style: const TextStyle(
                                color: Color(0xFF1F2937)),
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: 'Client (Optional)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0),
                              ),
                              prefixIcon: const Icon(Icons.person),
                              suffixIcon: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : null,
                            ),
                            hint: const Text(
                              'Select a client',
                              style: TextStyle(
                                  color: Color(0xFF9CA3AF)),
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0),
                              ),
                              prefixIcon: const Icon(Icons.calendar_today),
                            ),
                            controller: TextEditingController(
                              text: DateFormat('MMM dd, yyyy')
                                  .format(_selectedDate),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter expense description',
                          prefixIcon: const Icon(Icons.description),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                12.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SwitchListTile(
                        title: Text(
                          'Recurring Expense',
                          style: const TextStyle(fontSize: 16),
                        ),
                        value: _isRecurring,
                        activeThumbColor: const Color(0xFF667EEA),
                        onChanged: (value) {
                          setState(() {
                            _isRecurring = value;
                          });
                        },
                        subtitle: Text(
                          'Enable for regularly occurring expenses',
                          style: const TextStyle(fontSize: 12).copyWith(
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ),
                      if (_isRecurring) ...[
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          initialValue: _recurringFrequency,
                          decoration: InputDecoration(
                            labelText: 'Frequency',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0),
                            ),
                            prefixIcon: const Icon(Icons.repeat),
                          ),
                          items: _frequencies.map((frequency) {
                            return DropdownMenuItem<String>(
                              value: frequency,
                              child: Text(
                                frequency[0].toUpperCase() +
                                    frequency.substring(1),
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
                      ModernButton(
                        onPressed: _isSubmitting ? null : _submitExpense,
                        text: _isSubmitting
                            ? (_receiptFiles.isNotEmpty
                                ? 'Uploading files...'
                                : 'Submitting...')
                            : (widget.expenseToEdit != null
                                ? 'Update Expense'
                                : 'Submit Expense'),
                        isLoading: _isSubmitting,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
