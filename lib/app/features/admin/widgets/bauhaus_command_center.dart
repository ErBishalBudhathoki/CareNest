import 'package:carenest/app/features/admin/utils/command_desk_prefs.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// Data model for a single action item inside a category.
class CommandAction {
  final Widget icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final String? statusLabel;
  final Color? statusColor;

  const CommandAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.statusLabel,
    this.statusColor,
  });
}

/// Data model for a category group.
class CommandCategory {
  final String title;
  final IconData headerIcon;
  final Color accentColor;
  final List<CommandAction> actions;
  final String? setupBannerTitle;
  final String? setupBannerSubtitle;
  final String? setupBannerActionLabel;
  final VoidCallback? onSetupBannerTap;

  const CommandCategory({
    required this.title,
    required this.headerIcon,
    required this.accentColor,
    required this.actions,
    this.setupBannerTitle,
    this.setupBannerSubtitle,
    this.setupBannerActionLabel,
    this.onSetupBannerTap,
  });
}

/// Quick action command center for admin dashboard.
///
/// Stacked collapsible sections + cross-category search. Sections float by
/// recency only when the opt-in toggle
/// (`CommandDeskPrefs.sortByRecent`) is on.
class BauhausCommandCenter extends StatefulWidget {
  final List<CommandCategory> categories;

  const BauhausCommandCenter({super.key, required this.categories});

  @override
  State<BauhausCommandCenter> createState() => _BauhausCommandCenterState();
}

class _BauhausCommandCenterState extends State<BauhausCommandCenter> {
  final Set<int> _expanded = {0};
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  Map<String, int> _lastUsedByCategory = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    CommandDeskPrefs.sortByRecent.addListener(_onSortToggleChanged);
    _loadPrefs();
  }

  @override
  void didUpdateWidget(covariant BauhausCommandCenter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categories.length != widget.categories.length) {
      _expanded.removeWhere((i) => i < 0 || i >= widget.categories.length);
      if (widget.categories.isNotEmpty && _expanded.isEmpty) {
        _expanded.add(0);
      }
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    CommandDeskPrefs.sortByRecent.removeListener(_onSortToggleChanged);
    super.dispose();
  }

  Future<void> _loadPrefs() async {
    await CommandDeskPrefs.load();
    final entries = await CommandDeskPrefs.recentEntries();
    if (!mounted) return;
    setState(() {
      _refreshRecency(entries);
    });
  }

  void _refreshRecency(List<String> entries) {
    final map = <String, int>{};
    for (final category in widget.categories) {
      final last = CommandDeskPrefs.sectionLastUsed(category.title, entries);
      if (last != null) map[category.title] = last;
    }
    _lastUsedByCategory = map;
  }

  void _onSearchChanged() {
    setState(() {
      _query = _searchController.text.trim().toLowerCase();
    });
  }

  void _onSortToggleChanged() {
    if (mounted) setState(() {});
  }

  void _toggleSection(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      if (_expanded.contains(index)) {
        _expanded.remove(index);
      } else {
        _expanded.add(index);
      }
    });
  }

  /// Display order: original, recency-floated, or search-ranked.
  List<int> _displayIndices() {
    final titles = widget.categories.map((c) => c.title).toList();
    if (_query.isNotEmpty) {
      final scored = <int, int>{};
      for (var i = 0; i < widget.categories.length; i++) {
        scored[i] = _matchCount(widget.categories[i]);
      }
      final visible = scored.entries
          .where((e) => e.value > 0)
          .map((e) => e.key)
          .toList();
      visible.sort((a, b) {
        final cmp = scored[b]!.compareTo(scored[a]!);
        if (cmp != 0) return cmp;
        return a.compareTo(b);
      });
      return visible;
    }
    return CommandDeskPrefs.orderedSectionIndices(
      categoryTitles: titles,
      lastUsedByCategory: _lastUsedByCategory,
      sortByRecent: CommandDeskPrefs.sortByRecent.value,
    );
  }

  int _matchCount(CommandCategory category) {
    if (_query.isEmpty) return category.actions.length;
    var count = 0;
    for (final action in category.actions) {
      if (action.title.toLowerCase().contains(_query) ||
          action.subtitle.toLowerCase().contains(_query)) {
        count++;
      }
    }
    return count;
  }

  List<CommandAction> _visibleActions(CommandCategory category) {
    if (_query.isEmpty) return category.actions;
    return category.actions
        .where(
          (a) =>
              a.title.toLowerCase().contains(_query) ||
              a.subtitle.toLowerCase().contains(_query),
        )
        .toList();
  }

  Future<void> _onActionTap(
    CommandCategory category,
    CommandAction action,
  ) async {
    await CommandDeskPrefs.recordActionUse(category.title, action.title);
    if (!mounted) {
      action.onTap();
      return;
    }
    setState(() {
      _lastUsedByCategory[category.title] =
          DateTime.now().millisecondsSinceEpoch;
    });
    action.onTap();
  }

  /// True when this section floated above its original position via recency.
  bool _isFloated(int displayPosition, int originalIndex) {
    if (_query.isNotEmpty) return false;
    if (!CommandDeskPrefs.sortByRecent.value) return false;
    if (!_lastUsedByCategory.containsKey(
      widget.categories[originalIndex].title,
    )) {
      return false;
    }
    return displayPosition < originalIndex;
  }

  @override
  Widget build(BuildContext context) {
    final indices = _displayIndices();
    final totalActions = widget.categories.fold<int>(
      0,
      (sum, category) => sum + category.actions.length,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDeckHeader(),
        const SizedBox(height: BauhausDesign.space3),
        _buildSearchField(totalActions),
        const SizedBox(height: BauhausDesign.space3),
        if (indices.isEmpty)
          _buildEmptyState()
        else
          for (var position = 0; position < indices.length; position++)
            Padding(
              padding: EdgeInsets.only(
                bottom: position == indices.length - 1
                    ? 0
                    : BauhausDesign.space3,
              ),
              child: _BauhausSectionCard(
                category: widget.categories[indices[position]],
                originalIndex: indices[position],
                // Search always reveals matches, regardless of collapse state.
                expanded:
                    _query.isNotEmpty || _expanded.contains(indices[position]),
                showRecentChip: _isFloated(position, indices[position]),
                visibleActions: _visibleActions(
                  widget.categories[indices[position]],
                ),
                searchActive: _query.isNotEmpty,
                onHeaderTap: () => _toggleSection(indices[position]),
                onActionTap: (action) =>
                    _onActionTap(widget.categories[indices[position]], action),
              ),
            ),
      ],
    );
  }

  Widget _buildDeckHeader() {
    return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: BauhausDesign.neutral,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: const Icon(
                  Icons.apps_rounded,
                  color: BauhausDesign.surfaceWhite,
                  size: 22,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Command Desk',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: BauhausDesign.textDark,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'Focused control for admin workflows',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.06, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }

  Widget _buildSearchField(int totalActions) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(BauhausDesign.space2),
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.neutral,
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
            ),
            child: const Icon(
              Icons.search_rounded,
              size: 18,
              color: BauhausDesign.surfaceWhite,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: BauhausDesign.textDark,
              ),
              decoration: InputDecoration(
                hintText: 'Search $totalActions actions…',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textMuted,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: BauhausDesign.space3,
                ),
              ),
            ),
          ),
          if (_query.isNotEmpty)
            IconButton(
              onPressed: _searchController.clear,
              icon: const Icon(Icons.close_rounded, size: 18),
              color: BauhausDesign.textMuted,
              tooltip: 'Clear search',
            )
          else
            const SizedBox(width: BauhausDesign.space2),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: BauhausDesign.backgroundLight,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: BauhausDesign.textMuted,
              size: 22,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            'No actions match "$_query"',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: BauhausDesign.textDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: BauhausDesign.space2),
          TextButton(
            onPressed: _searchController.clear,
            child: Text(
              'CLEAR SEARCH',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: BauhausDesign.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausSectionCard extends StatelessWidget {
  final CommandCategory category;
  final int originalIndex;
  final bool expanded;
  final bool showRecentChip;
  final List<CommandAction> visibleActions;
  final bool searchActive;
  final VoidCallback onHeaderTap;
  final void Function(CommandAction action) onActionTap;

  const _BauhausSectionCard({
    required this.category,
    required this.originalIndex,
    required this.expanded,
    required this.showRecentChip,
    required this.visibleActions,
    required this.searchActive,
    required this.onHeaderTap,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: category.accentColor, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildHeader(context),
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: expanded
                ? _buildBody(context)
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onHeaderTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3,
            vertical: BauhausDesign.space3,
          ),
          child: Row(
            children: [
              Container(width: 8, height: 28, color: category.accentColor),
              const SizedBox(width: BauhausDesign.space3),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: category.accentColor.withValues(alpha: 0.14),
                  border: Border.all(
                    color: category.accentColor.withValues(alpha: 0.55),
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  category.headerIcon,
                  color: category.accentColor,
                  size: 19,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title.toUpperCase(),
                      style: GoogleFonts.oswald(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textDark,
                        letterSpacing: 1.0,
                        height: 1.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      searchActive
                          ? '${visibleActions.length} matching actions'
                          : '${category.actions.length} actions',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (showRecentChip)
                Container(
                  margin: const EdgeInsets.only(right: BauhausDesign.space2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: category.accentColor.withValues(alpha: 0.12),
                    border: Border.all(color: category.accentColor, width: 1),
                  ),
                  child: Text(
                    'RECENT',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: category.accentColor,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: expanded ? 0.5 : 0,
                child: const Icon(
                  Icons.expand_more_rounded,
                  size: 22,
                  color: BauhausDesign.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: BauhausDesign.backgroundLight,
      child: Column(
        children: [
          if (category.setupBannerTitle != null &&
              category.setupBannerSubtitle != null)
            _buildSetupBanner(),
          _buildActionGrid(context),
        ],
      ),
    );
  }

  Widget _buildSetupBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.warning.withValues(alpha: 0.08),
        border: Border(
          bottom: BorderSide(
            color: BauhausDesign.warning.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: BauhausDesign.warning.withValues(alpha: 0.14),
              border: Border.all(color: BauhausDesign.warning, width: 1.5),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.settings_suggest_outlined,
              size: 18,
              color: BauhausDesign.warning,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.setupBannerTitle!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: BauhausDesign.textDark,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.setupBannerSubtitle!,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textMuted,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          if (category.onSetupBannerTap != null &&
              category.setupBannerActionLabel != null)
            TextButton(
              onPressed: category.onSetupBannerTap,
              style: TextButton.styleFrom(
                foregroundColor: BauhausDesign.warning,
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                category.setupBannerActionLabel!,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width >= 1100
        ? 4
        : width >= 760
        ? 3
        : width < 390
        ? 1
        : 2;
    final childAspectRatio = crossAxisCount == 1 ? 2.8 : 1.18;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        BauhausDesign.space3,
        BauhausDesign.space3,
        BauhausDesign.space3,
        BauhausDesign.space3,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: BauhausDesign.space3,
          crossAxisSpacing: BauhausDesign.space3,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: visibleActions.length,
        itemBuilder: (context, index) {
          return _BauhausGridActionCard(
            action: visibleActions[index],
            index: index,
            categoryIndex: originalIndex,
            onTap: () => onActionTap(visibleActions[index]),
          );
        },
      ),
    );
  }
}

class _BauhausGridActionCard extends StatelessWidget {
  final CommandAction action;
  final int index;
  final int categoryIndex;
  final VoidCallback? onTap;

  const _BauhausGridActionCard({
    required this.action,
    required this.index,
    required this.categoryIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          if (onTap != null) {
            onTap!();
          } else {
            action.onTap();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 1.8),
            boxShadow: const [BauhausDesign.shadowHardXs],
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
                        color: action.color.withValues(alpha: 0.14),
                        border: Border.all(
                          color: action.color.withValues(alpha: 0.55),
                          width: 1.4,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: IconTheme(
                        data: IconThemeData(color: action.color, size: 22),
                        child: _constrainIcon(action.icon),
                      ),
                    ),
                    const Spacer(),
                    if (action.statusLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BauhausDesign.space2,
                          vertical: BauhausDesign.space1,
                        ),
                        decoration: BoxDecoration(
                          color: (action.statusColor ?? BauhausDesign.warning)
                              .withValues(alpha: 0.12),
                          border: Border.all(
                            color: action.statusColor ?? BauhausDesign.warning,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          action.statusLabel!,
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: action.statusColor ?? BauhausDesign.warning,
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: BauhausDesign.backgroundLight,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  action.title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: BauhausDesign.textDark,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: BauhausDesign.space1),
                Expanded(
                  child: Text(
                    action.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textMuted,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: action.color,
                    border: Border.all(
                      color: BauhausDesign.neutral.withValues(alpha: 0.25),
                      width: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Constrain image assets to fit the icon container properly.
  Widget _constrainIcon(Widget icon) {
    if (icon is Icon) return icon;
    return SizedBox(width: 22, height: 22, child: icon);
  }
}
