import 'dart:io';

import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/values/themes/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/core/utils/Services/launch_map_status.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../notes/views/add_notes_view.dart';
import 'package:carenest/app/features/Appointment/widgets/shift_selection_dialog.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

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
  ApiMethod apiMethod = ApiMethod();
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
    _setupAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncTimerWithServer();
      final timerService = ref.read(timerServiceProvider);
      if (timerService.getTimerClientEmail() != widget.clientEmail ||
          !timerService.isRunning) {
        timerService.resetTimer(widget.clientEmail);
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
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
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

    _timerPulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _timerPulseController,
      curve: Curves.easeInOut,
    ));
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timerModel = ref.read(timerServiceProvider);
    if (!isInitCompleted) {
      _initializeData();
    }
  }

  Future<void> _initializeData() async {
    await getAppointmentData().then((_) {
      setState(() {
        isInitCompleted = true;
        clientDetails =
            clientAndAppointmentData['data']?['clientDetails']?.isNotEmpty ==
                    true
                ? clientAndAppointmentData['data']!['clientDetails'][0]
                : null;
      });
    });
  }

  Future<void> updateTimerModel() async {
    if (timerModel.isRunning &&
        timerModel
            .getTimerClientEmail()
            .contains(widget.clientEmail.toString())) {
      debugPrint(
          "1 : ${widget.clientEmail} : ${timerModel.getTimerClientEmail()}");
      //_stopTimer();
      timerModel.stop();
      timerModel.setTimerClientEmail(widget.clientEmail);
    } else if (timerModel.isRunning &&
        (widget.clientEmail != timerModel.getTimerClientEmail())) {
      debugPrint("2");
      return;
    } else {
      debugPrint(
          "3: ${widget.clientEmail} : ${clientAndAppointmentData['data']?['clientDetails'][0]?['clientEmail']}");
      timerModel.start();
      // await _startTimer();
      timerModel.setTimerClientEmail(widget.clientEmail);
    }
  }

  Future<dynamic> getAppointmentData() async {
    clientAndAppointmentData = (await apiMethod.getClientAndAppointmentData(
        widget.userEmail, widget.clientEmail)) as Map;
    setState(() {
      debugPrint("Clinet Email: ${widget.clientEmail} "
          "${clientAndAppointmentData['data']?['clientDetails'][0]}");
      setClientAndAppointmentData = clientAndAppointmentData;
      isCurrentClient = (clientAndAppointmentData['data']?['clientDetails'][0]
              ?['clientEmail'] ==
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
          activeTimer['userEmail'], activeTimer['clientEmail']);
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
      final success =
          await timerService.startTimer(widget.userEmail, widget.clientEmail);

      if (success) {
        debugPrint(
            "Timer started successfully for ${widget.userEmail} - ${widget.clientEmail}");
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
      String? activeUserEmail, String? activeClientEmail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Timer Already Running'),
          content: Text(
            'A timer is already running for:\n'
            'User: ${activeUserEmail ?? 'Unknown'}\n'
            'Client: ${activeClientEmail ?? 'Unknown'}\n\n'
            'Please stop the current timer before starting a new one.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setWorkedTime() async {
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
        return; // User cancelled
      }

      final formattedTime = _formatTime(timerModel.elapsedSeconds);
      final response = await apiMethod.setWorkedTime(
        widget.userEmail,
        widget.clientEmail,
        formattedTime,
        selectedShiftIndex,
      );

      if (response != null) {
        // Update local data with response
        setState(() {
          // Ensure we maintain the structure of clientAndAppointmentData
          if (response is Map) {
            clientAndAppointmentData = response;
          } else {
            // If response is not in the expected format, refresh data
            _loadClientData();
          }
        });

        // Refresh the data again to ensure we have the latest
        await _loadClientData();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Time updated successfully'),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error in _setWorkedTime: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating time: $e'),
          ),
        );
      }
    }
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
            clientDetails = clientAndAppointmentData['data']?['clientDetails']
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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF007AFF)),
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading appointment details...',
            style: AppThemeConfig.bodyStyle.copyWith(
              color: const Color(0xFF757575),
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
          color: const Color(0xFF007AFF).withValues(alpha: 0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        children: [
          _buildTableHeader("Appointment Date"),
          _buildTableHeader("Start Time"),
          _buildTableHeader("End Time"),
          _buildTableHeader("Break"),
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
          rows.add(_buildTableRow(
            schedule['date'] ?? 'N/A',
            schedule['startTime'] ?? 'N/A',
            schedule['endTime'] ?? 'N/A',
            schedule['break'] ?? 'N/A',
            i,
          ));
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
          breakList.length
        ].reduce((a, b) => a > b ? a : b);

        for (int i = 0; i < maxLength; i++) {
          rows.add(_buildTableRow(
            i < dateList.length ? dateList[i].toString() : 'N/A',
            i < startTimeList.length ? startTimeList[i].toString() : 'N/A',
            i < endTimeList.length ? endTimeList[i].toString() : 'N/A',
            i < breakList.length ? breakList[i].toString() : 'N/A',
            i,
          ));
        }
      }
    }

    return rows;
  }

  Widget _buildTableHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: AppThemeConfig.bodyStyle.copyWith(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF007AFF),
          fontSize: 14,
        ),
      ),
    );
  }

  TableRow _buildTableRow(String date, String startTime, String endTime,
      String breakTime, int index) {
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven ? const Color(0xFFFAFAFA) : Colors.white,
      ),
      children: [
        _buildTableCell(date),
        _buildTableCell(startTime),
        _buildTableCell(endTime),
        _buildTableCell(breakTime),
      ],
    );
  }

  Widget _buildTableCell(String content) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: AppThemeConfig.bodyStyle.copyWith(
          fontSize: 13,
          color: const Color(0xFF424242),
        ),
      ),
    );
  }

  Widget _buildContent(TimerService timerService, bool isCurrentClientTimer) {
    if (clientAndAppointmentData['data'] == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: const Color(0xFFBDBDBD),
            ),
            const SizedBox(height: 16),
            Text(
              'No client data found',
              style: AppThemeConfig.titleStyle.copyWith(
                color: const Color(0xFF757575),
              ),
            ),
          ],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: const Color(0xFFBDBDBD),
            ),
            const SizedBox(height: 16),
            Text(
              'No client details found',
              style: AppThemeConfig.titleStyle.copyWith(
                color: const Color(0xFF757575),
              ),
            ),
          ],
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Client Info Card
                _buildClientInfoCard(clientData),
                const SizedBox(height: 24),

                // Schedule Table Card
                _buildScheduleCard(),
                const SizedBox(height: 24),

                // Timer Section
                _buildTimerSection(timerService),
                const SizedBox(height: 24),

                // Action Buttons
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoCard(Map<String, dynamic> clientData) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF007AFF).withValues(alpha: 0.1),
              const Color(0xFF34C759).withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF007AFF).withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF007AFF).withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF007AFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Client Information',
                          style: AppThemeConfig.titleStyle.copyWith(
                            color: const Color(0xFF007AFF),
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Personal details and contact information',
                          style: AppThemeConfig.captionStyle.copyWith(
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInfoRow(Icons.badge, 'Full Name',
                  '${clientData['clientFirstName'] ?? "No"} ${clientData['clientLastName'] ?? "Name"}'),
              _buildInfoRow(Icons.email, 'Email',
                  clientData['clientEmail'] ?? "No email data found"),
              _buildInfoRow(Icons.phone, 'Phone',
                  clientData['clientPhone'] ?? "No phone data found"),
              _buildInfoRow(
                  Icons.location_on,
                  'Address',
                  '${clientData['clientAddress'] ?? "No address data found"}, '
                      '${clientData['clientCity'] ?? ""}${clientData['clientCity'] != null && clientData['clientState'] != null ? ', ' : ''}'
                      '${clientData['clientState'] ?? ""} ${clientData['clientZip'] ?? ""}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: const Color(0xFF757575),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppThemeConfig.captionStyle.copyWith(
                    color: const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppThemeConfig.bodyStyle.copyWith(
                    color: const Color(0xFF212121),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5AC8FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.schedule,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schedule Details',
                      style: AppThemeConfig.titleStyle.copyWith(
                        color: const Color(0xFF5AC8FA),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Appointment dates and times',
                      style: AppThemeConfig.captionStyle.copyWith(
                        color: const Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFEEEEEE),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(3.0),
                  1: IntrinsicColumnWidth(),
                  2: IntrinsicColumnWidth(),
                  3: IntrinsicColumnWidth(),
                },
                children: _buildTableRows(),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTimerSection(TimerService timerService) {
    final isRunning = timerService.isRunning &&
        timerService.getTimerClientEmail() == widget.clientEmail;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isRunning
              ? [
                  const Color(0xFFFF9500).withValues(alpha: 0.1),
                  const Color(0xFFFF9500).withValues(alpha: 0.1)
                ]
              : [
                  const Color(0xFF007AFF).withValues(alpha: 0.1),
                  const Color(0xFF34C759).withValues(alpha: 0.1)
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRunning
              ? const Color(0xFFFF9500).withValues(alpha: 0.1)
              : const Color(0xFF007AFF).withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
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
                        vertical: 20, horizontal: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: isRunning
                              ? const Color(0xFFFF9500).withValues(alpha: 0.1)
                              : const Color(0xFF007AFF).withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      (timerService.isRunning &&
                              (widget.clientEmail ==
                                  timerService.getTimerClientEmail()))
                          ? timerService
                              .getFormattedTime(timerService.elapsedSeconds)
                          : timerService.isRunning
                              ? "00:00:00"
                              : timerService.getFormattedTime(
                                  timerService.elapsedSeconds),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: isRunning
                            ? const Color(0xFFFF9500)
                            : const Color(0xFF007AFF),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Timer Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (timerService.isRunning &&
                      timerService.getTimerClientEmail() !=
                          widget.clientEmail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Another client\'s shift is currently active'),
                      ),
                    );
                    return;
                  }
                  if (timerService.isRunning &&
                      timerService.getTimerClientEmail() ==
                          widget.clientEmail) {
                    // Stop current timer
                    await _stopTimer(timerService);
                    await _setWorkedTime();
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRunning
                      ? const Color(0xFFFF9500)
                      : const Color(0xFF007AFF),
                  foregroundColor: Colors.white,
                  elevation: isRunning ? 8 : 4,
                  shadowColor: isRunning
                      ? const Color(0xFFFF9500).withValues(alpha: 0.1)
                      : const Color(0xFF007AFF).withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isRunning ? Icons.stop : Icons.play_arrow,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isRunning ? 'End Shift' : 'Start Shift',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
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
          margin: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              if (clientDetails != null) {
                final address = clientDetails?['clientAddress'] ?? '';
                final city = clientDetails?['clientCity'] ?? '';
                final state = clientDetails?['clientState'] ?? '';
                final zipCode = clientDetails?['clientZipCode'] ?? '';
                final fullAddress = '$address, $city, $state, $zipCode';
                launchMap(fullAddress);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5AC8FA),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF5AC8FA).withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.map, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'View in Map',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Notes Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNotesView(
                      userEmail: widget.userEmail,
                      clientEmail: widget.clientEmail,
                      clientDetails: clientDetails),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5AC8FA),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF34C759).withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.note_add, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Add Notes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
          appBar: AppBar(
            title: Text(
              'Client Details',
              style: AppThemeConfig.titleStyle.copyWith(
                color: const Color(0xFF007AFF),
                fontSize: 20,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF007AFF)),
              onPressed: () => Navigator.of(context).pop(),
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

Future<LaunchMapStatus> launchMap(String address) async {
  String query = Uri.encodeComponent(address);
  String appleMapsUrl = 'maps://?q=$query';
  String googleMapsUrl = 'geo:0,0?q=$query';

  if (Platform.isIOS) {
    if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
      await launchUrl(Uri.parse(appleMapsUrl));
      return LaunchMapStatus(
        success: true,
        title: 'Success',
        message: 'Launched Apple Maps',
        surfaceColor: Colors.green,
      );
    } else if (await canLaunchUrl(Uri.parse('comgooglemaps://?q=$query'))) {
      await launchUrl(Uri.parse('comgooglemaps://?q=$query'));
      return LaunchMapStatus(
        success: true,
        title: 'Success',
        message: 'Launched Google Maps',
        surfaceColor: Colors.green,
      );
    } else {
      return LaunchMapStatus(
        success: false,
        title: 'Error',
        message: 'Could not launch any map application',
        surfaceColor: Colors.red,
      );
    }
  } else if (Platform.isAndroid) {
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
      return LaunchMapStatus(
        success: true,
        title: 'Success',
        message: 'Launched Google Maps',
        surfaceColor: Colors.green,
      );
    } else {
      return LaunchMapStatus(
        success: false,
        title: 'Error',
        message: 'Could not launch Google Maps',
        surfaceColor: Colors.red,
      );
    }
  }
  return LaunchMapStatus(
    success: false,
    title: 'Error',
    message: 'Unsupported platform',
    surfaceColor: Colors.red,
  );
}
