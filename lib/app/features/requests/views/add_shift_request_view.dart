import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/requests/viewmodels/requests_viewmodel.dart';
import 'package:carenest/app/features/requests/viewmodels/config_viewmodel.dart';

class AddShiftRequestView extends ConsumerStatefulWidget {
  final String email;

  const AddShiftRequestView({super.key, required this.email});

  @override
  ConsumerState<AddShiftRequestView> createState() =>
      _AddShiftRequestViewState();
}

class _AddShiftRequestViewState extends ConsumerState<AddShiftRequestView> {
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime? endDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  bool _showNoteField = false;
  bool _isSubmitting = false;
  String? selectedJob;

  @override
  void initState() {
    super.initState();
    // Default end date is same as start date
    endDate = selectedDate;
  }

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
                  color: AppColors.colorGrey500,
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
    if (selectedJob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a job')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final start = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);

    final endDateTime = endDate ?? selectedDate;
    final end = DateTime(endDateTime.year, endDateTime.month, endDateTime.day,
        endTime.hour, endTime.minute);

    if (end.isBefore(start)) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time cannot be before start time')),
      );
      return;
    }

    final details = {
      'job': selectedJob,
      'starts': start.toIso8601String(),
      'ends': end.toIso8601String(),
    };

    final success =
        await ref.read(requestsViewModelProvider.notifier).createRequest(
              'Shift',
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
    final jobRolesAsync = ref.watch(jobRolesProvider);

    // Calculate total hours
    final start = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);

    final endDateTime = endDate ?? selectedDate;
    var end = DateTime(endDateTime.year, endDateTime.month, endDateTime.day,
        endTime.hour, endTime.minute);

    // Logic: if user hasn't explicitly selected end date and end time is earlier than start time,
    // it probably means next day if the end date is same as start date.
    // However, now we have explicit end date picker, so we should respect that.
    // If end date is same as start date and end time is before start time, it's invalid (or handled by validation).
    // If user intended overnight, they should pick next day.
    // But to keep it user friendly, if end date is not set (or same), we might assume next day if time is earlier?
    // No, let's stick to explicit date selection now.

    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final totalHoursStr = duration.isNegative
        ? 'Invalid duration'
        : '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppColors.colorBlack),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Add shift',
            style: TextStyle(
              color: AppColors.colorBlack,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Job Section
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Job',
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
                  color: AppColors.colorGrey100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: jobRolesAsync.when(
                  data: (roles) {
                    // Set default if not set and roles available
                    if (selectedJob == null && roles.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted)
                          setState(() => selectedJob = roles.first.title);
                      });
                    }

                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedJob,
                        isExpanded: true,
                        hint: const Text('Select Job'),
                        items: roles.map((role) {
                          return DropdownMenuItem(
                            value: role.title,
                            child: Text(
                              role.title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.colorGrey800,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() => selectedJob = val);
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, s) => const Text('Error loading roles'),
                ),
              ),
              const SizedBox(height: 16),

              // Start Time Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Starts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now().subtract(
                                const Duration(days: 30)), // Allow past dates?
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
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                              // Ensure end date is not before new start date
                              if (endDate != null && endDate!.isBefore(date)) {
                                endDate = date;
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
                            DateFormat('MMMM dd yyyy').format(selectedDate),
                            style: const TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: startTime,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.colorBlue,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (time != null) {
                            setState(() => startTime = time);
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
                            startTime.format(context),
                            style: const TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // End Time Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ends',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: endDate ?? selectedDate,
                            firstDate: selectedDate, // Can't end before start
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
                            DateFormat('MMMM dd yyyy')
                                .format(endDate ?? selectedDate),
                            style: const TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: endTime,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: AppColors.colorBlue,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (time != null) {
                            setState(() => endTime = time);
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
                            endTime.format(context),
                            style: const TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Total Hours Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    totalHoursStr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                    color: AppColors.colorGrey50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.colorGrey300),
                  ),
                  child: TextField(
                    controller: _noteController,
                    maxLines: 4,
                    maxLength: 500,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.colorGrey800,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your note here...',
                      hintStyle: TextStyle(
                        color: AppColors.colorGrey400,
                        fontSize: 16,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counterStyle: TextStyle(
                        color: AppColors.colorGrey600,
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
                  color: AppColors.colorGrey500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              // Bottom Buttons
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
