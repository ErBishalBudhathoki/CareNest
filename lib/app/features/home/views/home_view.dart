
import 'dart:typed_data';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/shared/widgets/app_bar_widget.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/shared/widgets/dynamic_appointment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

import 'package:carenest/app/features/admin/views/bank_details_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

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
  // Controls bank details selection UI in HomeView (visual only for normal users)
  bool _useAdminBankDetails = false;
  // Shared preferences helper
  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();
  // Employee bank details status
  bool _bankDetailsLoading = false;
  bool _hasBankDetails = false;
  String? _bankDetailsError;
  Map<String, dynamic>? _bankDetails;

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
      // Load employee bank details status for Home UI
      await _loadEmployeeBankDetails();
      // Load persisted preference for admin vs employee bank details
      await _loadUseAdminPreference();

      setState(() {
        _appointmentDataFuture = getAppointmentData();
      });
    } catch (e) {
      debugPrint('Error initializing data: $e');
    }
  }

  /// Loads the current user's bank details from backend to show status on Home.
  /// Uses ApiMethod.getBankDetails which reads `userEmail` and `organizationId` from SharedPreferences.
  Future<void> _loadEmployeeBankDetails() async {
    setState(() {
      _bankDetailsLoading = true;
      _bankDetailsError = null;
    });
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.getBankDetails();
      if (response['success'] == true && response['data'] is Map) {
        setState(() {
          _bankDetails = Map<String, dynamic>.from(response['data'] as Map);
          _hasBankDetails = true;
        });
      } else {
        setState(() {
          _hasBankDetails = false;
          _bankDetailsError = (response['message']?.toString());
        });
      }
    } catch (e) {
      setState(() {
        _hasBankDetails = false;
        _bankDetailsError = 'Error loading bank details: $e';
      });
    } finally {
      setState(() {
        _bankDetailsLoading = false;
      });
    }
  }

  /// Loads the persisted preference for using admin bank details.
  /// Defaults to false if not previously set.
  Future<void> _loadUseAdminPreference() async {
    try {
      await _prefs.init();
      final stored = _prefs.getBool(SharedPreferencesUtils.kUseAdminBankDetailsKey);
      if (stored != null) {
        setState(() => _useAdminBankDetails = stored);
      }
    } catch (e) {
      debugPrint('Failed to load useAdminBankDetails preference: $e');
    }
  }

  /// Persists the current admin/employee bank details preference.
  Future<void> _persistUseAdminPreference(bool value) async {
    try {
      await _prefs.setBool(SharedPreferencesUtils.kUseAdminBankDetailsKey, value);
    } catch (e) {
      debugPrint('Failed to persist useAdminBankDetails preference: $e');
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
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 150,
                color: const Color(0xFFE5E5E5),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 14,
                width: 200,
                color: const Color(0xFFE5E5E5),
              ),
              const SizedBox(height: 8.0),
              Container(
                height: 14,
                width: 250,
                color: const Color(0xFFE5E5E5),
              ),
              const Spacer(),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius:
                      BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
            height:
                16.0), // Space between card and indicator
        // Skeleton for the page indicator
        Container(
          height: 10,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }

  /// Builds the bank details configuration UI with radio toggles.
  /// Allows a normal user to choose between using employee or admin bank details.
  /// This UI does not trigger invoice creation and serves as a visual configuration.
  Widget _buildBankDetailsConfiguration() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_hasBankDetails)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: const Text(
                'Employee bank details are not set yet. Please add your bank details first.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ),
          const Text(
            'Select which bank details to display',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12.0),
          if (_hasBankDetails)
            RadioListTile<bool>(
              title: const Text(
                'Employee Bank Details',
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Use the employee’s saved bank details',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              value: false,
              groupValue: _useAdminBankDetails,
              activeColor: const Color(0xFF667EEA),
              onChanged: (val) async {
                final newVal = val ?? false;
                setState(() {
                  _useAdminBankDetails = newVal;
                });
                await _persistUseAdminPreference(newVal);
              },
              contentPadding: EdgeInsets.zero,
            ),
          RadioListTile<bool>(
            title: const Text(
              'Admin Bank Details',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              'Use admin bank details (invoices created by admin only)',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            value: true,
            groupValue: _useAdminBankDetails,
            activeColor: const Color(0xFF667EEA),
            onChanged: (val) async {
              final newVal = val ?? false;
              setState(() {
                _useAdminBankDetails = newVal;
              });
              await _persistUseAdminPreference(newVal);
            },
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Note: Invoice creation is restricted to admin users.',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the employee bank details status section with CTA to add/update.
  /// Navigates to BankDetailsView for editing and refreshes status on return.
  Widget _buildEmployeeBankDetailsSection() {
    String maskedAccount = '';
    if (_bankDetails != null && (_bankDetails!['accountNumber'] is String)) {
      final acc = (_bankDetails!['accountNumber'] as String).trim();
      if (acc.isNotEmpty) {
        final last4 = acc.length >= 4 ? acc.substring(acc.length - 4) : acc;
        maskedAccount = '••••••$last4';
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Bank Details',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12.0),
          if (_bankDetailsLoading)
            const Center(child: CircularProgressIndicator())
          else if (_hasBankDetails)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (_bankDetails?['bankName'] ?? 'Bank').toString(),
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Account: ${maskedAccount.isNotEmpty ? maskedAccount : 'Hidden'}',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 12.0),
                ButtonWidget(
                  buttonText: 'Update Your Bank Details',
                  buttonColor: const Color(0xFF667EEA),
                  textColor: Colors.white,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BankDetailsView(),
                      ),
                    );
                    await _loadEmployeeBankDetails();
                  },
                ),
              ],
            )
          else ...[
            if (_bankDetailsError != null)
              Text(
                _bankDetailsError!,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            const SizedBox(height: 8.0),
            const Text(
              'No bank details saved yet.',
              style: TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12.0),
            ButtonWidget(
              buttonText: 'Add Your Bank Details',
              buttonColor: const Color(0xFF667EEA),
              textColor: Colors.white,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BankDetailsView(),
                  ),
                );
                await _loadEmployeeBankDetails();
              },
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
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
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    16.0, 0.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your Appointments',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8.0),
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
                                  color: Color(0xFF1F2937),
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
                                        color: const Color(0xFF1F2937),
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
                      const SizedBox(height: 20.0),

                      // Employee Bank Details section (add/update)
                      const Text(
                        'Bank Details',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildEmployeeBankDetailsSection(),
                      const SizedBox(height: 20.0),

                      // Expense Management Section
                      const Text(
                        'Expense Management',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
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
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(12.0),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1.0,
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color:
                          //         const Color(0xFFD4D4D4).withOpacity(0.1),
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
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            ButtonWidget(
                              buttonText: "Open Expense Dashboard",
                              buttonColor: const Color(0xFF667EEA),
                              textColor: Colors.white,
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
                      const SizedBox(height: 20.0),

                      // Bank Details Configuration Section
                      // Show only for admin users as per requirement
                      if (ref.watch(userRoleProvider) == UserRole.admin) ...[
                        const Text(
                          'Bank Details Configuration',
                          style: TextStyle(
                            color: Color(0xFF1F2937),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBankDetailsConfiguration(),
                        const SizedBox(height: 20.0),
                      ],

                      ButtonWidget(
                        buttonText: "ClockIn",
                        buttonColor: Colors.white,
                        textColor: const Color(0xFF667EEA),
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
                      const SizedBox(height: 16.0),
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
