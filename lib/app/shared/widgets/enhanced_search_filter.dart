import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Enhanced Search and Filter Bar
class EnhancedSearchFilterBar extends StatefulWidget {
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final List<FilterOption>? filterOptions;
  final ValueChanged<FilterOption?>? onFilterChanged;
  final VoidCallback? onClearFilters;
  final bool showFilterChips;
  final List<String>? activeFilters;

  const EnhancedSearchFilterBar({
    super.key,
    this.searchHint = 'Search...',
    this.onSearchChanged,
    this.filterOptions,
    this.onFilterChanged,
    this.onClearFilters,
    this.showFilterChips = true,
    this.activeFilters,
  });

  @override
  State<EnhancedSearchFilterBar> createState() =>
      _EnhancedSearchFilterBarState();
}

class _EnhancedSearchFilterBarState extends State<EnhancedSearchFilterBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        if (widget.showFilterChips &&
            widget.activeFilters?.isNotEmpty == true) ...[
          const SizedBox(height: 8.0),
          _buildActiveFilters(),
        ],
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: _isSearchFocused
              ? BauhausDesign.primary
              : BauhausDesign.neutral,
          width: 2,
        ),
        boxShadow: _isSearchFocused ? const [BauhausDesign.shadowHardSm] : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: widget.onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _searchFocusNode.unfocus(),
              onTapOutside: (_) => _searchFocusNode.unfocus(),
              decoration: InputDecoration(
                hintText: widget.searchHint,
                hintStyle: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.textMuted,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: BauhausDesign.textMuted,
                  semanticLabel: 'Search',
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        tooltip: 'Clear search',
                        icon: const Icon(
                          Icons.clear,
                          color: BauhausDesign.textMuted,
                        ),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          _searchController.clear();
                          widget.onSearchChanged?.call('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
          if (widget.filterOptions?.isNotEmpty == true) ...[
            Container(width: 2, height: 24, color: BauhausDesign.neutral),
            _buildFilterButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return PopupMenuButton<FilterOption>(
      tooltip: 'Filter options',
      icon: const Icon(
        Icons.filter_list,
        color: BauhausDesign.textDark,
        semanticLabel: 'Filter options',
      ),
      onSelected: (option) {
        HapticFeedback.selectionClick();
        widget.onFilterChanged?.call(option);
      },
      itemBuilder: (context) {
        return widget.filterOptions!.map((option) {
          return PopupMenuItem<FilterOption>(
            value: option,
            child: Row(
              children: [
                Icon(
                  option.icon,
                  size: 18,
                  color: option.color ?? BauhausDesign.textDark,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    option.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (option.count != null) ...[
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceOffWhite,
                      border: Border.all(color: BauhausDesign.neutral),
                    ),
                    child: Text(
                      option.count.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList();
      },
    );
  }

  Widget _buildActiveFilters() {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.activeFilters!.map((filter) {
              return Chip(
                label: Text(
                  filter,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ).copyWith(color: BauhausDesign.textDark),
                ),
                backgroundColor: BauhausDesign.surfaceOffWhite,
                deleteIcon: const Icon(
                  Icons.close,
                  size: 16,
                  semanticLabel: 'Remove filter',
                ),
                onDeleted: () {
                  HapticFeedback.lightImpact();
                },
                side: const BorderSide(color: BauhausDesign.neutral, width: 1.5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              );
            }).toList(),
          ),
        ),
        if (widget.onClearFilters != null)
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              widget.onClearFilters?.call();
            },
            child: Text(
              'Clear All',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ).copyWith(color: BauhausDesign.textDark),
            ),
          ),
      ],
    );
  }
}

/// Filter option data model
class FilterOption {
  final String label;
  final String value;
  final IconData? icon;
  final Color? color;
  final int? count;

  const FilterOption({
    required this.label,
    required this.value,
    this.icon,
    this.color,
    this.count,
  });
}
