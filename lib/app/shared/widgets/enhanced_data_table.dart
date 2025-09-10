import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

/// Enhanced Data Table with improved UX/UI features
class EnhancedDataTable extends StatefulWidget {
  final List<EnhancedDataColumn> columns;
  final List<EnhancedDataRow> rows;
  final bool sortAscending;
  final int? sortColumnIndex;
  final DataColumnSortCallback?
      onSort; // Change from ValueChanged<int>? to DataColumnSortCallback?
  final bool showCheckboxColumn;
  final ValueChanged<bool?>? onSelectAll;
  final bool isLoading;
  final String? emptyMessage;
  final Widget? emptyWidget;
  final EdgeInsets? padding;
  final bool responsive;
  final ScrollController? horizontalScrollController;
  final ScrollController? verticalScrollController;

  const EnhancedDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.onSort,
    this.showCheckboxColumn = false,
    this.onSelectAll,
    this.isLoading = false,
    this.emptyMessage,
    this.emptyWidget,
    this.padding,
    this.responsive = true,
    this.horizontalScrollController,
    this.verticalScrollController,
  });

  @override
  State<EnhancedDataTable> createState() => _EnhancedDataTableState();
}

class _EnhancedDataTableState extends State<EnhancedDataTable> {
  late ScrollController _horizontalController;
  late ScrollController _verticalController;

  @override
  void initState() {
    super.initState();
    _horizontalController =
        widget.horizontalScrollController ?? ScrollController();
    _verticalController = widget.verticalScrollController ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.horizontalScrollController == null) {
      _horizontalController.dispose();
    }
    if (widget.verticalScrollController == null) {
      _verticalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingState();
    }

    if (widget.rows.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      padding: widget.padding ?? const EdgeInsets.all(ModernSaasDesign.space3),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: ModernSaasDesign.shadowMd,
      ),
      child:
          widget.responsive ? _buildResponsiveTable() : _buildStandardTable(),
    );
  }

  Widget _buildResponsiveTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        if (isMobile) {
          return _buildMobileCards();
        } else {
          return _buildStandardTable();
        }
      },
    );
  }

  Widget _buildStandardTable() {
    return Column(
      children: [
        // Header
        Container(
          decoration: const BoxDecoration(
            color: ModernSaasDesign.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortAscending: widget.sortAscending,
              sortColumnIndex: widget.sortColumnIndex,
              showCheckboxColumn: widget.showCheckboxColumn,
              onSelectAll: widget.onSelectAll,
              headingRowColor: MaterialStateProperty.all(
                ModernSaasDesign.background,
              ),
              headingTextStyle: ModernSaasDesign.labelMedium.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
              dataTextStyle: ModernSaasDesign.bodyMedium.copyWith(
                color: ModernSaasDesign.textPrimary,
              ),
              columns: widget.columns.map((column) {
                return DataColumn(
                  label: column.label,
                  onSort: column.onSort ?? widget.onSort,
                  numeric: column.numeric,
                  tooltip: column.tooltip,
                );
              }).toList(),
              rows: widget.rows.map((row) {
                return DataRow(
                  selected: row.selected,
                  onSelectChanged: row.onSelectChanged,
                  color: row.color,
                  cells: row.cells.map((cell) {
                    return DataCell(
                      cell.child,
                      showEditIcon: cell.showEditIcon,
                      onTap: cell.onTap,
                      onLongPress: cell.onLongPress,
                      onDoubleTap: cell.onDoubleTap,
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCards() {
    return ListView.builder(
      controller: _verticalController,
      shrinkWrap: true,
      itemCount: widget.rows.length,
      itemBuilder: (context, index) {
        final row = widget.rows[index];
        return _buildMobileCard(row, index);
      },
    );
  }

  Widget _buildMobileCard(EnhancedDataRow row, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: ModernSaasDesign.space2),
      padding: const EdgeInsets.all(ModernSaasDesign.space3),
      decoration: BoxDecoration(
        color: row.selected
            ? ModernSaasDesign.primary.withValues(alpha: 0.05)
            : ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: row.selected
              ? ModernSaasDesign.primary.withValues(alpha: 0.3)
              : ModernSaasDesign.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.columns.length, (columnIndex) {
          final column = widget.columns[columnIndex];
          final cell = row.cells[columnIndex];

          return Padding(
            padding: const EdgeInsets.only(bottom: ModernSaasDesign.space1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    _getColumnTitle(column.label),
                    style: ModernSaasDesign.labelSmall.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: cell.onTap,
                    onLongPress: cell.onLongPress,
                    onDoubleTap: cell.onDoubleTap,
                    child: cell.child,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
  }

  String _getColumnTitle(Widget label) {
    if (label is Text) {
      return label.data ?? '';
    }
    return '';
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(ModernSaasDesign.space8),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: ModernSaasDesign.shadowMd,
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ModernSaasDesign.primary),
            ),
            SizedBox(height: ModernSaasDesign.space3),
            Text(
              'Loading data...',
              style: ModernSaasDesign.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(ModernSaasDesign.space8),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: ModernSaasDesign.shadowMd,
      ),
      child: Center(
        child: widget.emptyWidget ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: ModernSaasDesign.neutral400,
                ),
                const SizedBox(height: ModernSaasDesign.space3),
                Text(
                  widget.emptyMessage ?? 'No data available',
                  style: ModernSaasDesign.headlineSmall.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

/// Enhanced Data Column
class EnhancedDataColumn {
  final Widget label;
  final String? tooltip;
  final bool numeric;
  final DataColumnSortCallback? onSort; // Changed from ValueChanged<int>?
  final bool sortable;

  const EnhancedDataColumn({
    required this.label,
    this.tooltip,
    this.numeric = false,
    this.onSort,
    this.sortable = true,
  });
}

/// Enhanced Data Row
class EnhancedDataRow {
  final List<EnhancedDataCell> cells;
  final bool selected;
  final ValueChanged<bool?>? onSelectChanged;
  final MaterialStateProperty<Color?>? color;
  final VoidCallback? onTap;

  const EnhancedDataRow({
    required this.cells,
    this.selected = false,
    this.onSelectChanged,
    this.color,
    this.onTap,
  });
}

/// Enhanced Data Cell
class EnhancedDataCell {
  final Widget child;
  final bool showEditIcon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;

  const EnhancedDataCell({
    required this.child,
    this.showEditIcon = false,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
  });

  /// Factory for status cell
  factory EnhancedDataCell.status({
    required String status,
    Color? color,
    VoidCallback? onTap,
  }) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'active':
      case 'paid':
      case 'completed':
        statusColor = ModernSaasDesign.success;
        break;
      case 'pending':
      case 'processing':
        statusColor = ModernSaasDesign.warning;
        break;
      case 'inactive':
      case 'unpaid':
      case 'cancelled':
        statusColor = ModernSaasDesign.error;
        break;
      default:
        statusColor = ModernSaasDesign.neutral500;
    }

    return EnhancedDataCell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSaasDesign.spacing8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: (color ?? statusColor).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (color ?? statusColor).withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          status,
          style: ModernSaasDesign.labelSmall.copyWith(
            color: color ?? statusColor,
          ),
        ),
      ),
    );
  }

  /// Factory for action cell
  factory EnhancedDataCell.actions({
    required List<ActionButton> actions,
  }) {
    return EnhancedDataCell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(right: ModernSaasDesign.spacing4),
            child: IconButton(
              icon: Icon(
                action.icon,
                size: 18,
                color: action.color ?? ModernSaasDesign.textSecondary,
              ),
              onPressed: action.onPressed,
              tooltip: action.tooltip,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Action Button for data cells
class ActionButton {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? color;

  const ActionButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
  });
}
