import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/client/providers/client_provider.dart';
import 'package:carenest/app/features/employee_tracking/views/employee_tracking_view.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/family_access_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/messaging_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/realtime_tracking_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/service_confirmation_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/views/admin_family_management_view.dart';
import 'package:carenest/app/features/realtime_portal/views/appointment_timeline_view.dart';
import 'package:carenest/app/features/realtime_portal/views/admin_service_confirmations_view.dart';
import 'package:carenest/app/features/realtime_portal/views/messaging_audit_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Real-Time Client Portal dashboard connected to live backend data.
class RealtimePortalDashboard extends ConsumerStatefulWidget {
  const RealtimePortalDashboard({super.key});

  @override
  ConsumerState<RealtimePortalDashboard> createState() =>
      _RealtimePortalDashboardState();
}

class _RealtimePortalDashboardState
    extends ConsumerState<RealtimePortalDashboard> {
  String? _loadedOrgId;
  String? _activeClientId;
  String? _activeClientName;
  String? _userIdentifier;
  String? _userName;
  UserRole? _userRole;
  bool _isFetching = false;

  static const List<_PortalModule> _modules = [
    _PortalModule(
      title: 'Live Insights',
      description: 'Monitor worker location pings and arrival confidence.',
      route: Routes.liveTracking,
      icon: Icons.location_searching_rounded,
      accent: BauhausDesign.primary,
    ),
    _PortalModule(
      title: 'Appointment Timeline',
      description: 'Follow service progression from arrival to completion.',
      route: Routes.appointmentTimeline,
      icon: Icons.timeline_rounded,
      accent: BauhausDesign.secondary,
    ),
    _PortalModule(
      title: 'Secure Messaging',
      description: 'Monitor encrypted conversation flow and unread backlog.',
      route: Routes.secureMessaging,
      icon: Icons.mark_chat_unread_rounded,
      accent: BauhausDesign.accent,
    ),
    _PortalModule(
      title: 'Service Confirmation',
      description:
          'Review checklists, ratings, signatures, and closeout proof.',
      route: Routes.serviceConfirmation,
      icon: Icons.fact_check_rounded,
      accent: BauhausDesign.success,
    ),
    _PortalModule(
      title: 'Family Access',
      description: 'Manage member permissions and recent access history.',
      route: Routes.familyManagement,
      icon: Icons.family_restroom_rounded,
      accent: BauhausDesign.warning,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orgId = ref.read(app_providers.organizationIdProvider);
      if (orgId != null && orgId.isNotEmpty) {
        _initializeDashboard(orgId);
      }
    });
  }

  Future<void> _initializeDashboard(
    String organizationId, {
    bool force = false,
  }) async {
    if (_isFetching && !force) return;
    if (!force && _loadedOrgId == organizationId && _userIdentifier != null) {
      return;
    }

    _isFetching = true;
    _loadedOrgId = organizationId;

    try {
      final prefs = ref.read(app_providers.sharedPreferencesProvider);
      await prefs.init();

      final userId = prefs.getUserId();
      final userEmail = prefs.getUserEmail();
      _userName = prefs.getName();
      _userRole = prefs.getRole();
      _userIdentifier = (userId != null && userId.isNotEmpty)
          ? userId
          : (userEmail != null && userEmail.isNotEmpty ? userEmail : null);

      final apiMethod = ref.read(app_providers.apiMethodProvider);
      if (userEmail != null && (_userName == null || _userName!.isEmpty)) {
        try {
          final initData = await apiMethod.getInitData(userEmail);
          if (initData is Map<String, dynamic>) {
            final firstName = initData['firstName'] ?? '';
            final lastName = initData['lastName'] ?? '';
            _userName = '$firstName $lastName'.trim();
            if (_userName!.isNotEmpty) {
              await prefs.setString('First LastName', _userName!);
            }
          }
        } catch (e) {
          debugPrint('Error resolving user name from initData: $e');
        }
      }

      await ref
          .read(clientProvider.notifier)
          .fetchClientsByOrganization(organizationId);

      final clients = ref
          .read(clientProvider)
          .clients
          .where((client) => client.id != null && client.id!.isNotEmpty)
          .toList();

      if (clients.isEmpty) {
        _activeClientId = null;
        _activeClientName = null;
      } else {
        final selectedClient = clients.firstWhere(
          (client) => client.id == _activeClientId,
          orElse: () => clients.first,
        );
        _activeClientId = selectedClient.id;
        _activeClientName = selectedClient.displayName;
      }

      final preloadTasks = <Future<void>>[
        ref
            .read(serviceConfirmationViewModelProvider.notifier)
            .getChecklistTemplate(serviceType: 'home_care'),
      ];

      if (_userIdentifier != null && _userIdentifier!.isNotEmpty) {
        preloadTasks.add(
          ref.read(messagingViewModelProvider.notifier).getUserConversations(
                userId: _userIdentifier!,
              ),
        );
      }

      if (_activeClientId != null) {
        preloadTasks.addAll([
          ref.read(familyAccessViewModelProvider.notifier).getFamilyMembers(
                clientId: _activeClientId!,
              ),
          ref.read(familyAccessViewModelProvider.notifier).getAccessLog(
                clientId: _activeClientId!,
              ),
        ]);
      }

      await Future.wait(preloadTasks);

      final conversations = ref.read(messagingViewModelProvider).conversations;
      if (conversations.isNotEmpty) {
        final appointmentId = conversations.first.appointmentId;
        if (appointmentId.isNotEmpty) {
          await Future.wait([
            ref
                .read(realtimeTrackingViewModelProvider.notifier)
                .getLiveTracking(
                  appointmentId: appointmentId,
                ),
            ref
                .read(serviceConfirmationViewModelProvider.notifier)
                .getConfirmation(
                  appointmentId: appointmentId,
                ),
          ]);
        }
      }
    } finally {
      _isFetching = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final organizationId = ref.watch(app_providers.organizationIdProvider);
    final clientState = ref.watch(clientProvider);
    final trackingState = ref.watch(realtimeTrackingViewModelProvider);
    final messagingState = ref.watch(messagingViewModelProvider);
    final serviceState = ref.watch(serviceConfirmationViewModelProvider);
    final familyState = ref.watch(familyAccessViewModelProvider);

    if (organizationId != null &&
        organizationId.isNotEmpty &&
        _loadedOrgId != organizationId &&
        !_isFetching) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _initializeDashboard(organizationId);
        }
      });
    }

    final metrics = _buildLiveMetrics(
      trackingState: trackingState,
      messagingState: messagingState,
      serviceState: serviceState,
      familyState: familyState,
    );

    final moduleTiles = _buildModuleTiles(
      trackingState: trackingState,
      messagingState: messagingState,
      serviceState: serviceState,
      familyState: familyState,
    );

    final activityEntries = _buildActivityEntries(
      trackingState: trackingState,
      messagingState: messagingState,
      serviceState: serviceState,
      familyState: familyState,
    );

    final hasAnyData = trackingState.liveLocation != null ||
        trackingState.activeSession != null ||
        trackingState.appointmentStatus != null ||
        messagingState.conversations.isNotEmpty ||
        messagingState.unreadCount > 0 ||
        serviceState.confirmation != null ||
        serviceState.checklist.isNotEmpty ||
        familyState.members.isNotEmpty ||
        familyState.auditLogs.isNotEmpty ||
        familyState.pendingInvitation != null;

    final isLoading = (clientState.isLoading ||
            trackingState.isLoading ||
            messagingState.isLoading ||
            serviceState.isLoading ||
            familyState.isLoading ||
            _isFetching) &&
        !hasAnyData;

    final error = _firstMeaningfulError([
      clientState.error,
      trackingState.error,
      messagingState.error,
      serviceState.error,
      familyState.error,
    ]);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(context),
      body: organizationId == null || organizationId.isEmpty
          ? _buildMissingOrganizationState(context)
          : isLoading
              ? const Center(child: BauhausLoadingState())
              : RefreshIndicator(
                  color: BauhausDesign.primary,
                  onRefresh: () async {
                    await _initializeDashboard(organizationId, force: true);
                  },
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            BauhausDesign.space4,
                            BauhausDesign.space4,
                            BauhausDesign.space4,
                            BauhausDesign.space8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (error != null) ...[
                                _buildErrorBanner(context, error),
                                const SizedBox(height: BauhausDesign.space4),
                              ],
                              _buildContextStrip(context),
                              const SizedBox(height: BauhausDesign.space4),
                              _buildCommandDeck(
                                context,
                                metrics: metrics,
                                hasLiveSignal:
                                    trackingState.liveLocation != null,
                              ),
                              const SizedBox(height: BauhausDesign.space6),
                              _buildSectionHeader(
                                context,
                                title: 'Module Control',
                                subtitle:
                                    'Each module reflects real backend state and routes to its workflow.',
                                accent: BauhausDesign.secondary,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              _buildModuleMatrix(context, moduleTiles),
                              const SizedBox(height: BauhausDesign.space6),
                              _buildSectionHeader(
                                context,
                                title: 'Activity Ledger',
                                subtitle:
                                    'Latest platform events across insights, messaging, confirmation, and family access.',
                                accent: BauhausDesign.primary,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              _buildActivityLedger(context, activityEntries),
                              if (_activeClientId == null &&
                                  !clientState.isLoading) ...[
                                const SizedBox(height: BauhausDesign.space4),
                                _buildClientHint(context, organizationId),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return AppBar(
      backgroundColor: BauhausDesign.accent,
      elevation: 0,
      titleSpacing: 0,
      title: Text(
        'REALTIME PORTAL',
        style: textTheme.headlineMedium?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.primary),
            ),
            Expanded(
              flex: 3,
              child: Container(height: 8, color: BauhausDesign.surfaceWhite),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.secondary),
            ),
            Expanded(
              flex: 2,
              child: Container(height: 8, color: BauhausDesign.success),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissingOrganizationState(BuildContext context) {
    return Center(
      child: BauhausEmptyState(
        title: 'Organization Context Missing',
        message:
            'Realtime portal needs organization context before loading live services.',
        icon: Icons.domain_disabled_rounded,
        actionLabel: 'RETRY',
        onAction: () {
          final orgId = ref.read(app_providers.organizationIdProvider);
          if (orgId != null && orgId.isNotEmpty) {
            _initializeDashboard(orgId, force: true);
          }
        },
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context, String error) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.error.withOpacity(0.14),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: BauhausDesign.textDark,
            size: 18,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              error,
              style: textTheme.bodySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextStrip(BuildContext context) {
    final textTheme = BauhausDesign.getTextTheme(context);
    final clientState = ref.watch(clientProvider);
    final isAdmin = _userRole == UserRole.admin;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: BauhausDesign.space4,
            runSpacing: BauhausDesign.space2,
            children: [
              _buildContextPill(
                context,
                label: 'Insights Client',
                value: _activeClientName ?? 'Not selected',
                accent: BauhausDesign.primary,
                onTap: isAdmin ? () => _showClientSelector(context) : null,
              ),
              _buildContextPill(
                context,
                label: 'Logged in as',
                value: _userName ?? 'Unavailable',
                accent: BauhausDesign.secondary,
              ),
              _buildContextPill(
                context,
                label: 'Role',
                value:
                    _userRole != null ? _humanize(_userRole!.name) : 'Unknown',
                accent: BauhausDesign.success,
              ),
            ],
          ),
          if (isAdmin && _loadedOrgId != null) ...[
            const SizedBox(height: BauhausDesign.space2),
            Text(
              'Organization Context: $_loadedOrgId • ${clientState.clients.length} clients fetched',
              style: textTheme.bodySmall?.copyWith(
                color: BauhausDesign.textDark.withOpacity(0.6),
                fontSize: 10,
                fontFamily: 'Courier',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'Auto-sync keeps this dashboard aligned with backend realtime APIs.',
            style: textTheme.bodySmall?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showClientSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(BauhausDesign.radiusLg)),
      ),
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final clientState = ref.watch(clientProvider);
          final clients = clientState.clients
              .where((c) => c.id != null && c.id!.isNotEmpty)
              .toList();

          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(
                      vertical: BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.neutral,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BauhausDesign.space4,
                    0,
                    BauhausDesign.space4,
                    BauhausDesign.space4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Client for Insights',
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: BauhausDesign.textDark,
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh_rounded),
                        onPressed: () {
                          if (_loadedOrgId != null) {
                            ref
                                .read(clientProvider.notifier)
                                .fetchClientsByOrganization(_loadedOrgId!);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Divider(color: BauhausDesign.neutral, height: 1),
                if (clientState.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(BauhausDesign.space8),
                    child:
                        CircularProgressIndicator(color: BauhausDesign.primary),
                  )
                else if (clients.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space8),
                    child: Text(
                      'No clients found for this organization.',
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: clients.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: BauhausDesign.neutral, height: 1),
                      itemBuilder: (context, index) {
                        final client = clients[index];
                        final isSelected = client.id == _activeClientId;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? BauhausDesign.primary
                                : BauhausDesign.neutral.withOpacity(0.3),
                            child: Text(
                              client.displayName.isNotEmpty
                                  ? client.displayName[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : BauhausDesign.textDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          title: Text(
                            client.displayName,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              color: isSelected
                                  ? BauhausDesign.primary
                                  : BauhausDesign.textDark,
                            ),
                          ),
                          subtitle: Text(
                            client.clientEmail,
                            style: BauhausDesign.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(fontSize: 11),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle,
                                  color: BauhausDesign.primary)
                              : null,
                          onTap: () {
                            setState(() {
                              _activeClientId = client.id;
                              _activeClientName = client.displayName;
                            });
                            Navigator.pop(context);
                            if (_loadedOrgId != null) {
                              _initializeDashboard(_loadedOrgId!, force: true);
                            }
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(
                    height: MediaQuery.of(context).padding.bottom +
                        BauhausDesign.space4),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContextPill(
    BuildContext context, {
    required String label,
    required String value,
    required Color accent,
    VoidCallback? onTap,
  }) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3,
          vertical: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
          border: Border.all(
            color: onTap != null ? accent : BauhausDesign.neutral,
            width: onTap != null ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label: $value',
              style: textTheme.bodySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: onTap != null ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: accent),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCommandDeck(
    BuildContext context, {
    required List<_PortalMetric> metrics,
    required bool hasLiveSignal,
  }) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: BauhausDesign.accent.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border:
                        Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.radar_rounded,
                    color: BauhausDesign.textDark,
                    size: 28,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Operational Command Deck',
                        style: textTheme.headlineMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Metrics below are generated from live realtime-portal endpoints.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3,
                    vertical: BauhausDesign.space2,
                  ),
                  decoration: BoxDecoration(
                    color: hasLiveSignal
                        ? BauhausDesign.success.withOpacity(0.18)
                        : BauhausDesign.warning.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.circular(BauhausDesign.radiusFull),
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Text(
                    hasLiveSignal ? 'LIVE FEED' : 'SYNCED',
                    style: textTheme.labelSmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1160
                    ? 5
                    : constraints.maxWidth >= 860
                        ? 3
                        : constraints.maxWidth >= 560
                            ? 2
                            : 1;
                final spacing = BauhausDesign.space3;
                final cardWidth =
                    (constraints.maxWidth - (columns - 1) * spacing) / columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final metric in metrics)
                      SizedBox(
                        width: cardWidth,
                        child: _buildMetricCard(context, metric),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, _PortalMetric metric) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: metric.accent,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(BauhausDesign.radiusMd),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(metric.icon, color: BauhausDesign.textDark, size: 18),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Text(
                        metric.label,
                        style: textTheme.labelLarge?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  metric.value,
                  style: textTheme.headlineMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  metric.detail,
                  style: textTheme.bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color accent,
  }) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 56,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.headlineLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModuleMatrix(
    BuildContext context,
    List<_PortalModuleTileData> modules,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1180
            ? 3
            : constraints.maxWidth >= 760
                ? 2
                : 1;
        final spacing = BauhausDesign.space3;
        final cardWidth =
            (constraints.maxWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final module in modules)
              SizedBox(
                width: cardWidth,
                child: _buildModuleCard(context, module),
              ),
          ],
        );
      },
    );
  }

  Widget _buildModuleCard(BuildContext context, _PortalModuleTileData module) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return InkWell(
      borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      onTap: () => _openModule(context, module.module.route),
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 1.6),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: module.module.accent.withOpacity(0.15),
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                      border:
                          Border.all(color: BauhausDesign.neutral, width: 1),
                    ),
                    child: Icon(
                      module.module.icon,
                      color: BauhausDesign.textDark,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      module.module.title,
                      style: textTheme.labelLarge?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                module.module.description,
                style: textTheme.bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: BauhausDesign.space3),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: module.badgeColor.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
                child: Text(
                  module.status,
                  style: textTheme.bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      module.detail,
                      style: textTheme.bodySmall?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: BauhausDesign.textDark,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityLedger(
    BuildContext context,
    List<_ActivityEntry> entries,
  ) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 1.8),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: entries[i].accent.withOpacity(0.16),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 1),
                        ),
                        child: Icon(
                          entries[i].icon,
                          color: BauhausDesign.textDark,
                          size: 16,
                        ),
                      ),
                      if (i < entries.length - 1)
                        Container(
                          width: 2,
                          height: 34,
                          color: BauhausDesign.neutral.withOpacity(0.35),
                        ),
                    ],
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entries[i].title,
                          style: textTheme.labelLarge?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          entries[i].detail,
                          style: textTheme.bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          entries[i].timeLabel,
                          style: textTheme.bodySmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (i < entries.length - 1)
                const SizedBox(height: BauhausDesign.space2),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildClientHint(BuildContext context, String organizationId) {
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.warning.withOpacity(0.2),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: BauhausDesign.textDark,
            size: 18,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No client profiles resolved for this organization.',
                  style: textTheme.bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  'Family access metrics will populate once clients are synced.',
                  style: textTheme.bodySmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space2),
          TextButton(
            onPressed: () => _initializeDashboard(organizationId, force: true),
            child: Text(
              'SYNC',
              style: textTheme.labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openModule(BuildContext context, String route) {
    try {
      final isAdmin = _userRole == UserRole.admin;

      if (isAdmin) {
        if (route == Routes.liveTracking) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EmployeeTrackingView()),
          );
          return;
        }
        if (route == Routes.secureMessaging) {
          if (_activeClientId == null || _activeClientId!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a client in the context bar first.'),
                backgroundColor: BauhausDesign.neutral,
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MessagingAuditView(
                clientId: _activeClientId!,
                clientName: _activeClientName ?? 'Client',
              ),
            ),
          );
          return;
        }
        if (route == Routes.appointmentTimeline) {
          if (_activeClientId == null || _activeClientId!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a client in the context bar first.'),
                backgroundColor: BauhausDesign.neutral,
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AppointmentTimelineView(
                clientId: _activeClientId!,
                clientName: _activeClientName ?? 'Client',
              ),
            ),
          );
          return;
        }
        if (route == Routes.familyManagement) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdminFamilyManagementView(
                clientId: _activeClientId ?? '',
              ),
            ),
          );
          return;
        }
        if (route == Routes.serviceConfirmation) {
          if (_activeClientId == null || _activeClientId!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a client in the context bar first.'),
                backgroundColor: BauhausDesign.neutral,
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdminServiceConfirmationsView(
                clientId: _activeClientId!,
                clientName: _activeClientName ?? 'Client',
              ),
            ),
          );
          return;
        }
      }

      // Handle Family Management with clientId argument for non-admins (or if push failed)
      if (route == Routes.familyManagement) {
        Navigator.pushNamed(
          context,
          route,
          arguments: {
            'clientId': _activeClientId,
          },
        );
        return;
      }

      // Check for Timeline route specifically as it might not be in the map if not registered correctly
      if (route == Routes.appointmentTimeline) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AppointmentTimelineView(
              clientId: _activeClientId,
              clientName: _activeClientName,
            ),
          ),
        );
        return;
      }

      Navigator.pushNamed(context, route);
    } catch (e) {
      debugPrint('Navigation error to $route: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Navigation to ${_humanize(route.replaceAll("/", ""))} failed: $e'),
          backgroundColor: BauhausDesign.neutral,
        ),
      );
    }
  }

  List<_PortalMetric> _buildLiveMetrics({
    required RealtimeTrackingState trackingState,
    required MessagingState messagingState,
    required ServiceConfirmationState serviceState,
    required FamilyAccessState familyState,
  }) {
    final activeMembers =
        familyState.members.where((member) => member.status == 'active').length;
    final pendingMembers = familyState.members
            .where((member) => member.status == 'pending')
            .length +
        (familyState.pendingInvitation != null ? 1 : 0);

    final checklistTotal = serviceState.checklist.length;
    final checklistDone =
        serviceState.checklist.where((item) => item.completed == true).length;

    final status = trackingState.liveLocation?.status;

    return [
      _PortalMetric(
        label: 'Insights State',
        value: trackingState.liveLocation != null
            ? (status != null && status.isNotEmpty
                ? _humanize(status)
                : 'Active')
            : 'Idle',
        detail: trackingState.liveLocation != null
            ? 'Last ping ${_formatRelative(trackingState.liveLocation?.timestamp)}'
            : 'No active insights session.',
        icon: Icons.location_on_rounded,
        accent: BauhausDesign.primary,
      ),
      _PortalMetric(
        label: 'Conversations',
        value: messagingState.conversations.length.toString(),
        detail:
            '${messagingState.unreadCount} unread message${messagingState.unreadCount == 1 ? '' : 's'}',
        icon: Icons.forum_rounded,
        accent: BauhausDesign.secondary,
      ),
      _PortalMetric(
        label: 'Family Members',
        value: activeMembers.toString(),
        detail: '$pendingMembers pending invitation(s)',
        icon: Icons.family_restroom_rounded,
        accent: BauhausDesign.warning,
      ),
      _PortalMetric(
        label: 'Checklist',
        value: checklistTotal == 0
            ? 'Not Loaded'
            : '$checklistDone/$checklistTotal',
        detail: serviceState.confirmation != null
            ? 'Latest confirmation ${_formatRelative(serviceState.confirmation?.timestamp)}'
            : 'Service confirmation awaiting signature.',
        icon: Icons.checklist_rounded,
        accent: BauhausDesign.success,
      ),
      _PortalMetric(
        label: 'Incidents Logged',
        value: serviceState.incidents.length.toString(),
        detail: serviceState.incidents.isEmpty
            ? 'No incidents reported.'
            : 'Review incident records before closure.',
        icon: Icons.report_problem_rounded,
        accent: BauhausDesign.accent,
      ),
    ];
  }

  List<_PortalModuleTileData> _buildModuleTiles({
    required RealtimeTrackingState trackingState,
    required MessagingState messagingState,
    required ServiceConfirmationState serviceState,
    required FamilyAccessState familyState,
  }) {
    final activeMembers =
        familyState.members.where((member) => member.status == 'active').length;
    final pendingMembers = familyState.members
            .where((member) => member.status == 'pending')
            .length +
        (familyState.pendingInvitation != null ? 1 : 0);

    final checklistTotal = serviceState.checklist.length;
    final checklistDone =
        serviceState.checklist.where((item) => item.completed == true).length;

    final latestLog = familyState.auditLogs.isNotEmpty
        ? (familyState.auditLogs.toList()
              ..sort((a, b) => b.timestamp.compareTo(a.timestamp)))
            .first
        : null;

    return [
      if (!kReleaseMode)
        _PortalModuleTileData(
          module: _modules[0],
          status: trackingState.liveLocation != null
              ? 'Session active'
              : 'No active session',
          detail: trackingState.liveLocation != null
              ? 'Updated ${_formatRelative(trackingState.liveLocation?.timestamp)}'
              : 'Awaiting worker location updates.',
          badgeColor: trackingState.liveLocation != null
              ? BauhausDesign.success
              : BauhausDesign.warning,
        ),
      _PortalModuleTileData(
        module: _modules[1],
        status: trackingState.appointmentStatus != null
            ? '${_humanize(trackingState.appointmentStatus!.status)} • ${trackingState.appointmentStatus!.progress}%'
            : 'Timeline standby',
        detail: messagingState.conversations.isNotEmpty
            ? '${messagingState.conversations.length} conversation thread(s) linked.'
            : 'No linked appointment conversation yet.',
        badgeColor: trackingState.appointmentStatus != null
            ? BauhausDesign.secondary
            : BauhausDesign.warning,
      ),
      _PortalModuleTileData(
        module: _modules[2],
        status:
            '${messagingState.unreadCount} unread across ${messagingState.conversations.length} thread(s)',
        detail: messagingState.conversations.isNotEmpty
            ? 'Most recent ${_formatRelative(_latestConversation(messagingState.conversations)?.lastMessageAt)}'
            : 'Conversation channel not initialized.',
        badgeColor: messagingState.unreadCount > 0
            ? BauhausDesign.accent
            : BauhausDesign.success,
      ),
      _PortalModuleTileData(
        module: _modules[3],
        status: serviceState.confirmation != null
            ? 'Visit confirmed'
            : 'Confirmation pending',
        detail: checklistTotal > 0
            ? 'Checklist progress: $checklistDone/$checklistTotal'
            : 'Checklist template not loaded yet.',
        badgeColor: serviceState.confirmation != null
            ? BauhausDesign.success
            : BauhausDesign.warning,
      ),
      _PortalModuleTileData(
        module: _modules[4],
        status: '$activeMembers active • $pendingMembers pending',
        detail: latestLog != null
            ? 'Last audit: ${_humanize(latestLog.action)} ${_formatRelative(latestLog.timestamp)}'
            : 'No family access audit entries yet.',
        badgeColor:
            activeMembers > 0 ? BauhausDesign.secondary : BauhausDesign.warning,
      ),
    ];
  }

  List<_ActivityEntry> _buildActivityEntries({
    required RealtimeTrackingState trackingState,
    required MessagingState messagingState,
    required ServiceConfirmationState serviceState,
    required FamilyAccessState familyState,
  }) {
    final entries = <_ActivityEntry>[];

    if (trackingState.liveLocation != null) {
      entries.add(
        _ActivityEntry(
          title: 'Live location received',
          detail:
              'Worker status: ${_humanize(trackingState.liveLocation?.status ?? 'active')}.',
          timeLabel: _formatRelative(trackingState.liveLocation?.timestamp),
          icon: Icons.location_on_rounded,
          accent: BauhausDesign.primary,
        ),
      );
    }

    final latestConversation =
        _latestConversation(messagingState.conversations);
    if (latestConversation != null) {
      entries.add(
        _ActivityEntry(
          title: 'Conversation activity',
          detail: latestConversation.lastMessage?.isNotEmpty == true
              ? latestConversation.lastMessage!
              : 'Conversation exists with no preview message.',
          timeLabel: _formatRelative(
            latestConversation.lastMessageAt ?? latestConversation.createdAt,
          ),
          icon: Icons.chat_rounded,
          accent: BauhausDesign.secondary,
        ),
      );
    }

    if (serviceState.confirmation != null) {
      entries.add(
        _ActivityEntry(
          title: 'Service confirmation submitted',
          detail:
              'Confirmation status: ${_humanize(serviceState.confirmation!.status)}.',
          timeLabel: _formatRelative(serviceState.confirmation?.timestamp),
          icon: Icons.verified_rounded,
          accent: BauhausDesign.success,
        ),
      );
    }

    if (familyState.pendingInvitation != null) {
      entries.add(
        _ActivityEntry(
          title: 'Family invitation pending',
          detail: 'Invitation sent to ${familyState.pendingInvitation!.email}.',
          timeLabel: _formatRelative(familyState.pendingInvitation?.invitedAt),
          icon: Icons.mail_outline_rounded,
          accent: BauhausDesign.warning,
        ),
      );
    }

    if (familyState.auditLogs.isNotEmpty) {
      final latestLog = (familyState.auditLogs.toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)))
          .first;
      entries.add(
        _ActivityEntry(
          title: 'Family access audit update',
          detail: _humanize(latestLog.action),
          timeLabel: _formatRelative(latestLog.timestamp),
          icon: Icons.manage_accounts_rounded,
          accent: BauhausDesign.accent,
        ),
      );
    }

    if (entries.isEmpty) {
      entries.add(
        const _ActivityEntry(
          title: 'No realtime events yet',
          detail:
              'Once insights, messaging, or confirmation events arrive, they will appear here.',
          timeLabel: 'Waiting for backend updates',
          icon: Icons.hourglass_bottom_rounded,
          accent: BauhausDesign.secondary,
        ),
      );
    }

    return entries.take(6).toList();
  }

  MessageThread? _latestConversation(List<MessageThread> conversations) {
    MessageThread? latest;

    for (final conversation in conversations) {
      if (latest == null) {
        latest = conversation;
        continue;
      }

      final currentTime = conversation.lastMessageAt ?? conversation.createdAt;
      final latestTime = latest.lastMessageAt ?? latest.createdAt;

      if (currentTime.isAfter(latestTime)) {
        latest = conversation;
      }
    }

    return latest;
  }

  String? _firstMeaningfulError(List<String?> candidates) {
    for (final candidate in candidates) {
      if (candidate == null || candidate.trim().isEmpty) {
        continue;
      }
      final normalized = candidate.toLowerCase();
      if (normalized.contains('not found')) {
        continue;
      }
      return candidate;
    }
    return null;
  }

  String _humanize(String raw) {
    if (raw.isEmpty) return 'Unknown';

    final cleaned = raw.replaceAll('_', ' ').trim();
    if (cleaned.isEmpty) return 'Unknown';

    return cleaned[0].toUpperCase() + cleaned.substring(1);
  }

  String _formatRelative(DateTime? timestamp) {
    if (timestamp == null) {
      return 'No timestamp';
    }

    final diff = DateTime.now().difference(timestamp.toLocal());

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    final y = timestamp.year.toString();
    final m = timestamp.month.toString().padLeft(2, '0');
    final d = timestamp.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}

class _PortalMetric {
  const _PortalMetric({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color accent;
}

class _PortalModule {
  const _PortalModule({
    required this.title,
    required this.description,
    required this.route,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String description;
  final String route;
  final IconData icon;
  final Color accent;
}

class _PortalModuleTileData {
  const _PortalModuleTileData({
    required this.module,
    required this.status,
    required this.detail,
    required this.badgeColor,
  });

  final _PortalModule module;
  final String status;
  final String detail;
  final Color badgeColor;
}

class _ActivityEntry {
  const _ActivityEntry({
    required this.title,
    required this.detail,
    required this.timeLabel,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String detail;
  final String timeLabel;
  final IconData icon;
  final Color accent;
}
