import 'package:carenest/app/features/admin/utils/command_desk_prefs.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Darkens bright accents (e.g. the tangerine) so an icon tinted with the
/// category colour still clears a 3:1 non-text contrast ratio against the
/// surface tile behind it. Dark accents pass through untouched.
Color _readableAccent(BuildContext context, Color color) {
  final tile = Theme.of(context).colorScheme.surface;
  if (color.computeLuminance() > 0.42 && tile.computeLuminance() > 0.5) {
    return Color.lerp(color, BauhausDesign.textDark, 0.5)!;
  }
  return color;
}

/// Picks ink or paper for a glyph sitting on a solid accent block, so the
/// colour plane keeps a readable icon at any category hue in either theme.
Color _onAccent(BuildContext context, Color color) =>
    BauhausDesign.readableOnColor(color);

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
        _buildSearchField(totalActions),
        const SizedBox(height: BauhausDesign.space3),
        if (indices.isEmpty)
          _buildEmptyState()
        else
          for (var position = 0; position < indices.length; position++)
            _BauhausSectionCard(
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
      ],
    );
  }

  Widget _buildSearchField(int totalActions) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(BauhausDesign.space2),
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.search_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Search $totalActions actions…',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
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
              icon: Icon(Icons.close_rounded, size: 18),
              color: Theme.of(context).colorScheme.onSurfaceVariant,
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
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.search_off_rounded,
              color: Theme.of(context).colorScheme.surface,
              size: 22,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            'No actions match "$_query"',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
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

class _BauhausSectionCard extends StatefulWidget {
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
  State<_BauhausSectionCard> createState() => _BauhausSectionCardState();
}

class _BauhausSectionCardState extends State<_BauhausSectionCard>
    with SingleTickerProviderStateMixin {
  static const Duration _expandDuration = Duration(milliseconds: 460);
  static const Duration _collapseDuration = Duration(milliseconds: 280);

  late final AnimationController _controller;
  late final Animation<double> _reveal;
  late final Animation<double> _chevron;

  /// Body stays mounted while the card is open or mid-close so the collapse
  /// animates real content, then unmounts once fully collapsed.
  bool _showBody = false;

  @override
  void initState() {
    super.initState();
    _showBody = widget.expanded;
    _controller = AnimationController(
      vsync: this,
      duration: _expandDuration,
      reverseDuration: _collapseDuration,
      value: widget.expanded ? 1 : 0,
    );
    _controller.addStatusListener(_handleStatus);
    _reveal = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInOutCubic,
    );
    _chevron = Tween<double>(begin: 0, end: 0.5).animate(_reveal);
  }

  void _handleStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && _showBody && mounted) {
      setState(() => _showBody = false);
    }
  }

  @override
  void didUpdateWidget(covariant _BauhausSectionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        if (!_showBody) setState(() => _showBody = true);
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      // Static subtree; the body stays mounted through the close animation so
      // it retracts under SizeTransition instead of vanishing instantly.
      child: Column(
        children: [
          _buildHeader(context),
          SizeTransition(
            sizeFactor: _reveal,
            axisAlignment: -1,
            child: _showBody
                ? _buildBody(context)
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
      builder: (context, child) {
        final t = _reveal.value;
        return Transform.translate(
          offset: Offset(0, -2 * t),
          child: Container(
            margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
              boxShadow: [
                BoxShadow.lerp(
                  BauhausDesign.shadowHardSm,
                  BauhausDesign.shadowHard,
                  t,
                )!,
              ],
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final accent = widget.category.accentColor;
    final onAccent = _onAccent(context, accent);
    final meta = widget.searchActive
        ? '${widget.visibleActions.length} MATCHING'
        : '${widget.category.actions.length} ACTIONS';

    return Material(
      color: accent,
      child: InkWell(
        onTap: widget.onHeaderTap,
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: onAccent.withValues(alpha: 0.85),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  if (widget.showRecentChip)
                    Container(
                      margin: const EdgeInsets.only(
                        right: BauhausDesign.space2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: onAccent.withValues(alpha: 0.16),
                        border: Border.all(
                          color: onAccent.withValues(alpha: 0.55),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'RECENT',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: onAccent,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: onAccent.withValues(alpha: 0.16),
                      border: Border.all(
                        color: onAccent.withValues(alpha: 0.55),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      widget.category.headerIcon,
                      color: onAccent,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space3),
              Text(
                widget.category.title.toUpperCase(),
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: onAccent,
                  letterSpacing: 0.8,
                  height: 1.05,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Center(
                child: RotationTransition(
                  turns: _chevron,
                  child: Container(
                    width: 36,
                    height: 24,
                    decoration: BoxDecoration(
                      color: onAccent.withValues(alpha: 0.16),
                      border: Border.all(
                        color: onAccent.withValues(alpha: 0.55),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: onAccent,
                      size: 20,
                    ),
                  ),
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
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          if (widget.category.setupBannerTitle != null &&
              widget.category.setupBannerSubtitle != null)
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
              border: Border.all(
                color: _readableAccent(context, BauhausDesign.warning),
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.settings_suggest_outlined,
              size: 18,
              color: _readableAccent(context, BauhausDesign.warning),
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category.setupBannerTitle!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.category.setupBannerSubtitle!,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          if (widget.category.onSetupBannerTap != null &&
              widget.category.setupBannerActionLabel != null)
            TextButton(
              onPressed: widget.category.onSetupBannerTap,
              style: TextButton.styleFrom(
                foregroundColor: _readableAccent(
                  context,
                  BauhausDesign.warning,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                widget.category.setupBannerActionLabel!,
                style: GoogleFonts.inter(
                  fontSize: 11,
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
    final childAspectRatio = crossAxisCount == 1 ? 2.4 : 1.18;

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
        itemCount: widget.visibleActions.length,
        itemBuilder: (context, index) {
          return _BauhausGridActionCard(
            action: widget.visibleActions[index],
            accentColor: widget.category.accentColor,
            index: index,
            categoryIndex: widget.originalIndex,
            onTap: () => widget.onActionTap(widget.visibleActions[index]),
          );
        },
      ),
    );
  }
}

class _BauhausGridActionCard extends StatefulWidget {
  final CommandAction action;
  final Color accentColor;
  final int index;
  final int categoryIndex;
  final VoidCallback? onTap;

  const _BauhausGridActionCard({
    required this.action,
    required this.accentColor,
    required this.index,
    required this.categoryIndex,
    this.onTap,
  });

  @override
  State<_BauhausGridActionCard> createState() => _BauhausGridActionCardState();
}

class _BauhausGridActionCardState extends State<_BauhausGridActionCard> {
  static const Offset _pressOffset = Offset(2, 2);
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    final callback = widget.onTap;
    if (callback != null) {
      callback();
    } else {
      widget.action.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor;
    final reducedMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final pressed = _pressed && !reducedMotion;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _handleTap,
        onHighlightChanged: _setPressed,
        splashFactory: NoSplash.splashFactory,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            pressed ? _pressOffset.dx : 0,
            pressed ? _pressOffset.dy : 0,
            0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
            boxShadow: pressed ? const [] : const [BauhausDesign.shadowHardSm],
          ),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconBlock(accent),
                    const Spacer(),
                    _buildTrailing(),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  widget.action.title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: BauhausDesign.space1),
                Expanded(
                  child: Text(
                    widget.action.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Solid accent plane that gives every action a strong, categorised marker
  /// instead of the old washed-out tint.
  Widget _buildIconBlock(Color accent) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: accent,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: IconTheme(
        data: IconThemeData(color: _onAccent(context, accent), size: 22),
        child: _constrainIcon(widget.action.icon),
      ),
    );
  }

  Widget _buildTrailing() {
    final statusLabel = widget.action.statusLabel;
    if (statusLabel != null) {
      final statusColor = _readableAccent(
        context,
        widget.action.statusColor ?? BauhausDesign.warning,
      );
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space2,
          vertical: BauhausDesign.space1,
        ),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.12),
          border: Border.all(color: statusColor, width: 1.5),
        ),
        child: Text(
          statusLabel,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: statusColor,
            letterSpacing: 0.5,
          ),
        ),
      );
    }
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1.5,
        ),
      ),
      child: Icon(
        Icons.arrow_outward_rounded,
        size: 15,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  /// Constrain image assets to fit the icon container properly.
  Widget _constrainIcon(Widget icon) {
    if (icon is Icon) return icon;
    return SizedBox(width: 22, height: 22, child: icon);
  }
}
