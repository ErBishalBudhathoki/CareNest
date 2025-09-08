import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';

/// Price Override View
/// Allows users to override prices for NDIS line items before invoice generation
class PriceOverrideView extends StatefulWidget {
  final String clientId;
  final String organizationId;
  final List<Map<String, dynamic>> clientAssignments;

  const PriceOverrideView({
    Key? key,
    required this.clientId,
    required this.organizationId,
    required this.clientAssignments,
  }) : super(key: key);

  @override
  State<PriceOverrideView> createState() => _PriceOverrideViewState();
}

class _PriceOverrideViewState extends State<PriceOverrideView> {
  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, TextEditingController> _descriptionControllers = {};
  final Map<String, TextEditingController> _quantityControllers = {};
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _isOverridden = {};
  final Map<String, double> _originalPrices = {};
  bool _isLoading = false;
  List<Map<String, dynamic>> _lineItems = [];
  final ApiMethod _apiMethod = ApiMethod();

  @override
  void initState() {
    super.initState();
    _loadLineItems();
  }

  void _initializeControllers() {
    _controllers.clear();
    for (final item in _lineItems) {
      final ndisItemNumber = item['ndisItemNumber'] as String;
      _controllers[ndisItemNumber] =
          TextEditingController(text: item['unitPrice'].toStringAsFixed(2));

      // Also initialize the legacy controllers for compatibility
      final id = item['id'] as String;
      _descriptionControllers[id] =
          TextEditingController(text: item['description']);
      _priceControllers[id] =
          TextEditingController(text: item['unitPrice'].toString());
      _quantityControllers[id] =
          TextEditingController(text: item['quantity'].toString());
      _originalPrices[id] = item['unitPrice'] as double;
      _isOverridden[id] = false;
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (final controller in _priceControllers.values) {
      controller.dispose();
    }
    for (final controller in _descriptionControllers.values) {
      controller.dispose();
    }
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadLineItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<Map<String, dynamic>> items = [];

      // Process each client assignment to extract employee, client, and NDIS item data
      for (final assignment in widget.clientAssignments) {
        final userEmail =
            assignment['userEmail'] as String? ?? 'Unknown Employee';
        final clientEmail =
            assignment['clientEmail'] as String? ?? 'Unknown Client';
        final userName = assignment['userName'] as String? ?? userEmail;
        final clientName = assignment['clientName'] as String? ?? clientEmail;

        final schedule = assignment['schedule'] as List<dynamic>? ?? [];

        for (final scheduleItem in schedule) {
          final ndisItem = scheduleItem['ndisItem'] as Map<String, dynamic>?;
          if (ndisItem != null) {
            final itemNumber = ndisItem['itemNumber'] as String?;
            final itemName = ndisItem['itemName'] as String?;
            final date = scheduleItem['date'] as String? ?? 'No date';
            final startTime = scheduleItem['startTime'] as String? ?? '';
            final endTime = scheduleItem['endTime'] as String? ?? '';

            if (itemNumber != null && itemName != null) {
              // Get pricing information
              final pricingData = await _apiMethod.getPricingLookup(
                  widget.organizationId, itemNumber,
                  clientId: widget.clientId);

              final supportItemDetails =
                  await _apiMethod.getSupportItemDetails(itemNumber);

              double currentPrice = 30.00; // Default fallback
              double maxPrice = 65.17; // Default fallback

              if (pricingData != null) {
                currentPrice =
                    (pricingData['price'] as num?)?.toDouble() ?? currentPrice;
              }

              if (supportItemDetails != null &&
                  supportItemDetails['priceCaps'] != null) {
                final priceCaps =
                    supportItemDetails['priceCaps'] as Map<String, dynamic>;
                // Get the highest price cap available
                final priceCapValues = priceCaps.values
                    .where((v) => v is num)
                    .map((v) => (v as num).toDouble());
                if (priceCapValues.isNotEmpty) {
                  maxPrice = priceCapValues.reduce((a, b) => a > b ? a : b);
                }
              }

              // Create unique ID for each assignment-schedule combination
              final uniqueId =
                  '${assignment['assignmentId'] ?? userEmail}_${itemNumber}_${date}_${startTime}';

              items.add({
                'id': uniqueId,
                'ndisItemNumber': itemNumber,
                'description': itemName,
                'unitPrice': currentPrice,
                'maxPrice': maxPrice,
                'quantity': 1.0,
                'total': currentPrice,
                'employeeEmail': userEmail,
                'employeeName': userName,
                'clientEmail': clientEmail,
                'clientName': clientName,
                'scheduleDate': date,
                'startTime': startTime,
                'endTime': endTime,
                'assignmentId': assignment['assignmentId'] ?? '',
              });
            }
          }
        }
      }

      _lineItems = items;

      // Initialize controllers and state
      _initializeControllers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading line items: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onPriceChanged(String itemId, String value) {
    final originalPrice = _originalPrices[itemId] ?? 0.0;
    final newPrice = double.tryParse(value) ?? originalPrice;

    // Find and update the item in _lineItems
    final itemIndex = _lineItems.indexWhere((item) => item['id'] == itemId);
    if (itemIndex != -1) {
      final quantity = _lineItems[itemIndex]['quantity'] as double;
      _lineItems[itemIndex]['unitPrice'] = newPrice;
      _lineItems[itemIndex]['total'] = quantity * newPrice;
    }

    setState(() {
      _isOverridden[itemId] = newPrice != originalPrice;
    });
  }

  void _resetPrice(String itemId) {
    final originalPrice = _originalPrices[itemId] ?? 0.0;
    _priceControllers[itemId]?.text = originalPrice.toStringAsFixed(2);
    setState(() {
      _isOverridden[itemId] = false;
    });
  }

  void _applyOverrides() {
    final overrides = <String, Map<String, dynamic>>{};

    for (final item in _lineItems) {
      final id = item['id'] as String;
      if (_isOverridden[id] == true) {
        final newPrice =
            double.tryParse(_priceControllers[id]?.text ?? '') ?? 0.0;
        final newDescription = _descriptionControllers[id]?.text ?? '';

        overrides[id] = {
          'unitPrice': newPrice,
          'description': newDescription,
          'originalPrice': _originalPrices[id],
        };
      }
    }

    // Return the overrides to the previous screen
    Navigator.pop(context, overrides);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernInvoiceDesign.background,
      appBar: AppBar(
        title: Text(
          'Price Override',
          style: ModernInvoiceDesign.headlineMedium.copyWith(
            color: ModernInvoiceDesign.textOnPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ModernInvoiceDesign.primary,
        elevation: 0,
        iconTheme: IconThemeData(color: ModernInvoiceDesign.textOnPrimary),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading NDIS items and pricing...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : _lineItems.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No NDIS items found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No client assignments with NDIS items available for price override.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: _buildLineItemsList(),
                    ),
                    _buildActionButtons(),
                  ],
                ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: ModernInvoiceDesign.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ModernInvoiceDesign.radiusXl),
          bottomRight: Radius.circular(ModernInvoiceDesign.radiusXl),
        ),
        boxShadow: ModernInvoiceDesign.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review and Override Prices',
            style: ModernInvoiceDesign.headlineLarge.copyWith(
              color: ModernInvoiceDesign.textOnPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_lineItems.length} NDIS items found from client assignments',
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              color: ModernInvoiceDesign.textOnPrimary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineItemsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _lineItems.length,
      itemBuilder: (context, index) {
        return _buildLineItemCard(_lineItems[index]);
      },
    );
  }

  Widget _buildLineItemCard(Map<String, dynamic> item) {
    final id = item['id'] as String;
    final ndisItemNumber = item['ndisItemNumber'] as String;
    final quantity = item['quantity'] as double;
    final isOverridden = _isOverridden[id] ?? false;
    final originalPrice = _originalPrices[id] ?? 0.0;
    final currentPrice = item['unitPrice'] as double;
    final employeeName = item['employeeName'] as String? ?? 'Unknown Employee';
    final clientName = item['clientName'] as String? ?? 'Unknown Client';
    final scheduleDate = item['scheduleDate'] as String? ?? 'No date';
    final startTime = item['startTime'] as String? ?? '';
    final endTime = item['endTime'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: ModernInvoiceDesign.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        side: BorderSide(
          color: isOverridden
              ? ModernInvoiceDesign.warning
              : ModernInvoiceDesign.border,
          width: isOverridden ? 2 : 1,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
          boxShadow: isOverridden
              ? ModernInvoiceDesign.shadowMd
              : ModernInvoiceDesign.shadowSm,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employee and Client Information Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.primary.withValues(alpha: 0.05),
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                  border: Border.all(
                    color: ModernInvoiceDesign.primary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: ModernInvoiceDesign.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Employee: $employeeName',
                            style: ModernInvoiceDesign.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ModernInvoiceDesign.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 16,
                          color: ModernInvoiceDesign.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Client: $clientName',
                            style: ModernInvoiceDesign.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ModernInvoiceDesign.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: ModernInvoiceDesign.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Schedule: $scheduleDate ${startTime.isNotEmpty && endTime.isNotEmpty ? '($startTime - $endTime)' : ''}',
                            style: ModernInvoiceDesign.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // NDIS Item Information
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ModernInvoiceDesign.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                                ModernInvoiceDesign.radiusSm),
                          ),
                          child: Text(
                            ndisItemNumber,
                            style: ModernInvoiceDesign.labelSmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ModernInvoiceDesign.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['description'] ?? 'No description available',
                          style: ModernInvoiceDesign.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ModernInvoiceDesign.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quantity: ${quantity.toStringAsFixed(1)}',
                          style: ModernInvoiceDesign.bodySmall.copyWith(
                            color: ModernInvoiceDesign.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isOverridden) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ModernInvoiceDesign.warning,
                        borderRadius: BorderRadius.circular(
                            ModernInvoiceDesign.radiusFull),
                      ),
                      child: Text(
                        'OVERRIDDEN',
                        style: ModernInvoiceDesign.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  IconButton(
                    onPressed: () => _resetPrice(id),
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Reset to original price',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Price Information Display
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Price',
                          style: ModernInvoiceDesign.labelSmall.copyWith(
                            color: ModernInvoiceDesign.textSecondary,
                          ),
                        ),
                        Text(
                          '\$${currentPrice.toStringAsFixed(2)}',
                          style: ModernInvoiceDesign.headlineSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ModernInvoiceDesign.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Max Allowed',
                          style: ModernInvoiceDesign.labelSmall.copyWith(
                            color: ModernInvoiceDesign.textSecondary,
                          ),
                        ),
                        Text(
                          '\$${(item['maxPrice'] ?? item['unitPrice']).toStringAsFixed(2)}',
                          style: ModernInvoiceDesign.headlineSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ModernInvoiceDesign.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionControllers[id],
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: ModernInvoiceDesign.bodyMedium.copyWith(
                    color: ModernInvoiceDesign.textSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                    borderSide: BorderSide(color: ModernInvoiceDesign.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                    borderSide: BorderSide(color: ModernInvoiceDesign.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                    borderSide: BorderSide(
                        color: ModernInvoiceDesign.primary, width: 2),
                  ),
                ),
                style: ModernInvoiceDesign.bodyMedium.copyWith(
                  color: ModernInvoiceDesign.textPrimary,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _priceControllers[id],
                      decoration: InputDecoration(
                        labelText: 'Override Price (\$)',
                        labelStyle: ModernInvoiceDesign.bodyMedium.copyWith(
                          color: ModernInvoiceDesign.textSecondary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusMd),
                          borderSide:
                              BorderSide(color: ModernInvoiceDesign.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusMd),
                          borderSide:
                              BorderSide(color: ModernInvoiceDesign.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusMd),
                          borderSide: BorderSide(
                              color: ModernInvoiceDesign.primary, width: 2),
                        ),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: ModernInvoiceDesign.textSecondary,
                        ),
                        suffixIcon: isOverridden
                            ? Icon(
                                Icons.edit,
                                color: ModernInvoiceDesign.warning,
                              )
                            : null,
                      ),
                      style: ModernInvoiceDesign.bodyMedium.copyWith(
                        color: ModernInvoiceDesign.textPrimary,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      onChanged: (value) => _onPriceChanged(id, value),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: ModernInvoiceDesign.labelSmall.copyWith(
                            color: ModernInvoiceDesign.textSecondary,
                          ),
                        ),
                        Text(
                          '\$${(quantity * (double.tryParse(_priceControllers[id]?.text ?? '0') ?? 0)).toStringAsFixed(2)}',
                          style: ModernInvoiceDesign.headlineSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ModernInvoiceDesign.textPrimary,
                          ),
                        ),
                        if (isOverridden) ...[
                          Text(
                            'Was: \$${(quantity * originalPrice).toStringAsFixed(2)}',
                            style: ModernInvoiceDesign.bodySmall.copyWith(
                              color: ModernInvoiceDesign.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),

              // Validation Message
              if ((double.tryParse(_priceControllers[id]?.text ?? '0') ?? 0.0) >
                  (item['maxPrice'] ?? item['unitPrice']))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Warning: Price exceeds maximum allowed (\$${(item['maxPrice'] ?? item['unitPrice']).toStringAsFixed(2)})',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: ModernInvoiceDesign.textSecondary,
                side: BorderSide(color: ModernInvoiceDesign.border),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Cancel',
                style: ModernInvoiceDesign.labelLarge.copyWith(
                  color: ModernInvoiceDesign.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : _applyOverrides,
              style: ElevatedButton.styleFrom(
                backgroundColor: ModernInvoiceDesign.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Apply Overrides',
                      style: ModernInvoiceDesign.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
