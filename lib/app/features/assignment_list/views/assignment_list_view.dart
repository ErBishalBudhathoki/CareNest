import 'package:carenest/app/shared/widgets/enhanced_3d_assignment_card.dart';
import 'package:carenest/app/features/assignment_list/views/edit_assignment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <--- THIS LINE FIXES THE ERROR
import 'package:carenest/app/features/assignment_list/viewmodels/assignment_list_viewmodel.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/features/assignment/views/ndis_item_selection_view.dart';

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
      appBar: AppBar(
        title: Text(
          'Organization Assignments',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600).copyWith(
            color: const Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF667EEA)),
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
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Assignments',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600).copyWith(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage,
              style: const TextStyle(fontSize: 14).copyWith(
                color: const Color(0xFF525252),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  viewModel.loadOrganizationAssignments(widget.organizationId),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
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
              color: const Color(0xFF525252),
            ),
            const SizedBox(height: 16),
            Text(
              'No Assignments Found',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600).copyWith(
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'There are no assignments for this organization yet.',
              style: const TextStyle(fontSize: 14).copyWith(
                color: const Color(0xFF525252),
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
    return Enhanced3DAssignmentCard(
      assignment: assignment,
      onEdit: () => _showEditDialog(context, assignment),
      employeeName: null, // Will be loaded from assignment data
      clientName: null, // Will be loaded from assignment data
    );
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

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Client: ${clientDetails?.clientFirstName ?? ''} ${clientDetails?.clientLastName ?? _getDisplayName(clientEmail)}',
                        style: const TextStyle(fontSize: 14).copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF667EEA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length} Shift${(scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length) != 1 ? 's' : ''}',
                        style: const TextStyle(fontSize: 12).copyWith(
                          color: const Color(0xFF667EEA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: widget.onEdit,
                      icon: const Icon(Icons.edit),
                      iconSize: 20,
                      color: const Color(0xFF667EEA),
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
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF667EEA),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (dateList.isNotEmpty) ...[
              const Text(
                'Shift Details:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
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
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF525252),
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
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF525252),
                  ),
                ),
                Text(
                  'Total Hours: ${_calculateTotalHours(startTimeList, endTimeList, breakList)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF667EEA),
                  ),
                ),
              ],
            ),
          ],
        ),
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
              const Text('Additional client details not available',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey)),
            ],
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoSection(
          'Employee Information',
          [
            if (employeeDetails != null) ...[
              _buildInfoRow('Email', employeeDetails!['email'] ?? ''),
              const Text(
                  'Additional employee details available via user management',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey)),
            ] else ...[
              _buildInfoRow('Email', widget.assignment['userEmail'] ?? ''),
              const Text('Additional employee details not available',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey)),
            ],
          ],
        ),
        const SizedBox(height: 16),
      ],
    ];
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: TextStyle(
                fontSize: 12,
                color: value.isNotEmpty ? Colors.black87 : Colors.grey[500],
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
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$startTime - $endTime',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Break: $breakTime',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF525252),
              ),
            ),
          ),
          if (isHighIntensity)
            Icon(Icons.fitness_center,
                size: 16, color: const Color(0xFF667EEA)),
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

class EditAssignmentDialog extends ConsumerStatefulWidget {
  final Map<String, dynamic> assignment;
  final String organizationId;

  const EditAssignmentDialog(
      {super.key, required this.assignment, required this.organizationId});

  @override
  ConsumerState<EditAssignmentDialog> createState() =>
      _EditAssignmentDialogState();
}

class _EditAssignmentDialogState extends ConsumerState<EditAssignmentDialog> {
  @override
  Widget build(BuildContext context) {
    return _buildEditAssignmentDialog();
  }

  final ApiMethod _apiMethod = ApiMethod();
  late Map<String, dynamic> editedAssignment;
  bool isLoading = false;
  NDISItem? _selectedNdisItem;
  String? _selectedNdisItemNumber;
  final NDISMatcher _ndisMatcher = NDISMatcher();

  late List<dynamic> dateList;
  late List<dynamic> startTimeList;
  late List<dynamic> endTimeList;
  late List<dynamic> breakList;
  late List<bool> highIntensityList;

  // New: Support for individual NDIS items per schedule entry
  late List<NDISItem?> scheduleNdisItems;
  late List<Map<String, dynamic>?> scheduleCustomPricing;

  @override
  void initState() {
    super.initState();
    editedAssignment = Map<String, dynamic>.from(widget.assignment);
    _selectedNdisItemNumber = editedAssignment['assignedNdisItemNumber'];
    _loadInitialNdisItem();

    final List<dynamic> scheduleArray = editedAssignment['schedule'] ?? [];
    dateList = scheduleArray.map((item) => item['date'] ?? '').toList();
    startTimeList =
        scheduleArray.map((item) => item['startTime'] ?? '').toList();
    endTimeList = scheduleArray.map((item) => item['endTime'] ?? '').toList();
    breakList = scheduleArray.map((item) => item['break'] ?? '').toList();
    highIntensityList = scheduleArray
        .map((item) => item['highIntensity'] as bool? ?? false)
        .toList();

    // Initialize NDIS items and custom pricing for each schedule entry
    scheduleNdisItems = List<NDISItem?>.filled(scheduleArray.length, null);
    scheduleCustomPricing =
        List<Map<String, dynamic>?>.filled(scheduleArray.length, null);

    // Load existing NDIS items from schedule if available
    for (int i = 0; i < scheduleArray.length; i++) {
      final scheduleItem = scheduleArray[i];
      if (scheduleItem['ndisItem'] != null) {
        // This will be loaded after _ndisMatcher.loadItems() completes
        _loadScheduleNdisItem(i, scheduleItem['ndisItem']);
      }
    }
  }

  Future<void> _loadInitialNdisItem() async {
    await _ndisMatcher.loadItems();
    if (_selectedNdisItemNumber != null && mounted) {
      setState(() {
        _selectedNdisItem =
            _ndisMatcher.getItemByNumber(_selectedNdisItemNumber!);
      });
    }

    // Load existing NDIS items from schedule if available
    final List<dynamic> scheduleArray = editedAssignment['schedule'] ?? [];
    for (int i = 0; i < scheduleArray.length; i++) {
      final scheduleItem = scheduleArray[i];
      if (scheduleItem['ndisItem'] != null) {
        _loadScheduleNdisItem(i, scheduleItem['ndisItem']);
      }
    }
  }

  void _loadScheduleNdisItem(int index, Map<String, dynamic> ndisItemData) {
    if (mounted) {
      setState(() {
        final itemNumber = ndisItemData['itemNumber'];
        if (itemNumber != null) {
          scheduleNdisItems[index] = _ndisMatcher.getItemByNumber(itemNumber);
        }
      });
    }
  }

  Widget _buildEditAssignmentDialog() {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE5E5E5),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Assignment',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: const Color(0xFF6B7280),
                    ),
                    style: IconButton.styleFrom(backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF667EEA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Employee: ${editedAssignment['userEmail'] ?? ''}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Client: ${editedAssignment['clientEmail'] ?? ''}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _selectNdisItem,
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                              text: _selectedNdisItem?.itemName ?? ''),
                          decoration: InputDecoration(
                            labelText: 'Assigned NDIS Item (Optional)',
                            hintText: 'Tap to select NDIS item',
                            border: const OutlineInputBorder(),
                            suffixIcon: _selectedNdisItem != null
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _selectedNdisItem = null;
                                      });
                                    },
                                  )
                                : const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Shifts:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dateList.length,
                        itemBuilder: (context, index) {
                          return _buildEditableShiftCard(
                              index,
                              dateList,
                              startTimeList,
                              endTimeList,
                              breakList,
                              highIntensityList);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFFE5E5E5),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: const Color(0xFFD4D4D4)),
                          foregroundColor: const Color(0xFF6B7280),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          minimumSize: const Size(80, 36),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(100, 36),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
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

  Widget _buildEditableShiftCard(
      int index,
      List<dynamic> dateList,
      List<dynamic> startTimeList,
      List<dynamic> endTimeList,
      List<dynamic> breakList,
      List<bool> highIntensityList) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shift ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
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
                      if (highIntensityList.length > index) {
                        highIntensityList.removeAt(index);
                      }
                      if (scheduleNdisItems.length > index) {
                        scheduleNdisItems.removeAt(index);
                      }
                      if (scheduleCustomPricing.length > index) {
                        scheduleCustomPricing.removeAt(index);
                      }
                    });
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                  child: Text('Date:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(index, dateList),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        index < dateList.length
                            ? dateList[index].toString()
                            : 'Select Date',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                  child: Text('Start:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _selectTime(index, true, startTimeList, endTimeList),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        index < startTimeList.length
                            ? startTimeList[index].toString()
                            : 'Select Time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                  child: Text('End:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _selectTime(index, false, startTimeList, endTimeList),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        index < endTimeList.length
                            ? endTimeList[index].toString()
                            : 'Select Time',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                  child: Text('Break:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: index < breakList.length
                        ? breakList[index].toString()
                        : '0',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      suffixText: 'minutes',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        while (breakList.length <= index) {
                          breakList.add('0');
                        }
                        breakList[index] = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text('High Intensity:',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: Switch(
                    value: index < highIntensityList.length
                        ? highIntensityList[index]
                        : false,
                    onChanged: (value) {
                      setState(() {
                        while (highIntensityList.length <= index) {
                          highIntensityList.add(false);
                        }
                        highIntensityList[index] = value;
                      });
                    },
                    activeThumbColor: const Color(0xFF667EEA),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // NDIS Item selection for this specific schedule entry
            GestureDetector(
              onTap: () => _selectNdisItemForSchedule(index),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text('NDIS Item:',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: Text(
                        index < scheduleNdisItems.length &&
                                scheduleNdisItems[index] != null
                            ? scheduleNdisItems[index]!.itemName
                            : 'Select NDIS Item',
                        style: TextStyle(
                          color: index < scheduleNdisItems.length &&
                                  scheduleNdisItems[index] != null
                              ? Colors.black
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                    if (index < scheduleNdisItems.length &&
                        scheduleNdisItems[index] != null)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () {
                          setState(() {
                            scheduleNdisItems[index] = null;
                            scheduleCustomPricing[index] = null;
                          });
                        },
                      )
                    else
                      const Icon(Icons.search, color: Colors.grey),
                  ],
                ),
              ),
            ),
            // Show custom pricing info if set
            if (index < scheduleCustomPricing.length &&
                scheduleCustomPricing[index] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Custom Price: \$${scheduleCustomPricing[index]!['price']} (${scheduleCustomPricing[index]!['pricingType']})',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.colorPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(int index, List<dynamic> dateList) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        while (dateList.length <= index) {
          dateList.add('');
        }
        final dateParts = picked.toIso8601String().split('T');
        dateList[index] =
            dateParts.isNotEmpty ? dateParts[0] : picked.toIso8601String();
      });
    }
  }

  Future<void> _selectTime(int index, bool isStartTime,
      List<dynamic> startTimeList, List<dynamic> endTimeList) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final timeString =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

      setState(() {
        if (isStartTime) {
          while (startTimeList.length <= index) {
            startTimeList.add('');
          }
          startTimeList[index] = timeString;
        } else {
          while (endTimeList.length <= index) {
            endTimeList.add('');
          }
          endTimeList[index] = timeString;
        }
      });
    }
  }

  Future<void> _selectNdisItem() async {
    // Import the enhanced view at the top of the file
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NdisItemSelectionView(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedNdisItem = result.ndisItem;
        _selectedNdisItemNumber = result.ndisItem.itemNumber;

        // Store custom pricing information if set
        if (result.isCustomPriceSet && result.customPrice != null) {
          editedAssignment['customPricing'] = {
            'price': result.customPrice,
            'pricingType': result.pricingType,
            'isCustom': true,
          };
        } else {
          editedAssignment.remove('customPricing');
        }
      });
    }
  }

  Future<void> _selectNdisItemForSchedule(int index) async {
    // Ensure lists are properly sized
    while (scheduleNdisItems.length <= index) {
      scheduleNdisItems.add(null);
    }
    while (scheduleCustomPricing.length <= index) {
      scheduleCustomPricing.add(null);
    }

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NdisItemSelectionView(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        scheduleNdisItems[index] = result.ndisItem;

        // Store custom pricing information if set
        if (result.isCustomPriceSet && result.customPrice != null) {
          scheduleCustomPricing[index] = {
            'price': result.customPrice,
            'pricingType': result.pricingType,
            'isCustom': true,
          };
        } else {
          scheduleCustomPricing[index] = null;
        }
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    try {
      final userEmail = editedAssignment['userEmail'];
      final clientEmail = editedAssignment['clientEmail'];

      final List<Map<String, dynamic>> updatedSchedule = [];
      final List<Map<String, dynamic>> scheduleWithNdisItems = [];

      debugPrint(
          'DEBUG: scheduleNdisItems length: ${scheduleNdisItems.length}');
      debugPrint(
          'DEBUG: scheduleCustomPricing length: ${scheduleCustomPricing.length}');
      debugPrint('DEBUG: dateList length: ${dateList.length}');

      for (int i = 0; i < dateList.length; i++) {
        updatedSchedule.add({
          'date': dateList[i],
          'startTime': startTimeList[i],
          'endTime': endTimeList[i],
          'break': breakList[i],
          'highIntensity': highIntensityList[i],
        });

        // Prepare schedule entry with NDIS item and custom pricing
        Map<String, dynamic> scheduleEntry = {
          'date': dateList[i],
          'startTime': startTimeList[i],
          'endTime': endTimeList[i],
          'break': breakList[i],
          'highIntensity': highIntensityList[i],
        };

        // Add NDIS item if selected for this schedule entry
        debugPrint(
            'DEBUG: Schedule entry $i - scheduleNdisItems[$i]: ${i < scheduleNdisItems.length ? scheduleNdisItems[i]?.itemNumber : "index out of bounds"}');
        if (i < scheduleNdisItems.length && scheduleNdisItems[i] != null) {
          scheduleEntry['ndisItem'] = scheduleNdisItems[i]!.toJson();
          debugPrint(
              'DEBUG: Added NDIS item to schedule entry $i: ${scheduleNdisItems[i]!.itemNumber}');

          // Add custom pricing if set for this schedule entry
          if (i < scheduleCustomPricing.length &&
              scheduleCustomPricing[i] != null) {
            scheduleEntry['customPricing'] = scheduleCustomPricing[i];
            debugPrint(
                'DEBUG: Added custom pricing to schedule entry $i: ${scheduleCustomPricing[i]}');
          }
        } else {
          debugPrint('DEBUG: No NDIS item found for schedule entry $i');
        }

        scheduleWithNdisItems.add(scheduleEntry);
      }

      // Prepare NDIS item with custom pricing if available (for backward compatibility)
      Map<String, dynamic>? ndisItemWithPricing = _selectedNdisItem?.toJson();
      if (ndisItemWithPricing != null &&
          editedAssignment.containsKey('customPricing')) {
        ndisItemWithPricing['customPricing'] =
            editedAssignment['customPricing'];
      }

      debugPrint('DEBUG: Final scheduleWithNdisItems being sent to backend:');
      for (int i = 0; i < scheduleWithNdisItems.length; i++) {
        debugPrint(
            'DEBUG: scheduleWithNdisItems[$i]: ${scheduleWithNdisItems[i]}');
      }

      final response = await _apiMethod.assignClientToUserWithScheduleItems(
        userEmail,
        clientEmail,
        updatedSchedule.map((s) => s['date'] as String).toList(),
        updatedSchedule.map((s) => s['startTime'] as String).toList(),
        updatedSchedule.map((s) => s['endTime'] as String).toList(),
        updatedSchedule.map((s) => s['break'] as String).toList(),
        ndisItemWithPricing,
        updatedSchedule.map((s) => s['highIntensity'] as bool).toList(),
        scheduleWithNdisItems, // New parameter for individual NDIS items
      );

      if (!mounted) return;

      if (response['success'] != true) {
        throw Exception(response['error'] ?? 'Failed to update assignment');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Assignment updated successfully'),
        ),
      );

      Navigator.of(context).pop();

      ref
          .read(assignmentListViewModelProvider.notifier)
          .loadOrganizationAssignments(widget.organizationId);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating assignment: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
