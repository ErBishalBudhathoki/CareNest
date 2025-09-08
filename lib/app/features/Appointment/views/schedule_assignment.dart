import 'package:carenest/app/features/assignment/views/enhanced_ndis_item_selection_view.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/features/Appointment/widgets/shift_details_widget.dart';
import 'package:carenest/app/features/shift_assignment/views/shift_assignment_success_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/foundation.dart';

class ScheduleAssignment extends ConsumerStatefulWidget {
  final String userEmail;
  final String clientEmail;
  const ScheduleAssignment(
      {super.key, required this.userEmail, required this.clientEmail});

  @override
  ConsumerState<ScheduleAssignment> createState() => _TimeAndDatePickerState();
}

class _TimeAndDatePickerState extends ConsumerState<ScheduleAssignment>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _staggerController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _staggerAnimation;

  late DateTime _focusedDay = DateTime.now();
  TimeOfDay _focusedTime = TimeOfDay.now();
  TimeOfDay _focusedTime1 = TimeOfDay.now();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'time_date_picker_scaffold_key');
  bool _isVisibleDate = true;
  bool _isVisibleTime = true;
  bool _isVisibleTime1 = true;
  String _selectedBreak = "No";
  List<String> breakOptionItems = ["Yes", "No"];

  // Hover state variables for modern UI interactions
  bool _isDateHovered = false;
  bool _isTimeHovered = false;
  bool _isTime1Hovered = false;
  bool _isBreakHovered = false;

  ApiMethod apiMethod = ApiMethod();
  List<String> dateList = [];
  List<String> startTimeList = [];
  List<String> endTimeList = [];
  List<String> breakList = [];
  List<bool> highIntensityList = [];
  List<NDISItem?> ndisItemList = [];
  List<bool> customPricingSetList =
      []; // Track custom pricing per schedule entry
  List<double?> customPriceList = []; // Track custom price per schedule entry
  List<String?> pricingTypeList = []; // Track pricing type per schedule entry
  bool _isSubmitting = false;
  bool _isHighIntensity = false;

  // NDIS Item Selection
  NDISItem? _selectedNdisItem;
  String? _selectedNdisItemNumber;
  final TextEditingController _searchController = TextEditingController();

  // Custom pricing variables (for global selection)
  bool _isCustomPriceSet = false;
  double? _customPrice;
  String? _pricingType;

  // Error states
  String? _ndisError;
  String? _scheduleError;
  List<String> _validationErrors = [];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _staggerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggerController,
      curve: Curves.easeOutBack,
    ));

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
    _staggerController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _staggerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// Validates and adds a new schedule entry with comprehensive checks
  void _addCardWidget() {
    // Clear previous validation errors
    setState(() {
      _scheduleError = null;
      _validationErrors.clear();
    });

    // Validate current schedule entry before adding
    String? validationError = _validateCurrentSchedule();
    if (validationError != null) {
      setState(() {
        _scheduleError = validationError;
      });
      return;
    }

    setState(() {
      dateList.add(DateFormat("yyyy-MM-dd").format(_focusedDay));
      startTimeList.add(_focusedTime.format(context));
      endTimeList.add(_focusedTime1.format(context));
      breakList.add(_selectedBreak);
      ndisItemList.add(_selectedNdisItem);
      highIntensityList.add(_isHighIntensity);

      // Add custom pricing information for this schedule entry
      customPricingSetList.add(_isCustomPriceSet);
      customPriceList.add(_customPrice);
      pricingTypeList.add(_pricingType);

      // Clear any remaining errors after successful addition
      _scheduleError = null;
      _validationErrors.clear();
    });
  }

  /// Clears validation errors when user starts interacting with form
  void _clearValidationErrors() {
    if (_scheduleError != null || _validationErrors.isNotEmpty) {
      setState(() {
        _scheduleError = null;
        _validationErrors.clear();
      });
    }
  }

  /// Validates the current schedule entry for logical consistency
  String? _validateCurrentSchedule() {
    // Check if date is in the past
    DateTime selectedDate =
        DateTime(_focusedDay.year, _focusedDay.month, _focusedDay.day);
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (selectedDate.isBefore(today)) {
      return 'Cannot schedule appointments in the past';
    }

    // Check if start time is before end time
    DateTime startDateTime = DateTime(
      _focusedDay.year,
      _focusedDay.month,
      _focusedDay.day,
      _focusedTime.hour,
      _focusedTime.minute,
    );

    DateTime endDateTime = DateTime(
      _focusedDay.year,
      _focusedDay.month,
      _focusedDay.day,
      _focusedTime1.hour,
      _focusedTime1.minute,
    );

    if (startDateTime.isAfter(endDateTime) ||
        startDateTime.isAtSameMomentAs(endDateTime)) {
      return 'Start time must be before end time';
    }

    // Check minimum duration (30 minutes)
    Duration duration = endDateTime.difference(startDateTime);
    if (duration.inMinutes < 30) {
      return 'Minimum appointment duration is 30 minutes';
    }

    // Check for time conflicts on the same date (allow multiple schedules per date if no time overlap)
    String formattedDate = DateFormat("yyyy-MM-dd").format(_focusedDay);
    for (int i = 0; i < dateList.length; i++) {
      if (dateList[i] == formattedDate) {
        if (_hasTimeConflict(i, startDateTime, endDateTime)) {
          return 'Time conflict with existing schedule on this date';
        }
      }
    }

    return null; // No validation errors
  }

  /// Validates all schedules before submission
  List<String> _validateAllSchedules() {
    List<String> errors = [];

    // Check if there are any schedules
    if (dateList.isEmpty) {
      errors.add('Please add at least one schedule');
      return errors;
    }
    // Validate NDIS item selection
    if (_selectedNdisItem == null) {
      errors.add('Please select an NDIS Service Item');
    }
    // Check data consistency across all lists
    if (!_areListsConsistent()) {
      errors
          .add('Schedule data is inconsistent. Please refresh and try again.');
      return errors;
    }
    // Validate each schedule entry
    for (int i = 0; i < dateList.length; i++) {
      String? scheduleError = _validateScheduleAtIndex(i);
      if (scheduleError != null) {
        errors.add('Schedule ${i + 1}: $scheduleError');
      }
    }
    // Check for time conflicts across all schedules
    for (int i = 0; i < dateList.length; i++) {
      for (int j = i + 1; j < dateList.length; j++) {
        if (dateList[i] == dateList[j]) {
          // Same date, check for time conflicts
          if (_hasTimeConflictBetweenSchedules(i, j)) {
            errors.add(
                'Time conflict between schedules ${i + 1} and ${j + 1} on ${dateList[i]}');
          }
        }
      }
    }
    return errors;
  }

  /// Checks if all schedule lists have consistent lengths
  bool _areListsConsistent() {
    int expectedLength = dateList.length;
    return startTimeList.length == expectedLength &&
        endTimeList.length == expectedLength &&
        breakList.length == expectedLength &&
        ndisItemList.length == expectedLength &&
        highIntensityList.length == expectedLength &&
        customPricingSetList.length == expectedLength &&
        customPriceList.length == expectedLength &&
        pricingTypeList.length == expectedLength;
  }

  /// Validates a specific schedule entry by index
  String? _validateScheduleAtIndex(int index) {
    try {
      // Validate date format and value
      DateTime scheduleDate = DateTime.parse(dateList[index]);
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      if (scheduleDate.isBefore(today)) {
        return 'Date cannot be in the past';
      }

      // Validate time format and logic
      String? timeValidation = _validateTimeLogic(index);
      if (timeValidation != null) {
        return timeValidation;
      }

      // Validate NDIS item
      if (ndisItemList[index] == null) {
        return 'NDIS Service Item is required';
      }

      return null;
    } catch (e) {
      return 'Invalid schedule data format';
    }
  }

  /// Validates time logic for a specific schedule
  String? _validateTimeLogic(int index) {
    try {
      // Parse start and end times
      String startTimeStr = startTimeList[index];
      String endTimeStr = endTimeList[index];

      DateTime scheduleDate = DateTime.parse(dateList[index]);

      // Convert time strings to DateTime objects for comparison
      DateTime? startDateTime = _parseTimeString(startTimeStr, scheduleDate);
      DateTime? endDateTime = _parseTimeString(endTimeStr, scheduleDate);

      if (startDateTime == null || endDateTime == null) {
        return 'Invalid time format';
      }

      if (startDateTime.isAfter(endDateTime) ||
          startDateTime.isAtSameMomentAs(endDateTime)) {
        return 'Start time must be before end time';
      }

      // Check minimum duration (30 minutes)
      Duration duration = endDateTime.difference(startDateTime);
      if (duration.inMinutes < 30) {
        return 'Minimum duration is 30 minutes';
      }

      return null;
    } catch (e) {
      return 'Time validation error';
    }
  }

  /// Parses time string to DateTime object
  DateTime? _parseTimeString(String timeStr, DateTime date) {
    try {
      // Handle different time formats (12-hour with AM/PM)
      List<String> timeParts = timeStr.split(':');
      if (timeParts.length != 2) return null;

      int hour = int.parse(timeParts[0]);
      String minuteAndPeriod = timeParts[1];

      int minute;
      bool isPM = false;

      if (minuteAndPeriod.toLowerCase().contains('pm')) {
        isPM = true;
        minute = int.parse(minuteAndPeriod.split(' ')[0]);
      } else if (minuteAndPeriod.toLowerCase().contains('am')) {
        minute = int.parse(minuteAndPeriod.split(' ')[0]);
      } else {
        minute = int.parse(minuteAndPeriod);
      }

      // Convert to 24-hour format
      if (isPM && hour != 12) {
        hour += 12;
      } else if (!isPM && hour == 12) {
        hour = 0;
      }

      return DateTime(date.year, date.month, date.day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  /// Checks if there's a time conflict with an existing schedule
  bool _hasTimeConflict(int existingIndex, DateTime newStart, DateTime newEnd) {
    try {
      // Parse existing schedule times
      String startTimeStr = startTimeList[existingIndex];
      String endTimeStr = endTimeList[existingIndex];

      List<String> startTimeParts = startTimeStr.split(':');
      List<String> endTimeParts = endTimeStr.split(':');

      int existingStartHour = int.parse(startTimeParts[0]);
      final startMinuteParts = startTimeParts[1].split(' ');
      int existingStartMinute = int.parse(startMinuteParts.isNotEmpty
          ? startMinuteParts[0]
          : startTimeParts[1]);

      int existingEndHour = int.parse(endTimeParts[0]);
      final endMinuteParts = endTimeParts[1].split(' ');
      int existingEndMinute = int.parse(
          endMinuteParts.isNotEmpty ? endMinuteParts[0] : endTimeParts[1]);

      // Handle AM/PM conversion for start time
      if (startTimeParts[1].toLowerCase().contains('pm') &&
          existingStartHour != 12) {
        existingStartHour += 12;
      } else if (startTimeParts[1].toLowerCase().contains('am') &&
          existingStartHour == 12) {
        existingStartHour = 0;
      }

      // Handle AM/PM conversion for end time
      if (endTimeParts[1].toLowerCase().contains('pm') &&
          existingEndHour != 12) {
        existingEndHour += 12;
      } else if (endTimeParts[1].toLowerCase().contains('am') &&
          existingEndHour == 12) {
        existingEndHour = 0;
      }

      DateTime existingStart = DateTime(
        newStart.year,
        newStart.month,
        newStart.day,
        existingStartHour,
        existingStartMinute,
      );

      DateTime existingEnd = DateTime(
        newEnd.year,
        newEnd.month,
        newEnd.day,
        existingEndHour,
        existingEndMinute,
      );

      // Check for overlap
      return (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart));
    } catch (e) {
      // If parsing fails, assume no conflict to be safe
      return false;
    }
  }

  /// Checks if there's a time conflict between two schedule entries
  bool _hasTimeConflictBetweenSchedules(int index1, int index2) {
    try {
      // Parse times for both schedules
      DateTime? start1 = _parseTimeString(
          startTimeList[index1], DateTime.parse(dateList[index1]));
      DateTime? end1 = _parseTimeString(
          endTimeList[index1], DateTime.parse(dateList[index1]));
      DateTime? start2 = _parseTimeString(
          startTimeList[index2], DateTime.parse(dateList[index2]));
      DateTime? end2 = _parseTimeString(
          endTimeList[index2], DateTime.parse(dateList[index2]));

      if (start1 == null || end1 == null || start2 == null || end2 == null) {
        return false; // If parsing fails, assume no conflict
      }

      // Check for overlap: schedules overlap if start1 < end2 AND start2 < end1
      return (start1.isBefore(end2) && start2.isBefore(end1));
    } catch (e) {
      // If parsing fails, assume no conflict to be safe
      return false;
    }
  }

  Widget _card(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          width: 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).cardColor,
            Theme.of(context).cardColor.withValues(alpha: 0.95),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.colorSecondary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.colorSecondary.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.event_available_outlined,
                    color: AppColors.colorSecondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Schedule Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.colorFontPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Added on ${DateFormat('MMM d, yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            AppColors.colorFontSecondary.withValues(alpha: 0.7),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorRed.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.colorRed.withValues(alpha: 0.15),
                      width: 1.5,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (dateList.length > index) dateList.removeAt(index);
                        if (startTimeList.length > index) {
                          startTimeList.removeAt(index);
                        }
                        if (endTimeList.length > index) {
                          endTimeList.removeAt(index);
                        }
                        if (breakList.length > index) breakList.removeAt(index);
                        if (ndisItemList.length > index) {
                          ndisItemList.removeAt(index);
                        }
                        if (highIntensityList.length > index) {
                          highIntensityList.removeAt(index);
                        }
                        // Remove custom pricing information for this schedule entry
                        if (customPricingSetList.length > index) {
                          customPricingSetList.removeAt(index);
                        }
                        if (customPriceList.length > index) {
                          customPriceList.removeAt(index);
                        }
                        if (pricingTypeList.length > index) {
                          pricingTypeList.removeAt(index);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.colorRed,
                      size: 22,
                    ),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildScheduleDetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Appointment Date',
                  value: DateFormat('EEEE, MMMM d, y')
                      .format(DateFormat('yyyy-MM-dd').parse(dateList[index])),
                  iconColor: AppColors.colorPrimary,
                  backgroundColor:
                      AppColors.colorPrimary.withValues(alpha: 0.12),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildScheduleDetailRow(
                        icon: Icons.access_time_outlined,
                        label: 'Start Time',
                        value: startTimeList[index],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildScheduleDetailRow(
                        icon: Icons.access_time_filled_outlined,
                        label: 'End Time',
                        value: endTimeList[index],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildScheduleDetailRow(
                  icon: Icons.coffee_outlined,
                  label: 'Break Duration',
                  value: breakList[index],
                ),
                const SizedBox(height: 20),
                _buildScheduleDetailRow(
                  icon: Icons.medical_services_outlined,
                  label: 'NDIS Service Item',
                  value: ndisItemList[index] != null
                      ? '${ndisItemList[index]!.itemNumber} - ${ndisItemList[index]!.itemName}'
                      : 'Select NDIS Service Item',
                  iconColor: _ndisError != null ? Colors.red : null,
                  backgroundColor: _ndisError != null
                      ? Colors.red.withValues(alpha: 0.1)
                      : null,
                ),
                if (_ndisError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      _ndisError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 12),
                // NDIS Item Selection Button for this schedule entry
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnhancedNdisItemSelectionView(
                            organizationId: null,
                            clientId: null,
                            highIntensity: highIntensityList[index],
                            userState: 'NSW',
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          ndisItemList[index] = result.ndisItem;

                          // Store custom pricing information for this specific schedule entry
                          if (result.isCustomPriceSet &&
                              result.customPrice != null) {
                            customPricingSetList[index] = true;
                            customPriceList[index] = result.customPrice;
                            pricingTypeList[index] = result.pricingType;
                            debugPrint(
                                'Custom price set for schedule $index: ${result.customPrice}');
                          } else {
                            customPricingSetList[index] = false;
                            customPriceList[index] = null;
                            pricingTypeList[index] = null;
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ndisItemList[index] != null
                          ? AppColors.colorSecondary
                          : AppColors.colorPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    icon: Icon(
                      ndisItemList[index] != null ? Icons.edit : Icons.add,
                      size: 20,
                    ),
                    label: Text(
                      ndisItemList[index] != null
                          ? 'Change NDIS Item'
                          : 'Select NDIS Item',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Show custom pricing info if set for this schedule entry
                if (customPricingSetList.length > index &&
                    customPricingSetList[index] &&
                    customPriceList[index] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.green.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: Colors.green[700],
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Custom Price: \$${customPriceList[index]!.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fitness_center_outlined,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'High Intensity Care',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: highIntensityList[index],
                        onChanged: (value) {
                          setState(() {
                            highIntensityList[index] = value;
                          });
                        },
                        activeColor: AppColors.colorPrimary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleDetailRow(
      {required IconData icon,
      required String label,
      required String value,
      Color? iconColor,
      Color? backgroundColor}) {
    final effectiveIconColor = iconColor ?? AppColors.colorPrimary;
    final effectiveBackgroundColor =
        backgroundColor ?? AppColors.colorPrimary.withValues(alpha: 0.1);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.colorSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.colorPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 34,
            height: 34,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: effectiveBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: effectiveIconColor,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorFontSecondary.withValues(alpha: 0.8),
                    letterSpacing: 0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() {
    _clearValidationErrors(); // Clear errors when user interacts
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      locale: const Locale('en', 'AU'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.colorPrimary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.colorFontPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.colorPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String formattedDate = dateFormat.format(value);
        setState(() {
          _isVisibleDate = false;
          _focusedDay = dateFormat.parse(formattedDate);
        });
      }
    });
  }

  void _showTimePicker() {
    _clearValidationErrors(); // Clear errors when user interacts
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.colorPrimary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.colorFontPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.colorPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _isVisibleTime = false;
          _focusedTime = value;
        });
      }
    });
  }

  void _showTimePicker1() {
    _clearValidationErrors(); // Clear errors when user interacts
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.colorPrimary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.colorFontPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.colorPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _isVisibleTime1 = false;
          _focusedTime1 = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.colorBackground,
      appBar: _buildModernAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEnhancedHeaderSection(),
                const SizedBox(height: 32),
                _buildEnhancedDateTimeSection(),
                const SizedBox(height: 32),
                _buildEnhancedScheduleList(),
                const SizedBox(height: 32),
                _buildEnhancedActionButtons(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Modern app bar with gradient and enhanced styling
  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.colorPrimary,
              AppColors.colorSecondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      title: const Text(
        'Schedule Assignment',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Enhanced header section with modern design
  Widget _buildEnhancedHeaderSection() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.colorPrimary.withValues(alpha: 0.08),
              AppColors.colorSecondary.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.colorPrimary.withValues(alpha: 0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorPrimary.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.colorPrimary.withValues(alpha: 0.15),
                        AppColors.colorSecondary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.assignment_ind_rounded,
                    color: AppColors.colorPrimary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Assignment Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorFontPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildEnhancedInfoRow(
                'Employee', widget.userEmail, Icons.person_rounded),
            const SizedBox(height: 12),
            _buildEnhancedInfoRow(
                'Client', widget.clientEmail, Icons.business_rounded),
          ],
        ),
      ),
    );
  }

  /// Enhanced info row with icons and better styling
  Widget _buildEnhancedInfoRow(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.colorPrimary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.colorPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.colorPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorFontPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Enhanced date time section with modern styling
  Widget _buildEnhancedDateTimeSection() {
    return AnimatedBuilder(
      animation: _staggerAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _staggerAnimation.value)),
          child: Opacity(
            opacity: (_staggerAnimation.value).clamp(0.0, 1.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: AppColors.colorPrimary.withValues(alpha: 0.04),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
                border: Border.all(
                  color: AppColors.colorPrimary.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              AppColors.colorSecondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.schedule_rounded,
                          color: AppColors.colorSecondary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Schedule Configuration',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.colorFontPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          children: [
                            Expanded(child: _buildEnhancedDateSelector()),
                            const SizedBox(width: 16),
                            Expanded(
                                child: _buildEnhancedTimeSelector(
                                    'Start Time',
                                    _focusedTime,
                                    _isVisibleTime,
                                    _showTimePicker)),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildEnhancedDateSelector(),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                    child: _buildEnhancedTimeSelector(
                                        'Start Time',
                                        _focusedTime,
                                        _isVisibleTime,
                                        _showTimePicker)),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: _buildEnhancedTimeSelector(
                                        'End Time',
                                        _focusedTime1,
                                        _isVisibleTime1,
                                        _showTimePicker1)),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Row(
                          children: [
                            Expanded(child: _buildEnhancedBreakSelector()),
                            const SizedBox(width: 16),
                            Expanded(
                                child: _buildEnhancedTimeSelector(
                                    'End Time',
                                    _focusedTime1,
                                    _isVisibleTime1,
                                    _showTimePicker1)),
                          ],
                        );
                      } else {
                        return _buildEnhancedBreakSelector();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  // NDIS Item Search and Selection
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EnhancedNdisItemSelectionView(
                                organizationId:
                                    null, // Can be retrieved from SharedPreferences if needed
                                clientId:
                                    null, // Can be retrieved from SharedPreferences if needed
                                highIntensity: _isHighIntensity,
                                userState:
                                    'NSW', // You can get this from SharedPreferences
                              ),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              _clearValidationErrors(); // Clear errors when NDIS item is selected
                              _selectedNdisItem = result.ndisItem;
                              _selectedNdisItemNumber =
                                  result.ndisItem.itemNumber;
                              _searchController.text =
                                  '${result.ndisItem.itemNumber} - ${result.ndisItem.itemName}';

                              // Store custom pricing information if set
                              if (result.isCustomPriceSet &&
                                  result.customPrice != null) {
                                _isCustomPriceSet = true;
                                _customPrice = result.customPrice;
                                _pricingType = result.pricingType;
                                debugPrint(
                                    'Custom price set: ${result.customPrice}');
                              } else {
                                _isCustomPriceSet = false;
                                _customPrice = null;
                                _pricingType = null;
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _selectedNdisItem != null
                                    ? '${_selectedNdisItem!.itemNumber} - ${_selectedNdisItem!.itemName}'
                                    : 'Select NDIS Item',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_selectedNdisItem != null) ...[
                              const SizedBox(width: 12),
                              IconButton(
                                icon: const Icon(Icons.clear,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _selectedNdisItem = null;
                                    _selectedNdisItemNumber = null;
                                    _searchController.clear();
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (_selectedNdisItem != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.colorPrimary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.colorPrimary
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.colorPrimary,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${_selectedNdisItem!.itemName} ${_selectedNdisItem!.itemNumber}',
                                    style: TextStyle(
                                      color: AppColors.colorPrimary,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Enhanced date selector with hover effects and animations
  Widget _buildEnhancedDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          onEnter: (_) => setState(() => _isDateHovered = true),
          onExit: (_) => setState(() => _isDateHovered = false),
          child: GestureDetector(
            onTap: _showDatePicker,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _isDateHovered
                    ? AppColors.colorPrimary.withValues(alpha: 0.05)
                    : AppColors.colorSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isDateHovered
                      ? AppColors.colorPrimary.withValues(alpha: 0.4)
                      : AppColors.colorPrimary.withValues(alpha: 0.2),
                  width: _isDateHovered ? 2 : 1.5,
                ),
                boxShadow: _isDateHovered
                    ? [
                        BoxShadow(
                          color: AppColors.colorPrimary.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.colorPrimary
                            .withValues(alpha: _isDateHovered ? 0.15 : 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.colorPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _isVisibleDate
                          ? 'Select Date'
                          : DateFormat('MMM dd, yyyy').format(_focusedDay),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _isVisibleDate
                            ? AppColors.colorFontSecondary
                            : AppColors.colorFontPrimary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.colorPrimary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Enhanced time selector with modern styling
  Widget _buildEnhancedTimeSelector(
      String label, TimeOfDay time, bool isVisible, VoidCallback onTap) {
    bool isHovered = (label == 'Start Time' && _isTimeHovered) ||
        (label == 'End Time' && _isTime1Hovered);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.colorFontSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        MouseRegion(
          onEnter: (_) => setState(() {
            if (label == 'Start Time') _isTimeHovered = true;
            if (label == 'End Time') _isTime1Hovered = true;
          }),
          onExit: (_) => setState(() {
            if (label == 'Start Time') _isTimeHovered = false;
            if (label == 'End Time') _isTime1Hovered = false;
          }),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isHovered
                    ? AppColors.colorSecondary.withValues(alpha: 0.05)
                    : AppColors.colorSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isHovered
                      ? AppColors.colorSecondary.withValues(alpha: 0.4)
                      : AppColors.colorSecondary.withValues(alpha: 0.2),
                  width: isHovered ? 2 : 1.5,
                ),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color:
                              AppColors.colorSecondary.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.colorSecondary
                            .withValues(alpha: isHovered ? 0.15 : 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.access_time_rounded,
                        color: AppColors.colorSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isVisible ? 'Select Time' : time.format(context),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isVisible
                            ? AppColors.colorFontSecondary
                            : AppColors.colorFontPrimary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.colorSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Enhanced break selector with modern dropdown styling
  Widget _buildEnhancedBreakSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Break Allowed',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const Text(
              'High Intensity',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MouseRegion(
                onEnter: (_) => setState(() => _isBreakHovered = true),
                onExit: (_) => setState(() => _isBreakHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: _isBreakHovered
                        ? AppColors.colorBlue.withValues(alpha: 0.05)
                        : AppColors.colorSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isBreakHovered
                          ? AppColors.colorBlue.withValues(alpha: 0.4)
                          : AppColors.colorBlue.withValues(alpha: 0.2),
                      width: _isBreakHovered ? 2 : 1.5,
                    ),
                    boxShadow: _isBreakHovered
                        ? [
                            BoxShadow(
                              color: AppColors.colorBlue.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedBreak,
                      isExpanded: true,
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.colorBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.colorBlue,
                          size: 20,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorFontPrimary,
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedBreak = value!;
                        });
                      },
                      items: breakOptionItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: item == 'Yes'
                                        ? AppColors.colorSecondary
                                            .withValues(alpha: 0.1)
                                        : AppColors.colorGrey600
                                            .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    item == 'Yes'
                                        ? Icons.coffee_rounded
                                        : Icons.block_rounded,
                                    color: item == 'Yes'
                                        ? AppColors.colorSecondary
                                        : AppColors.colorGrey600,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 58,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fitness_center_outlined,
                      color: Colors.grey[700],
                    ),
                    //const SizedBox(width: 12), // Fixed spacing

                    const Spacer(), // Pushes the switch to the right
                    Switch(
                      value: _isHighIntensity,
                      onChanged: (value) => setState(() {
                        _clearValidationErrors(); // Clear errors when user interacts
                        _isHighIntensity = value;
                      }),
                      activeColor: AppColors.colorPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Enhanced schedule list with modern animations
  Widget _buildEnhancedScheduleList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.colorPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.list_alt_rounded,
                color: AppColors.colorPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Added Schedules',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.colorFontPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.colorSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.colorSecondary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                '${dateList.length} schedule${dateList.length != 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (dateList.isEmpty)
          _buildEnhancedEmptyState()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dateList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => _card(index),
          ),
      ],
    );
  }

  /// Enhanced empty state with modern design
  Widget _buildEnhancedEmptyState() {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    AppColors.colorBackground.withValues(alpha: 0.5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.colorPrimary.withValues(alpha: 0.15),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorPrimary.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.colorPrimary.withValues(alpha: 0.1),
                          AppColors.colorSecondary.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.schedule_outlined,
                      size: 48,
                      color: AppColors.colorPrimary.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No schedules added yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorFontPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create your first schedule to get started with assignment management',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.colorFontSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Enhanced error display widget
  Widget _buildEnhancedErrorDisplay() {
    if (_scheduleError == null && _validationErrors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Validation Errors',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_scheduleError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _scheduleError!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.red,
                  height: 1.4,
                ),
              ),
            ),
          if (_validationErrors.isNotEmpty)
            ...(_validationErrors.map((error) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          error,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
        ],
      ),
    );
  }

  /// Enhanced action buttons with modern styling and animations
  Widget _buildEnhancedActionButtons() {
    return Column(
      children: [
        // Error Display
        _buildEnhancedErrorDisplay(),
        // Add Schedule Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _addCardWidget,
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child:
                  const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            ),
            label: const Text(
              'Add Schedule',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorSecondary,
              foregroundColor: Colors.white,
              elevation: 8,
              shadowColor: AppColors.colorSecondary.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ).copyWith(
              overlayColor: MaterialStateProperty.all(
                Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              debugPrint(
                  "Submit button pressed. _isSubmitting: $_isSubmitting, dateList.isEmpty: ${dateList.isEmpty}");
              if (_isSubmitting || dateList.isEmpty) {
                debugPrint("Submit button disabled. Returning.");
                return;
              }
              _handleSubmit();
            },
            icon: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 20),
                  ),
            label: Text(
              _isSubmitting ? 'Submitting Assignment...' : 'Submit Assignment',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: dateList.isEmpty
                  ? AppColors.colorGrey600
                  : AppColors.colorPrimary,
              foregroundColor: Colors.white,
              elevation: dateList.isEmpty ? 0 : 8,
              shadowColor: AppColors.colorPrimary.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ).copyWith(
              overlayColor: MaterialStateProperty.all(
                dateList.isEmpty
                    ? Colors.transparent
                    : Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Handles form submission with comprehensive validation
  void _handleSubmit() async {
    debugPrint(
        "Submitting assignment ${_isSubmitting.toString()} ${_selectedNdisItem.toString()}");

    // Prevent double submission
    if (_isSubmitting) return;

    // Clear previous errors
    setState(() {
      _ndisError = null;
      _scheduleError = null;
      _validationErrors.clear();
    });

    // Comprehensive validation before submission
    List<String> validationErrors = _validateAllSchedules();
    if (validationErrors.isNotEmpty) {
      setState(() {
        _validationErrors = validationErrors;
        _scheduleError = validationErrors.first;
      });

      // Show error message
      FlushBarWidget fbw = FlushBarWidget();
      fbw.flushBar(
        context: context,
        title: "Validation Error",
        message: validationErrors.first,
        backgroundColor: AppColors.colorRed,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      var response = await _submitAssignedAppointment();
      debugPrint("Response: $response");
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        FlushBarWidget fbw = FlushBarWidget();

        // Explicitly cast response to Map<String, dynamic>
        Map<String, dynamic> responseData = response as Map<String, dynamic>;
        debugPrint("Response data: $responseData\n");
        if (responseData['success'] == true) {
          // Create shift data for ShiftDetailsWidget
          Map<String, dynamic> shiftData = {
            'dateList': dateList,
            'startTimeList': startTimeList,
            'endTimeList': endTimeList,
            'breakList': breakList,
            'ndisItem': _selectedNdisItem?.toJson() ?? {},
            'isHighIntensity': highIntensityList,
          };

          // Navigate to modern ShiftAssignmentSuccessView
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ShiftAssignmentSuccessView(
                userEmail: widget.userEmail,
                clientEmail: widget.clientEmail,
                shiftData: shiftData,
                assignmentId: DateTime.now().millisecondsSinceEpoch.toString(),
              ),
            ),
          );

          fbw.flushBar(
            context: context,
            title: "Success",
            message: responseData['message']
                .toString(), // Use the actual message from the backend
            backgroundColor: AppColors.colorSecondary,
          );
        } else {
          fbw.flushBar(
            context: context,
            title: "Error",
            message: responseData['message']
                .toString(), // Use the actual message from the backend
            backgroundColor: AppColors.colorRed,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        FlushBarWidget fbw = FlushBarWidget();
        fbw.flushBar(
          context: context,
          title: "Error",
          message: "An error occurred. Please try again.",
          backgroundColor: AppColors.colorRed,
        );
      }
    }
  }

  Future<dynamic> _submitAssignedAppointment() async {
    // Prepare NDIS item with custom pricing if available (for backward compatibility)
    Map<String, dynamic>? ndisItemWithPricing = _selectedNdisItem?.toJson();
    if (ndisItemWithPricing != null &&
        _isCustomPriceSet &&
        _customPrice != null) {
      ndisItemWithPricing['customPricing'] = {
        'price': _customPrice,
        'pricingType': _pricingType,
        'isCustom': true,
      };
    }

    // Create scheduleWithNdisItems array for individual NDIS items per schedule entry
    final List<Map<String, dynamic>> scheduleWithNdisItems = [];

    debugPrint(
        'DEBUG: Creating scheduleWithNdisItems for ${dateList.length} schedule entries');
    debugPrint('DEBUG: ndisItemList length: ${ndisItemList.length}');

    for (int i = 0; i < dateList.length; i++) {
      // Prepare schedule entry
      Map<String, dynamic> scheduleEntry = {
        'date': dateList[i],
        'startTime': startTimeList[i],
        'endTime': endTimeList[i],
        'break': breakList[i],
        'highIntensity': highIntensityList[i],
      };

      // Add NDIS item if available for this schedule entry
      NDISItem? scheduleNdisItem;
      if (i < ndisItemList.length && ndisItemList[i] != null) {
        scheduleNdisItem = ndisItemList[i];
      } else {
        // Fallback to the globally selected NDIS item
        scheduleNdisItem = _selectedNdisItem;
      }

      if (scheduleNdisItem != null) {
        scheduleEntry['ndisItem'] = scheduleNdisItem.toJson();
        debugPrint(
            'DEBUG: Added NDIS item to schedule entry $i: ${scheduleNdisItem.itemNumber}');

        // Add custom pricing if set for this specific schedule entry
        if (i < customPricingSetList.length &&
            customPricingSetList[i] &&
            customPriceList[i] != null) {
          scheduleEntry['customPricing'] = {
            'price': customPriceList[i],
            'pricingType': pricingTypeList[i],
            'isCustom': true,
          };
          debugPrint(
              'DEBUG: Added per-schedule custom pricing to schedule entry $i: ${customPriceList[i]}');
        } else if (scheduleNdisItem == _selectedNdisItem &&
            _isCustomPriceSet &&
            _customPrice != null) {
          // If using the global NDIS item and global custom pricing is set, apply it
          scheduleEntry['customPricing'] = {
            'price': _customPrice,
            'pricingType': _pricingType,
            'isCustom': true,
          };
          debugPrint(
              'DEBUG: Added global custom pricing to schedule entry $i: $_customPrice');
        }
      } else {
        debugPrint('DEBUG: No NDIS item found for schedule entry $i');
      }

      scheduleWithNdisItems.add(scheduleEntry);
    }

    debugPrint('DEBUG: Final scheduleWithNdisItems being sent to backend:');
    for (int i = 0; i < scheduleWithNdisItems.length; i++) {
      debugPrint(
          'DEBUG: scheduleWithNdisItems[$i]: ${scheduleWithNdisItems[i]}');
    }

    // Log all data being sent to backend
    debugPrint('=== SUBMIT BUTTON PRESSED - DATA BEING SENT TO BACKEND ===');
    debugPrint('User Email: ${widget.userEmail}');
    debugPrint('Client Email: ${widget.clientEmail}');
    debugPrint('Date List: $dateList');
    debugPrint('Start Time List: $startTimeList');
    debugPrint('End Time List: $endTimeList');
    debugPrint('Break List: $breakList');
    debugPrint('High Intensity List: $highIntensityList');
    debugPrint('Schedule With NDIS Items: $scheduleWithNdisItems');
    debugPrint(
        'Schedule With NDIS Items Length: ${scheduleWithNdisItems.length}');
    debugPrint('Selected NDIS Item (fallback): ${_selectedNdisItem?.toJson()}');
    debugPrint('Global Custom Price Set: $_isCustomPriceSet');
    debugPrint('Global Custom Price: $_customPrice');
    debugPrint('Global Pricing Type: $_pricingType');
    debugPrint('Per-Schedule Custom Pricing Set List: $customPricingSetList');
    debugPrint('Per-Schedule Custom Price List: $customPriceList');
    debugPrint('Per-Schedule Pricing Type List: $pricingTypeList');
    debugPrint('=== END OF FRONTEND DATA LOG ===');

    // Use the enhanced API method that supports individual NDIS items per schedule entry
    var ins = await apiMethod.assignClientToUserWithScheduleItems(
      widget.userEmail,
      widget.clientEmail,
      dateList,
      startTimeList,
      endTimeList,
      breakList,
      ndisItemWithPricing ?? {},
      highIntensityList,
      scheduleWithNdisItems,
    );
    return ins; // Explicitly return the result of the API call

    Stream<Text> getDate(Duration refreshTime) async* {
      while (true) {
        await Future.delayed(refreshTime);
        yield Text(
            "Selected Date: ${DateFormat("yyyy-MM-dd").format(_focusedDay)}");
      }
    }
  }
}
