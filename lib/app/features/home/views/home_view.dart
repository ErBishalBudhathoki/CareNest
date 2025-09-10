import 'dart:typed_data';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/shared/widgets/appBar_widget.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/shared/widgets/dynamic_appointment_card_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter/foundation.dart';

// ... existing code ...

class HomeView extends ConsumerStatefulWidget {
  final String email;
  final Uint8List? photoData;
  final PersistentTabController? controller;
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  // final String lastName;

  const HomeView({
    super.key,
    required this.email,
    this.photoData,
    this.controller,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    Uint8List? photoDataFromParent,
    // required this.lastName,
  });

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final PageController _pageController = PageController();
  late final PersistentTabController controller;
  late Future<dynamic> _appointmentDataFuture = Future.value(null);
  var eml;
  var initialData = {};
  var setAppointmentData;
  var appointmentData = {};
  late List<dynamic> clientEmailList = [];
  bool isDataFetched = false;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch photo data when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(photoDataProvider.notifier).fetchPhotoData(widget.email);
    });
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await Future.microtask(() {});

      // Ensure photo data is fetched
      final photoDataNotifier = ref.read(photoDataProvider.notifier);
      await photoDataNotifier.fetchPhotoData(widget.email);

      if (!isDataFetched) {
        await getInitData();
        isDataFetched = true;
      }

      setState(() {
        _appointmentDataFuture = getAppointmentData();
      });
    } catch (e) {
      debugPrint('Error initializing data: $e');
    }
  }

  Future<dynamic> getInitData() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      initialData = await apiMethod.getInitData(widget.email);
      // debugPrint("INS: "+ins['firstName']!);
      setState(() {
        eml = initialData;
        isDataFetched = true; // Set flag to true after fetching data
      });
      return initialData;
    } catch (e) {
      debugPrint('Error fetching initial data: $e');
    }
  }

  /// Fetches appointment data and handles errors gracefully
  Future<dynamic> getAppointmentData() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final now = DateTime.now();
      final appointmentData =
          (await apiMethod.getAppointmentData(widget.email)) as Map;

      if (appointmentData.containsKey('data') &&
          appointmentData['data'] is List) {
        final appointments =
            List<Map<String, dynamic>>.from(appointmentData['data']);

        appointments.sort((firstAppointment, secondAppointment) {
          debugPrint('Sorting appointment: ${firstAppointment.toString()}');

          // Handle different data structures
          dynamic firstSchedule;
          dynamic secondSchedule;

          // Check if appointment has schedule array
          if (firstAppointment['schedule'] != null &&
              firstAppointment['schedule'] is List) {
            final scheduleList = firstAppointment['schedule'] as List;
            firstSchedule = scheduleList.isNotEmpty ? scheduleList[0] : null;
          }

          if (secondAppointment['schedule'] != null &&
              secondAppointment['schedule'] is List) {
            final scheduleList = secondAppointment['schedule'] as List;
            secondSchedule = scheduleList.isNotEmpty ? scheduleList[0] : null;
          }

          debugPrint('First schedule: $firstSchedule');
          debugPrint('Second schedule: $secondSchedule');

          if (firstSchedule == null || secondSchedule == null) {
            debugPrint('One of the schedules is null');
            return 0;
          }

          try {
            final firstAppointmentDateTime = _parseDateTime(
                firstSchedule['date'], firstSchedule['startTime']);
            final secondAppointmentDateTime = _parseDateTime(
                secondSchedule['date'], secondSchedule['startTime']);

            if (firstAppointmentDateTime == null ||
                secondAppointmentDateTime == null) {
              debugPrint('Failed to parse one or both appointment times');
              return 0;
            }

            return firstAppointmentDateTime
                .difference(now)
                .abs()
                .compareTo(secondAppointmentDateTime.difference(now).abs());
          } catch (e) {
            debugPrint('Error parsing appointment dates: $e');
            return 0;
          }
        });

        setState(() {
          setAppointmentData = {'data': appointments};
        });
        return {'data': appointments};
      } else {
        setState(() {
          setAppointmentData = {'data': []};
        });
        return {'data': []};
      }
    } catch (e) {
      debugPrint('Error loading appointments in home view: $e');
      setState(() {
        setAppointmentData = {'data': []};
      });
      return {'data': []};
    }
  }

  /// Returns the number of appointments, handling null data gracefully
  int getLength() {
    try {
      if (setAppointmentData != null &&
          setAppointmentData['data'] != null &&
          setAppointmentData['data'] is List) {
        return setAppointmentData['data'].length;
      }
    } catch (e) {
      debugPrint('Error getting appointment length: $e');
    }
    return 0;
  }

  /// Safely parse date and time strings into DateTime object
  DateTime? _parseDateTime(dynamic date, dynamic time) {
    try {
      if (date == null || time == null) {
        debugPrint('_parseDateTime: null input - date: $date, time: $time');
        return null;
      }

      String dateStr = date.toString().trim();
      String timeStr = time.toString().trim();
      debugPrint('_parseDateTime: parsing date: "$dateStr", time: "$timeStr"');

      // Handle different date formats
      DateTime parsedDate;
      if (dateStr.contains('-')) {
        // ISO format: YYYY-MM-DD
        parsedDate = DateTime.parse(dateStr);
      } else if (dateStr.contains('/')) {
        // US format: MM/DD/YYYY or DD/MM/YYYY
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          // Assume MM/DD/YYYY format
          parsedDate = DateTime(
              int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));
        } else {
          return null;
        }
      } else {
        return null;
      }

      // Handle different time formats
      TimeOfDay parsedTime;
      if (timeStr.contains(':')) {
        final timeParts = timeStr.split(':');
        if (timeParts.length >= 2) {
          try {
            int hour = int.parse(timeParts[0].trim());
            // Extract minute part and remove any non-numeric characters
            String minutePart = timeParts[1].replaceAll(RegExp(r'[^0-9]'), '');
            int minute = minutePart.isNotEmpty ? int.parse(minutePart) : 0;

            debugPrint('_parseDateTime: parsed hour: $hour, minute: $minute');

            // Handle AM/PM format
            if (timeStr.toUpperCase().contains('PM') && hour != 12) {
              hour += 12;
            } else if (timeStr.toUpperCase().contains('AM') && hour == 12) {
              hour = 0;
            }

            debugPrint('_parseDateTime: final hour: $hour, minute: $minute');
            parsedTime = TimeOfDay(hour: hour, minute: minute);
          } catch (e) {
            debugPrint('_parseDateTime: Error parsing time parts: $e');
            return null;
          }
        } else {
          debugPrint('_parseDateTime: Invalid time format - not enough parts');
          return null;
        }
      } else {
        debugPrint('_parseDateTime: Invalid time format - no colon found');
        return null;
      }

      // Combine date and time
      return DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      debugPrint('Error parsing date "$date" and time "$time": $e');
      return null;
    }
  }

  Widget _buildSkeletonLoader() {
    return Column(
      children: [
        // Skeleton for the card
        Container(
          height: 180, // Approximate height of the card
          width: double.infinity,
          padding: const EdgeInsets.all(ModernSaasDesign.space4),
          decoration: BoxDecoration(
            color: ModernSaasDesign.neutral100,
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 150,
                color: ModernSaasDesign.neutral200,
              ),
              const SizedBox(height: ModernSaasDesign.space4),
              Container(
                height: 14,
                width: 200,
                color: ModernSaasDesign.neutral200,
              ),
              const SizedBox(height: ModernSaasDesign.space2),
              Container(
                height: 14,
                width: 250,
                color: ModernSaasDesign.neutral200,
              ),
              const Spacer(),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ModernSaasDesign.neutral200,
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
            height:
                ModernSaasDesign.space4), // Space between card and indicator
        // Skeleton for the page indicator
        Container(
          height: 10,
          width: 60,
          decoration: BoxDecoration(
            color: ModernSaasDesign.neutral100,
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ModernSaasDesign.surface,
      child: Scaffold(
        backgroundColor: ModernSaasDesign.surface,
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Consumer(
            builder: (context, ref, _) {
              final photoDataState = ref.watch(photoDataProvider);
              debugPrint(
                  'Building HomeView AppBar with photo: ${photoDataState.photoData}');
              return CustomAppBar(
                email: widget.email,
                firstName: initialData['firstName'] ?? 'First Name',
                lastName: initialData['lastName'] ?? 'Last Name',
                photoData: photoDataState.photoData,
              );
            },
          ),
        ),
        body: Container(
          color: ModernSaasDesign.background,
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Container(
              color: ModernSaasDesign.surface,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    ModernSaasDesign.space4, 0.0, ModernSaasDesign.space4, 0.0),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your Appointments',
                        style: TextStyle(
                          color: ModernSaasDesign.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space2),
                      FutureBuilder(
                        future: _appointmentDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return _buildSkeletonLoader();
                          } else if (snapshot.hasError) {
                            // Only show error for actual errors, not for empty data
                            return const Center(
                              child: Text(
                                'Unable to load appointments. Please try again.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ModernSaasDesign.textPrimary,
                                ),
                              ),
                            );
                          } else {
                            // Handle both null data and empty data gracefully
                            return getLength() == 0
                                ? Center(
                                    child: Text(
                                      'No Appointments right now',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ModernSaasDesign.textPrimary,
                                      ),
                                    ),
                                  )
                                : DynamicAppointmentCardWidget(
                                    currentUserEmail: widget.email,
                                    listLength: getLength(),
                                    clientEmailList: setAppointmentData['data']
                                        .map((item) => item['clientEmail'])
                                        .toList(),
                                  );
                          }
                        },
                      ),
                      const SizedBox(height: ModernSaasDesign.space5),

                      // Expense Management Section
                      const Text(
                        'Expense Management',
                        style: TextStyle(
                          color: ModernSaasDesign.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: ModernSaasDesign.surface,
                          borderRadius:
                              BorderRadius.circular(ModernSaasDesign.radiusLg),
                          border: Border.all(
                            color: ModernSaasDesign.border,
                            width: 1.0,
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color:
                          //         ModernSaasDesign.neutral300.withValues(alpha:0.3),
                          //     spreadRadius: 1,
                          //     blurRadius: 4,
                          //     offset: const Offset(0, 2),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Manage your expenses and track spending',
                              style: TextStyle(
                                color: ModernSaasDesign.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: ModernSaasDesign.space3),
                            ButtonWidget(
                              buttonText: "Open Expense Dashboard",
                              buttonColor: ModernSaasDesign.primary,
                              textColor: ModernSaasDesign.textOnPrimary,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseManagementView(
                                      adminEmail: widget.email,
                                      organizationId: widget.organizationId,
                                      organizationName: widget.organizationName,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space5),

                      ButtonWidget(
                        buttonText: "ClockIn",
                        buttonColor: Colors.white,
                        textColor: ModernSaasDesign.primary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Consumer(
                                builder: (context, ref, child) {
                                  final timerService =
                                      ref.watch(timerServiceProvider);
                                  return ClockInAndOutView(
                                    email: widget.email,
                                    // timerService: timerService,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: ModernSaasDesign.space4),
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
