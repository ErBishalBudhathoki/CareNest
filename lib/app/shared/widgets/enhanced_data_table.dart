import 'package:flutter/material.dart';
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
      padding: widget.padding ?? const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
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
            color: Colors.white,
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
              headingRowColor: WidgetStateProperty.all(
                Colors.white,
              ),
              headingTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500).copyWith(
                color: const Color(0xFF6B7280),
              ),
              dataTextStyle: const TextStyle(fontSize: 14).copyWith(
                color: const Color(0xFF1F2937),
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
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: row.selected
            ? const Color(0xFF667EEA).withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: row.selected
              ? const Color(0xFF667EEA).withOpacity(0.1)
              : const Color(0xFFE0E0E0),
        ),
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
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
                      color: const Color(0xFF6B7280),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xFF667EEA)),
            ),
            SizedBox(height: 12.0),
            Text(
              'Loading data...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Center(
        child: widget.emptyWidget ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: const Color(0xFFA3A3A3),
                ),
                const SizedBox(height: 12.0),
                Text(
                  widget.emptyMessage ?? 'No data available',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                    color: const Color(0xFF6B7280),
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
        statusColor = Colors.green;
        break;
      case 'pending':
      case 'processing':
        statusColor = Colors.orange;
        break;
      case 'inactive':
      case 'unpaid':
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = const Color(0xFF737373);
    }

    return EnhancedDataCell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: (color ?? statusColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (color ?? statusColor).withOpacity(0.1),
          ),
        ),
        child: Text(
          status,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
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
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                action.icon,
                size: 18,
                color: action.color ?? const Color(0xFF6B7280),
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
