import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_viewmodel.dart';
import 'package:carenest/app/features/requests/viewmodels/config_viewmodel.dart';

class AddTimeOffRequestView extends ConsumerStatefulWidget {
  final String email;

  const AddTimeOffRequestView({super.key, required this.email});

  @override
  ConsumerState<AddTimeOffRequestView> createState() =>
      _AddTimeOffRequestViewState();
}

class _AddTimeOffRequestViewState extends ConsumerState<AddTimeOffRequestView> {
  final TextEditingController _noteController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String? selectedType;
  bool _showNoteField = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.colorGreen,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Request sent',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your request has been sent for approval',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Close the dialog using the dialog's context
                    Navigator.of(dialogContext).pop();
                    // Close the bottom sheet if the widget is still mounted
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("I'm done"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a leave type')),
      );
      return;
    }

    if (endDate.isBefore(startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End date cannot be before start date')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final details = {
      'timeOffType': selectedType,
      'starts': startDate.toIso8601String(),
      'ends': endDate.toIso8601String(),
    };

    final success =
        await ref.read(requestsViewModelProvider.notifier).createRequest(
              'Time Off',
              details,
              _noteController.text,
            );

    setState(() => _isSubmitting = false);

    if (success) {
      _showSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create request')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveTypesAsync = ref.watch(leaveTypesProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Time off',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 56,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Type Section
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: leaveTypesAsync.when(
                  data: (types) {
                    // Set default if not set and types available
                    if (selectedType == null && types.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted)
                          setState(() => selectedType = types.first.name);
                      });
                    }

                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedType,
                        isExpanded: true,
                        hint: const Text('Select Leave Type'),
                        items: types.map((type) {
                          return DropdownMenuItem(
                            value: type.name,
                            child: Text(
                              type.name,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.colorBlack87,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() => selectedType = val);
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, s) => const Text('Error loading types'),
                ),
              ),
              const SizedBox(height: 16),

              // Date Range Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'From',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColors.colorBlue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.colorBlue,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (date != null) {
                              setState(() {
                                startDate = date;
                                if (endDate.isBefore(startDate)) {
                                  endDate = startDate;
                                }
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.colorBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              DateFormat('MMMM dd yyyy').format(startDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'To',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: endDate,
                              firstDate: startDate,
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColors.colorBlue,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.colorBlue,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (date != null) {
                              setState(() => endDate = date);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.colorBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              DateFormat('MMMM dd yyyy').format(endDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Add Note Section
              Row(
                children: [
                  const Icon(Icons.edit_outlined, color: AppColors.colorBlue),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showNoteField = !_showNoteField;
                      });
                    },
                    child: const Text(
                      'Add a note',
                      style: TextStyle(
                        color: AppColors.colorBlue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              if (_showNoteField) ...[
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    controller: _noteController,
                    maxLines: 4,
                    maxLength: 500,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.colorBlack87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your note here...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counterStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Info Text
              const Text(
                "All requests will be sent for a manager's approval",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Send for approval',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Add some bottom padding
            ],
          ),
        ),
      ],
    );
  }
}
