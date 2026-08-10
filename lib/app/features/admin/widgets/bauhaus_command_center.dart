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
class BauhausCommandCenter extends StatefulWidget {
  final List<CommandCategory> categories;

  const BauhausCommandCenter({super.key, required this.categories});

  @override
  State<BauhausCommandCenter> createState() => _BauhausCommandCenterState();
}

class _BauhausCommandCenterState extends State<BauhausCommandCenter>
    with SingleTickerProviderStateMixin {
  late int _selectedCategoryIndex;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = widget.categories.isEmpty ? -1 : 0;
    _initializeTabController();
  }

  @override
  void didUpdateWidget(covariant BauhausCommandCenter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categories.length != widget.categories.length) {
      if (widget.categories.isEmpty) {
        _selectedCategoryIndex = -1;
      } else if (_selectedCategoryIndex < 0 ||
          _selectedCategoryIndex >= widget.categories.length) {
        _selectedCategoryIndex = 0;
      }
      _initializeTabController();
    }
  }

  void _initializeTabController() {
    _tabController?.dispose();
    if (widget.categories.isEmpty) {
      _tabController = null;
      return;
    }
    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
      initialIndex: _selectedCategoryIndex.clamp(
        0,
        widget.categories.length - 1,
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _selectCategory(int index) {
    if (index < 0 || index >= widget.categories.length) return;
    HapticFeedback.lightImpact();
    setState(() {
      _selectedCategoryIndex = index;
    });
    if (_tabController != null && _tabController!.index != index) {
      _tabController!.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalActions = widget.categories.fold<int>(
      0,
      (sum, category) => sum + category.actions.length,
    );
    final hasActiveCategory =
        _selectedCategoryIndex >= 0 &&
        _selectedCategoryIndex < widget.categories.length;
    final activeCategory = hasActiveCategory
        ? widget.categories[_selectedCategoryIndex]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCommandDeckHeader(totalActions),
        const SizedBox(height: BauhausDesign.space4),
        _buildCategoryTabs(),
        if (activeCategory != null) ...[
          const SizedBox(height: BauhausDesign.space4),
          _BauhausCategoryCard(
            category: activeCategory,
            categoryIndex: _selectedCategoryIndex,
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryTabs() {
    if (widget.categories.isEmpty || _tabController == null) {
      return const SizedBox.shrink();
    }

    return Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            onTap: _selectCategory,
            dividerColor: Colors.transparent,
            indicatorColor: BauhausDesign.neutral,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: BauhausDesign.textDark,
            unselectedLabelColor: BauhausDesign.textMuted,
            labelStyle: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            tabs: [
              for (int i = 0; i < widget.categories.length; i++)
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: BauhausDesign.space1,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: widget.categories[i].accentColor,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        Text(widget.categories[i].title),
                        const SizedBox(width: BauhausDesign.space1),
                        Text('(${widget.categories[i].actions.length})'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 280.ms, curve: Curves.easeOut)
        .slideY(begin: 0.04, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }

  Widget _buildCommandDeckHeader(int totalActions) {
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.backgroundLight,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      '$totalActions',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textDark,
                        height: 1,
                      ),
                    ),
                    Text(
                      'ACTIONS',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: BauhausDesign.textMuted,
                        letterSpacing: 0.8,
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
}

class _BauhausCategoryCard extends StatelessWidget {
  final CommandCategory category;
  final int categoryIndex;

  const _BauhausCategoryCard({
    required this.category,
    required this.categoryIndex,
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
            children: [_buildCategoryHeader(), _buildExpandedContent(context)],
          ),
        )
        .animate(delay: (categoryIndex * 90).ms)
        .fadeIn(duration: 360.ms, curve: Curves.easeOut)
        .slideY(begin: 0.05, end: 0, duration: 360.ms, curve: Curves.easeOut);
  }

  Widget _buildCategoryHeader() {
    final endColor = Color.lerp(category.accentColor, Colors.black, 0.2)!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [category.accentColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border(
          bottom: BorderSide(color: Colors.black.withValues(alpha: 0.18), width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space3,
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: Icon(category.headerIcon, color: Colors.white, size: 21),
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
                      color: Colors.white,
                      letterSpacing: 1.1,
                      height: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${category.actions.length} available actions',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space2,
                vertical: BauhausDesign.space1,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.32),
                  width: 1,
                ),
              ),
              child: Text(
                'ACTIVE TAB',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Container(
      key: ValueKey<String>('expanded_$categoryIndex'),
      color: BauhausDesign.backgroundLight,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              border: Border(
                bottom: BorderSide(
                  color: BauhausDesign.neutral.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              'Select an action tile to open its workflow',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: BauhausDesign.textMuted,
              ),
            ),
          ),
          if (category.setupBannerTitle != null &&
              category.setupBannerSubtitle != null)
            Container(
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
                        color: BauhausDesign.warning,
                        width: 1.5,
                      ),
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
            ),
          _buildActionGrid(context),
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
        4,
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
        itemCount: category.actions.length,
        itemBuilder: (context, index) {
          return _BauhausGridActionCard(
            action: category.actions[index],
            index: index,
            categoryIndex: categoryIndex,
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

  const _BauhausGridActionCard({
    required this.action,
    required this.index,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          action.onTap();
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
