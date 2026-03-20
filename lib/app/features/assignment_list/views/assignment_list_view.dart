import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/assignment_list/views/edit_assignment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/assignment_list/viewmodels/assignment_list_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  BoxDecoration _panelDecoration({
    Color color = BauhausDesign.surfaceLight,
    Color borderColor = BauhausDesign.neutral,
    double borderWidth = 2,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: const [BauhausDesign.shadowHardXs],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(assignmentListViewModelProvider.notifier)
          .loadOrganizationAssignments(widget.organizationId);
    });

    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (query != _searchQuery) {
        setState(() {
          _searchQuery = query;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredAssignments(
      List<Map<String, dynamic>> assignments) {
    if (_searchQuery.isEmpty) return assignments;

    final query = _searchQuery.toLowerCase();
    return assignments.where((assignment) {
      final userEmail =
          (assignment['userEmail'] ?? '').toString().toLowerCase();
      final clientEmail =
          (assignment['clientEmail'] ?? '').toString().toLowerCase();
      final assignmentId = (assignment['_id'] ?? '').toString().toLowerCase();

      final scheduleArray = assignment['schedule'] as List<dynamic>? ?? [];
      final scheduleText = scheduleArray
          .map((item) =>
              '${item['date'] ?? ''} ${item['startTime'] ?? ''} ${item['endTime'] ?? ''}')
          .join(' ')
          .toLowerCase();

      return userEmail.contains(query) ||
          clientEmail.contains(query) ||
          assignmentId.contains(query) ||
          scheduleText.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assignmentListViewModelProvider);
    final viewModel = ref.read(assignmentListViewModelProvider.notifier);
    final filteredAssignments = _getFilteredAssignments(state.assignments);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(state, viewModel),
            Expanded(
              child: _buildBody(state, viewModel, filteredAssignments),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      AssignmentListState state, AssignmentListViewModel viewModel) {
    final filteredAssignments = _getFilteredAssignments(state.assignments);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        BauhausDesign.space4,
        BauhausDesign.space3,
        BauhausDesign.space4,
        BauhausDesign.space3,
      ),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              BauhausIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back,
                variant: BauhausActionVariant.neutral,
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.assignmentList.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              BauhausIconButton(
                onPressed: () =>
                    viewModel.refreshAssignments(widget.organizationId),
                icon: Icons.refresh,
                variant: BauhausActionVariant.neutral,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: _panelDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: _buildHeaderStat(
                    title: AppLocalizations.of(context)!.assignments,
                    value: '${state.assignments.length}',
                    icon: Icons.assignment_outlined,
                    color: BauhausDesign.secondary,
                  ),
                ),
                Container(
                  width: 2,
                  height: 42,
                  color: BauhausDesign.neutral.withValues(alpha: 0.2),
                ),
                Expanded(
                  child: _buildHeaderStat(
                    title: AppLocalizations.of(context)!.totalHours,
                    value: viewModel.getTotalHours().toStringAsFixed(1),
                    icon: Icons.schedule,
                    color: BauhausDesign.primary,
                  ),
                ),
                if (_searchQuery.isNotEmpty) ...[
                  Container(
                    width: 2,
                    height: 42,
                    color: BauhausDesign.neutral.withValues(alpha: 0.2),
                  ),
                  Expanded(
                    child: _buildHeaderStat(
                      title: 'Filtered',
                      value: '${filteredAssignments.length}',
                      icon: Icons.filter_alt,
                      color: BauhausDesign.success,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Container(
            decoration: _panelDecoration(),
            padding:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space3),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: BauhausDesign.textMuted,
                  size: 18,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(color: BauhausDesign.textDark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by employee, client, date, or ID',
                      hintStyle: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  InkWell(
                    onTap: () {
                      _searchController.clear();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(BauhausDesign.space1),
                      child: Icon(
                        Icons.close,
                        color: BauhausDesign.textMuted,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: BauhausDesign.space1),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context)
                      .labelSmall
                      ?.copyWith(color: BauhausDesign.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    AssignmentListState state,
    AssignmentListViewModel viewModel,
    List<Map<String, dynamic>> filteredAssignments,
  ) {
    if (state.isLoading) {
      return const BauhausLoadingState();
    }

    if (state.errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: BauhausErrorState(
          title: AppLocalizations.of(context)!.errorLoadingAssignments,
          description: state.errorMessage,
          onRetry: () =>
              viewModel.loadOrganizationAssignments(widget.organizationId),
        ),
      );
    }

    if (state.assignments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: BauhausEmptyState(
          title: AppLocalizations.of(context)!.noAssignmentsFound,
          message: AppLocalizations.of(context)!.noAssignmentsMessage,
          icon: Icons.assignment_outlined,
          onAction: () =>
              viewModel.loadOrganizationAssignments(widget.organizationId),
          actionLabel: AppLocalizations.of(context)!.retryButton,
        ),
      );
    }

    if (filteredAssignments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: BauhausEmptyState(
          title: 'No Matching Assignments',
          message: 'Try a different search term.',
          icon: Icons.search_off,
          onAction: () => _searchController.clear(),
          actionLabel: 'Clear Search',
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.refreshAssignments(widget.organizationId),
      child: ListView.separated(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        itemCount: filteredAssignments.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: BauhausDesign.space3),
        itemBuilder: (context, index) {
          final assignment = filteredAssignments[index];
          return _buildAssignmentCard(assignment, context);
        },
      ),
    );
  }

  Widget _buildAssignmentCard(
      Map<String, dynamic> assignment, BuildContext context) {
    try {
      return EnhancedAssignmentCard(
        assignment: assignment,
        onEdit: () => _showEditDialog(context, assignment),
      );
    } catch (e, stackTrace) {
      debugPrint('Error building assignment card: $e\n$stackTrace');
      return Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: _panelDecoration(
          color: BauhausDesign.error.withValues(alpha: 0.08),
          borderColor: BauhausDesign.error,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline, color: BauhausDesign.error),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Error displaying assignment',
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                    color: BauhausDesign.error,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              e.toString(),
              style: BauhausDesign.getTextTheme(context)
                  .labelSmall
                  ?.copyWith(color: BauhausDesign.textMuted),
            ),
          ],
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

class EnhancedAssignmentCard extends ConsumerStatefulWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback onEdit;

  const EnhancedAssignmentCard({
    super.key,
    required this.assignment,
    required this.onEdit,
  });

  @override
  ConsumerState<EnhancedAssignmentCard> createState() =>
      _EnhancedAssignmentCardState();
}

class _EnhancedAssignmentCardState
    extends ConsumerState<EnhancedAssignmentCard> {
  late final ApiMethod _apiMethod;
  Patient? clientDetails;
  Map<String, dynamic>? employeeDetails;
  bool isLoadingDetails = false;
  bool showFullDetails = false;

  BoxDecoration _panelDecoration({
    Color color = BauhausDesign.surfaceLight,
    Color borderColor = BauhausDesign.neutral,
    double borderWidth = 2,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: const [BauhausDesign.shadowHardXs],
    );
  }

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
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
    final String userEmail = widget.assignment['userEmail'] ?? '';
    final String clientEmail = widget.assignment['clientEmail'] ?? '';

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

    final shiftCount =
        scheduleArray.isNotEmpty ? scheduleArray.length : dateList.length;
    final String createdAt = widget.assignment['createdAt'] ?? '';

    final employeeFullName =
        ('${employeeDetails?['firstName'] ?? ''} ${employeeDetails?['lastName'] ?? ''}')
            .trim();
    final employeeName = employeeFullName.isNotEmpty
        ? employeeFullName
        : _getDisplayName(userEmail, AppLocalizations.of(context)!.employee);

    final clientFullName =
        ('${clientDetails?.clientFirstName ?? ''} ${clientDetails?.clientLastName ?? ''}')
            .trim();
    final clientName = clientFullName.isNotEmpty
        ? clientFullName
        : _getDisplayName(clientEmail, AppLocalizations.of(context)!.client);

    return Container(
      decoration: _panelDecoration(),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(employeeName, clientName, shiftCount),
          const SizedBox(height: BauhausDesign.space3),
          _buildMetaRow(createdAt, startTimeList, endTimeList, breakList),
          const SizedBox(height: BauhausDesign.space3),
          _buildShiftPreview(
            dateList,
            startTimeList,
            endTimeList,
            breakList,
            highIntensityList,
            shiftCount,
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildDetailsToggle(),
          if (showFullDetails) ...[
            const SizedBox(height: BauhausDesign.space3),
            ..._buildDetailedInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(String employeeName, String clientName, int shiftCount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabeledValue(
                AppLocalizations.of(context)!.employee,
                employeeName,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: BauhausDesign.space2),
              _buildLabeledValue(
                AppLocalizations.of(context)!.client,
                clientName,
                icon: Icons.business_outlined,
              ),
            ],
          ),
        ),
        const SizedBox(width: BauhausDesign.space2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space1,
              ),
              decoration: _panelDecoration(
                color: BauhausDesign.surfaceLight,
                borderColor: BauhausDesign.primary,
                borderWidth: 2,
              ),
              child: Text(
                '$shiftCount Shift${shiftCount == 1 ? '' : 's'}',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      fontSize: BauhausDesign.fontMd,
                      color: BauhausDesign.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Container(
              decoration: _panelDecoration(),
              child: InkWell(
                onTap: widget.onEdit,
                child: Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit,
                          size: 16, color: BauhausDesign.primary),
                      const SizedBox(width: BauhausDesign.space1),
                      Text(
                        AppLocalizations.of(context)!.edit,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              fontSize: BauhausDesign.fontSm,
                              color: BauhausDesign.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabeledValue(String label, String value,
      {required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: BauhausDesign.textMuted),
        const SizedBox(width: BauhausDesign.space1),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: BauhausDesign.getTextTheme(context)
                    .labelSmall
                    ?.copyWith(color: BauhausDesign.textMuted),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style:
                    BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetaRow(String createdAt, List<dynamic> startTimeList,
      List<dynamic> endTimeList, List<dynamic> breakList) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: _panelDecoration(
        color: BauhausDesign.backgroundLight,
        borderColor: BauhausDesign.neutral.withValues(alpha: 0.4),
        borderWidth: 1.5,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 14, color: BauhausDesign.textMuted),
                const SizedBox(width: BauhausDesign.space1),
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.createdLabel}: ${_formatDate(createdAt)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(color: BauhausDesign.textMuted),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          Text(
            '${AppLocalizations.of(context)!.totalHours}: ${_calculateTotalHours(startTimeList, endTimeList, breakList)}',
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftPreview(
    List<dynamic> dateList,
    List<dynamic> startTimeList,
    List<dynamic> endTimeList,
    List<dynamic> breakList,
    List<dynamic> highIntensityList,
    int shiftCount,
  ) {
    if (dateList.isEmpty) {
      return Text(
        AppLocalizations.of(context)!.noAssignmentData,
        style: BauhausDesign.getTextTheme(context)
            .bodyMedium
            ?.copyWith(color: BauhausDesign.textMuted),
      );
    }

    final previewCount = shiftCount > 3 ? 3 : shiftCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.schedule,
                size: 16, color: BauhausDesign.secondary),
            const SizedBox(width: BauhausDesign.space1),
            Text(
              AppLocalizations.of(context)!.shiftDetails,
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space2),
        ...List.generate(
          previewCount,
          (index) => Padding(
            padding: EdgeInsets.only(
              bottom: index == previewCount - 1 ? 0 : BauhausDesign.space2,
            ),
            child: _buildShiftRow(
              dateList.length > index ? dateList[index]?.toString() ?? '' : '',
              startTimeList.length > index
                  ? startTimeList[index]?.toString() ?? ''
                  : '',
              endTimeList.length > index
                  ? endTimeList[index]?.toString() ?? ''
                  : '',
              breakList.length > index
                  ? breakList[index]?.toString() ?? ''
                  : '',
              highIntensityList.length > index
                  ? highIntensityList[index] as bool
                  : false,
            ),
          ),
        ),
        if (shiftCount > 3) ...[
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'and ${shiftCount - 3} more shift${shiftCount - 3 == 1 ? '' : 's'}',
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailsToggle() {
    return Container(
      decoration: _panelDecoration(
        color: showFullDetails
            ? BauhausDesign.primary
            : BauhausDesign.surfaceLight,
        borderColor:
            showFullDetails ? BauhausDesign.neutral : BauhausDesign.neutral,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            showFullDetails = !showFullDetails;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3,
            vertical: BauhausDesign.space2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                showFullDetails ? Icons.expand_less : Icons.expand_more,
                size: 18,
                color: showFullDetails
                    ? BauhausDesign.surfaceLight
                    : BauhausDesign.textDark,
              ),
              const SizedBox(width: BauhausDesign.space1),
              Text(
                showFullDetails ? 'Hide Details' : 'Show Details',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: showFullDetails
                          ? BauhausDesign.surfaceLight
                          : BauhausDesign.textDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDetailedInfo() {
    return [
      if (isLoadingDetails)
        const Padding(
          padding: EdgeInsets.all(BauhausDesign.space3),
          child: BauhausLoadingState(showMessage: false),
        )
      else ...[
        _buildInfoSection(
          AppLocalizations.of(context)!.clientInformationTitle,
          [
            if (clientDetails != null) ...[
              _buildInfoRow(
                'Name',
                '${clientDetails!.clientFirstName} ${clientDetails!.clientLastName}',
              ),
              _buildInfoRow('Email', clientDetails!.clientEmail),
              _buildInfoRow(
                'Phone',
                clientDetails!.clientPhone ?? 'Phone Number Not Provided',
              ),
              _buildInfoRow(
                'Address',
                '${clientDetails!.clientAddress}, ${clientDetails!.clientCity}, ${clientDetails!.clientState} ${clientDetails!.clientZip}',
              ),
            ] else ...[
              _buildInfoRow('Email', widget.assignment['clientEmail'] ?? ''),
              _buildInfoRow(
                  'Details', 'Additional client details not available'),
            ],
          ],
        ),
        const SizedBox(height: BauhausDesign.space3),
        _buildInfoSection(
          'Employee Information',
          [
            if (employeeDetails != null) ...[
              _buildInfoRow('Email', employeeDetails!['email'] ?? ''),
              _buildInfoRow(
                'Details',
                'Additional employee details available via user management',
              ),
            ] else ...[
              _buildInfoRow('Email', widget.assignment['userEmail'] ?? ''),
              _buildInfoRow(
                  'Details', 'Additional employee details not available'),
            ],
          ],
        ),
      ],
    ];
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: _panelDecoration(
        color: BauhausDesign.backgroundLight,
        borderColor: BauhausDesign.neutral.withValues(alpha: 0.3),
        borderWidth: 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final hasValue = value.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: Text(
              '$label:',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              hasValue ? value : 'Not provided',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: hasValue
                        ? BauhausDesign.textDark
                        : BauhausDesign.textMuted,
                    fontStyle: hasValue ? FontStyle.normal : FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftRow(String date, String startTime, String endTime,
      String breakTime, bool isHighIntensity) {
    final dateValue = _formatShiftDate(date);
    final timeValue =
        '${_toInlineValue(startTime)} - ${_toInlineValue(endTime)}';
    final breakValue = _toInlineValue(breakTime).isEmpty
        ? AppLocalizations.of(context)!.unknown
        : _toInlineValue(breakTime);

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: _panelDecoration(
        color: BauhausDesign.backgroundLight,
        borderColor: BauhausDesign.neutral.withValues(alpha: 0.3),
        borderWidth: 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: BauhausDesign.secondary,
              ),
              const SizedBox(width: BauhausDesign.space1),
              Text(
                '${AppLocalizations.of(context)!.dateLabel}: ',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Expanded(
                child: Text(
                  dateValue,
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            fontSize: BauhausDesign.fontMd,
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.schedule,
                size: 14,
                color: BauhausDesign.secondary,
              ),
              const SizedBox(width: BauhausDesign.space1),
              Text(
                '${AppLocalizations.of(context)!.startLabel} - ${AppLocalizations.of(context)!.endLabel}: ',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Expanded(
                child: Text(
                  timeValue,
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            fontSize: BauhausDesign.fontMd,
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.coffee_outlined,
                size: 14,
                color: BauhausDesign.secondary,
              ),
              const SizedBox(width: BauhausDesign.space1),
              Text(
                '${AppLocalizations.of(context)!.breakLabel}: ',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Expanded(
                child: Text(
                  breakValue,
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            fontSize: BauhausDesign.fontMd,
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ),
              if (isHighIntensity)
                Container(
                  margin: const EdgeInsets.only(left: BauhausDesign.space1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space1,
                    vertical: 2,
                  ),
                  decoration: _panelDecoration(
                    color: BauhausDesign.primary.withValues(alpha: 0.1),
                    borderColor: BauhausDesign.primary,
                    borderWidth: 1.5,
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 12,
                    color: BauhausDesign.primary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _toInlineValue(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String _getDisplayName(String email, String fallback) {
    if (email.isEmpty) return fallback;
    final parts = email.split('@');
    if (parts.isNotEmpty) {
      return parts[0].replaceAll('.', ' ').replaceAll('_', ' ');
    }
    return email;
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return AppLocalizations.of(context)!.unknown;
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return dateString;
    }
  }

  String _formatShiftDate(String dateString) {
    if (dateString.isEmpty) return AppLocalizations.of(context)!.unknown;
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('EEE, MMM dd').format(date);
    } catch (_) {
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
