import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  final VoidCallback? onRetry;
  final String? retryLabel;
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
    this.onRetry,
    this.retryLabel,
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
      padding: widget.padding ?? const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: widget.responsive
          ? _buildResponsiveTable()
          : _buildStandardTable(),
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
            color: BauhausDesign.surfaceOffWhite,
            border: Border(
              bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
            ),
          ),
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortAscending: widget.sortAscending,
              sortColumnIndex: widget.sortColumnIndex,
              showCheckboxColumn: widget.showCheckboxColumn,
              onSelectAll: widget.onSelectAll,
              headingRowColor: WidgetStateProperty.all(
                BauhausDesign.surfaceOffWhite,
              ),
              headingTextStyle: BauhausDesign.neoMonoStyle(
                context,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              dataTextStyle: BauhausDesign.getTextTheme(context).bodyMedium,
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
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: row.selected
            ? BauhausDesign.accent.withValues(alpha: 0.15)
            : BauhausDesign.surfaceWhite,
        border: Border.all(
          color: row.selected
              ? BauhausDesign.neutral
              : BauhausDesign.neutral.withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.columns.length, (columnIndex) {
          final column = widget.columns[columnIndex];
          final cell = row.cells[columnIndex];

          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    _getColumnTitle(column.label),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      fontSize: 11,
                      color: BauhausDesign.textMuted,
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
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Center(
        child: Semantics(
          liveRegion: true,
          label: 'Loading data',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  BauhausDesign.primary,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Loading data...',
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Center(
        child:
            widget.emptyWidget ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: const Icon(
                    Icons.inbox_outlined,
                    size: 48,
                    color: BauhausDesign.textMuted,
                    semanticLabel: 'No data',
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  widget.emptyMessage ?? 'No data available',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: BauhausDesign.getTextTheme(context).titleSmall
                      ?.copyWith(color: BauhausDesign.textDark),
                ),
                if (widget.onRetry != null) ...[
                  const SizedBox(height: 16.0),
                  OutlinedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      widget.onRetry?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: BauhausDesign.textDark,
                      side: const BorderSide(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize: const Size(48, 48),
                    ),
                    child: Text(widget.retryLabel ?? 'TRY AGAIN'),
                  ),
                ],
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
  final WidgetStateProperty<Color?>? color;
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
        statusColor = BauhausDesign.success;
        break;
      case 'pending':
      case 'processing':
        statusColor = BauhausDesign.warning;
        break;
      case 'inactive':
      case 'unpaid':
      case 'cancelled':
        statusColor = BauhausDesign.error;
        break;
      default:
        statusColor = BauhausDesign.textMuted;
    }

    return EnhancedDataCell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        decoration: BoxDecoration(
          color: (color ?? statusColor).withValues(alpha: 0.12),
          border: Border.all(
            color: BauhausDesign.neutral,
            width: 1.5,
          ),
        ),
        child: Text(
          status,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ).copyWith(color: color ?? statusColor),
        ),
      ),
    );
  }

  /// Factory for action cell
  factory EnhancedDataCell.actions({required List<ActionButton> actions}) {
    return EnhancedDataCell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                action.icon,
                size: 20,
                color: action.color ?? BauhausDesign.textDark,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                action.onPressed();
              },
              tooltip: action.tooltip,
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
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
