import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import '../models/team_models.dart';
import '../providers/team_providers.dart';

class TeamDashboardView extends ConsumerStatefulWidget {
  const TeamDashboardView({super.key});

  @override
  ConsumerState<TeamDashboardView> createState() => _TeamDashboardViewState();
}

class _TeamDashboardViewState extends ConsumerState<TeamDashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    debugPrint('TeamDashboardView: initState');
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('TeamDashboardView: Triggering initial loads');
      ref.read(teamViewModelProvider.notifier).loadMyTeams();
      ref.read(teamViewModelProvider.notifier).loadActiveBroadcasts();
      ref
          .read(teamViewModelProvider.notifier)
          .loadBroadcastHistory(silent: true);
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(teamViewModelProvider);
    debugPrint(
      'TeamDashboardView: build (isLoading: ${viewModel.isLoading}, teams: ${viewModel.teams.length}, error: ${viewModel.errorMessage})',
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FadeTransition(
        opacity: _fadeIn,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverHeader(context),
            // Emergency Banner
            SliverToBoxAdapter(
              child: _buildBroadcastBanner(context, viewModel),
            ),
            // Section label
            SliverToBoxAdapter(child: _buildSectionLabel('MY TEAMS')),
            // Teams list
            if (viewModel.isLoading)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: BauhausDesign.secondary,
                            strokeWidth: 3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'LOADING TEAMS...',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (viewModel.errorMessage != null && viewModel.teams.isEmpty)
              SliverToBoxAdapter(
                child: _buildErrorState(context, viewModel.errorMessage!),
              )
            else if (viewModel.teams.isEmpty)
              SliverToBoxAdapter(child: _buildEmptyState(context))
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _TeamCard(
                        team: viewModel.teams[index],
                        index: index,
                        availableUsers: viewModel.availableUsers,
                        isAdmin: ref.watch(userRoleProvider) == UserRole.admin,
                        onInvite: (teamId, email, role) async {
                          await ref
                              .read(teamViewModelProvider.notifier)
                              .inviteMember(teamId, email, role);
                          // Reload to show new member
                          ref
                              .read(teamViewModelProvider.notifier)
                              .loadMyTeams();
                        },
                      ),
                    ),
                    childCount: viewModel.teams.length,
                  ),
                ),
              ),
            // Emergency History (Admins only)
            if (ref.watch(userRoleProvider) == UserRole.admin &&
                viewModel.broadcastHistory.isNotEmpty) ...[
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: _buildSectionLabel('EMERGENCY HISTORY'),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final broadcast = viewModel.broadcastHistory[index];
                  return _buildHistoryItem(context, broadcast);
                }, childCount: viewModel.broadcastHistory.length),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
      floatingActionButton: ref.watch(userRoleProvider) == UserRole.admin
          ? _buildFAB(context)
          : null,
    );
  }

  // ─── Sliver Header ───────────────────────────────────────
  Widget _buildSliverHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: 130,
      collapsedHeight: 62,
      pinned: true,
      backgroundColor: colorScheme.inverseSurface,
      foregroundColor: colorScheme.onInverseSurface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.onInverseSurface),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          tooltip: 'Refresh',
          icon: Icon(Icons.refresh, color: colorScheme.onInverseSurface),
          onPressed: () {
            HapticFeedback.lightImpact();
            ref.read(teamViewModelProvider.notifier).loadMyTeams();
            ref.read(teamViewModelProvider.notifier).loadActiveBroadcasts();
            ref
                .read(teamViewModelProvider.notifier)
                .loadBroadcastHistory(silent: true);
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(16, 0, 0, 14),
        title: Text(
          'TEAM COORDINATION',
          style: GoogleFonts.oswald(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.onInverseSurface,
            letterSpacing: 2,
          ),
        ),
        background: Container(
          color: colorScheme.inverseSurface,
          child: const SizedBox.shrink(),
        ),
      ),
    );
  }

  // ─── Emergency Broadcast Banner ───────────────────────────
  Widget _buildBroadcastBanner(BuildContext context, dynamic viewModel) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentUserId = ref.watch(userIdProvider);
    final allBroadcasts =
        viewModel.activeBroadcasts as List<EmergencyBroadcast>;

    // Filter out acknowledged broadcasts
    final broadcasts = allBroadcasts.where((b) {
      if (currentUserId == null) return true;
      return !b.acknowledgments.contains(currentUserId);
    }).toList();

    final hasActive = broadcasts.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar
          Container(
            width: double.infinity,
            color: hasActive ? colorScheme.error : colorScheme.inverseSurface,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  hasActive
                      ? Icons.warning_amber_rounded
                      : Icons.campaign_outlined,
                  color: hasActive
                      ? colorScheme.onError
                      : colorScheme.onInverseSurface,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  hasActive
                      ? 'ACTIVE EMERGENCY  ·  ${broadcasts.length}'
                      : 'EMERGENCY BROADCASTS',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: hasActive
                        ? colorScheme.onError
                        : colorScheme.onInverseSurface,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          // Body
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: hasActive
                  ? colorScheme.errorContainer
                  : colorScheme.surfaceContainer,
              border: Border.all(
                color: hasActive ? colorScheme.error : colorScheme.outline,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: hasActive ? colorScheme.error : colorScheme.outline,
                  offset: const Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                if (!hasActive)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: BauhausDesign.success,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'No active emergencies — all clear.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...broadcasts.map(
                    (b) => _BroadcastTile(
                      broadcast: b,
                      onAcknowledge: () {
                        HapticFeedback.mediumImpact();
                        if (b.id != null) {
                          ref
                              .read(teamViewModelProvider.notifier)
                              .acknowledgeBroadcast(b.id!);
                        }
                      },
                    ),
                  ),
                // Send button
                if (ref.watch(userRoleProvider) == UserRole.admin)
                  GestureDetector(
                    onTap: () => _showEmergencyDialog(context, viewModel),
                    child: Container(
                      width: double.infinity,
                      color: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.campaign,
                            color: colorScheme.onPrimary,
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'SEND EMERGENCY BROADCAST',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.onPrimary,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
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

  // ─── Section Label ────────────────────────────────────────
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Container(width: 4, height: 16, color: BauhausDesign.secondary),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.oswald(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Empty State ──────────────────────────────────────────
  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          border: Border(
            left: BorderSide(color: BauhausDesign.accent, width: 4),
            right: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NO TEAMS YET',
              style: GoogleFonts.oswald(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap the NEW TEAM button below to create\nyour first coordination team.',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Error State ──────────────────────────────────────────
  Widget _buildErrorState(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 4,
            ),
            right: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: BauhausDesign.primary,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── FAB ──────────────────────────────────────────────────
  Widget _buildFAB(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _showCreateTeamDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          boxShadow: const [BauhausDesign.shadowHardLg],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: colorScheme.onSecondary, size: 18),
            const SizedBox(width: 6),
            Text(
              'NEW TEAM',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: colorScheme.onSecondary,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Create Team Dialog ───────────────────────────────────
  void _showCreateTeamDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => _NeoBrutalistDialog(
        accentColor: BauhausDesign.secondary,
        title: 'CREATE NEW TEAM',
        titleIcon: Icons.groups_outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InputLabel('TEAM NAME'),
            const SizedBox(height: 6),
            _NeoTextField(
              controller: nameCtrl,
              hint: 'e.g. Morning Shift Alpha',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _NeoOutlineButton(
                    label: 'CANCEL',
                    onTap: () => Navigator.pop(ctx),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NeoFilledButton(
                    label: 'CREATE',
                    color: BauhausDesign.secondary,
                    onTap: () {
                      final name = nameCtrl.text.trim();
                      if (name.isEmpty) return;
                      HapticFeedback.mediumImpact();
                      ref.read(teamViewModelProvider.notifier).createTeam(name);
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Emergency Dialog ─────────────────────────────────────
  void _showEmergencyDialog(BuildContext context, dynamic viewModel) {
    final colorScheme = Theme.of(context).colorScheme;
    final msgCtrl = TextEditingController();
    final teams = viewModel.teams as List<Team>;
    final selectedTeamIds = <String>{};
    if (teams.isNotEmpty && teams.first.id != null) {
      selectedTeamIds.add(teams.first.id!);
    }

    showDialog(
      context: context,
      builder: (ctx) => _NeoBrutalistDialog(
        accentColor: BauhausDesign.primary,
        title: 'EMERGENCY BROADCAST',
        titleIcon: Icons.warning_amber_rounded,
        child: StatefulBuilder(
          builder: (context, setS) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: colorScheme.tertiaryContainer,
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14,
                      color: colorScheme.onTertiaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This will notify all team members immediately.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _InputLabel('MESSAGE'),
              const SizedBox(height: 6),
              _NeoTextField(
                controller: msgCtrl,
                hint: 'Describe the emergency...',
                maxLines: 3,
                focusBorderColor: BauhausDesign.primary,
              ),
              const SizedBox(height: 20),
              _InputLabel('TARGET TEAMS'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: teams.map((t) {
                  final teamId = t.id;
                  if (teamId == null) return const SizedBox.shrink();

                  final isSelected = selectedTeamIds.contains(teamId);
                  return FilterChip(
                    label: Text(t.name.toUpperCase()),
                    selected: isSelected,
                    onSelected: (val) {
                      setS(() {
                        if (val) {
                          selectedTeamIds.add(teamId);
                        } else {
                          if (selectedTeamIds.length > 1) {
                            selectedTeamIds.remove(teamId);
                          }
                        }
                      });
                    },
                    selectedColor: colorScheme.primary,
                    checkmarkColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.surfaceContainer,
                    labelStyle: GoogleFonts.oswald(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: colorScheme.outline, width: 2),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _NeoOutlineButton(
                      label: 'CANCEL',
                      onTap: () => Navigator.pop(ctx),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _NeoFilledButton(
                      label: 'BROADCAST',
                      color: BauhausDesign.primary,
                      onTap: () async {
                        final msg = msgCtrl.text.trim();
                        if (msg.isEmpty) return;
                        HapticFeedback.heavyImpact();

                        try {
                          if (selectedTeamIds.isNotEmpty) {
                            await viewModel.sendBroadcast(
                              selectedTeamIds.toList(),
                              msg,
                              'alert',
                            );
                          }

                          if (context.mounted) {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Emergency broadcast sent!',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                                backgroundColor: colorScheme.primary,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to send broadcast: $e',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onError,
                                  ),
                                ),
                                backgroundColor: colorScheme.error,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, EmergencyBroadcast broadcast) {
    return _HistoryTile(broadcast: broadcast);
  }
}

// ═══════════════════════════════════════════════════════════
// Team Card
// ═══════════════════════════════════════════════════════════
class _TeamCard extends ConsumerStatefulWidget {
  final Team team;
  final int index;
  final bool isAdmin;
  final List<TeamMember> availableUsers;
  final Future<void> Function(String teamId, String email, String role)
  onInvite;

  const _TeamCard({
    required this.team,
    required this.index,
    required this.isAdmin,
    required this.availableUsers,
    required this.onInvite,
  });

  @override
  ConsumerState<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends ConsumerState<_TeamCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _ctrl;
  late Animation<double> _expandAnim;

  static const _accents = [
    BauhausDesign.secondary,
    BauhausDesign.primary,
    BauhausDesign.success,
    BauhausDesign.info,
  ];

  Color get _accent => _accents[widget.index % _accents.length];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _expandAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initial = widget.team.name.isNotEmpty
        ? widget.team.name[0].toUpperCase()
        : '?';
    final avatarForeground = _accent == colorScheme.primary
        ? colorScheme.onPrimary
        : _accent == colorScheme.secondary
        ? colorScheme.onSecondary
        : colorScheme.onInverseSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline, width: 2),
        boxShadow: [
          BoxShadow(
            color: _expanded
                ? _accent.withValues(alpha: 0.85)
                : BauhausDesign.neoInk,
            offset: const Offset(5, 5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Card Header ──────────────────────────────────
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _expanded = !_expanded);
              _expanded ? _ctrl.forward() : _ctrl.reverse();
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Initial avatar
                  Container(
                    width: 44,
                    height: 44,
                    color: _accent,
                    alignment: Alignment.center,
                    child: Text(
                      initial,
                      style: GoogleFonts.oswald(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: avatarForeground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.team.name.toUpperCase(),
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.team.members.length} '
                          'MEMBER${widget.team.members.length == 1 ? '' : 'S'}',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isAdmin) ...[
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      onPressed: () => _showEditTeamDialog(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.archive_outlined, size: 18),
                      onPressed: () => _showSquashConfirm(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: BauhausDesign.primary,
                      ),
                      onPressed: () => _showDeleteConfirm(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                  ],
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 240),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: colorScheme.onSurface,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ── Expanded Members Area ────────────────────────
          SizeTransition(
            sizeFactor: _expandAnim,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  color: colorScheme.outline.withValues(alpha: 0.18),
                ),
                if (widget.team.members.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Text(
                      'No members yet — invite someone below.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                else
                  ...widget.team.members.map((m) => _MemberRow(member: m)),
                // Invite row
                InkWell(
                  onTap: () => _showInviteDialog(context),
                  child: Container(
                    width: double.infinity,
                    color: colorScheme.surfaceContainer,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          color: _accent,
                          child: Icon(
                            Icons.person_add,
                            color: avatarForeground,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'INVITE MEMBER',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 18,
                        ),
                      ],
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

  void _showInviteDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accentForeground = _accent == colorScheme.primary
        ? colorScheme.onPrimary
        : _accent == colorScheme.secondary
        ? colorScheme.onSecondary
        : colorScheme.onInverseSurface;
    String selectedRole = 'member';
    TeamMember? selectedUser;

    // Filter available users to those not already in the team
    final existingUserIds = widget.team.members.map((m) => m.userId).toSet();
    final selectableUsers = widget.availableUsers
        .where((u) => !existingUserIds.contains(u.userId))
        .toList();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => _NeoBrutalistDialog(
          accentColor: _accent,
          title: 'INVITE TO ${widget.team.name.toUpperCase()}',
          titleIcon: Icons.person_add_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InputLabel('SELECT USER'),
              const SizedBox(height: 6),
              if (selectableUsers.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    border: Border.fromBorderSide(
                      BorderSide(color: colorScheme.outline, width: 2),
                    ),
                  ),
                  child: Text(
                    'No available users to invite.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    border: Border.fromBorderSide(
                      BorderSide(color: colorScheme.outline, width: 2),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<TeamMember>(
                      isExpanded: true,
                      value: selectedUser,
                      hint: Text(
                        'Select an organization member',
                        style: GoogleFonts.inter(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: colorScheme.onSurface,
                      ),
                      dropdownColor: colorScheme.surface,
                      items: selectableUsers.map((user) {
                        final label = user.displayName.isNotEmpty
                            ? '${user.displayName} (${user.email})'
                            : user.email;
                        return DropdownMenuItem<TeamMember>(
                          value: user,
                          child: Text(
                            label,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setS(() => selectedUser = val);
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              _InputLabel('ROLE'),
              const SizedBox(height: 8),
              // Role selector
              Row(
                children: ['member', 'admin', 'manager'].map((r) {
                  final isSelected = selectedRole == r;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setS(() => selectedRole = r),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _accent
                              : colorScheme.surfaceContainer,
                          border: Border.all(
                            color: isSelected ? _accent : colorScheme.outline,
                            width: 2,
                          ),
                          boxShadow: isSelected
                              ? [BauhausDesign.shadowHardSm]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          r.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: isSelected
                                ? accentForeground
                                : colorScheme.onSurface,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _NeoOutlineButton(
                      label: 'CANCEL',
                      onTap: () => Navigator.pop(ctx),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _NeoFilledButton(
                      label: 'SEND INVITE',
                      color: _accent,
                      textColor: accentForeground,
                      onTap: () async {
                        if (selectedUser == null) return;
                        final email = selectedUser!.email;
                        if (email.isEmpty || !email.contains('@')) return;
                        HapticFeedback.mediumImpact();
                        Navigator.pop(ctx);
                        await widget.onInvite(
                          widget.team.id ?? '',
                          email,
                          selectedRole,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Invite sent to $email',
                                style: GoogleFonts.inter(
                                  color: colorScheme.onSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: colorScheme.secondary,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditTeamDialog(BuildContext context) {
    final nameCtrl = TextEditingController(text: widget.team.name);
    showDialog(
      context: context,
      builder: (ctx) => _NeoBrutalistDialog(
        accentColor: BauhausDesign.secondary,
        title: 'EDIT TEAM',
        titleIcon: Icons.edit_outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InputLabel('TEAM NAME'),
            const SizedBox(height: 8),
            _NeoTextField(
              controller: nameCtrl,
              hint: 'Enter team name...',
              focusBorderColor: BauhausDesign.secondary,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _NeoOutlineButton(
                    label: 'CANCEL',
                    onTap: () => Navigator.pop(ctx),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NeoFilledButton(
                    label: 'SAVE',
                    color: BauhausDesign.secondary,
                    onTap: () async {
                      final name = nameCtrl.text.trim();
                      if (name.isEmpty) return;
                      await ref
                          .read(teamViewModelProvider.notifier)
                          .updateTeam(widget.team.id!, name);
                      if (context.mounted) Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _NeoBrutalistDialog(
        accentColor: BauhausDesign.primary,
        title: 'DELETE TEAM',
        titleIcon: Icons.delete_outline,
        child: Column(
          children: [
            Text(
              'Are you sure you want to delete ${widget.team.name}?\nThis action cannot be undone.',
              style: GoogleFonts.inter(fontSize: 13, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _NeoOutlineButton(
                    label: 'CANCEL',
                    onTap: () => Navigator.pop(ctx),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NeoFilledButton(
                    label: 'DELETE',
                    color: BauhausDesign.primary,
                    onTap: () async {
                      await ref
                          .read(teamViewModelProvider.notifier)
                          .deleteTeam(widget.team.id!);
                      if (context.mounted) Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSquashConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _NeoBrutalistDialog(
        accentColor: BauhausDesign.info,
        title: 'SQUASH TEAM',
        titleIcon: Icons.archive_outlined,
        child: Column(
          children: [
            Text(
              'Squashing will archive ${widget.team.name}. It will be hidden from the active dashboard.',
              style: GoogleFonts.inter(fontSize: 13, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _NeoOutlineButton(
                    label: 'CANCEL',
                    onTap: () => Navigator.pop(ctx),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NeoFilledButton(
                    label: 'SQUASH',
                    color: BauhausDesign.info,
                    onTap: () async {
                      await ref
                          .read(teamViewModelProvider.notifier)
                          .squashTeam(widget.team.id!);
                      if (context.mounted) Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Member Row — shows name & email, never raw IDs
// ═══════════════════════════════════════════════════════════
class _MemberRow extends StatelessWidget {
  final TeamMember member;

  const _MemberRow({required this.member});

  static const _roleColors = {
    'manager': BauhausDesign.primary,
    'admin': BauhausDesign.secondary,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final roleColor = _roleColors[member.role] ?? colorScheme.onSurfaceVariant;
    final isActive = member.status == 'active';

    // Prefer display name, fall back to email, never show raw ID
    final label = member.displayName.isNotEmpty
        ? member.displayName
        : member.email.isNotEmpty
        ? member.email
        : 'Pending invitation';

    final sublabel = member.displayName.isNotEmpty && member.email.isNotEmpty
        ? member.email
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.14),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Status indicator
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? BauhausDesign.success
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (sublabel != null)
                  Text(
                    sublabel,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            color: roleColor.withValues(alpha: 0.12),
            child: Text(
              member.role.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: roleColor,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Broadcast Tile
// ═══════════════════════════════════════════════════════════

class _HistoryTile extends StatelessWidget {
  final EmergencyBroadcast broadcast;

  const _HistoryTile({required this.broadcast});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initiatorName = broadcast.initiatorName ?? 'Admin';
    final ackCount = broadcast.acknowledgments.length;
    final dateStr =
        "${broadcast.createdAt.day}/${broadcast.createdAt.month} ${broadcast.createdAt.hour}:${broadcast.createdAt.minute.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: Border.all(color: colorScheme.outline, width: 1.5),
        boxShadow: const [BauhausDesign.shadowHardXs],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.outline.withValues(alpha: 0.08),
            ),
            child: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  broadcast.message,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'By $initiatorName  ·  $dateStr',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              '$ackCount ACK',
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BroadcastTile extends StatelessWidget {
  final EmergencyBroadcast broadcast;
  final VoidCallback onAcknowledge;

  const _BroadcastTile({required this.broadcast, required this.onAcknowledge});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: colorScheme.primary,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  broadcast.message,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  broadcast.type.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onAcknowledge,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.inverseSurface,
                boxShadow: const [BauhausDesign.shadowHardXs],
              ),
              child: Text(
                'ACK',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onInverseSurface,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Shared Dialog Shell
// ═══════════════════════════════════════════════════════════
class _NeoBrutalistDialog extends StatelessWidget {
  final Color accentColor;
  final String title;
  final IconData titleIcon;
  final Widget child;

  const _NeoBrutalistDialog({
    required this.accentColor,
    required this.title,
    required this.titleIcon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border.all(color: colorScheme.outline, width: 2),
          boxShadow: [
            BoxShadow(
              color: accentColor,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              color: colorScheme.inverseSurface,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    titleIcon,
                    color: colorScheme.onInverseSurface,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.oswald(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onInverseSurface,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            // Body
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.65,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(padding: const EdgeInsets.all(20), child: child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Shared form helpers
// ═══════════════════════════════════════════════════════════
class _InputLabel extends StatelessWidget {
  final String label;
  const _InputLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Theme.of(context).colorScheme.onSurface,
        letterSpacing: 2,
      ),
    );
  }
}

class _NeoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final Color? focusBorderColor;

  const _NeoTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.focusBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      autofocus: maxLines == 1,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: focusBorderColor ?? colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
      ),
    );
  }
}

class _NeoFilledButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;
  final VoidCallback onTap;

  const _NeoFilledButton({
    required this.label,
    required this.color,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: colorScheme.outline, width: 1.5),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: textColor ?? colorScheme.onInverseSurface,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class _NeoOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NeoOutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          border: Border.fromBorderSide(
            BorderSide(color: colorScheme.outline, width: 1.5),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
