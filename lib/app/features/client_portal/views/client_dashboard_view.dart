import 'package:carenest/app/core/utils/permission_manager.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/repositories/realtime_portal_repository.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/requests/models/request_model.dart';
import 'package:carenest/app/features/requests/repositories/request_repository.dart';
import 'client_invoice_list_view.dart';

import 'client_appointment_view.dart';
import 'client_portal_dashboard.dart';

class ClientDashboardView extends ConsumerStatefulWidget {
  final String? clientId;
  final bool isFamilyViewer;

  const ClientDashboardView({
    super.key,
    this.clientId,
    this.isFamilyViewer = false,
  });

  @override
  ConsumerState<ClientDashboardView> createState() =>
      _ClientDashboardViewState();
}

class _ClientDashboardViewState extends ConsumerState<ClientDashboardView> {
  int _currentIndex = 0;
  FamilyPermissions? _viewerPermissions;
  bool _permissionsFetched = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await PermissionManager.requestNotificationPermission(context);
        if (widget.isFamilyViewer && widget.clientId != null) {
          _loadMyPermissions();
        }
      }
    });
  }

  @override
  void didUpdateWidget(ClientDashboardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final needsReload =
        (widget.isFamilyViewer != oldWidget.isFamilyViewer ||
            widget.clientId != oldWidget.clientId) &&
        widget.isFamilyViewer &&
        widget.clientId != null;
    if (needsReload) {
      _permissionsFetched = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadMyPermissions();
      });
    }
  }

  Future<void> _loadMyPermissions() async {
    if (widget.clientId == null) return;
    try {
      final apiMethod = ref.read(app_providers.apiMethodProvider);
      final repository = RealtimePortalRepository(apiMethod);
      final permissions = await repository.getMyFamilyPermissions(
        clientId: widget.clientId!,
      );
      debugPrint(
        '🔐 FAMILY PERMISSIONS: '
        'appointments=${permissions?.viewAppointments}, '
        'invoices=${permissions?.viewInvoices}, '
        'messages=${permissions?.viewMessages}, '
        'location=${permissions?.viewLocation}, '
        'manage=${permissions?.manageFamily}, '
        'feedback=${permissions?.approveServices}',
      );
      if (!mounted) return;
      setState(() {
        _viewerPermissions = permissions;
        _permissionsFetched = true;
      });
    } catch (e) {
      debugPrint('Error loading family permissions: $e');
      debugPrint('Stack: ${StackTrace.current}');
      if (!mounted) return;
      setState(() => _permissionsFetched = true);
    }
  }

  bool _canViewInvoices() =>
      !widget.isFamilyViewer || (_viewerPermissions?.viewInvoices ?? false);

  bool _canViewAppointments() =>
      !widget.isFamilyViewer || (_viewerPermissions?.viewAppointments ?? false);

  @override
  Widget build(BuildContext context) {
    final viewerPermissions = widget.isFamilyViewer ? _viewerPermissions : null;
    final showInvoices = _canViewInvoices();
    final showAppointments = _canViewAppointments() || !_permissionsFetched;

    final pages = <Widget>[
      ClientPortalDashboardBody(
        clientId: widget.clientId,
        showHeroHeader: false,
        useSafeArea: false,
        isFamilyViewer: widget.isFamilyViewer,
        viewerPermissions: viewerPermissions,
        footer: widget.isFamilyViewer
            ? null
            : _buildDeleteAccountFooter(context),
      ),
    ];

    if (showInvoices) {
      pages.add(ClientInvoiceListView(isFamilyViewer: widget.isFamilyViewer));
    }

    if (showAppointments) {
      pages.add(
        ClientAppointmentView(
          clientId: widget.clientId,
          isFamilyViewer: widget.isFamilyViewer,
        ),
      );
    }

    final headerTitle = widget.isFamilyViewer
        ? 'FAMILY DASHBOARD'
        : 'CLIENT DASHBOARD';
    final headerSubtitle = widget.isFamilyViewer
        ? 'View your loved one\'s care updates'
        : 'Manage services, invoices, and appointments';

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space4,
                  vertical: BauhausDesign.space3,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space2),
                      decoration: BoxDecoration(
                        color: widget.isFamilyViewer
                            ? BauhausDesign.warning.withValues(alpha: 0.1)
                            : BauhausDesign.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: widget.isFamilyViewer
                              ? BauhausDesign.warning
                              : BauhausDesign.primary,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        widget.isFamilyViewer
                            ? Icons.family_restroom_outlined
                            : Icons.person_outline,
                        color: widget.isFamilyViewer
                            ? BauhausDesign.warning
                            : BauhausDesign.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headerTitle,
                            style: GoogleFonts.oswald(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            headerSubtitle,
                            style: BauhausDesign.getTextTheme(context).bodySmall
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                        ],
                      ),
                    ),
                    if (!widget.isFamilyViewer)
                      BauhausActionButton(
                        onPressed: () => _openFamilyAccess(context),
                        text: 'Family',
                        icon: Icons.family_restroom_outlined,
                        variant: BauhausActionVariant.secondary,
                        isOutlined: true,
                        isSmall: true,
                      ),
                    if (!widget.isFamilyViewer)
                      const SizedBox(width: BauhausDesign.space2),
                    BauhausIconButton(
                      onPressed: () async {
                        await SessionTimeoutService().logoutAndClearSession(
                          reason: 'manual_logout_from_client_portal',
                        );
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.login,
                          (route) => false,
                        );
                      },
                      icon: Icons.logout,
                      variant: BauhausActionVariant.neutral,
                      tooltip: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _currentIndex < pages.length
                ? pages[_currentIndex]
                : pages[0],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(
        context,
        showInvoices: showInvoices,
        showAppointments: showAppointments,
      ),
    );
  }

  void _openFamilyAccess(BuildContext context) {
    Navigator.of(context).pushNamed(
      Routes.familyManagement,
      arguments: {'clientId': widget.clientId},
    );
  }

  Widget _buildDeleteAccountFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: BauhausActionButton(
        onPressed: () => _showDeleteAccountConfirmation(context, ref),
        text: 'DELETE ACCOUNT',
        icon: Icons.delete_forever,
        variant: BauhausActionVariant.danger,
        isFullWidth: true,
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context, {
    required bool showInvoices,
    required bool showAppointments,
  }) {
    final navItems = <Widget>[];
    // Track page indices separately from widget list length
    // (navItems includes SizedBox spacers that inflate the count)
    var pageIndex = 0;

    navItems.add(
      _buildNavItem(
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'Dashboard',
        index: pageIndex,
      ),
    );
    pageIndex++;

    if (showInvoices) {
      navItems.add(const SizedBox(width: BauhausDesign.space4));
      navItems.add(
        _buildNavItem(
          icon: Icons.receipt_long_outlined,
          activeIcon: Icons.receipt_long,
          label: 'Invoices',
          index: pageIndex,
        ),
      );
      pageIndex++;
    }

    if (showAppointments) {
      navItems.add(const SizedBox(width: BauhausDesign.space4));
      navItems.add(
        _buildNavItem(
          icon: Icons.calendar_today_outlined,
          activeIcon: Icons.calendar_today,
          label: 'Appointments',
          index: pageIndex,
        ),
      );
      pageIndex++;
    }

    return Container(
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(top: BorderSide(color: BauhausDesign.neutral, width: 2)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space4,
            vertical: BauhausDesign.space2,
          ),
          child: Row(children: navItems),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space2),
          decoration: BoxDecoration(
            color: isSelected ? BauhausDesign.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(
              color: isSelected ? BauhausDesign.primary : Colors.transparent,
              width: 2,
            ),
            boxShadow: isSelected ? const [BauhausDesign.shadowHardSm] : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected
                    ? BauhausDesign.surfaceWhite
                    : BauhausDesign.textMuted,
                size: 22,
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? BauhausDesign.surfaceWhite
                      : BauhausDesign.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: BauhausDesign.surfaceWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
                side: const BorderSide(color: BauhausDesign.neoInk, width: 3),
              ),
              title: Text(
                'Delete Account',
                style: GoogleFonts.oswald(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.neoDanger,
                  letterSpacing: 1.0,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you sure you want to start account deletion?',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.neoHighlight.withValues(alpha: 0.1),
                      border: Border.all(
                        color: BauhausDesign.neoHighlight,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: BauhausDesign.neoHighlight,
                          size: 20,
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        Expanded(
                          child: Text(
                            'After approval, your account is deactivated and records required for payroll, tax, audit, and care obligations are retained for up to 90 days before permanent deletion.',
                            style: GoogleFonts.spaceMono(
                              fontSize: 13,
                              color: BauhausDesign.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                if (!isLoading)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textMuted,
                      ),
                    ),
                  ),
                BauhausActionButton(
                  onPressed: isLoading
                      ? () {}
                      : () async {
                          setState(() => isLoading = true);
                          try {
                            final orgId = ref.read(
                              app_providers.organizationIdProvider,
                            );
                            final currentUser =
                                FirebaseAuth.instance.currentUser;

                            if (orgId == null ||
                                orgId.isEmpty ||
                                currentUser == null) {
                              throw Exception(
                                'Missing organization or user context',
                              );
                            }

                            final request = RequestModel(
                              organizationId: orgId,
                              userId: currentUser.uid,
                              type: 'ACCOUNT_DELETION',
                              status: RequestStatus.pending,
                              details: {
                                'reason':
                                    'Client requested account deletion via portal with 90-day retention',
                                'retentionDays': 90,
                                'retentionReason':
                                    'Payroll, tax, audit, and care-service record obligations',
                                'deactivateOnApproval': true,
                                'requestedAt': DateTime.now().toIso8601String(),
                              },
                            );

                            await ref
                                .read(requestRepositoryProvider)
                                .createRequest(
                                  request,
                                  currentUser.email ?? '',
                                );

                            if (!context.mounted) return;
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Deletion requested. After approval, the account is deactivated and required records are retained for up to 90 days before permanent deletion.',
                                ),
                                backgroundColor: BauhausDesign.primary,
                              ),
                            );
                          } catch (e) {
                            if (!context.mounted) return;
                            setState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${e.toString()}'),
                                backgroundColor: BauhausDesign.neoDanger,
                              ),
                            );
                          }
                        },
                  text: isLoading ? 'Submitting...' : 'Submit Request',
                  variant: BauhausActionVariant.danger,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
