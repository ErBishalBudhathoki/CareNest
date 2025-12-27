import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/models/invoice_line_item.dart';

import 'package:carenest/utils/hours_formatting.dart';

class DynamicLineItemEntry extends StatefulWidget {
  final List<InvoiceLineItem> lineItems;
  final void Function(List<InvoiceLineItem>) onChanged;

  const DynamicLineItemEntry({
    super.key,
    required this.lineItems,
    required this.onChanged,
  });

  @override
  State<DynamicLineItemEntry> createState() => _DynamicLineItemEntryState();
}

class _DynamicLineItemEntryState extends State<DynamicLineItemEntry> {
  late List<InvoiceLineItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.lineItems);
  }

  /// Builds a visual indicator for price compliance status
  Widget _buildComplianceIndicator(InvoiceLineItem item) {
    switch (item.complianceStatus) {
      case PriceComplianceStatus.compliant:
        return Tooltip(
          message:
              item.validationMessage ?? 'Price is compliant with NDIS caps',
          child: const Icon(Icons.check_circle, color: Colors.green, size: 16),
        );
      case PriceComplianceStatus.nonCompliant:
        return Tooltip(
          message: item.validationMessage ?? 'Price exceeds NDIS caps',
          child: const Icon(Icons.warning, color: Colors.orange, size: 16),
        );
      case PriceComplianceStatus.unknown:
      default:
        return const SizedBox.shrink(); // No indicator for unknown status
    }
  }

  /// This is the key method to ensure the UI updates when the parent's data changes.
  @override
  void didUpdateWidget(covariant DynamicLineItemEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lineItems != oldWidget.lineItems) {
      setState(() {
        _items = List.from(widget.lineItems);
      });
    }
  }

  void _addItem() {
    setState(() {
      final newItem = InvoiceLineItem(
          description: '', quantity: 1.0, unitPrice: 0.0, type: 'service');
      _items.add(newItem);
      widget.onChanged(_items);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
      widget.onChanged(_items);
    });
  }

  void _updateItem(int index, InvoiceLineItem newItem) {
    setState(() {
      _items[index] = newItem;
      widget.onChanged(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              const Icon(Icons.list_alt_outlined, size: 48, color: Colors.grey),
              const SizedBox(height: 8),
              const Text('No invoice items have been generated.'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Item Manually'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, idx) {
            final item = _items[idx];
            return Card(
              elevation: 1.5,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        initialValue: item.description,
                        decoration: const InputDecoration(
                            labelText: 'Description',
                            isDense: true,
                            border: InputBorder.none),
                        onChanged: (val) =>
                            _updateItem(idx, item.copyWith(description: val)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: HoursFormatting.formatDecimalHours(
                          item.quantity,
                          minDecimals: 2,
                          maxDecimals: 4,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Qty',
                          isDense: true,
                          border: InputBorder.none,
                          suffixIcon: item.type == 'service'
                              ? Tooltip(
                                  message:
                                      'Exact hours shown up to 4 decimals. Seconds included. Total = Hours × Rate.',
                                  child: const Icon(
                                    Icons.info_outline,
                                    size: 16,
                                  ),
                                )
                              : null,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (val) => _updateItem(
                            idx,
                            item.copyWith(
                                quantity: double.tryParse(val) ?? 1.0)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            initialValue: item.unitPrice.toStringAsFixed(2),
                            decoration: InputDecoration(
                              labelText: 'Price',
                              isDense: true,
                              border: InputBorder.none,
                              suffixIcon: item.complianceStatus !=
                                      PriceComplianceStatus.unknown
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: _buildComplianceIndicator(item),
                                    )
                                  : null,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            onChanged: (val) => _updateItem(
                                idx,
                                item.copyWith(
                                    unitPrice: double.tryParse(val) ?? 0.0)),
                          ),
                          if (item.complianceStatus ==
                                  PriceComplianceStatus.nonCompliant &&
                              item.recommendedPrice != null)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _updateItem(
                                      idx,
                                      item.copyWith(
                                        unitPrice: item.recommendedPrice,
                                        complianceStatus:
                                            PriceComplianceStatus.compliant,
                                        validationMessage:
                                            'Price updated to recommended value',
                                        excessAmount: 0.0,
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 4.0),
                                  child: Text(
                                    'Use ${item.recommendedPrice?.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _removeItem(idx),
                      tooltip: 'Remove Item',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addItem,
          icon: const Icon(Icons.add),
          label: const Text('Add Line Item'),
        ),
      ],
    );
  }
}
