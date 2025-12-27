import 'package:flutter/material.dart';

import 'package:carenest/app/features/invoice/utils/hours_formatting.dart';
import 'package:flutter/services.dart';

/// Price Prompt Dialog Widget
/// Handles missing price prompts during single invoice generation
/// Task 2.3: Create price prompt system for missing prices
class PricePromptDialog extends StatefulWidget {
  final Map<String, dynamic> promptData;
  final Function(Map<String, dynamic>) onPriceProvided;
  final VoidCallback? onCancel;

  const PricePromptDialog({
    super.key,
    required this.promptData,
    required this.onPriceProvided,
    this.onCancel,
  });

  @override
  State<PricePromptDialog> createState() => _PricePromptDialogState();
}

class _PricePromptDialogState extends State<PricePromptDialog> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  bool _saveAsCustomPricing = false;
  bool _applyToClient = false;
  bool _applyToOrganization = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with suggested price if available
    if (widget.promptData['suggestedPrice'] != null &&
        widget.promptData['suggestedPrice'] > 0) {
      _priceController.text = widget.promptData['suggestedPrice'].toString();
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.attach_money,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Price Required',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemInfoCard(),
              const SizedBox(height: 16),
              _buildPriceInputSection(),
              const SizedBox(height: 16),
              _buildCustomPricingOptions(),
              const SizedBox(height: 16),
              _buildNotesSection(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : _handleCancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSubmit,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Apply Price'),
        ),
      ],
    );
  }

  Widget _buildItemInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
                'NDIS Item:', widget.promptData['ndisItemNumber'] ?? 'N/A'),
            _buildInfoRow(
                'Description:', widget.promptData['itemDescription'] ?? 'N/A'),
            _buildQuantityRow(),
            if (widget.promptData['priceCap'] != null)
              _buildInfoRow(
                'NDIS Price Cap:',
                '\$${widget.promptData['priceCap'].toStringAsFixed(2)}',
                isHighlight: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.orange[700] : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the quantity row with precise hour formatting and tooltip.
  Widget _buildQuantityRow() {
    final rawQty = widget.promptData['quantity'];
    final qty = rawQty is num
        ? rawQty.toDouble()
        : double.tryParse(rawQty?.toString() ?? '') ?? 1.0;
    final unit = widget.promptData['unit']?.toString() ?? 'unit';
    final formattedQty = HoursFormatting.formatDecimalHours(
      qty,
      minDecimals: 2,
      maxDecimals: 4,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Quantity:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  '$formattedQty $unit',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 6),
                const Tooltip(
                  message:
                      'Exact hours shown up to 4 decimals (seconds included). Total = Hours × Rate.',
                  child: Icon(
                    Icons.info_outline,
                    size: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Price',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            labelText: 'Price (AUD)',
            prefixText: '\$',
            border: const OutlineInputBorder(),
            hintText: 'Enter the price for this item',
            suffixIcon: widget.promptData['priceCap'] != null
                ? IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showPriceCapInfo(),
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Price is required';
            }

            final price = double.tryParse(value);
            if (price == null || price <= 0) {
              return 'Please enter a valid price';
            }

            // Check against NDIS price cap if available
            if (widget.promptData['priceCap'] != null) {
              final priceCap = widget.promptData['priceCap'];
              if (price > priceCap) {
                return 'Price exceeds NDIS cap of \$${priceCap.toStringAsFixed(2)}';
              }
            }

            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCustomPricingOptions() {
    final hasClientContext = widget.promptData['clientId'] != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Save Options',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text('Save as custom pricing'),
          subtitle: const Text('Save this price for future use'),
          value: _saveAsCustomPricing,
          onChanged: (value) {
            setState(() {
              _saveAsCustomPricing = value ?? false;
              if (!_saveAsCustomPricing) {
                _applyToClient = false;
                _applyToOrganization = false;
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
        ),
        if (_saveAsCustomPricing) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                if (hasClientContext)
                  CheckboxListTile(
                    title: const Text('Apply to this client only'),
                    value: _applyToClient,
                    onChanged: (value) {
                      setState(() {
                        _applyToClient = value ?? false;
                        if (_applyToClient) {
                          _applyToOrganization = false;
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                  ),
                CheckboxListTile(
                  title: const Text('Apply to entire organization'),
                  value: _applyToOrganization,
                  onChanged: (value) {
                    setState(() {
                      _applyToOrganization = value ?? false;
                      if (_applyToOrganization) {
                        _applyToClient = false;
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                ),
                if (!hasClientContext)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'No client selected; save as organization rate.',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (Optional)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Additional notes',
            border: OutlineInputBorder(),
            hintText: 'Add any notes about this pricing decision...',
          ),
        ),
      ],
    );
  }

  void _showPriceCapInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('NDIS Price Cap Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'NDIS Price Cap: \$${widget.promptData['priceCap'].toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            const Text(
              'This is the maximum price allowed by NDIS for this support item. '
              'Prices above this cap may require additional justification or approval.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleCancel() {
    if (widget.onCancel != null) {
      widget.onCancel!();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final price = double.parse(_priceController.text);

      final resolution = {
        'providedPrice': price,
        'saveAsCustomPricing': _saveAsCustomPricing,
        'applyToClient': _applyToClient,
        'applyToOrganization': _applyToOrganization,
        'notes': _notesController.text.trim(),
      };

      // Let the parent decide how to close the dialog; do not pop here.
      widget.onPriceProvided(resolution);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

/// Helper function to show price prompt dialog
Future<Map<String, dynamic>?> showPricePromptDialog({
  required BuildContext context,
  required Map<String, dynamic> promptData,
}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (context) => PricePromptDialog(
      promptData: promptData,
      onPriceProvided: (resolution) {
        Navigator.of(context).pop(resolution);
      },
      onCancel: () {
        Navigator.of(context).pop(null);
      },
    ),
  );
}

/// Price Prompt Manager for handling multiple prompts
class PricePromptManager {
  static Future<List<Map<String, dynamic>>> handleMultiplePrompts({
    required BuildContext context,
    required List<Map<String, dynamic>> prompts,
    bool allowPriceCapOverride = false,
  }) async {
    final List<Map<String, dynamic>> resolutions = [];

    for (int i = 0; i < prompts.length; i++) {
      final prompt = prompts[i];

      // Show progress indicator
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        barrierDismissible: false,
        builder: (context) => PricePromptDialog(
          promptData: {
            ...prompt,
            'promptIndex': i + 1,
            'totalPrompts': prompts.length,
            'allowPriceCapOverride': allowPriceCapOverride,
          },
          onPriceProvided: (resolution) {
            Navigator.of(context).pop(resolution);
          },
          onCancel: () {
            Navigator.of(context).pop(null);
          },
        ),
      );

      if (result == null) {
        // User cancelled, return empty list
        return [];
      }

      resolutions.add({
        'promptId': prompt['promptId'],
        'resolution': result,
      });
    }

    return resolutions;
  }
}
