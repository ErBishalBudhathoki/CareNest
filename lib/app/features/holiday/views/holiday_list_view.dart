import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/widgets/modern_holiday_card.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';

class HolidayListView extends ConsumerStatefulWidget {
  final List<dynamic> holidays;

  const HolidayListView({super.key, required this.holidays});

  @override
  _HolidayListViewState createState() => _HolidayListViewState();
}

class _HolidayListViewState extends ConsumerState<HolidayListView> {
  @override
  void initState() {
    super.initState();
    // Sort the list of holidays by date
    widget.holidays.sort((a, b) => DateFormat("dd-MM-yyyy")
        .parse("${a['Date']}")
        .compareTo(DateFormat("dd-MM-yyyy").parse("${b['Date']}")));
  }

  void _addHoliday(Map<String, String> holiday) {
    setState(() {
      // Add the new holiday to the list
      widget.holidays.add(holiday);
      widget.holidays.sort((a, b) => DateFormat("dd-MM-yyyy")
          .parse("${a['Date']}")
          .compareTo(DateFormat("dd-MM-yyyy").parse("${b['Date']}")));
    });
  }

  var holiday = {};
  void _deleteHoliday(int index) {
    setState(() {
      holiday = widget.holidays[index];
      debugPrint(holiday['_id']);
      _deleteHolidayItem(holiday['_id']);
      // Remove the holiday at the specified index from the list
      widget.holidays.removeAt(index);
    });
  }

  Future<dynamic> _deleteHolidayItem(String id) async {
    final apiMethod = ref.read(apiMethodProvider);
    // debugPrint("Username:  ${_userEmailController.text.trim()}");
    // debugPrint("Password:  ${_passwordController.text.trim()}");
    var ins = await apiMethod.deleteHolidayItem(
      id,
    );
    //debugPrint("Response: "+ ins['email'].toString() + ins['password'].toString());
    return ins;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        title: Text(
          'Holidays',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: theme.colorScheme.onSurface,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: screenWidth,
            margin: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
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
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Holiday Management',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'Manage your holiday calendar',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/3D Icons/3dicons-calender-dynamic-color.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Total Holidays: ${widget.holidays.length}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.3),

          // Holiday List
          Expanded(
            child: widget.holidays.isEmpty
                ? _buildEmptyState(theme)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.holidays.length,
                    itemBuilder: (context, index) {
                      final holiday = widget.holidays[index];
                      final DateTime? holidayDate = _parseDate(holiday['Date']);
                      final bool isUpcoming = holidayDate != null &&
                          holidayDate.isAfter(DateTime.now());
                      final bool isToday = holidayDate != null &&
                          DateFormat('dd-MM-yyyy').format(holidayDate) ==
                              DateFormat('dd-MM-yyyy').format(DateTime.now());

                      return ModernHolidayCard(
                        holiday: holiday,
                        index: index,
                        onDelete: () => _deleteHoliday(index),
                        isUpcoming: isUpcoming,
                        isToday: isToday,
                      )
                          .animate(delay: Duration(milliseconds: 100 * index))
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .slideX(
                              begin: 0.2,
                              duration: const Duration(milliseconds: 400));
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddHolidayScreen(
                  addHoliday: _addHoliday,
                  holidays: widget.holidays,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.add_rounded,
            color: theme.colorScheme.onPrimary,
            size: 20,
          ),
          label: Text(
            'Add Holiday',
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      )
          .animate(delay: 1000.ms)
          .scale(duration: 600.ms, curve: Curves.elasticOut)
          .shimmer(delay: 1500.ms, duration: 2000.ms),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 2,
              ),
            ),
            child: Image.asset(
              'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Holidays Yet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add your first holiday to get started',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildHolidayCard(
      Map<String, dynamic> holiday, int index, ThemeData theme) {
    final DateTime? holidayDate = _parseDate(holiday['Date']);
    final bool isUpcoming =
        holidayDate != null && holidayDate.isAfter(DateTime.now());
    final bool isToday = holidayDate != null &&
        DateFormat('dd-MM-yyyy').format(holidayDate) ==
            DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key('holiday_$index'),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          _deleteHoliday(index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${holiday['Holiday']} deleted'),
              backgroundColor: theme.colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: theme.colorScheme.error,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_rounded,
                color: theme.colorScheme.onError,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                'Delete',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onError,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isToday
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                : theme.colorScheme.surfaceVariant.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isToday
                  ? theme.colorScheme.primary.withValues(alpha: 0.3)
                  : theme.colorScheme.outline.withValues(alpha: 0.2),
              width: isToday ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Date Circle
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isToday
                      ? theme.colorScheme.primary
                      : isUpcoming
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.outline.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getDateDay(holiday['Date']),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? theme.colorScheme.onPrimary
                            : isUpcoming
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      _getDateMonth(holiday['Date']),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isToday
                            ? theme.colorScheme.onPrimary.withValues(alpha: 0.8)
                            : isUpcoming
                                ? theme.colorScheme.onPrimaryContainer
                                    .withValues(alpha: 0.8)
                                : theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Holiday Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            holiday['Holiday'] ?? 'Unknown Holiday',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        if (isToday)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'TODAY',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${holiday['Date']} • ${holiday['Day']}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    if (isUpcoming && !isToday) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getDaysUntil(holidayDate!),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Status Icon
              Icon(
                isToday
                    ? Icons.today_rounded
                    : isUpcoming
                        ? Icons.upcoming_rounded
                        : Icons.history_rounded,
                color: isToday
                    ? theme.colorScheme.primary
                    : isUpcoming
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.outline.withValues(alpha: 0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateFormat('dd-MM-yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  String _getDateDay(String? dateString) {
    if (dateString == null) return '--';
    try {
      final date = DateFormat('dd-MM-yyyy').parse(dateString);
      return DateFormat('dd').format(date);
    } catch (e) {
      return '--';
    }
  }

  String _getDateMonth(String? dateString) {
    if (dateString == null) return '---';
    try {
      final date = DateFormat('dd-MM-yyyy').parse(dateString);
      return DateFormat('MMM').format(date).toUpperCase();
    } catch (e) {
      return '---';
    }
  }

  String _getDaysUntil(DateTime date) {
    final now = DateTime.now();
    final difference =
        date.difference(DateTime(now.year, now.month, now.day)).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 7) return 'In $difference days';
    if (difference < 30) return 'In ${(difference / 7).round()} weeks';
    return 'In ${(difference / 30).round()} months';
  }
}

class AddHolidayScreen extends ConsumerStatefulWidget {
  final Function(Map<String, String>) addHoliday;
  final List<dynamic> holidays; // Add a parameter for the holidays list

  const AddHolidayScreen({
    super.key,
    required this.addHoliday,
    required this.holidays,
  });

  @override
  ConsumerState<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends ConsumerState<AddHolidayScreen> {
  // Declare variables to store new holiday data
  final TextEditingController _holidayController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  ApiMethod apiMethod = ApiMethod();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        iconTheme: IconThemeData(
          color: theme.colorScheme.onSurface,
        ),
        title: Text(
          'Add Holiday',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Add New Holiday',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a new holiday entry for your calendar',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer
                          .withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Form Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Holiday Details',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Holiday Name Field
                    _buildInputField(
                      controller: _holidayController,
                      label: 'Holiday Name',
                      hint: 'e.g., Christmas Day',
                      iconAsset:
                          'assets/icons/3D Icons/3dicons-fire-dynamic-color.png',
                      theme: theme,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a holiday name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date Field
                    _buildInputField(
                      controller: _dateController,
                      label: 'Date',
                      hint: 'DD-MM-YYYY',
                      iconAsset:
                          'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                      theme: theme,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a date';
                        }
                        if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
                          return 'Please use DD-MM-YYYY format';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Day Field
                    _buildInputField(
                      controller: _dayController,
                      label: 'Day of Week',
                      hint: 'e.g., Monday',
                      iconAsset:
                          'assets/icons/3D Icons/3dicons-calendar-dynamic-color.png',
                      theme: theme,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the day of week';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _addHolidayItem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.onPrimary,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    color: AppColors.colorWhite,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Add Holiday',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.colorWhite,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    String? iconAsset,
    required ThemeData theme,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: iconAsset != null
                ? Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      iconAsset,
                      width: 24,
                      height: 24,
                    ),
                  )
                : Icon(
                    icon!,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _addHolidayItem() async {
    final apiMethod = ref.read(apiMethodProvider);
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String holiday = _holidayController.text.trim();
    final String date = _dateController.text.trim();
    final String day = _dayController.text.trim();

    final Map<String, String> newHoliday = {
      'Holiday': holiday,
      'Date': date,
      'Day': day,
    };

    try {
      var ins = await apiMethod.addHolidayItem(
        newHoliday,
      );

      if (ins['status'] == 'success' && mounted) {
        debugPrint("Holiday Added");

        // Add the new holiday to the list
        widget.addHoliday(newHoliday);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.colorWhite,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('Holiday added successfully!'),
              ],
            ),
            backgroundColor: AppColors.colorGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        Navigator.pop(context); // Return to the previous screen
      } else {
        debugPrint("Holiday Not Added ${ins['message']}");
        throw Exception('Failed to add holiday');
      }
    } catch (e) {
      if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_rounded,
                  color: AppColors.colorWhite,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('Failed to add holiday. Please try again.'),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
