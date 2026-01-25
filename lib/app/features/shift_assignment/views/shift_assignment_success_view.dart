import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/services.dart';
import '../viewmodels/shift_assignment_success_viewmodel.dart';
import '../widgets/animated_success_header.dart';
import '../widgets/animated_shift_card.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Modern animated view for displaying shift assignment success
class ShiftAssignmentSuccessView extends StatefulWidget {
  final String userEmail;
  final String clientEmail;
  final Map<String, dynamic> shiftData;
  final String? assignmentId;

  const ShiftAssignmentSuccessView({
    super.key,
    required this.userEmail,
    required this.clientEmail,
    required this.shiftData,
    this.assignmentId,
  });

  @override
  State<ShiftAssignmentSuccessView> createState() =>
      _ShiftAssignmentSuccessViewState();
}

class _ShiftAssignmentSuccessViewState extends State<ShiftAssignmentSuccessView>
    with TickerProviderStateMixin {
  late ShiftAssignmentSuccessViewModel _viewModel;
  late AnimationController _surfaceController;
  late AnimationController _actionButtonController;
  late Animation<double> _surfaceAnimation;
  late Animation<double> _actionButtonAnimation;
  bool _showShifts = false;

  @override
  void initState() {
    super.initState();
    _setupViewModel();
    _setupAnimations();
    _initializeData();
  }

  void _setupViewModel() {
    _viewModel = ShiftAssignmentSuccessViewModel();
  }

  void _setupAnimations() {
    _surfaceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _actionButtonController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _surfaceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _surfaceController,
      curve: Curves.easeOut,
    ));

    _actionButtonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _actionButtonController,
      curve: Curves.elasticOut,
    ));

    _surfaceController.forward();
  }

  void _initializeData() {
    _viewModel.initializeAssignment(
      userEmail: widget.userEmail,
      clientEmail: widget.clientEmail,
      shiftData: widget.shiftData,
      assignmentId: widget.assignmentId,
    );
  }

  void _onHeaderAnimationComplete() {
    setState(() {
      _showShifts = true;
    });
    _actionButtonController.forward();
  }

  @override
  void dispose() {
    _surfaceController.dispose();
    _actionButtonController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: AnimatedBuilder(
        animation: _surfaceController,
        builder: (context, child) {
          return Column(
            children: [
              _buildBauhausAppBar(),
              Expanded(
                child: _buildContent(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBauhausAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + BauhausDesign.space2,
        left: BauhausDesign.space4,
        right: BauhausDesign.space4,
        bottom: BauhausDesign.space2,
      ),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      child: Row(
        children: [
          BauhausIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icons.arrow_back,
            variant: BauhausActionVariant.ghost,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.assignmentComplete,
              style: BauhausDesign.getTextTheme(context).displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
          BauhausIconButton(
            onPressed: _shareAssignment,
            icon: Icons.share_rounded,
            variant: BauhausActionVariant.ghost,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        if (_viewModel.isLoading) {
          return _buildLoadingState();
        }

        if (_viewModel.error != null) {
          return _buildErrorState();
        }

        if (!_viewModel.hasAssignment) {
          return _buildEmptyState();
        }

        return _buildSuccessContent();
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: BauhausDesign.primary),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            AppLocalizations.of(context)!.processingAssignment,
            style: TextStyle(
              color: BauhausDesign.textMuted,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: BauhausErrorState(
          message: _viewModel.error!,
          onRetry: () {
            _viewModel.clearError();
            _initializeData();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: BauhausEmptyState(
        title: AppLocalizations.of(context)!.noData,
        subtitle: AppLocalizations.of(context)!.noAssignmentData,
        icon: Icons.assignment_outlined,
      ),
    );
  }

  Widget _buildSuccessContent() {
    final assignment = _viewModel.assignment!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      child: Column(
        children: [
          // Success Header
          AnimatedSuccessHeader(
            employeeName: _viewModel.getEmployeeName(
                defaultName: AppLocalizations.of(context)!.unknownEmployee),
            clientName: _viewModel.getClientName(
                defaultName: AppLocalizations.of(context)!.unknownClient),
            assignmentSummary: assignment.assignmentSummary,
            onAnimationComplete: _onHeaderAnimationComplete,
          ),

          const SizedBox(height: BauhausDesign.space6),

          // Summary Stats
          _buildSummaryStats(),

          const SizedBox(height: BauhausDesign.space6),

          // Shifts Section
          if (_showShifts) ...[
            _buildShiftsHeader(),
            const SizedBox(height: BauhausDesign.space4),
            _buildShiftsList(),
            const SizedBox(height: BauhausDesign.space4),
            _buildActionButtons()
          ],

          const SizedBox(height: BauhausDesign.space6), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return AnimatedOpacity(
      opacity: _showShifts ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: BauhausCard(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: Icons.schedule_rounded,
                label: AppLocalizations.of(context)!.totalHours,
                value: _viewModel.getTotalWorkingHours(
                    hoursSuffix: AppLocalizations.of(context)!.hoursSuffix),
                color: BauhausDesign.info,
              ),
            ),
            Container(
              width: 2,
              height: 40.0,
              color: BauhausDesign.neutral.withOpacity(0.3),
            ),
            Expanded(
              child: _buildStatItem(
                icon: Icons.event_rounded,
                label: AppLocalizations.of(context)!.totalShifts,
                value: '${_viewModel.assignment!.totalShifts}',
                color: BauhausDesign.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.0),
        const SizedBox(height: BauhausDesign.space2),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildShiftsHeader() {
    return Row(
      children: [
        const Icon(
          Icons.list_alt_rounded,
          color: BauhausDesign.primary,
          size: 24.0,
        ),
        const SizedBox(width: BauhausDesign.space2),
        Text(
          AppLocalizations.of(context)!.assignedShifts,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.primary,
              ),
        ),
      ],
    );
  }

  Widget _buildShiftsList() {
    final assignment = _viewModel.assignment!;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: assignment.totalShifts,
      itemBuilder: (context, index) {
        return AnimatedShiftCard(
          shiftDetails: _viewModel.getShiftDetails(index),
          index: index,
          delay: Duration(milliseconds: 200 * index),
          onTap: () => _showShiftDetails(index),
        );
      },
    );
  }

  /// Modern action buttons with Bauhaus design
  Widget _buildActionButtons() {
    return AnimatedBuilder(
      animation: _actionButtonController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50.0 * (1.0 - _actionButtonAnimation.value)),
          child: Opacity(
            opacity: _actionButtonAnimation.value.clamp(0.0, 1.0),
            child: BauhausCard(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              child: Column(
                children: [
                  // Primary action button
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!.goToDashboard,
                    onPressed: _goToDashboard,
                    icon: Icons.dashboard_rounded,
                    variant: BauhausActionVariant.primary,
                    isFullWidth: true,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  // Secondary action button
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!.viewAllAssignments,
                    onPressed: _viewAssignments,
                    icon: Icons.assignment_rounded,
                    variant: BauhausActionVariant.secondary,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _shareAssignment() {
    if (_viewModel.hasAssignment) {
      final assignment = _viewModel.assignment!;
      final shareText = '''
${AppLocalizations.of(context)!.shiftAssignmentComplete}

${AppLocalizations.of(context)!.employee}: ${_viewModel.getEmployeeName(defaultName: AppLocalizations.of(context)!.unknownEmployee)}
${AppLocalizations.of(context)!.client}: ${_viewModel.getClientName(defaultName: AppLocalizations.of(context)!.unknownClient)}
${AppLocalizations.of(context)!.totalShifts}: ${assignment.totalShifts}
${AppLocalizations.of(context)!.totalHours}: ${_viewModel.getTotalWorkingHours(hoursSuffix: AppLocalizations.of(context)!.hoursSuffix)}

${AppLocalizations.of(context)!.assignmentId}: ${assignment.assignmentId}
''';

      // Copy to clipboard
      Clipboard.setData(ClipboardData(text: shareText));

      // Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: BauhausDesign.surfaceWhite),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                AppLocalizations.of(context)!.assignmentDetailsCopied,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.surfaceWhite,
                    ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: BauhausDesign.success,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            side: const BorderSide(color: BauhausDesign.neutral, width: 1.5),
          ),
        ),
      );
    }
  }

  void _showShiftDetails(int index) {
    final shiftDetails = _viewModel.getShiftDetails(index);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(BauhausDesign.radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.shiftIndexDetails(index + 1),
                  style:
                      BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.primary,
                          ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            ...shiftDetails.entries.map(
              (entry) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: BauhausDesign.space2),
                child: Row(
                  children: [
                    Text(
                      '${entry.key.toUpperCase()}: ',
                      style: BauhausDesign.getTextTheme(context)
                          .labelMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                    Text(
                      entry.value,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: BauhausDesign.textDark,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
        ),
      ),
    );
  }

  void _viewAssignments() async {
    // Navigate to assignment list
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();

    final userEmail = await sharedPrefs.getUserEmailFromSharedPreferences();
    final organizationId = sharedPrefs.getString('organizationId');
    final organizationName = sharedPrefs.getString('organizationName');
    final organizationCode = sharedPrefs.getString('organizationCode');

    Navigator.of(context).pushNamed(
      Routes.assignmentList,
      arguments: {
        'userEmail': userEmail ?? widget.userEmail,
        'organizationId': organizationId,
        'organizationName': organizationName,
        'organizationCode': organizationCode,
      },
    );
  }

  void _goToDashboard() async {
    // Navigate back to bottom navigation with dashboard/home tab
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();

    final userEmail = await sharedPrefs.getUserEmailFromSharedPreferences();
    final userRole = sharedPrefs.getRole();
    final organizationId = sharedPrefs.getString('organizationId');
    final organizationName = sharedPrefs.getString('organizationName');
    final organizationCode = sharedPrefs.getString('organizationCode');

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.admin,
      (route) => true,
      arguments: {
        'email': userEmail ?? widget.userEmail,
        'role': userRole ?? UserRole.normal,
        'organizationId': organizationId,
        'organizationName': organizationName,
        'organizationCode': organizationCode,
      },
    );
  }
}
