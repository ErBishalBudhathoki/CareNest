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
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
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
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'OFFER SHIFT SWAP',
                  style: BauhausDesign.getTextTheme(context)
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  '${shift['date']} (${shift['startTime']} - ${shift['endTime']})',
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: BauhausDesign.space4),
                DropdownButtonFormField<String>(
                  value: urgency,
                  decoration: InputDecoration(
                    labelText: 'Urgency',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                    ),
                  ),
                  items: ['Low', 'Medium', 'High']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => urgency = v!),
                ),
                const SizedBox(height: BauhausDesign.space3),
                TextField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                    ),
                  ),
                  maxLines: 2,
                ),
                if (error != null) ...[
                  const SizedBox(height: BauhausDesign.space2),
                  Text(error!, style: TextStyle(color: BauhausDesign.error)),
                ],
                const SizedBox(height: BauhausDesign.space4),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('CANCEL',
                            style: TextStyle(color: BauhausDesign.textMuted)),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BauhausDesign.primary,
                          foregroundColor: BauhausDesign.surfaceWhite,
                        ),
                        onPressed: () async {
                          final sharedPrefs = SharedPreferencesUtils();
                          await sharedPrefs.init();
                          final organizationId =
                              sharedPrefs.getString('organizationId');
                          final userId = sharedPrefs.getString('userId') ??
                              widget.userEmail;

                          if (organizationId == null) {
                            setState(() => error = 'Organization ID not found');
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
                            final response = await apiMethod.createSwapOffer(
                              organizationId: organizationId,
                              userId: userId,
                              userEmail: widget.userEmail,
                              details: details,
                            );

                            if (response['success'] == true) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Swap offer created!')),
                                );
                              }
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Failed: ${response['message']}')),
                                );
                              }
                            }
                          } catch (e) {
                            debugPrint('Error creating swap: $e');
                          }
                        },
                        child: const Text('OFFER'),
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
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: BauhausDesign.space2, horizontal: BauhausDesign.space1),
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(Icons.swap_horiz, color: BauhausDesign.primary, size: 20),
        onPressed: () => _showSwapOfferDialog(shift),
        tooltip: 'Offer Swap',
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
            strokeWidth: 3,
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Loading appointment details...',
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  color: BauhausDesign.textMuted,
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
          rows.add(_buildTableRow(
            schedule['date'] ?? 'N/A',
            schedule['startTime'] ?? 'N/A',
            schedule['endTime'] ?? 'N/A',
            schedule['break'] ?? 'N/A',
            i,
            schedule is Map<String, dynamic>
                ? schedule
                : Map<String, dynamic>.from(schedule),
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
          final scheduleMap = {
            'date': i < dateList.length ? dateList[i].toString() : 'N/A',
            'startTime':
                i < startTimeList.length ? startTimeList[i].toString() : 'N/A',
            'endTime':
                i < endTimeList.length ? endTimeList[i].toString() : 'N/A',
            'break': i < breakList.length ? breakList[i].toString() : 'N/A',
          };
          rows.add(_buildTableRow(
            scheduleMap['date']!,
            scheduleMap['startTime']!,
            scheduleMap['endTime']!,
            scheduleMap['break']!,
            i,
            scheduleMap,
          ));
        }
      }
    }

    return rows;
  }

  Widget _buildTableHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: BauhausDesign.space4, horizontal: BauhausDesign.space1),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.primary,
              fontSize: 12,
            ),
      ),
    );
  }

  TableRow _buildTableRow(String date, String startTime, String endTime,
      String breakTime, int index, Map<String, dynamic> schedule) {
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
          vertical: BauhausDesign.space3, horizontal: BauhausDesign.space2),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              fontSize: 13,
              color: BauhausDesign.textDark,
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
              color: BauhausDesign.neutral,
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'No client data found',
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    color: BauhausDesign.textMuted,
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
              color: BauhausDesign.neutral,
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'No client details found',
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    color: BauhausDesign.textMuted,
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
                _buildHistoryCard(),
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
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(
            color: BauhausDesign.neutral,
            width: 2,
          ),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
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
                      color: Colors.purple.shade100,
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.purple,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preferences & Care',
                          style: BauhausDesign.getTextTheme(context)
                              .titleLarge
                              ?.copyWith(
                                color: Colors.purple,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          'Important client needs',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space5),
              if (careNotes.isNotEmpty)
                _buildInfoRow(Icons.medical_services, 'Care Notes', careNotes),
              ...preferences.entries.map((e) => _buildInfoRow(
                  Icons.star_outline, e.key.toUpperCase(), e.value.toString())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard() {
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
        final date = DateTime.parse(s['date']);
        return date.isBefore(now);
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

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2,
        ),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
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
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  child: Icon(
                    Icons.history,
                    color: Colors.teal,
                    size: 24,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Visits',
                      style: BauhausDesign.getTextTheme(context)
                          .titleLarge
                          ?.copyWith(
                            color: Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ...recentVisits.map((visit) => ListTile(
                leading: Icon(Icons.check_circle_outline,
                    color: BauhausDesign.success),
                title: Text(visit['date'] ?? 'Unknown Date'),
                subtitle: Text('${visit['startTime']} - ${visit['endTime']}'),
              )),
        ],
      ),
    );
  }

  Widget _buildClientInfoCard(Map<String, dynamic> clientData) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(
            color: BauhausDesign.neutral,
            width: 2,
          ),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
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
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                    ),
                    child: Icon(
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
                          'Client Information',
                          style: BauhausDesign.getTextTheme(context)
                              .titleLarge
                              ?.copyWith(
                                color: BauhausDesign.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          'Personal details and contact information',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space5),
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
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(
          color: BauhausDesign.accent,
          width: 2,
        ),
      ),
      child: Material(
        color: BauhausDesign.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        child: InkWell(
          onTap: () async {
            final success =
                await NavigationHelper.openDirectionsToAddress(fullAddress);
            if (!success && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not open maps application'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions,
                color: BauhausDesign.accent,
                size: 22,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                AppLocalizations.of(context)?.appointmentDetailsOpenMaps ??
                    'Get Directions',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: BauhausDesign.accent,
                      fontWeight: FontWeight.w600,
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
              color: BauhausDesign.backgroundLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
            child: Icon(
              icon,
              size: 16,
              color: BauhausDesign.textMuted,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  value,
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            color: BauhausDesign.textDark,
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
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2,
        ),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
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
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  child: Icon(
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
                      'Schedule Details',
                      style: BauhausDesign.getTextTheme(context)
                          .titleLarge
                          ?.copyWith(
                            color: BauhausDesign.accent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      'Appointment dates and times',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space5,
                vertical: BauhausDesign.space2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(
                color: BauhausDesign.neutral,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              child: Table(
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
          ),
          const SizedBox(height: BauhausDesign.space5),
        ],
      ),
    );
  }

  Widget _buildTimerSection(TimerService timerService) {
    final isRunning = timerService.isRunning &&
        timerService.getTimerClientEmail() == widget.clientEmail;

    return Container(
      decoration: BoxDecoration(
        color: isRunning
            ? BauhausDesign.warning.withOpacity(0.05)
            : BauhausDesign.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: isRunning ? BauhausDesign.warning : BauhausDesign.primary,
          width: 2,
        ),
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
                        horizontal: BauhausDesign.space6),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusMd),
                      border: Border.all(
                        color: isRunning
                            ? BauhausDesign.warning
                            : BauhausDesign.primary,
                        width: 1.5,
                      ),
                      boxShadow: const [BauhausDesign.shadowSoft],
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
                            ? BauhausDesign.warning
                            : BauhausDesign.primary,
                        letterSpacing: 2,
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
                  backgroundColor:
                      isRunning ? BauhausDesign.warning : BauhausDesign.primary,
                  foregroundColor: BauhausDesign.surfaceWhite,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    side: BorderSide(
                      color: BauhausDesign.neutral,
                      width: 2,
                    ),
                  ),
                ),
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
          margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
          child: ElevatedButton(
            onPressed: () {
              if (clientDetails != null) {
                final address = clientDetails?['clientAddress'] ?? '';
                final city = clientDetails?['clientCity'] ?? '';
                final state = clientDetails?['clientState'] ?? '';
                final zipCode = clientDetails?['clientZipCode'] ?? '';
                final fullAddress = '$address, $city, $state, $zipCode';
                navigationService.openMapWithAddress(fullAddress);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.accent,
              foregroundColor: BauhausDesign.surfaceWhite,
              elevation: 4,
              shadowColor: BauhausDesign.shadowHard.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                side: BorderSide(
                  color: BauhausDesign.neutral,
                  width: 2,
                ),
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
              backgroundColor: BauhausDesign.primary,
              foregroundColor: BauhausDesign.surfaceWhite,
              elevation: 4,
              shadowColor: BauhausDesign.shadowHard.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                side: BorderSide(
                  color: BauhausDesign.neutral,
                  width: 2,
                ),
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
          backgroundColor: BauhausDesign.backgroundLight,
          appBar: AppBar(
            title: Text(
              'Client Details',
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    color: BauhausDesign.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            backgroundColor: BauhausDesign.surfaceWhite,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: BauhausDesign.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(color: BauhausDesign.neutral, height: 1.5),
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
