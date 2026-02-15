import 'dart:typed_data';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

import 'package:carenest/app/features/admin/views/bank_details_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

// Bauhaus Widgets
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/home/widgets/bauhaus_home_header.dart';
import 'package:carenest/app/features/home/widgets/bauhaus_action_card.dart';
import 'package:carenest/app/features/home/widgets/bauhaus_appointment_card.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/services/reminder/reminder_provider.dart';
import 'package:carenest/app/services/geofence/geofence_provider.dart';
import 'package:carenest/app/services/geofence/geofence_service.dart';
import 'package:carenest/app/features/requests/views/shift_exchange_view.dart';
import 'package:carenest/app/features/earnings/views/earnings_dashboard_view.dart';
import 'package:carenest/app/features/leave/views/leave_tracker_view.dart';
import 'package:carenest/app/features/training_compliance/views/training_compliance_hub_view.dart';
import 'package:carenest/app/features/mileage/views/mileage_tracker_view.dart';

// Employee Features
import 'package:carenest/app/features/notifications/views/notification_settings_view.dart';
import 'package:carenest/app/features/offline/views/offline_sync_dashboard.dart';

class HomeView extends ConsumerStatefulWidget {
  final String email;
  final Uint8List? photoData;
  final PersistentTabController? controller;
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;

  const HomeView({
    super.key,
    required this.email,
    this.photoData,
    this.controller,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    Uint8List? photoDataFromParent,
  });

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final PageController _pageController = PageController();
  late Future<dynamic> _appointmentDataFuture = Future.value(null);
  var eml;
  var initialData = {};
  var setAppointmentData;
  bool isDataFetched = false;

  // Bank details state
  bool _useAdminBankDetails = false;
  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(photoDataProvider.notifier).fetchPhotoData(widget.email);
    });
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final photoDataNotifier = ref.read(photoDataProvider.notifier);
      await photoDataNotifier.fetchPhotoData(widget.email);

      if (!isDataFetched) {
        await getInitData();
        isDataFetched = true;
      }
      await _loadEmployeeBankDetails();
      await _loadUseAdminPreference();

      setState(() {
        _appointmentDataFuture = getAppointmentData();
      });
    } catch (e) {
      debugPrint('Error initializing data: $e');
    }
  }

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

  Future<void> _loadUseAdminPreference() async {
    try {
      await _prefs.init();
      final stored =
          _prefs.getBool(SharedPreferencesUtils.kUseAdminBankDetailsKey);
      if (stored != null) {
        setState(() => _useAdminBankDetails = stored);
      }
    } catch (e) {
      debugPrint('Failed to load useAdminBankDetails preference: $e');
    }
  }

  Future<void> _persistUseAdminPreference(bool value) async {
    try {
      await _prefs.setBool(
          SharedPreferencesUtils.kUseAdminBankDetailsKey, value);
    } catch (e) {
      debugPrint('Failed to persist useAdminBankDetails preference: $e');
    }
  }

  Future<dynamic> getInitData() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      initialData = await apiMethod.getInitData(widget.email);
      setState(() {
        eml = initialData;
        isDataFetched = true;
      });
      return initialData;
    } catch (e) {
      debugPrint('Error fetching initial data: $e');
    }
  }

  Future<dynamic> getAppointmentData() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final now = DateTime.now();
      final appointmentData =
          (await apiMethod.getAppointmentData(widget.email)) as Map;

      if (appointmentData.containsKey('data') &&
          appointmentData['data'] is List) {
        final rawAssignments =
            List<Map<String, dynamic>>.from(appointmentData['data']);
        final appointments = <Map<String, dynamic>>[];

        for (var assignment in rawAssignments) {
          if (assignment['schedule'] != null &&
              assignment['schedule'] is List) {
            final scheduleList = assignment['schedule'] as List;

            // Find the closest FUTURE shift
            Map<String, dynamic>? nextUpcomingShift;
            DateTime? nextShiftDate;

            for (var shift in scheduleList) {
              final shiftDate =
                  _parseDateTime(shift['date'], shift['startTime']);
              if (shiftDate != null && shiftDate.isAfter(now)) {
                if (nextShiftDate == null ||
                    shiftDate.isBefore(nextShiftDate)) {
                  nextShiftDate = shiftDate;
                  nextUpcomingShift = shift;
                }
              }
            }

            // Only add if we have an upcoming shift
            if (nextUpcomingShift != null) {
              final newAssignment = Map<String, dynamic>.from(assignment);
              // Set the schedule to ONLY the next upcoming shift for the card display
              newAssignment['schedule'] = [nextUpcomingShift];
              appointments.add(newAssignment);
            }
          }
        }

        appointments.sort((firstAppointment, secondAppointment) {
          dynamic firstSchedule;
          dynamic secondSchedule;

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

          if (firstSchedule == null || secondSchedule == null) return 0;

          try {
            final firstAppointmentDateTime = _parseDateTime(
                firstSchedule['date'], firstSchedule['startTime']);
            final secondAppointmentDateTime = _parseDateTime(
                secondSchedule['date'], secondSchedule['startTime']);

            if (firstAppointmentDateTime == null ||
                secondAppointmentDateTime == null) {
              return 0;
            }

            return firstAppointmentDateTime
                .compareTo(secondAppointmentDateTime);
          } catch (e) {
            return 0;
          }
        });

        setState(() {
          setAppointmentData = {'data': appointments};
        });

        // Schedule shift reminders for upcoming appointments
        _scheduleAppointmentReminders(appointments);

        // Register geofences for client locations
        _registerGeofences(appointments);

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

  DateTime? _parseDateTime(dynamic date, dynamic time) {
    try {
      if (date == null || time == null) return null;

      String dateStr = date.toString().trim();
      String timeStr = time.toString().trim();

      DateTime parsedDate;
      if (dateStr.contains('-')) {
        parsedDate = DateTime.parse(dateStr);
      } else if (dateStr.contains('/')) {
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          parsedDate = DateTime(
              int.parse(parts[2]), int.parse(parts[0]), int.parse(parts[1]));
        } else {
          try {
            // Try DD/MM/YYYY fallback
            parsedDate = DateTime(
                int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
          } catch (e) {
            return null;
          }
        }
      } else {
        return null;
      }

      TimeOfDay parsedTime;
      if (timeStr.contains(':')) {
        final timeParts = timeStr.split(':');
        if (timeParts.length >= 2) {
          try {
            int hour = int.parse(timeParts[0].trim());
            String minutePart = timeParts[1].replaceAll(RegExp(r'[^0-9]'), '');
            int minute = minutePart.isNotEmpty ? int.parse(minutePart) : 0;

            if (timeStr.toUpperCase().contains('PM') && hour != 12) {
              hour += 12;
            } else if (timeStr.toUpperCase().contains('AM') && hour == 12) {
              hour = 0;
            }
            parsedTime = TimeOfDay(hour: hour, minute: minute);
          } catch (e) {
            return null;
          }
        } else {
          return null;
        }
      } else {
        return null;
      }

      return DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      return null;
    }
  }

  /// Schedule shift reminders for upcoming appointments.
  void _scheduleAppointmentReminders(List<Map<String, dynamic>> appointments) {
    try {
      final reminderScheduler = ref.read(reminderSchedulerProvider);

      for (final appointment in appointments) {
        // Extract schedule data
        final scheduleList = appointment['schedule'] as List?;
        if (scheduleList == null || scheduleList.isEmpty) continue;

        final schedule = scheduleList[0];
        final shiftStartTime =
            _parseDateTime(schedule['date'], schedule['startTime']);

        if (shiftStartTime == null) continue;

        // Extract client name
        final clientName = appointment['clientFirstName']?.toString() ??
            appointment['clientName']?.toString() ??
            'Client';

        // Extract appointment ID (try multiple possible fields)
        final appointmentId = appointment['_id']?.toString() ??
            appointment['id']?.toString() ??
            '${appointment.hashCode}';

        // Extract client address if available
        final clientAddress = appointment['clientAddress']?.toString();

        // Schedule reminders
        reminderScheduler.scheduleShiftReminders(
          appointmentId: appointmentId,
          clientName: clientName,
          shiftStartTime: shiftStartTime,
          userEmail: widget.email,
          clientAddress: clientAddress,
        );
      }

      debugPrint(
          'HomeView: Scheduled reminders for ${appointments.length} appointments');
    } catch (e) {
      debugPrint('HomeView: Error scheduling reminders: $e');
    }
  }

  /// Register geofences for upcoming appointments with valid location data
  Future<void> _registerGeofences(
      List<Map<String, dynamic>> appointments) async {
    try {
      final geofenceService = ref.read(geofenceServiceProvider);
      final isEnabled = await geofenceService.isGeofencingEnabled();

      if (!isEnabled) return;

      for (final appointment in appointments) {
        // Extract schedule data
        final scheduleList = appointment['schedule'] as List?;
        if (scheduleList == null || scheduleList.isEmpty) continue;

        final schedule = scheduleList[0];
        final shiftStartTime =
            _parseDateTime(schedule['date'], schedule['startTime']);

        if (shiftStartTime == null) continue;

        // Only register for upcoming shifts (e.g. within next 24 hours)
        final now = DateTime.now();
        if (shiftStartTime.isBefore(now) ||
            shiftStartTime.difference(now).inHours > 24) {
          continue;
        }

        // Extract location data
        final clientLat =
            double.tryParse(appointment['clientLatitude']?.toString() ?? '');
        final clientLng =
            double.tryParse(appointment['clientLongitude']?.toString() ?? '');

        if (clientLat == null || clientLng == null) continue;

        final clientId = appointment['clientId']?.toString() ?? '';
        final clientName = appointment['clientFirstName']?.toString() ??
            appointment['clientName']?.toString() ??
            'Client';
        final appointmentId = appointment['_id']?.toString() ??
            appointment['id']?.toString() ??
            '';

        await geofenceService.registerGeofence(GeofenceLocation(
          clientId: clientId,
          clientName: clientName,
          latitude: clientLat,
          longitude: clientLng,
          appointmentId: appointmentId,
          shiftStartTime: shiftStartTime,
        ));
      }

      // If we have geofences and enabled, ensure monitoring is active
      if (geofenceService.activeGeofences.isNotEmpty &&
          !geofenceService.isMonitoring) {
        // Initialize monitoring if not already active
        initializeGeofenceMonitoring(ref);
      }
    } catch (e) {
      debugPrint('Error registering geofences: $e');
    }
  }

  Future<void> _refreshData() async {
    try {
      if (mounted) {
        setState(() {
          isDataFetched = false;
        });
      }
      await _initializeData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data refreshed')),
        );
      }
    } catch (e) {
      debugPrint('Error refreshing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Current user's name logic
    String displayUserName = 'User';
    if (eml != null && eml is Map) {
      displayUserName = eml['firstName'] ?? 'User';
    }

    final photoDataState = ref.watch(photoDataProvider);
    final photoData = photoDataState.photoData;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/grid_pattern.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: _refreshData,
            color: BauhausDesign.primary,
            backgroundColor: BauhausDesign.surfaceWhite,
            strokeWidth: 3,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Bold Bauhaus Header
                  BauhausHomeHeader(
                    userName: displayUserName,
                    organizationName: widget.organizationName,
                    photoData: photoData ?? widget.photoData,
                    onRefresh: _refreshData,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- APPOINTMENTS ---
                        BauhausSectionHeader(
                            title:
                                AppLocalizations.of(context)!.upcomingShifts),
                        const SizedBox(height: 16),

                        FutureBuilder<dynamic>(
                          future: _appointmentDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return _buildBauhausSkeleton();
                            }

                            final data = setAppointmentData?['data'] as List?;
                            if (data == null || data.isEmpty) {
                              return BauhausEmptyState(
                                title: AppLocalizations.of(context)!
                                    .noUpcomingAppointments,
                                message: AppLocalizations.of(context)!
                                    .noUpcomingShiftsMessage,
                                icon: Icons.calendar_today_outlined,
                              );
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                final appointment = data[index];
                                final clientEmail = appointment['clientEmail'];

                                return BauhausAppointmentCard(
                                  appointment: appointment,
                                  onTap: () {
                                    if (clientEmail != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClientAndAppointmentDetails(
                                            userEmail: widget.email,
                                            clientEmail: clientEmail,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 48),

                        // --- QUICK ACTIONS ---
                        BauhausSectionHeader(
                            title: AppLocalizations.of(context)!.quickActions),
                        const SizedBox(height: 16),

                        // Clock In Action
                        BauhausActionCard(
                          title: AppLocalizations.of(context)!.timeClock,
                          description:
                              AppLocalizations.of(context)!.timeClockDesc,
                          icon: Icons.timer_outlined,
                          baseColor: BauhausDesign.success,
                          actionLabel: AppLocalizations.of(context)!.open,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClockInAndOutView(
                                  email: widget.email,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Leave Tracker
                        BauhausActionCard(
                          title: AppLocalizations.of(context)!.leaveTracker,
                          description:
                              AppLocalizations.of(context)!.leaveTrackerDesc,
                          icon: Icons.flight_takeoff,
                          baseColor: BauhausDesign.secondary,
                          actionLabel: AppLocalizations.of(context)!.open,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveTrackerView(
                                  userEmail: widget.email,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Training & Compliance Action
                        BauhausActionCard(
                          title:
                              AppLocalizations.of(context)!.trainingCompliance,
                          description: AppLocalizations.of(context)!
                              .trainingComplianceDesc,
                          icon: Icons.school_outlined,
                          baseColor: BauhausDesign.warning,
                          actionLabel: AppLocalizations.of(context)!.openHub,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TrainingComplianceHubView(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // Expense Action
                        BauhausActionCard(
                          title: AppLocalizations.of(context)!.trackExpenses,
                          description:
                              AppLocalizations.of(context)!.trackExpensesDesc,
                          icon: Icons.receipt_long_outlined,
                          baseColor: BauhausDesign.secondary,
                          actionLabel:
                              AppLocalizations.of(context)!.openDashboard,
                          onTap: () {
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

                        const SizedBox(height: 24),

                        // Shift Exchange Action
                        BauhausActionCard(
                          title: AppLocalizations.of(context)!.shiftExchange,
                          description:
                              AppLocalizations.of(context)!.shiftExchangeDesc,
                          icon: Icons
                              .swap_horiz_outlined, // or Icons.local_offer_outlined
                          baseColor:
                              BauhausDesign.primary, // Red/Primary for action
                          actionLabel: AppLocalizations.of(context)!.viewOffers,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShiftExchangeView(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // Mileage Tracker Action
                        BauhausActionCard(
                          title: AppLocalizations.of(context)!.mileageTracker,
                          description:
                              AppLocalizations.of(context)!.mileageTrackerDesc,
                          icon: Icons.route_outlined,
                          baseColor:
                              BauhausDesign.accent, // Yellow for distinction
                          actionLabel:
                              AppLocalizations.of(context)!.startTracking,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MileageTrackerView(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // Earnings Dashboard Action
                        BauhausActionCard(
                          title: AppLocalizations.of(context)!.earnings,
                          description:
                              AppLocalizations.of(context)!.earningsDesc,
                          icon: Icons.monetization_on_outlined,
                          baseColor: const Color(0xFF4CAF50), // Green
                          actionLabel:
                              AppLocalizations.of(context)!.viewEarnings,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EarningsDashboardView(
                                  organizationId: widget.organizationId,
                                  organizationName: widget.organizationName,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 48),

                        // --- PERSONAL SETTINGS ---
                        BauhausSectionHeader(
                            title: 'Personal Settings'),
                        const SizedBox(height: 16),

                        // Notification Settings
                        BauhausActionCard(
                          title: 'Smart Notifications',
                          description: 'Configure geofence alerts, quiet hours, and notification preferences',
                          icon: Icons.notifications_active_outlined,
                          baseColor: BauhausDesign.warning,
                          actionLabel: 'Settings',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationSettingsView(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Offline Mode
                        BauhausActionCard(
                          title: 'Offline Mode',
                          description: 'Work offline and sync your personal data when online',
                          icon: Icons.cloud_off_outlined,
                          baseColor: BauhausDesign.secondary,
                          actionLabel: 'Open',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OfflineSyncDashboard(
                                  userId: widget.email,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 48),

                        // --- BANKING DETAILS ---
                        BauhausSectionHeader(
                            title:
                                AppLocalizations.of(context)!.bankingPayouts),
                        const SizedBox(height: 16),

                        // Styled Bank Configuration Panel (The Admin/Employee Toggle)
                        BauhausCard(
                          child: Column(
                            children: [
                              // Header
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.primary.withOpacity(0.1),
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: BauhausDesign.textDark,
                                          width: 2)),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .selectBankDetails
                                      .toUpperCase(),
                                  style: BauhausDesign.getTextTheme(context)
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              // Content
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    if (!_hasBankDetails)
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        margin:
                                            const EdgeInsets.only(bottom: 16),
                                        decoration: BoxDecoration(
                                          color: BauhausDesign.neutral
                                              .withOpacity(0.1),
                                          border: Border.all(
                                              color: BauhausDesign.neutral),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.info_outline,
                                                size: 20,
                                                color: BauhausDesign.neutral),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .bankDetailsNotSet,
                                                style:
                                                    BauhausDesign.getTextTheme(
                                                            context)
                                                        .bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    // Custom Radio Options
                                    _buildBauhausRadioOption(
                                      label: AppLocalizations.of(context)!
                                          .employeeBankDetails,
                                      subLabel: AppLocalizations.of(context)!
                                          .employeeBankDetailsDesc,
                                      value: false,
                                      groupValue: _useAdminBankDetails,
                                      onChanged: (val) async {
                                        setState(
                                            () => _useAdminBankDetails = false);
                                        await _persistUseAdminPreference(false);
                                      },
                                    ),
                                    const Divider(
                                        height: 24,
                                        thickness: 1,
                                        color: BauhausDesign.neutral),
                                    _buildBauhausRadioOption(
                                      label: AppLocalizations.of(context)!
                                          .adminBankDetails,
                                      subLabel: AppLocalizations.of(context)!
                                          .adminBankDetailsDesc,
                                      value: true,
                                      groupValue: _useAdminBankDetails,
                                      onChanged: (val) async {
                                        setState(
                                            () => _useAdminBankDetails = true);
                                        await _persistUseAdminPreference(true);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Employee Bank Details Card (View/Edit)
                        _buildBauhausEmployeeBankCard(),

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBauhausRadioOption({
    required String label,
    required String subLabel,
    required bool value,
    required bool groupValue,
    required Function(bool?) onChanged,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Radio Circle
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? BauhausDesign.primary
                      : BauhausDesign.neutral,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: BauhausDesign.primary,
                            shape: BoxShape.circle),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? BauhausDesign.textDark
                              : BauhausDesign.neutral,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subLabel,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.neutral,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBauhausEmployeeBankCard() {
    String maskedAccount = 'Hidden';
    String bankName = 'Bank Name';

    if (_bankDetails != null && (_bankDetails!['accountNumber'] is String)) {
      final acc = (_bankDetails!['accountNumber'] as String).trim();
      if (acc.isNotEmpty) {
        final last4 = acc.length >= 4 ? acc.substring(acc.length - 4) : acc;
        maskedAccount = '•••• •••• $last4';
      }
      bankName = (_bankDetails?['bankName'] ?? 'Bank').toString();
    }

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: BauhausDesign.textDark, // Black Header
              border: Border(
                  bottom: BorderSide(color: BauhausDesign.textDark, width: 0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.primaryAccount.toUpperCase(),
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.surfaceWhite,
                          ),
                ),
                const Icon(Icons.account_balance,
                    color: BauhausDesign.surfaceWhite, size: 18),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: _bankDetailsLoading
                ? const Center(child: BauhausLoadingState(showMessage: false))
                : !_hasBankDetails
                    ? Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.noBankDetails,
                            style:
                                BauhausDesign.getTextTheme(context).bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: BauhausActionButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BankDetailsView()),
                                );
                                await _loadEmployeeBankDetails();
                              },
                              text: AppLocalizations.of(context)!
                                  .addBankDetails
                                  .toUpperCase(),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bankName.toUpperCase(),
                            style: BauhausDesign.getTextTheme(context)
                                .headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            maskedAccount,
                            style: BauhausDesign.getTextTheme(context)
                                .labelMedium
                                ?.copyWith(
                                  color: BauhausDesign.neutral,
                                ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: BauhausActionButton(
                              variant: BauhausActionVariant.ghost,
                              isOutlined: true,
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BankDetailsView()),
                                );
                                await _loadEmployeeBankDetails();
                              },
                              icon: Icons.edit,
                              text: AppLocalizations.of(context)!
                                  .updateBankDetails
                                  .toUpperCase(),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildBauhausSkeleton() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral.withOpacity(0.3)),
      ),
      child: const Center(
        child: BauhausLoadingState(showMessage: false),
      ),
    );
  }
}
