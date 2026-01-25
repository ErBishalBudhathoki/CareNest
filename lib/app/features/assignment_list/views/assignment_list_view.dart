import 'package:carenest/app/shared/widgets/enhanced_3d_assignment_card.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/assignment_list/views/edit_assignment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/assignment_list/viewmodels/assignment_list_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:intl/intl.dart';

class AssignmentListView extends ConsumerStatefulWidget {
  final String userEmail;
  final String organizationId;

  const AssignmentListView({
    super.key,
    required this.userEmail,
    required this.organizationId,
  });

  @override
  ConsumerState<AssignmentListView> createState() => _AssignmentListViewState();
}

class _AssignmentListViewState extends ConsumerState<AssignmentListView> {
  @override
  void initState() {
    super.initState();
    // Load assignments when the widget is first built.
    // Use addPostFrameCallback to ensure the context and ref are available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(assignmentListViewModelProvider.notifier)
          .loadOrganizationAssignments(widget.organizationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider to get the current state and rebuild on changes.
    final state = ref.watch(assignmentListViewModelProvider);
    // Read the notifier to call methods without rebuilding the widget.
    final viewModel = ref.read(assignmentListViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.primary,
        foregroundColor: BauhausDesign.surfaceLight,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral, width: 2.0),
              boxShadow: const [BauhausDesign.shadowHardXs],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  size: 18, color: BauhausDesign.neutral),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.assignments.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                color: BauhausDesign.surfaceLight,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(state, viewModel),
    );
  }

  Widget _buildBody(
      AssignmentListState state, AssignmentListViewModel viewModel) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: BauhausDesign.error,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.errorLoadingAssignments,
              style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                    color: BauhausDesign.error,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  viewModel.loadOrganizationAssignments(widget.organizationId),
              style: ElevatedButton.styleFrom(
                backgroundColor: BauhausDesign.primary,
                foregroundColor: BauhausDesign.surfaceLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.assignments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: BauhausDesign.neutral,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.noAssignmentsFound,
              style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                    color: BauhausDesign.textLight,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.noAssignmentsMessage,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.neutral,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          viewModel.loadOrganizationAssignments(widget.organizationId),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.assignments.length,
        itemBuilder: (context, index) {
          final assignment = state.assignments[index];
          return _buildAssignmentCard(assignment, context);
        },
      ),
    );
  }

  Widget _buildAssignmentCard(
      Map<String, dynamic> assignment, BuildContext context) {
    try {
      return Enhanced3DAssignmentCard(
        assignment: assignment,
        onEdit: () => _showEditDialog(context, assignment),
        employeeName: null, // Will be loaded from assignment data
        clientName: null, // Will be loaded from assignment data
      );
    } catch (e, stackTrace) {
      debugPrint('Error building assignment card: $e\n$stackTrace');
      return Card(
        color: BauhausDesign.error.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Icon(Icons.error, color: BauhausDesign.error),
              const SizedBox(height: 8),
              Text('Error displaying assignment',
                  style: TextStyle(color: BauhausDesign.error)),
              Text(e.toString(), style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
    }
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> assignment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAssignmentView(
          assignment: assignment,
          organizationId: widget.organizationId,
        ),
      ),
    );
  }
}

class EnhancedAssignmentCard extends StatefulWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback onEdit;

  const EnhancedAssignmentCard({
    super.key,
    required this.assignment,
    required this.onEdit,
  });

  @override
  State<EnhancedAssignmentCard> createState() => _EnhancedAssignmentCardState();
}

class _EnhancedAssignmentCardState extends State<EnhancedAssignmentCard> {
  final ApiMethod _apiMethod = ApiMethod();
  Patient? clientDetails;
  Map<String, dynamic>? employeeDetails;
  bool isLoadingDetails = false;
  bool showFullDetails = false;

  @override
  void initState() {
    super.initState();
    _loadDetailedInfo();
  }

  Future<void> _loadDetailedInfo() async {
    if (!mounted) return;
    setState(() {
      isLoadingDetails = true;
    });

    try {
      final String userEmail = widget.assignment['userEmail'] ?? '';
      final String clientEmail = widget.assignment['clientEmail'] ?? '';

      final clientData = await _apiMethod.fetchMultiplePatientData(clientEmail);
      if (mounted && clientData.isNotEmpty) {
        clientDetails = clientData.first;
      }

      final userData = await _apiMethod.checkEmail(userEmail);
      if (mounted && userData != null && userData['statusCode'] == 200) {
        employeeDetails = userData;
      }
    } catch (e) {
      debugPrint('Error loading detailed info: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoadingDetails = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userEmail = widget.assignment['userEmail'] ?? 'Unknown User';
    final String clientEmail =
        widget.assignment['clientEmail'] ?? 'Unknown Client';

    final List<dynamic> scheduleArray = widget.assignment['schedule'] ?? [];
    final List<dynamic> dateList = scheduleArray.isNotEmpty
        ? scheduleArray.map((item) => item['date'] ?? '').toList()
        : widget.assignment['dateList'] ?? [];
    final List<dynamic> startTimeList = scheduleArray.isNotEmpty
        ? scheduleArray.map((item) => item['startTime'] ?? '').toList()
        : widget.assignment['startTimeList'] ?? [];
    final List<dynamic> endTimeList = scheduleArray.isNotEmpty
        ? scheduleArray.map((item) => item['endTime'] ?? '').toList()
        : widget.assignment['endTimeList'] ?? [];
    final List<dynamic> breakList = scheduleArray.isNotEmpty
        ? scheduleArray.map((item) => item['break'] ?? '').toList()
        : widget.assignment['breakList'] ?? [];
    final List<dynamic> highIntensityList = scheduleArray.isNotEmpty
        ? scheduleArray
            .map((item) => item['highIntensity'] as bool? ?? false)
            .toList()
        : List<bool>.filled(dateList.length, false);
    final String createdAt = widget.assignment['createdAt'] ?? '';

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee: ${(employeeDetails?["firstName"] ?? "") + " " + (employeeDetails?["lastName"] ?? "")}'
                              .trim()
                              .isEmpty
                          ? _getDisplayName(userEmail)
                          : '${(employeeDetails?["firstName"] ?? "") + " " + (employeeDetails?["lastName"] ?? "")}'
                              .trim(),
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textLight,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Client: ${clientDetails?.clientFirstName ?? ''} ${clientDetails?.clientLastName ?? _getDisplayName(clientEmail)}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.neutral,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: BauhausDesign.primary.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                    ),
                    child: Text(
                      '${scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length} Shift${(scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length) != 1 ? 's' : ''}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: widget.onEdit,
                    icon: const Icon(Icons.edit),
                    iconSize: 20,
                    color: BauhausDesign.primary,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (showFullDetails) ..._buildDetailedInfo(),
          TextButton.icon(
            onPressed: () {
              setState(() {
                showFullDetails = !showFullDetails;
              });
            },
            icon: Icon(
              showFullDetails ? Icons.expand_less : Icons.expand_more,
              size: 16,
            ),
            label: Text(
              showFullDetails ? 'Show Less Details' : 'Show More Details',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          if (dateList.isNotEmpty) ...[
            Text(
              AppLocalizations.of(context)!.shiftDetails,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textLight,
                  ),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              (scheduleArray.isNotEmpty
                          ? scheduleArray.length
                          : dateList.length) >
                      3
                  ? 3
                  : (scheduleArray.isNotEmpty
                      ? scheduleArray.length
                      : dateList.length),
              (shiftIndex) => _buildShiftRow(
                dateList.length > shiftIndex
                    ? dateList[shiftIndex]?.toString() ?? ''
                    : '',
                startTimeList.length > shiftIndex
                    ? startTimeList[shiftIndex]?.toString() ?? ''
                    : '',
                endTimeList.length > shiftIndex
                    ? endTimeList[shiftIndex]?.toString() ?? ''
                    : '',
                breakList.length > shiftIndex
                    ? breakList[shiftIndex]?.toString() ?? ''
                    : '',
                highIntensityList.length > shiftIndex
                    ? highIntensityList[shiftIndex] as bool
                    : false,
              ),
            ),
            if ((scheduleArray.isNotEmpty
                    ? scheduleArray.length
                    : dateList.length) >
                3)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'and ${(scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length) - 3} more shift${(scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length) - 3 != 1 ? 's' : ''}...',
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: BauhausDesign.neutral,
                          ),
                ),
              ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created: ${_formatDate(createdAt)}',
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                      color: BauhausDesign.neutral,
                    ),
              ),
              Text(
                'Total Hours: ${_calculateTotalHours(startTimeList, endTimeList, breakList)}',
                style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.primary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDetailedInfo() {
    return [
      if (isLoadingDetails)
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        )
      else ...[
        _buildInfoSection(
          'Client Information',
          [
            if (clientDetails != null) ...[
              _buildInfoRow('Name',
                  '${clientDetails!.clientFirstName} ${clientDetails!.clientLastName}'),
              _buildInfoRow('Email', clientDetails!.clientEmail),
              _buildInfoRow('Phone',
                  clientDetails!.clientPhone ?? 'Phone Number Not Provided'),
              _buildInfoRow('Address',
                  '${clientDetails!.clientAddress}, ${clientDetails!.clientCity}, ${clientDetails!.clientState} ${clientDetails!.clientZip}'),
            ] else ...[
              _buildInfoRow('Email', widget.assignment['clientEmail'] ?? ''),
              Text('Additional client details not available',
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: BauhausDesign.neutral)),
            ],
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoSection(
          'Employee Information',
          [
            if (employeeDetails != null) ...[
              _buildInfoRow('Email', employeeDetails!['email'] ?? ''),
              Text('Additional employee details available via user management',
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: BauhausDesign.neutral)),
            ] else ...[
              _buildInfoRow('Email', widget.assignment['userEmail'] ?? ''),
              Text('Additional employee details not available',
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: BauhausDesign.neutral)),
            ],
          ],
        ),
        const SizedBox(height: 16),
      ],
    ];
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.neutral,
                ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: BauhausDesign.neutral.withValues(alpha: 0.7),
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: value.isNotEmpty
                        ? BauhausDesign.neutral
                        : BauhausDesign.neutral.withValues(alpha: 0.5),
                    fontStyle:
                        value.isNotEmpty ? FontStyle.normal : FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftRow(String date, String startTime, String endTime,
      String breakTime, bool isHighIntensity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              _formatShiftDate(date),
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textLight,
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$startTime - $endTime',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textLight,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Break: $breakTime',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.neutral,
                  ),
            ),
          ),
          if (isHighIntensity)
            Icon(Icons.fitness_center, size: 16, color: BauhausDesign.primary),
        ],
      ),
    );
  }

  String _getDisplayName(String email) {
    if (email.isEmpty) return 'Unknown';
    final parts = email.split('@');
    if (parts.isNotEmpty) {
      return parts[0].replaceAll('.', ' ').replaceAll('_', ' ');
    }
    return email;
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _formatShiftDate(String dateString) {
    if (dateString.isEmpty) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _calculateTotalHours(
      List<dynamic> startTimes, List<dynamic> endTimes, List<dynamic> breaks) {
    if (startTimes.isEmpty || endTimes.isEmpty) return '0.0';

    double totalHours = 0.0;
    for (int i = 0; i < startTimes.length && i < endTimes.length; i++) {
      final startTime = startTimes[i]?.toString() ?? '';
      final endTime = endTimes[i]?.toString() ?? '';
      final breakTime = i < breaks.length ? breaks[i]?.toString() ?? '' : '';
      totalHours += _calculateShiftHours(startTime, endTime, breakTime);
    }
    return totalHours.toStringAsFixed(1);
  }

  double _calculateShiftHours(
      String startTime, String endTime, String breakTime) {
    try {
      final start = _parseTime(startTime);
      final end = _parseTime(endTime);
      final breakHours = _parseBreakTime(breakTime);
      if (start != null && end != null) {
        double duration = end.difference(start).inMinutes / 60.0;
        if (duration < 0) duration += 24;
        return (duration - breakHours).clamp(0.0, 24.0);
      }
    } catch (e) {
      debugPrint('Error calculating shift hours: $e');
    }
    return 0.0;
  }

  DateTime? _parseTime(String timeString) {
    if (timeString.isEmpty) return null;
    try {
      final now = DateTime.now();
      if (timeString.toUpperCase().contains('AM') ||
          timeString.toUpperCase().contains('PM')) {
        final format = DateFormat('h:mm a');
        final time = format.parse(timeString.trim());
        return DateTime(now.year, now.month, now.day, time.hour, time.minute);
      }
      if (timeString.contains(':')) {
        final parts = timeString.split(':');
        if (parts.length >= 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          return DateTime(now.year, now.month, now.day, hour, minute);
        }
      }
    } catch (e) {
      debugPrint('Error parsing time "$timeString": $e');
    }
    return null;
  }

  double _parseBreakTime(String breakString) {
    if (breakString.isEmpty) return 0.0;
    final breakLower = breakString.toLowerCase().trim();
    if (breakLower == 'no' || breakLower == 'none') {
      return 0.0;
    }
    if (breakLower == 'yes') {
      return 0.5;
    }
    try {
      return double.parse(breakString);
    } catch (e) {
      debugPrint('Error parsing break time "$breakString": $e');
      return 0.0;
    }
  }
}
