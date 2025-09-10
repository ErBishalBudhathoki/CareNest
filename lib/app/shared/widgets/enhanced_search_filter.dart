import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

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
          const SizedBox(height: ModernSaasDesign.space2),
          _buildActiveFilters(),
        ],
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearchFocused
              ? ModernSaasDesign.primary
              : ModernSaasDesign.border,
          width: _isSearchFocused ? 2 : 1,
        ),
        boxShadow: [
          if (_isSearchFocused)
            BoxShadow(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: widget.onSearchChanged,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                hintStyle: ModernSaasDesign.bodyLarge.copyWith(
                  color: ModernSaasDesign.textTertiary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: ModernSaasDesign.textTertiary,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: ModernSaasDesign.textTertiary,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          widget.onSearchChanged?.call('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space3,
                  vertical: ModernSaasDesign.space3,
                ),
              ),
            ),
          ),
          if (widget.filterOptions?.isNotEmpty == true) ...[
            Container(
              width: 1,
              height: 24,
              color: ModernSaasDesign.border,
            ),
            _buildFilterButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return PopupMenuButton<FilterOption>(
      icon: const Icon(
        Icons.filter_list,
        color: ModernSaasDesign.textSecondary,
      ),
      onSelected: widget.onFilterChanged,
      itemBuilder: (context) {
        return widget.filterOptions!.map((option) {
          return PopupMenuItem<FilterOption>(
            value: option,
            child: Row(
              children: [
                Icon(
                  option.icon,
                  size: 18,
                  color: option.color ?? ModernSaasDesign.textSecondary,
                ),
                const SizedBox(width: ModernSaasDesign.space2),
                Text(option.label),
                if (option.count != null) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: ModernSaasDesign.neutral200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      option.count.toString(),
                      style: ModernSaasDesign.labelSmall,
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
            spacing: ModernSaasDesign.space2,
            runSpacing: ModernSaasDesign.space2,
            children: widget.activeFilters!.map((filter) {
              return Chip(
                label: Text(
                  filter,
                  style: ModernSaasDesign.labelMedium.copyWith(
                    color: ModernSaasDesign.primary,
                  ),
                ),
                backgroundColor:
                    ModernSaasDesign.primary.withValues(alpha: 0.1),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 16,
                  color: ModernSaasDesign.primary,
                ),
                onDeleted: () {
                  // Handle filter removal
                },
                side: BorderSide(
                  color: ModernSaasDesign.primary.withValues(alpha: 0.3),
                ),
              );
            }).toList(),
          ),
        ),
        if (widget.onClearFilters != null)
          TextButton(
            onPressed: widget.onClearFilters,
            child: Text(
              'Clear All',
              style: ModernSaasDesign.labelMedium.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
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
