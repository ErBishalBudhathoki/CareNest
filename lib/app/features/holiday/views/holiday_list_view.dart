import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/widgets/modern_holiday_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/features/holiday/views/add_holiday_view.dart';

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
      backgroundColor: ModernInvoiceDesign.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ModernInvoiceDesign.textPrimary,
        title: Text(
          'Holidays',
          style: ModernInvoiceDesign.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: ModernInvoiceDesign.textPrimary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ModernInvoiceDesign.border,
              ),
              boxShadow: ModernInvoiceDesign.shadowSm,
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: ModernInvoiceDesign.textPrimary,
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
                color: ModernInvoiceDesign.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: ModernInvoiceDesign.border,
                ),
                boxShadow: ModernInvoiceDesign.shadowMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ModernInvoiceDesign.primary
                              .withValues(alpha: 0.1),
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
                              style:
                                  ModernInvoiceDesign.headlineMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ModernInvoiceDesign.textPrimary,
                              ),
                            ),
                            Text(
                              'Manage your holiday calendar',
                              style: ModernInvoiceDesign.bodyMedium.copyWith(
                                color: ModernInvoiceDesign.textSecondary,
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
                      color: ModernInvoiceDesign.backgroundSecondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ModernInvoiceDesign.border,
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
                          style: ModernInvoiceDesign.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ModernInvoiceDesign.textPrimary,
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
          color: ModernInvoiceDesign.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: ModernInvoiceDesign.shadowPrimaryGlow,
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
            color: ModernInvoiceDesign.textOnPrimary,
            size: 20,
          ),
          label: Text(
            'Add Holiday',
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ModernInvoiceDesign.textOnPrimary,
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
              color: ModernInvoiceDesign.neutral100,
              shape: BoxShape.circle,
              border: Border.all(
                color: ModernInvoiceDesign.border,
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
          Text(
            'No Holidays Yet',
            style: ModernInvoiceDesign.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: ModernInvoiceDesign.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first holiday to get started',
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              color: ModernInvoiceDesign.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8));
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateFormat('dd-MM-yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
