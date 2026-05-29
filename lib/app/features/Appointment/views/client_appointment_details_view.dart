import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/core/services/navigation_service.dart';
import 'package:carenest/app/shared/utils/navigation_helper.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import '../../notes/views/add_notes_view.dart';
import 'package:carenest/app/features/Appointment/widgets/shift_selection_dialog.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:google_fonts/google_fonts.dart';

const int kTimerDurationInSeconds = 8 * 60 * 60; // 8 hours

class ClientAndAppointmentDetails extends ConsumerStatefulWidget {
  final String userEmail;
  final String clientEmail;
  final PersistentTabController? controller;

  const ClientAndAppointmentDetails({
    super.key,
    required this.userEmail,
    required this.clientEmail,
    this.controller,
  });

  @override
  ConsumerState<ClientAndAppointmentDetails> createState() =>
      _ClientAndAppointmentDetailsState();
}

class _ClientAndAppointmentDetailsState
    extends ConsumerState<ClientAndAppointmentDetails>
    with TickerProviderStateMixin {
  late final PersistentTabController controller;
  late final ApiMethod apiMethod;
  var setClientAndAppointmentData;
  var clientAndAppointmentData = {};
  late Future<List<Patient>> futureClientsData;
  late final TimerService timerModel;
  bool isCurrentClient = true;
  bool isInitCompleted = false;
  Map<String, dynamic>? _clientDetails;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _timerPulseController;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _timerPulseAnimation;

  Map<String, dynamic>? get clientDetails => _clientDetails;

  set clientDetails(Map<String, dynamic>? value) {
    _clientDetails = value;
  }

  @override
  void initState() {
    super.initState();
    apiMethod = ref.read(apiMethodProvider);
    _setupAnimations();
    timerModel = ref.read(timerServiceProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncTimerWithServer();
      if (timerModel.getTimerClientEmail() != widget.clientEmail ||
          !timerModel.isRunning) {
        timerModel.resetTimer(widget.clientEmail);
      }
    });

    getAppointmentData().then((_) {
      setState(() {
        isInitCompleted = true;
        clientDetails =
            clientAndAppointmentData['data']?['clientDetails']?.isNotEmpty ==
                true
            ? clientAndAppointmentData['data']!['clientDetails'][0]
            : null;
      });
      _startAnimations();
    });
  }

  Future<void> _syncTimerWithServer() async {
    final timerService = ref.read(timerServiceProvider);
    final response = await apiMethod.getTimerStatus(widget.userEmail);

    if (response['success'] && response['isRunning']) {
      final serverTimer = response['timer'];
      final startTime = DateTime.parse(serverTimer['startTime']);
      final currentTime = DateTime.now();
      final elapsedSeconds = currentTime.difference(startTime).inSeconds;

      timerService.setTimerClientEmail(serverTimer['clientEmail']);
      timerService.setElapsedSeconds(elapsedSeconds);
      if (!timerService.isRunning) {
        timerService.start();
      }
    } else {
      timerService.stop();
    }
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _timerPulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _timerPulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _timerPulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _scaleController.forward();
    });
    _timerPulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _timerPulseController.dispose();
    super.dispose();
  }

  Future<void> updateTimerModel() async {
    if (timerModel.isRunning &&
        timerModel.getTimerClientEmail().contains(
          widget.clientEmail.toString(),
        )) {
      debugPrint(
        "1 : ${widget.clientEmail} : ${timerModel.getTimerClientEmail()}",
      );
      //_stopTimer();
      timerModel.stop();
      timerModel.setTimerClientEmail(widget.clientEmail);
    } else if (timerModel.isRunning &&
        (widget.clientEmail != timerModel.getTimerClientEmail())) {
      debugPrint("2");
      return;
    } else {
      debugPrint(
        "3: ${widget.clientEmail} : ${clientAndAppointmentData['data']?['clientDetails'][0]?['clientEmail']}",
      );
      timerModel.start();
      // await _startTimer();
      timerModel.setTimerClientEmail(widget.clientEmail);
    }
  }

  Future<dynamic> getAppointmentData() async {
    clientAndAppointmentData =
        (await apiMethod.getClientAndAppointmentData(
              widget.userEmail,
              widget.clientEmail,
            ))
            as Map;
    setState(() {
      debugPrint(
        "Clinet Email: ${widget.clientEmail} "
        "${clientAndAppointmentData['data']?['clientDetails'][0]}",
      );
      setClientAndAppointmentData = clientAndAppointmentData;
      isCurrentClient =
          (clientAndAppointmentData['data']?['clientDetails'][0]?['clientEmail'] ==
          widget.clientEmail);
    });
    debugPrint("client apt det: $clientAndAppointmentData");
    return clientAndAppointmentData;
  }

  Future<dynamic> _startTimer(TimerService timerService) async {
    // Check if another timer is already running
    if (!timerService.canStartTimer(widget.userEmail, widget.clientEmail)) {
      final activeTimer = timerService.getActiveTimerInfo();
      _showTimerConflictDialog(
        activeTimer['userEmail'],
        activeTimer['clientEmail'],
      );
      return false;
    }

    try {
      // Get organizationId from SharedPreferences
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final organizationId = sharedPrefs.getString('organizationId');

      await apiMethod.startTimer(
        userEmail: widget.userEmail,
        clientEmail: widget.clientEmail,
        organizationId: organizationId,
      );

      // Start the surface-persistent timer
      final success = await timerService.startTimer(
        widget.userEmail,
        widget.clientEmail,
      );

      if (success) {
        debugPrint(
          "Timer started successfully for ${widget.userEmail} - ${widget.clientEmail}",
        );
        return true;
      } else {
        debugPrint("Failed to start timer - another timer is running");
        return false;
      }
    } catch (e) {
      debugPrint("Error starting timer: $e");
      return false;
    }
  }

  Future<void> _stopTimer(TimerService timerService) async {
    try {
      // Get organizationId from SharedPreferences
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final organizationId = sharedPrefs.getString('organizationId');

      var stopTime = await apiMethod.stopTimer(
        userEmail: widget.userEmail,
        organizationId: organizationId,
      );
      await timerService.stopTimer();
      debugPrint("Timer stopped successfully");
    } catch (e) {
      debugPrint("Error stopping timer: $e");
    }
  }

  void _showTimerConflictDialog(
    String? activeUserEmail,
    String? activeClientEmail,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardLg],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TIMER ALREADY RUNNING',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: BauhausDesign.primary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  'A timer is already running for:\n'
                  'User: ${activeUserEmail ?? 'Unknown'}\n'
                  'Client: ${activeClientEmail ?? 'Unknown'}\n\n'
                  'Please stop the current timer before starting a new one.',
                  style: GoogleFonts.inter(
                    color: BauhausDesign.textDark,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space5),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BauhausDesign.neutral,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                    boxShadow: const [BauhausDesign.shadowHardSm],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _setWorkedTime({int? elapsedSeconds}) async {
    final int seconds = elapsedSeconds ?? timerModel.elapsedSeconds;
    final formattedTime = _formatTime(seconds);
    bool success = false;
    bool shouldRetry = true;

    while (shouldRetry && !success) {
      try {
        // Get fresh data before showing dialog
        await _loadClientData();

        if (clientAndAppointmentData['data'] == null ||
            clientAndAppointmentData['data']['assignedClient'] == null) {
          throw Exception('No client data available');
        }

        final selectedShiftIndex = await showShiftSelectionDialog(
          context,
          clientAndAppointmentData['data']['assignedClient'],
          widget.clientEmail,
        );

        if (selectedShiftIndex == null) {
          // User cancelled shift selection. Ask if they want to resume the timer or exit.
          final resume = await _showResumeTimerDialog();
          if (resume == true) {
            await _resumeTimer(seconds);
          }
          return; // Exit setWorkedTime flow
        }

        // Extract shift details
        final assignedClient =
            clientAndAppointmentData['data']['assignedClient'];
        Map<String, dynamic>? currentClient;
        if (assignedClient is List) {
          final found = assignedClient.firstWhere(
            (c) => c['clientEmail'] == widget.clientEmail,
            orElse: () => null,
          );
          if (found != null) {
            currentClient = Map<String, dynamic>.from(found);
          }
        } else if (assignedClient is Map) {
          currentClient = Map<String, dynamic>.from(assignedClient);
        }

        if (currentClient == null) {
          throw Exception('Client details not found');
        }

        String? shiftDate;
        String? shiftStartTime;
        String? shiftEndTime;
        dynamic shiftBreak;

        if (currentClient['schedule'] != null &&
            currentClient['schedule'] is List) {
          final scheduleList = currentClient['schedule'] as List;
          if (selectedShiftIndex >= 0 &&
              selectedShiftIndex < scheduleList.length) {
            final schedule = scheduleList[selectedShiftIndex];
            shiftDate = schedule['date'];
            shiftStartTime = schedule['startTime'];
            shiftEndTime = schedule['endTime'];
            shiftBreak = schedule['break'];
          }
        } else {
          // Fallback to legacy format
          List<dynamic> dates = currentClient['dateList'] ?? [];
          List<dynamic> startTimes = currentClient['startTimeList'] ?? [];
          List<dynamic> endTimes = currentClient['endTimeList'] ?? [];
          List<dynamic> breaks = currentClient['breakList'] ?? [];

          if (selectedShiftIndex >= 0 && selectedShiftIndex < dates.length) {
            shiftDate = dates[selectedShiftIndex]?.toString();
            shiftStartTime = startTimes[selectedShiftIndex]?.toString();
            shiftEndTime = endTimes[selectedShiftIndex]?.toString();
            shiftBreak = breaks[selectedShiftIndex];
          }
        }

        // Confirm details with user first
        final confirmChoice = await _showConfirmShiftDialog({
          'date': shiftDate,
          'startTime': shiftStartTime,
          'endTime': shiftEndTime,
          'break': shiftBreak,
        });

        if (confirmChoice == 'cancel') {
          // Keep timer running
          return;
        } else if (confirmChoice == 'reselect') {
          continue; // Loop back to shift selection
        }

        // If confirmed, stop the timer first!
        await _stopTimer(timerModel);

        final response = await apiMethod.setWorkedTime(
          widget.userEmail,
          widget.clientEmail,
          formattedTime,
          selectedShiftIndex,
          shiftDate: shiftDate,
          shiftStartTime: shiftStartTime,
          shiftEndTime: shiftEndTime,
          shiftBreak: shiftBreak,
        );

        if (response != null) {
          success = true;
          // Update local data with response
          setState(() {
            if (response is Map) {
              clientAndAppointmentData = response;
            } else {
              _loadClientData();
            }
          });

          await _loadClientData();

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Time updated successfully')),
            );
          }
        }
      } catch (e) {
        debugPrint('Error in _setWorkedTime: $e');

        if (mounted) {
          final choice = await _showInvalidShiftDialog(e.toString());
          if (choice == 'reselect') {
            shouldRetry = true;
          } else if (choice == 'resume') {
            shouldRetry = false;
            await _resumeTimer(seconds);
          } else {
            shouldRetry = false;
          }
        } else {
          shouldRetry = false;
        }
      }
    }
  }

  Future<void> _resumeTimer(int seconds) async {
    try {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      final organizationId = sharedPrefs.getString('organizationId');

      // Start the timer on backend
      await apiMethod.startTimer(
        userEmail: widget.userEmail,
        clientEmail: widget.clientEmail,
        organizationId: organizationId,
      );

      // Start the timer locally with the subtract duration to maintain correct elapsed seconds
      final success = await timerModel.startTimer(
        widget.userEmail,
        widget.clientEmail,
        startTime: DateTime.now().subtract(Duration(seconds: seconds)),
      );

      if (success) {
        timerModel.setTimerClientEmail(widget.clientEmail);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Timer resumed successfully')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error resuming timer: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error resuming timer: $e')));
      }
    }
  }

  Future<String?> _showConfirmShiftDialog(Map<String, dynamic> shift) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardLg],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONFIRM SHIFT ASSOCIATION',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: BauhausDesign.secondary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  'Are you sure you want to end your shift and link it to this scheduled shift?\n\n'
                  'Date: ${shift['date']}\n'
                  'Time: ${shift['startTime']} - ${shift['endTime']}\n'
                  'Break: ${shift['break'] ?? 'None'}',
                  style: GoogleFonts.inter(
                    color: BauhausDesign.textDark,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.success,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop('confirm'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'CONFIRM',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.accent,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop('reselect'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'RE-SELECT',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                    boxShadow: const [BauhausDesign.shadowHardSm],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop('cancel'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'CANCEL & KEEP TIMER RUNNING',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool?> _showResumeTimerDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardLg],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RESUME TIMER?',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: BauhausDesign.primary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  'You cancelled ending the shift. Do you want to resume the timer where it left off?',
                  style: GoogleFonts.inter(
                    color: BauhausDesign.textDark,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.success,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(true),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'RESUME TIMER',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceOffWhite,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(false),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'DISCARD TIMER',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showInvalidShiftDialog(String errorMessage) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardLg],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SHIFT DETAILS INVALID',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: BauhausDesign.primary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  'Selected shift is invalid.\n\nError: $errorMessage\n\n'
                  'Please select the correct shift, or resume the timer.',
                  style: GoogleFonts.inter(
                    color: BauhausDesign.textDark,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space5),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BauhausDesign.accent,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                    boxShadow: const [BauhausDesign.shadowHardSm],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop('reselect'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'RE-SELECT CORRECT SHIFT',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.success,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop('resume'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'RESUME TIMER',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceOffWhite,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop('cancel'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'DISCARD TIMER',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Update the _loadClientData method to handle errors better
  Future<void> _loadClientData() async {
    try {
      final response = await apiMethod.getClientAndAppointmentData(
        widget.userEmail,
        widget.clientEmail,
      );

      if (mounted) {
        setState(() {
          if (response != null && response is Map) {
            clientAndAppointmentData = response;
            // Also update clientDetails if needed
            clientDetails =
                clientAndAppointmentData['data']?['clientDetails']
                        ?.isNotEmpty ==
                    true
                ? clientAndAppointmentData['data']!['clientDetails'][0]
                : null;
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading client data: $e');
      // Don't throw the error, just log it
    }
  }

  Future<void> _showSwapOfferDialog(Map<String, dynamic> shift) async {
    final reasonController = TextEditingController();
    String urgency = 'Medium';
    String? error;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardLg],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OFFER SHIFT SWAP',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: BauhausDesign.neutral,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  '${shift['date']} (${shift['startTime']} - ${shift['endTime']})',
                  style: GoogleFonts.robotoMono(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: BauhausDesign.neutral,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                DropdownButtonFormField<String>(
                  value: urgency,
                  dropdownColor: BauhausDesign.surfaceWhite,
                  iconEnabledColor: BauhausDesign.neutral,
                  style: GoogleFonts.roboto(
                    color: BauhausDesign.textDark,
                    fontSize: 14,
                  ),
                  decoration: BauhausDesign.inputDecoration('Urgency').copyWith(
                    labelText: 'URGENCY',
                    labelStyle: GoogleFonts.oswald(
                      color: BauhausDesign.neutral,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                  items: ['Low', 'Medium', 'High']
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.roboto(
                              color: BauhausDesign.textDark,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => urgency = v!),
                ),
                const SizedBox(height: BauhausDesign.space3),
                TextField(
                  controller: reasonController,
                  decoration: BauhausDesign.inputDecoration('Reason').copyWith(
                    labelText: 'REASON',
                    labelStyle: GoogleFonts.oswald(
                      color: BauhausDesign.neutral,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                  maxLines: 2,
                ),
                if (error != null) ...[
                  const SizedBox(height: BauhausDesign.space2),
                  Text(
                    error!,
                    style: const TextStyle(color: BauhausDesign.error),
                  ),
                ],
                const SizedBox(height: BauhausDesign.space5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceWhite,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'CANCEL',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.neutral,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              final sharedPrefs = SharedPreferencesUtils();
                              await sharedPrefs.init();
                              final organizationId = sharedPrefs.getString(
                                'organizationId',
                              );
                              final userId =
                                  sharedPrefs.getString('userId') ??
                                  widget.userEmail;

                              if (organizationId == null) {
                                setState(
                                  () => error = 'Organization ID not found',
                                );
                                return;
                              }

                              final details = {
                                'date': shift['date'],
                                'startTime': shift['startTime'],
                                'endTime': shift['endTime'],
                                'break': shift['break'],
                                'clientName':
                                    '${clientDetails?['clientFirstName'] ?? ''} ${clientDetails?['clientLastName'] ?? ''}'
                                        .trim(),
                                'clientEmail': widget.clientEmail,
                                'reason': reasonController.text,
                                'urgency': urgency,
                              };

                              if (shift['ndisItem'] != null) {
                                details['ndisItem'] = shift['ndisItem'];
                              }

                              Navigator.pop(context);

                              try {
                                final response = await apiMethod
                                    .createSwapOffer(
                                      organizationId: organizationId,
                                      userId: userId,
                                      userEmail: widget.userEmail,
                                      details: details,
                                    );

                                if (response['success'] == true) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Swap offer created!'),
                                      ),
                                    );
                                  }
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed: ${response['message']}',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                debugPrint('Error creating swap: $e');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'OFFER',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oswald(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCell(Map<String, dynamic> shift) {
    bool isPast = false;
    final dateStr = shift['date'];
    if (dateStr != null) {
      try {
        final shiftDate = DateTime.parse(dateStr);
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        isPast = shiftDate.isBefore(today);
      } catch (_) {}
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: BauhausDesign.space2,
        horizontal: BauhausDesign.space1,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isPast ? Colors.grey[200] : BauhausDesign.accent,
          border: Border.all(
            color: isPast ? BauhausDesign.textMuted : BauhausDesign.neutral,
            width: 1.5,
          ),
          boxShadow: isPast ? null : const [BauhausDesign.shadowHardXs],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isPast ? null : () => _showSwapOfferDialog(shift),
            child: Icon(
              Icons.swap_horiz,
              color: isPast ? BauhausDesign.textMuted : BauhausDesign.neutral,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: BauhausDesign.space5),
          Text(
            'LOADING APPOINTMENT DETAILS...',
            style: GoogleFonts.oswald(
              color: BauhausDesign.neutral,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> _buildTableRows() {
    List<TableRow> rows = [];

    debugPrint('Building table rows for client: ${widget.clientEmail}');

    // Add the heading with modern styling
    rows.add(
      TableRow(
        decoration: BoxDecoration(
          color: BauhausDesign.primary.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(BauhausDesign.radiusSm),
            topRight: Radius.circular(BauhausDesign.radiusSm),
          ),
        ),
        children: [
          _buildTableHeader("Date"),
          _buildTableHeader("Start"),
          _buildTableHeader("End"),
          _buildTableHeader("Break"),
          _buildTableHeader("Swap"),
        ],
      ),
    );

    // Check if assignedClient exists and has schedule data
    if (clientAndAppointmentData['data'] != null &&
        clientAndAppointmentData['data']['assignedClient'] != null) {
      final assignedClient = clientAndAppointmentData['data']['assignedClient'];

      // Handle both new format (schedule array) and legacy format (individual arrays)
      if (assignedClient['schedule'] != null &&
          assignedClient['schedule'] is List) {
        // New format with schedule array
        final scheduleList = assignedClient['schedule'] as List;
        for (int i = 0; i < scheduleList.length; i++) {
          final schedule = scheduleList[i];
          rows.add(
            _buildTableRow(
              schedule['date'] ?? 'N/A',
              schedule['startTime'] ?? 'N/A',
              schedule['endTime'] ?? 'N/A',
              schedule['break'] ?? 'N/A',
              i,
              schedule is Map<String, dynamic>
                  ? schedule
                  : Map<String, dynamic>.from(schedule),
            ),
          );
        }
      } else {
        // Legacy format with separate arrays
        final dateList = assignedClient['dateList'] as List? ?? [];
        final startTimeList = assignedClient['startTimeList'] as List? ?? [];
        final endTimeList = assignedClient['endTimeList'] as List? ?? [];
        final breakList = assignedClient['breakList'] as List? ?? [];

        final maxLength = [
          dateList.length,
          startTimeList.length,
          endTimeList.length,
          breakList.length,
        ].reduce((a, b) => a > b ? a : b);

        for (int i = 0; i < maxLength; i++) {
          final scheduleMap = {
            'date': i < dateList.length ? dateList[i].toString() : 'N/A',
            'startTime': i < startTimeList.length
                ? startTimeList[i].toString()
                : 'N/A',
            'endTime': i < endTimeList.length
                ? endTimeList[i].toString()
                : 'N/A',
            'break': i < breakList.length ? breakList[i].toString() : 'N/A',
          };
          rows.add(
            _buildTableRow(
              scheduleMap['date']!,
              scheduleMap['startTime']!,
              scheduleMap['endTime']!,
              scheduleMap['break']!,
              i,
              scheduleMap,
            ),
          );
        }
      }
    }

    return rows;
  }

  Widget _buildTableHeader(String title) {
    return Container(
      color: BauhausDesign.neutral,
      padding: const EdgeInsets.symmetric(
        vertical: BauhausDesign.space3,
        horizontal: BauhausDesign.space1,
      ),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.center,
        style: GoogleFonts.oswald(
          fontWeight: FontWeight.bold,
          color: BauhausDesign.surfaceWhite,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    String date,
    String startTime,
    String endTime,
    String breakTime,
    int index,
    Map<String, dynamic> schedule,
  ) {
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven
            ? BauhausDesign.backgroundLight
            : BauhausDesign.surfaceWhite,
      ),
      children: [
        _buildTableCell(date),
        _buildTableCell(startTime),
        _buildTableCell(endTime),
        _buildTableCell(breakTime),
        _buildActionCell(schedule),
      ],
    );
  }

  Widget _buildTableCell(String content) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: BauhausDesign.space3,
        horizontal: BauhausDesign.space2,
      ),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoMono(
          fontSize: 12,
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContent(TimerService timerService, bool isCurrentClientTimer) {
    if (clientAndAppointmentData['data'] == null) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(BauhausDesign.space6),
          padding: const EdgeInsets.all(BauhausDesign.space5),
          decoration: BauhausDesign.cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withOpacity(0.1),
                  border: Border.all(color: BauhausDesign.primary, width: 2),
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: BauhausDesign.primary,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'NO CLIENT DATA FOUND',
                style: GoogleFonts.oswald(
                  color: BauhausDesign.neutral,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final clientDetailsList =
        clientAndAppointmentData['data']['clientDetails'] as List?;
    final clientData =
        (clientDetailsList != null && clientDetailsList.isNotEmpty)
        ? clientDetailsList[0]
        : null;

    if (clientData == null) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(BauhausDesign.space6),
          padding: const EdgeInsets.all(BauhausDesign.space5),
          decoration: BauhausDesign.cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withOpacity(0.1),
                  border: Border.all(color: BauhausDesign.primary, width: 2),
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: BauhausDesign.primary,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'NO CLIENT DETAILS FOUND',
                style: GoogleFonts.oswald(
                  color: BauhausDesign.neutral,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Client Info Card
                _buildClientInfoCard(clientData),
                const SizedBox(height: BauhausDesign.space6),

                // Preferences & Care Notes
                _buildPreferencesCard(clientData),
                const SizedBox(height: BauhausDesign.space6),

                // Schedule Table Card
                _buildScheduleCard(),
                const SizedBox(height: BauhausDesign.space6),

                // Visit History
                _buildHistoryCard(timerService),
                const SizedBox(height: BauhausDesign.space6),

                // Timer Section
                _buildTimerSection(timerService),
                const SizedBox(height: BauhausDesign.space6),

                // Action Buttons
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreferencesCard(Map<String, dynamic> clientData) {
    final preferences =
        clientData['preferences'] as Map<String, dynamic>? ?? {};
    final careNotes = clientData['careNotes'] as String? ?? '';

    if (preferences.isEmpty && careNotes.isEmpty) {
      return const SizedBox.shrink();
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BauhausDesign.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.secondary,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: BauhausDesign.surfaceWhite,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PREFERENCES & CARE',
                          style: GoogleFonts.oswald(
                            color: BauhausDesign.neutral,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          'Important client needs',
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space5),
              if (careNotes.isNotEmpty)
                _buildInfoRow(Icons.medical_services, 'Care Notes', careNotes),
              ...preferences.entries.map(
                (e) => _buildInfoRow(
                  Icons.star_outline,
                  e.key.toUpperCase(),
                  e.value.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, int>? _parseTimeOfDay(String timeStr) {
    try {
      final cleanTime = timeStr.trim().toUpperCase();
      int hour = 0;
      int minute = 0;

      if (cleanTime.contains('AM') || cleanTime.contains('PM')) {
        final parts = cleanTime
            .replaceAll(RegExp(r'[A-Z]'), '')
            .trim()
            .split(':');
        hour = int.parse(parts[0]);
        minute = parts.length > 1 ? int.parse(parts[1]) : 0;
        if (cleanTime.contains('PM') && hour < 12) {
          hour += 12;
        } else if (cleanTime.contains('AM') && hour == 12) {
          hour = 0;
        }
      } else {
        final parts = cleanTime.split(':');
        hour = int.parse(parts[0]);
        minute = parts.length > 1 ? int.parse(parts[1]) : 0;
      }
      return {'hour': hour, 'minute': minute};
    } catch (_) {
      return null;
    }
  }

  DateTime? getShiftEndDateTime(
    String dateStr,
    String? endTimeStr,
    String? startTimeStr,
  ) {
    try {
      final shiftDate = DateTime.parse(dateStr);
      if (endTimeStr == null) return null;

      final endParts = _parseTimeOfDay(endTimeStr);
      if (endParts == null) return null;

      var endDateTime = DateTime(
        shiftDate.year,
        shiftDate.month,
        shiftDate.day,
        endParts['hour']!,
        endParts['minute']!,
      );

      // Check if overnight shift
      if (startTimeStr != null) {
        final startParts = _parseTimeOfDay(startTimeStr);
        if (startParts != null) {
          final startMinutes = startParts['hour']! * 60 + startParts['minute']!;
          final endMinutes = endParts['hour']! * 60 + endParts['minute']!;
          if (endMinutes <= startMinutes) {
            // End time is on the next day
            endDateTime = endDateTime.add(const Duration(days: 1));
          }
        }
      }
      return endDateTime;
    } catch (_) {
      return null;
    }
  }

  Widget _buildHistoryCard(TimerService timerService) {
    if (clientAndAppointmentData['data'] == null ||
        clientAndAppointmentData['data']['assignedClient'] == null) {
      return const SizedBox.shrink();
    }
    final assignedClient = clientAndAppointmentData['data']['assignedClient'];
    final scheduleList = (assignedClient['schedule'] as List?) ?? [];

    // Filter for past visits (completed)
    final now = DateTime.now();
    final pastVisits = scheduleList.where((s) {
      try {
        final dateStr = s['date'];
        final endTimeStr = s['endTime'];
        final startTimeStr = s['startTime'];
        if (dateStr == null) return false;

        final shiftDate = DateTime.parse(dateStr);
        final today = DateTime(now.year, now.month, now.day);

        // If the timer is currently running for this client, and this shift is scheduled for today or yesterday (for overnight shifts)
        if (timerService.isRunning &&
            timerService.getTimerClientEmail() == widget.clientEmail) {
          final isToday =
              shiftDate.year == today.year &&
              shiftDate.month == today.month &&
              shiftDate.day == today.day;
          final isYesterday =
              shiftDate.year == today.subtract(const Duration(days: 1)).year &&
              shiftDate.month ==
                  today.subtract(const Duration(days: 1)).month &&
              shiftDate.day == today.subtract(const Duration(days: 1)).day;
          if (isToday || isYesterday) {
            return false;
          }
        }

        final endDateTime = getShiftEndDateTime(
          dateStr,
          endTimeStr,
          startTimeStr,
        );
        if (endDateTime != null) {
          return endDateTime.isBefore(now);
        }

        // Fallback to simple date check
        return shiftDate.isBefore(today);
      } catch (e) {
        return false;
      }
    }).toList();

    // Sort by date descending
    pastVisits.sort((a, b) {
      return b['date'].compareTo(a['date']);
    });

    final recentVisits = pastVisits.take(3).toList();

    if (recentVisits.isEmpty) return const SizedBox.shrink();

    final timeRecords = (assignedClient['timeRecords'] as List?) ?? [];
    final attendedShiftKeys = <String>{};
    for (var record in timeRecords) {
      if (record['date'] != null && record['startTime'] != null) {
        attendedShiftKeys.add('${record['date']}_${record['startTime']}');
      }
    }

    return Container(
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.success,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: const Icon(
                    Icons.history,
                    color: BauhausDesign.surfaceWhite,
                    size: 24,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RECENT VISITS',
                      style: GoogleFonts.oswald(
                        color: BauhausDesign.neutral,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      'Previous shifts logged',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1.5,
            color: BauhausDesign.neutral,
          ),
          ...recentVisits.asMap().entries.map((entry) {
            final idx = entry.key;
            final visit = entry.value;
            final shiftKey = '${visit['date']}_${visit['startTime']}';
            final isAttended = attendedShiftKeys.contains(shiftKey);

            return Container(
              decoration: BoxDecoration(
                border: idx < recentVisits.length - 1
                    ? const Border(
                        bottom: BorderSide(
                          color: BauhausDesign.neutral,
                          width: 1.5,
                        ),
                      )
                    : null,
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space1),
                  decoration: BoxDecoration(
                    color: isAttended
                        ? BauhausDesign.success.withOpacity(0.1)
                        : BauhausDesign.error.withOpacity(0.1),
                    border: Border.all(
                      color: isAttended
                          ? BauhausDesign.success
                          : BauhausDesign.error,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    isAttended ? Icons.check : Icons.close,
                    color: isAttended
                        ? BauhausDesign.success
                        : BauhausDesign.error,
                    size: 16,
                  ),
                ),
                title: Text(
                  visit['date'] ?? 'Unknown Date',
                  style: GoogleFonts.oswald(
                    color: BauhausDesign.neutral,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${visit['startTime']} - ${visit['endTime']}${isAttended ? '' : ' (NOT ATTENDED)'}',
                  style: GoogleFonts.robotoMono(
                    color: isAttended
                        ? BauhausDesign.textMuted
                        : BauhausDesign.error,
                    fontSize: 12,
                    fontWeight: isAttended
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildClientInfoCard(Map<String, dynamic> clientData) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BauhausDesign.cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.primary,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: BauhausDesign.surfaceWhite,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CLIENT INFORMATION',
                          style: GoogleFonts.oswald(
                            color: BauhausDesign.neutral,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          'Personal details and contact information',
                          style: BauhausDesign.getTextTheme(context).bodyMedium
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space5),
              _buildInfoRow(
                Icons.badge,
                'Full Name',
                '${clientData['clientFirstName'] ?? "No"} ${clientData['clientLastName'] ?? "Name"}',
              ),
              _buildInfoRow(
                Icons.email,
                'Email',
                clientData['clientEmail'] ?? "No email data found",
              ),
              _buildInfoRow(
                Icons.phone,
                'Phone',
                clientData['clientPhone'] ?? "No phone data found",
              ),
              _buildInfoRow(
                Icons.location_on,
                'Address',
                '${clientData['clientAddress'] ?? "No address data found"}, '
                    '${clientData['clientCity'] ?? ""}${clientData['clientCity'] != null && clientData['clientState'] != null ? ', ' : ''}'
                    '${clientData['clientState'] ?? ""} ${clientData['clientZip'] ?? ""}',
              ),
              const SizedBox(height: BauhausDesign.space4),
              // Navigation Button
              _buildNavigationButton(clientData),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigation button to open maps with client address
  Widget _buildNavigationButton(Map<String, dynamic> clientData) {
    final address = clientData['clientAddress'] ?? '';
    final city = clientData['clientCity'] ?? '';
    final state = clientData['clientState'] ?? '';
    final zip = clientData['clientZip'] ?? '';
    final fullAddress = '$address, $city, $state $zip'.trim();

    // Don't show button if no address data
    if (address.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: BauhausDesign.accent,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final success = await NavigationHelper.openDirectionsToAddress(
              fullAddress,
            );
            if (!success && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not open maps application'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.directions,
                color: BauhausDesign.neutral,
                size: 22,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                (AppLocalizations.of(context)?.appointmentDetailsOpenMaps ??
                        'Get Directions')
                    .toUpperCase(),
                style: GoogleFonts.oswald(
                  color: BauhausDesign.neutral,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
            ),
            child: Icon(icon, size: 16, color: BauhausDesign.neutral),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.oswald(
                    color: BauhausDesign.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: BauhausDesign.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Container(
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.accent,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: const Icon(
                    Icons.schedule,
                    color: BauhausDesign.surfaceWhite,
                    size: 24,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SCHEDULE DETAILS',
                      style: GoogleFonts.oswald(
                        color: BauhausDesign.neutral,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      'Appointment dates and times',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space5,
              vertical: BauhausDesign.space2,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: Table(
              border: const TableBorder(
                horizontalInside: BorderSide(
                  color: BauhausDesign.neutral,
                  width: 1.5,
                ),
                verticalInside: BorderSide(
                  color: BauhausDesign.neutral,
                  width: 1.5,
                ),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2.5),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.2),
                4: FlexColumnWidth(1.0),
              },
              children: _buildTableRows(),
            ),
          ),
          const SizedBox(height: BauhausDesign.space5),
        ],
      ),
    );
  }

  Widget _buildTimerSection(TimerService timerService) {
    final isRunning =
        timerService.isRunning &&
        timerService.getTimerClientEmail() == widget.clientEmail;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          children: [
            // Timer Display
            AnimatedBuilder(
              animation: _timerPulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: isRunning ? _timerPulseAnimation.value : 1.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: BauhausDesign.space5,
                      horizontal: BauhausDesign.space6,
                    ),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                      boxShadow: const [BauhausDesign.shadowHardSm],
                    ),
                    child: Text(
                      (timerService.isRunning &&
                              (widget.clientEmail ==
                                  timerService.getTimerClientEmail()))
                          ? timerService.getFormattedTime(
                              timerService.elapsedSeconds,
                            )
                          : timerService.isRunning
                          ? "00:00:00"
                          : timerService.getFormattedTime(
                              timerService.elapsedSeconds,
                            ),
                      style: GoogleFonts.robotoMono(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: isRunning
                            ? BauhausDesign.success
                            : BauhausDesign.neutral,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: BauhausDesign.space6),

            // Timer Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  color: isRunning
                      ? BauhausDesign.primary
                      : BauhausDesign.success,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      if (timerService.isRunning &&
                          timerService.getTimerClientEmail() !=
                              widget.clientEmail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Another client\'s shift is currently active',
                            ),
                          ),
                        );
                        return;
                      }
                      if (timerService.isRunning &&
                          timerService.getTimerClientEmail() ==
                              widget.clientEmail) {
                        // Start the end shift flow (will confirm, stop timer, and log shift details)
                        await _setWorkedTime(
                          elapsedSeconds: timerService.elapsedSeconds,
                        );
                      } else {
                        // Try to start new timer
                        final success = await _startTimer(timerService);
                        if (success) {
                          timerService.setTimerClientEmail(widget.clientEmail);
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Timer started successfully'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isRunning ? Icons.stop : Icons.play_arrow,
                          size: 24,
                          color: BauhausDesign.surfaceWhite,
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        Text(
                          (isRunning ? 'End Shift' : 'Start Shift')
                              .toUpperCase(),
                          style: GoogleFonts.oswald(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.surfaceWhite,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Map Button
        Container(
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
          decoration: BoxDecoration(
            color: BauhausDesign.accent,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (clientDetails != null) {
                  final address = clientDetails?['clientAddress'] ?? '';
                  final city = clientDetails?['clientCity'] ?? '';
                  final state = clientDetails?['clientState'] ?? '';
                  final zipCode = clientDetails?['clientZipCode'] ?? '';
                  final fullAddress = '$address, $city, $state, $zipCode';
                  navigationService.openMapWithAddress(fullAddress);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 24, color: BauhausDesign.neutral),
                  const SizedBox(width: 8),
                  Text(
                    'VIEW IN MAP',
                    style: GoogleFonts.oswald(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.neutral,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Notes Button
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: BauhausDesign.primary,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNotesView(
                      userEmail: widget.userEmail,
                      clientEmail: widget.clientEmail,
                      clientDetails: clientDetails,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.note_add,
                    size: 24,
                    color: BauhausDesign.surfaceWhite,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ADD NOTES',
                    style: GoogleFonts.oswald(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.surfaceWhite,
                      letterSpacing: 1.0,
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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final timerService = ref.watch(timerServiceProviderWithNotifier);
        final isCurrentClientTimer =
            timerService.timerClientEmail == widget.clientEmail;
        if (timerModel.elapsedSeconds == kTimerDurationInSeconds) {
          timerModel.stop();
        }

        return Scaffold(
          backgroundColor: BauhausDesign.backgroundLight,
          appBar: AppBar(
            title: Text(
              'CLIENT DETAILS',
              style: GoogleFonts.oswald(
                color: BauhausDesign.neutral,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1.5,
              ),
            ),
            backgroundColor: BauhausDesign.surfaceWhite,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              child: Container(
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: BauhausDesign.neutral,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2),
              child: Container(color: BauhausDesign.neutral, height: 2),
            ),
          ),
          body: isInitCompleted
              ? _buildContent(timerService, isCurrentClientTimer)
              : _buildProgressIndicator(),
        );
      },
    );
  }
}
