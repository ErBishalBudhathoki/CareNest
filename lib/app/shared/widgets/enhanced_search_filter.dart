import 'package:flutter/material.dart';

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
          const SizedBox(height: 8.0),
          _buildActiveFilters(),
        ],
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isSearchFocused
              ? const Color(0xFF667EEA)
              : const Color(0xFFE0E0E0),
          width: _isSearchFocused ? 2 : 1,
        ),
        boxShadow: [
          if (_isSearchFocused)
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.1),
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
                hintStyle: const TextStyle(fontSize: 16).copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF9CA3AF),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color(0xFF9CA3AF),
                        ),
                        onPressed: () {
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
            Container(
              width: 1,
              height: 24,
              color: const Color(0xFFE0E0E0),
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
        color: Color(0xFF6B7280),
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
                  color: option.color ?? const Color(0xFF6B7280),
                ),
                const SizedBox(width: 8.0),
                Text(option.label),
                if (option.count != null) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      option.count.toString(),
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w500),
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
                  style:
                      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
                          .copyWith(
                    color: const Color(0xFF667EEA),
                  ),
                ),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 16,
                  color: Color(0xFF667EEA),
                ),
                onDeleted: () {
                  // Handle filter removal
                },
                side: BorderSide(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
                  .copyWith(
                color: const Color(0xFF6B7280),
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
