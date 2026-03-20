import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
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
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(teamViewModelProvider).loadMyTeams();
      ref.read(teamViewModelProvider).loadActiveBroadcasts();
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

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
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
            SliverToBoxAdapter(
              child: _buildSectionLabel('MY TEAMS'),
            ),
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
                            color: BauhausDesign.textMuted,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (viewModel.errorMessage != null)
              SliverToBoxAdapter(
                child: _buildErrorState(context, viewModel.errorMessage!),
              )
            else if (viewModel.teams.isEmpty)
              SliverToBoxAdapter(
                child: _buildEmptyState(context),
              )
            else
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _TeamCard(
                        team: viewModel.teams[index],
                        index: index,
                        availableUsers: viewModel.availableUsers,
                        onInvite: (teamId, email, role) async {
                          await ref
                              .read(teamViewModelProvider)
                              .inviteMember(teamId, email, role);
                          // Reload to show new member
                          ref.read(teamViewModelProvider).loadMyTeams();
                        },
                      ),
                    ),
                    childCount: viewModel.teams.length,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  // ─── Sliver Header ───────────────────────────────────────
  Widget _buildSliverHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130,
      collapsedHeight: 62,
      pinned: true,
      backgroundColor: BauhausDesign.neutral,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: BauhausDesign.textLight),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          tooltip: 'Refresh',
          icon: const Icon(Icons.refresh, color: BauhausDesign.textLight),
          onPressed: () {
            HapticFeedback.lightImpact();
            ref.read(teamViewModelProvider).loadMyTeams();
            ref.read(teamViewModelProvider).loadActiveBroadcasts();
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
            color: BauhausDesign.textLight,
            letterSpacing: 2,
          ),
        ),
        background: Container(
          color: BauhausDesign.neutral,
          child: const SizedBox.shrink(),
        ),
      ),
    );
  }

  // ─── Emergency Broadcast Banner ───────────────────────────
  Widget _buildBroadcastBanner(BuildContext context, dynamic viewModel) {
    final broadcasts =
        viewModel.activeBroadcasts as List<EmergencyBroadcast>;
    final hasActive = broadcasts.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar
          Container(
            width: double.infinity,
            color: hasActive
                ? const Color(0xFF8B0000)
                : BauhausDesign.neutral,
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  hasActive
                      ? Icons.warning_amber_rounded
                      : Icons.campaign_outlined,
                  color: BauhausDesign.textLight,
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
                    color: BauhausDesign.textLight,
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
                  ? const Color(0xFFFFF5F5)
                  : BauhausDesign.surfaceOffWhite,
              border: Border.all(
                color: hasActive
                    ? BauhausDesign.primary
                    : BauhausDesign.neutral,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: hasActive
                      ? BauhausDesign.primary
                      : BauhausDesign.neutral,
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
                        horizontal: 14, vertical: 14),
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
                            color: BauhausDesign.textDark,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...broadcasts.map((b) => _BroadcastTile(
                        broadcast: b,
                        onAcknowledge: () {
                          HapticFeedback.mediumImpact();
                          if (b.id != null) {
                            ref
                                .read(teamViewModelProvider)
                                .acknowledgeBroadcast(b.id!);
                          }
                        },
                      )),
                // Send button
                GestureDetector(
                  onTap: () => _showEmergencyDialog(context, viewModel),
                  child: Container(
                    width: double.infinity,
                    color: BauhausDesign.primary,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.campaign,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          'SEND EMERGENCY BROADCAST',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
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
          Container(
              width: 4,
              height: 16,
              color: BauhausDesign.secondary),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.oswald(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: BauhausDesign.textDark,
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
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceOffWhite,
          border: Border(
            left: BorderSide(color: BauhausDesign.accent, width: 4),
            right: BorderSide(color: BauhausDesign.neutral, width: 2),
            top: BorderSide(color: BauhausDesign.neutral, width: 2),
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
          boxShadow: [BauhausDesign.shadowHard],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NO TEAMS YET',
              style: GoogleFonts.oswald(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap the NEW TEAM button below to create\nyour first coordination team.',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: BauhausDesign.textMuted,
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
        decoration: const BoxDecoration(
          color: Color(0xFFFFF5F5),
          border: Border(
            left: BorderSide(color: BauhausDesign.primary, width: 4),
            right: BorderSide(color: BauhausDesign.neutral, width: 2),
            top: BorderSide(color: BauhausDesign.neutral, width: 2),
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline,
                color: BauhausDesign.primary, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: BauhausDesign.textDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── FAB ──────────────────────────────────────────────────
  Widget _buildFAB(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _showCreateTeamDialog(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.secondary,
          boxShadow: [BauhausDesign.shadowHardLg],
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              'NEW TEAM',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Colors.white,
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
            _NeoTextField(controller: nameCtrl, hint: 'e.g. Morning Shift Alpha'),
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
                      ref.read(teamViewModelProvider).createTeam(name);
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
    final msgCtrl = TextEditingController();
    // Pick first team for demo; in a real app user would select
    final teams = viewModel.teams as List<Team>;

    showDialog(
      context: context,
      builder: (ctx) => _NeoBrutalistDialog(
        accentColor: BauhausDesign.primary,
        title: 'EMERGENCY BROADCAST',
        titleIcon: Icons.warning_amber_rounded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFFFFF3E0),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 14, color: Color(0xFFE65100)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This will notify all team members immediately.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE65100),
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
                    onTap: () {
                      final msg = msgCtrl.text.trim();
                      if (msg.isEmpty) return;
                      HapticFeedback.heavyImpact();
                      if (teams.isNotEmpty && teams.first.id != null) {
                        viewModel.sendBroadcast(
                            teams.first.id!, msg, 'alert');
                      }
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Emergency broadcast sent!',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          backgroundColor: BauhausDesign.primary,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
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
// Team Card
// ═══════════════════════════════════════════════════════════
class _TeamCard extends StatefulWidget {
  final Team team;
  final int index;
  final List<TeamMember> availableUsers;
  final Future<void> Function(String teamId, String email, String role)
      onInvite;

  const _TeamCard({
    required this.team,
    required this.index,
    required this.availableUsers,
    required this.onInvite,
  });

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard>
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
        duration: const Duration(milliseconds: 240));
    _expandAnim =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initial = widget.team.name.isNotEmpty
        ? widget.team.name[0].toUpperCase()
        : '?';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [
          BoxShadow(
            color: _expanded
                ? _accent.withOpacity(0.85)
                : Colors.black,
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
                        color: _accent == BauhausDesign.accent
                            ? BauhausDesign.neutral
                            : Colors.white,
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
                            color: BauhausDesign.textDark,
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
                            color: BauhausDesign.textMuted,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 240),
                    child: const Icon(Icons.keyboard_arrow_down,
                        color: BauhausDesign.textDark, size: 22),
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
                  color: BauhausDesign.neutral.withOpacity(0.18),
                ),
                if (widget.team.members.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Text(
                      'No members yet — invite someone below.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: BauhausDesign.textMuted,
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
                    color: BauhausDesign.surfaceOffWhite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          color: _accent,
                          child: const Icon(Icons.person_add,
                              color: Colors.white, size: 14),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'INVITE MEMBER',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: BauhausDesign.textDark,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right,
                            color: BauhausDesign.textMuted, size: 18),
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
                  decoration: const BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.fromBorderSide(BorderSide(color: BauhausDesign.neutral, width: 2)),
                  ),
                  child: Text(
                    'No available users to invite.',
                    style: GoogleFonts.inter(fontSize: 13, color: BauhausDesign.textMuted),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.fromBorderSide(BorderSide(color: BauhausDesign.neutral, width: 2)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<TeamMember>(
                      isExpanded: true,
                      value: selectedUser,
                      hint: Text(
                        'Select an organization member',
                        style: GoogleFonts.inter(color: BauhausDesign.textMuted, fontSize: 13),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down, color: BauhausDesign.textDark),
                      dropdownColor: BauhausDesign.surfaceWhite,
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
                              color: BauhausDesign.textDark,
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
                        margin:
                            const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _accent
                              : BauhausDesign.surfaceOffWhite,
                          border: Border.all(
                            color: isSelected
                                ? _accent
                                : BauhausDesign.neutral,
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
                                ? (_accent == BauhausDesign.accent
                                    ? BauhausDesign.neutral
                                    : Colors.white)
                                : BauhausDesign.textDark,
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
                      textColor: _accent == BauhausDesign.accent
                          ? BauhausDesign.neutral
                          : Colors.white,
                      onTap: () async {
                        if (selectedUser == null) return;
                        final email = selectedUser!.email;
                        if (email.isEmpty ||
                            !email.contains('@')) return;
                        HapticFeedback.mediumImpact();
                        Navigator.pop(ctx);
                        await widget.onInvite(
                            widget.team.id ?? '', email, selectedRole);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text(
                              'Invite sent to $email',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: BauhausDesign.success,
                            behavior: SnackBarBehavior.floating,
                          ));
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
    'member': BauhausDesign.textMuted,
  };

  @override
  Widget build(BuildContext context) {
    final roleColor =
        _roleColors[member.role] ?? BauhausDesign.textMuted;
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
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: BauhausDesign.neutral.withOpacity(0.14),
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
                  : BauhausDesign.textMuted,
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
                    color: BauhausDesign.textDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (sublabel != null)
                  Text(
                    sublabel,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: BauhausDesign.textMuted,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            color: roleColor.withOpacity(0.12),
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
class _BroadcastTile extends StatelessWidget {
  final EmergencyBroadcast broadcast;
  final VoidCallback onAcknowledge;

  const _BroadcastTile(
      {required this.broadcast, required this.onAcknowledge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: BauhausDesign.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: BauhausDesign.primary, size: 18),
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
                    color: BauhausDesign.textDark,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  broadcast.type.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textMuted,
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: const BoxDecoration(
                color: BauhausDesign.neutral,
                boxShadow: [BauhausDesign.shadowHardXs],
              ),
              child: Text(
                'ACK',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
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
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
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
              color: BauhausDesign.neutral,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(titleIcon,
                      color: BauhausDesign.textLight, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.oswald(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: BauhausDesign.textLight,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(20),
              child: child,
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
        color: BauhausDesign.textDark,
        letterSpacing: 2,
      ),
    );
  }
}

class _NeoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final Color focusBorderColor;

  const _NeoTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.focusBorderColor = BauhausDesign.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: maxLines == 1,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: BauhausDesign.textDark,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: BauhausDesign.surfaceOffWhite,
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: BauhausDesign.textMuted,
          fontSize: 13,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide:
              BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide:
              BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: focusBorderColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 11),
      ),
    );
  }
}

class _NeoFilledButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _NeoFilledButton({
    required this.label,
    required this.color,
    this.textColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausDesign.neutral, width: 1.5),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: textColor,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceOffWhite,
          border: Border.fromBorderSide(
            BorderSide(color: BauhausDesign.neutral, width: 1.5),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.textDark,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
