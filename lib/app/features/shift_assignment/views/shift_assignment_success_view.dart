import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/services.dart';
import '../viewmodels/shift_assignment_success_viewmodel.dart';
import '../widgets/animated_success_header.dart';
import '../widgets/animated_shift_card.dart';

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
      body: AnimatedBuilder(
        animation: _surfaceController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.colorPrimary.withOpacity(0.1),
                  AppColors.colorBackground,
                  AppColors.colorSecondary.withOpacity(0.1),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                    child: _buildContent(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.colorBackground,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorGrey300.withOpacity(0.1),
                          blurRadius: 10.0,
                          offset: const Offset(0, -2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.colorPrimary,
            ),
            style: IconButton.styleFrom(backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Assignment Complete',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: AppColors.colorPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: _shareAssignment,
            icon: const Icon(
              Icons.share_rounded,
              color: AppColors.colorPrimary,
            ),
            style: IconButton.styleFrom(backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.colorPrimary,
          ),
          SizedBox(height: 16.0),
          Text(
            'Processing assignment...',
            style: TextStyle(
              color: AppColors.colorGrey600,
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64.0,
              color: AppColors.colorWarning,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Something went wrong',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              _viewModel.error!,
              style: TextStyle(
                color: AppColors.colorGrey600,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _viewModel.clearError();
                _initializeData();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                foregroundColor: AppColors.colorWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No assignment data available',
        style: TextStyle(
          color: AppColors.colorGrey600,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildSuccessContent() {
    final assignment = _viewModel.assignment!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Success Header
          AnimatedSuccessHeader(
            employeeName: _viewModel.getEmployeeName(),
            clientName: _viewModel.getClientName(),
            assignmentSummary: assignment.assignmentSummary,
            onAnimationComplete: _onHeaderAnimationComplete,
          ),

          const SizedBox(height: 24.0),

          // Summary Stats
          _buildSummaryStats(),

          const SizedBox(height: 24.0),

          // Shifts Section
          if (_showShifts) ...[
            _buildShiftsHeader(),
            const SizedBox(height: 16.0),
            _buildShiftsList(),
            const SizedBox(height: 16.0),
            _buildActionButtons()
          ],

          const SizedBox(height: 24.0), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return AnimatedOpacity(
      opacity: _showShifts ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorGrey300.withOpacity(0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 4.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: Icons.schedule_rounded,
                label: 'Total Hours',
                value: _viewModel.getTotalWorkingHours(),
                color: AppColors.colorBlue,
              ),
            ),
            Container(
              width: 1.0,
              height: 40.0,
              color: AppColors.colorGrey200,
            ),
            Expanded(
              child: _buildStatItem(
                icon: Icons.event_rounded,
                label: 'Total Shifts',
                value: '${_viewModel.assignment!.totalShifts}',
                color: AppColors.colorSecondary,
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
        Icon(
          icon,
          color: color,
          size: 24.0,
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: AppColors.colorGrey600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildShiftsHeader() {
    return Row(
      children: [
        Icon(
          Icons.list_alt_rounded,
          color: AppColors.colorPrimary,
          size: 24.0,
        ),
        const SizedBox(width: 8.0),
        const Text(
          'Assigned Shifts',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: AppColors.colorPrimary,
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

  /// Modern action buttons with gradient design and enhanced animations
  Widget _buildActionButtons() {
    return AnimatedBuilder(
      animation: _actionButtonController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50.0 * (1.0 - _actionButtonAnimation.value)),
          child: Opacity(
            opacity: _actionButtonAnimation.value.clamp(0.0, 1.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorPrimary.withOpacity(0.1),
                    blurRadius: 24.0,
                    offset: const Offset(0, -8.0),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.colorBlack.withOpacity(0.1),
                    blurRadius: 16.0,
                    offset: const Offset(0, 4.0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Primary action button with gradient
                  Container(
                    height: 56.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.colorPrimary,
                          AppColors.colorSecondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.colorPrimary.withOpacity(0.1),
                          blurRadius: 12.0,
                          offset: const Offset(0, 4.0),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _goToDashboard,
                        borderRadius: BorderRadius.circular(16.0),
                        splashColor:
                            AppColors.colorWhite.withOpacity(0.1),
                        highlightColor:
                            AppColors.colorWhite.withOpacity(0.1),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.dashboard_rounded,
                                color: AppColors.colorWhite,
                                size: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Go to Dashboard',
                                style: TextStyle(
                                  color: AppColors.colorWhite,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Secondary action button with modern outline design
                  Container(
                    height: 56.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.colorPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: AppColors.colorPrimary.withOpacity(0.1),
                        width: 1.5,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _viewAssignments,
                        borderRadius: BorderRadius.circular(16.0),
                        splashColor:
                            AppColors.colorPrimary.withOpacity(0.1),
                        highlightColor:
                            AppColors.colorPrimary.withOpacity(0.1),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.assignment_rounded,
                                color: AppColors.colorPrimary,
                                size: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'View All Assignments',
                                style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
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
          ),
        );
      },
    );
  }

  void _shareAssignment() {
    if (_viewModel.hasAssignment) {
      final assignment = _viewModel.assignment!;
      final shareText = '''
Shift Assignment Complete!

Employee: ${_viewModel.getEmployeeName()}
Client: ${_viewModel.getClientName()}
Total Shifts: ${assignment.totalShifts}
Total Hours: ${_viewModel.getTotalWorkingHours()}

Assignment ID: ${assignment.assignmentId}
''';

      // Copy to clipboard
      Clipboard.setData(ClipboardData(text: shareText));

      // Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Assignment details copied to clipboard'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
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
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Shift ${index + 1} Details',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ...shiftDetails.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      '${entry.key.toUpperCase()}: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorGrey600,
                      ),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorFontPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
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
    final userRole = sharedPrefs.getRole();
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
