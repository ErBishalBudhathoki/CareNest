import 'package:flutter/material.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_components.dart';
import 'package:carenest/app/shared/utils/debug_log.dart';

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
  double? _fallbackBaseRate; // Cached organization fallback base rate

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

  /// Load line items for the selected client assignments.
  ///
  /// - Fetches and caches the organization fallback base rate to use
  ///   as the default unit price when individual pricing is missing.
  /// - Resolves pricing via `getPricingLookup`: prefers `customPrice`,
  ///   otherwise falls back to `price` (NDIS default from bulk lookup).
  /// - Applies 2-decimal rounding to `unitPrice` and `total` for display.
  /// - Side effects: updates `_lineItems` list, controller maps, and
  ///   sets `_isLoading` state; logs UI state via `DebugLog`.
  Future<void> _loadLineItems() async {
    DebugLog.uiState('load_line_items_start', {
      'assignmentsCount': widget.clientAssignments.length,
      'organizationId': widget.organizationId,
      'clientId': widget.clientId,
    });
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch organization fallback base rate to use as default when pricing is missing
      try {
        final fb = await _apiMethod.getFallbackBaseRate(widget.organizationId);
        if (fb != null && fb > 0) {
          _fallbackBaseRate = fb;
          DebugLog.uiState('fallback_base_rate_cached', {
            'fallbackBaseRate': _fallbackBaseRate,
            'organizationId': widget.organizationId,
          });
        }
      } catch (e) {
        DebugLog.error('fallback_base_rate_fetch_error', details: {
          'organizationId': widget.organizationId,
          'error': e.toString(),
        });
      }

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

              double currentPrice = _fallbackBaseRate ?? 30.00; // Default fallback to org base rate
              double maxPrice = 65.17; // Default fallback

              if (pricingData != null) {
                // Prefer `customPrice` when custom pricing exists; otherwise fallback to `price` (NDIS default)
                final num? custom = pricingData['customPrice'] as num?;
                final num? price = pricingData['price'] as num?;
                final double? resolved = (custom ?? price)?.toDouble();
                if (resolved != null && resolved > 0) {
                  currentPrice = double.parse(resolved.toStringAsFixed(2));
                } else {
                  currentPrice = double.parse(currentPrice.toStringAsFixed(2));
                }
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

              // Attempt to use API-provided cap if available
              final apiCap = (pricingData?['priceCap'] as num?)?.toDouble();
              if (apiCap != null && apiCap > 0) {
                maxPrice = apiCap;
              }

              // Capture pricing source where available
              final src = (pricingData?['source'] as String?) ?? 'fallback';

              // Create unique ID for each assignment-schedule combination
              final uniqueId =
                  '${assignment['assignmentId'] ?? userEmail}_${itemNumber}_${date}_${startTime}';

              final unitPrice = double.parse(currentPrice.toStringAsFixed(2));
              final total = double.parse((unitPrice * 1.0).toStringAsFixed(2));
              items.add({
                'id': uniqueId,
                'ndisItemNumber': itemNumber,
                'description': itemName,
                'unitPrice': unitPrice,
                'maxPrice': maxPrice,
                'source': src,
                'quantity': 1.0,
                'total': total,
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
      DebugLog.uiState('load_line_items_success', {
        'itemsCount': _lineItems.length,
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading line items: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      DebugLog.error('load_line_items_error', details: {
        'error': e.toString(),
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      DebugLog.uiState('load_line_items_end', {
        'isLoading': _isLoading,
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

  /// Apply overrides, persist to backend, and confirm before success.
  ///
  /// - Builds overrides map for changed items.
  /// - For each changed item, performs create-or-update on custom pricing:
  ///   - If a custom pricing record exists, sends PUT update.
  ///   - Otherwise, creates new client-specific or organization pricing.
  /// - Re-fetches pricing lookup to confirm new price before reporting success.
  /// - Shows success only when all items are confirmed; otherwise shows errors.
  Future<void> _applyOverrides() async {
    if (_isLoading) {
      DebugLog.uiState('apply_overrides_ignored', {
        'reason': 'already_loading',
      });
      return;
    }
    final flowId = DebugLog.startFlow('apply_overrides', details: {
      'itemsCount': _lineItems.length,
    });
    DebugLog.uiState('apply_overrides_button_pressed', {
      'pendingOverrides': _isOverridden.values.where((v) => v == true).length,
    }, flowId: flowId);
    setState(() {
      _isLoading = true;
    });
    DebugLog.uiState('set_loading', {'value': true}, flowId: flowId);

    final overrides = <String, Map<String, dynamic>>{};
    final failures = <String, String>{};

    // Resolve context values
    final shared = SharedPreferencesUtils();
    await shared.init();
    final String? userEmail = shared.getString('userEmail');
    final String orgId = widget.organizationId;
    final String? clientId = widget.clientId.isNotEmpty ? widget.clientId : null;

    if (userEmail == null || userEmail.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing user context: userEmail'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    for (final item in _lineItems) {
      final id = item['id'] as String;
      if (_isOverridden[id] == true) {
        final newPrice = double.tryParse(_priceControllers[id]?.text ?? '') ?? 0.0;
        final newDescription = _descriptionControllers[id]?.text ?? '';
        final itemNumber = item['ndisItemNumber'] as String? ?? '';
        final itemName = item['description'] as String? ?? 'Item $itemNumber';

        // Basic validation
        if (newPrice <= 0) {
          failures[id] = 'Invalid price entered';
          DebugLog.error('invalid_price_entered', details: {
            'id': id,
            'enteredPrice': newPrice,
          }, flowId: flowId);
          continue;
        }

        try {
          // Check existing pricing
          DebugLog.uiState('lookup_existing_pricing', {
            'organizationId': orgId,
            'itemNumber': itemNumber,
            'clientId': clientId,
          }, flowId: flowId);
          final lookup = await _apiMethod.getPricingLookup(
            orgId,
            itemNumber,
            clientId: clientId,
          );

          Map<String, dynamic> result;
          String? pricingId;

          if (lookup != null && lookup['_id'] != null) {
            pricingId = lookup['_id']?.toString();
          }

          // Decide update vs create based on scope match
          final lookupIsClientSpecific = (lookup?['clientSpecific'] == true);
          final intendClientSpecific = clientId != null;
          final scopeMatches = pricingId != null && lookupIsClientSpecific == intendClientSpecific;

          if (scopeMatches && pricingId!.isNotEmpty) {
            // Update existing pricing only when scope matches
            DebugLog.uiState('update_custom_pricing', {
              'pricingId': pricingId,
              'newPrice': newPrice,
              'pricingType': 'fixed',
              'clientSpecific': intendClientSpecific,
            }, flowId: flowId);
            result = await _apiMethod.updateCustomPricing(
              pricingId: pricingId,
              price: newPrice,
              pricingType: 'fixed',
              userEmail: userEmail,
              supportItemName: itemName,
              clientId: intendClientSpecific ? clientId : null,
              clientSpecific: intendClientSpecific ? true : null,
            );
          } else {
            // Create new pricing for the intended scope; do not convert existing org/client record
            if (intendClientSpecific) {
              DebugLog.uiState('create_client_specific_pricing', {
                'organizationId': orgId,
                'clientId': clientId,
                'itemNumber': itemNumber,
                'newPrice': newPrice,
                'pricingType': 'fixed',
              }, flowId: flowId);
              result = await _apiMethod.saveClientCustomPricing(
                orgId,
                clientId!,
                itemNumber,
                newPrice,
                'fixed',
                userEmail,
                supportItemName: itemName,
              );
              // Fallback: if record already exists for intended scope, perform update instead
              if (result['success'] != true &&
                  (result['message']?.toString().toLowerCase().contains('already exists') ?? false)) {
                DebugLog.uiState('create_conflict_fallback_update', {
                  'organizationId': orgId,
                  'clientId': clientId,
                  'itemNumber': itemNumber,
                  'newPrice': newPrice,
                }, flowId: flowId);
                final existing = await _apiMethod.getPricingLookup(
                  orgId,
                  itemNumber,
                  clientId: clientId,
                );
                final existingId = existing?['_id']?.toString();
                if (existingId != null && existingId.isNotEmpty) {
                  result = await _apiMethod.updateCustomPricing(
                    pricingId: existingId,
                    price: newPrice,
                    pricingType: 'fixed',
                    userEmail: userEmail,
                    supportItemName: itemName,
                    clientId: clientId,
                    clientSpecific: true,
                  );
                }
              }
            } else {
              DebugLog.uiState('create_org_pricing', {
                'organizationId': orgId,
                'itemNumber': itemNumber,
                'newPrice': newPrice,
                'pricingType': 'fixed',
              }, flowId: flowId);
              result = await _apiMethod.saveAsCustomPricing(
                orgId,
                itemNumber,
                newPrice,
                'fixed',
                userEmail,
                supportItemName: itemName,
              );
              // Fallback: if record already exists for intended scope, perform update instead
              if (result['success'] != true &&
                  (result['message']?.toString().toLowerCase().contains('already exists') ?? false)) {
                DebugLog.uiState('create_conflict_fallback_update', {
                  'organizationId': orgId,
                  'itemNumber': itemNumber,
                  'newPrice': newPrice,
                }, flowId: flowId);
                final existing = await _apiMethod.getPricingLookup(
                  orgId,
                  itemNumber,
                );
                final existingId = existing?['_id']?.toString();
                if (existingId != null && existingId.isNotEmpty) {
                  result = await _apiMethod.updateCustomPricing(
                    pricingId: existingId,
                    price: newPrice,
                    pricingType: 'fixed',
                    userEmail: userEmail,
                    supportItemName: itemName,
                    clientSpecific: false,
                  );
                }
              }
            }
          }

          if (result['success'] != true) {
            failures[id] = (result['message']?.toString() ?? 'Save failed');
            DebugLog.error('persist_override_failed', details: {
              'id': id,
              'itemNumber': itemNumber,
              'result': result,
            }, flowId: flowId);
            continue;
          }

          // Confirm persistence by re-fetching lookup
          DebugLog.uiState('confirm_persistence_lookup', {
            'organizationId': orgId,
            'itemNumber': itemNumber,
            'clientId': clientId,
          }, flowId: flowId);
          final confirm = await _apiMethod.getPricingLookup(
            orgId,
            itemNumber,
            clientId: clientId,
          );
          // Some endpoints return `customPrice` (for custom pricing) and others return `price`.
          // Prefer `price`, but fall back to `customPrice` when `price` is absent.
          final dynamic confirmPriceField =
              (confirm != null && confirm.containsKey('price'))
                  ? confirm['price']
                  : confirm?['customPrice'];
          final confirmedPrice = (confirmPriceField is num)
              ? confirmPriceField.toDouble()
              : double.tryParse('${confirmPriceField ?? ''}');
          if (confirmedPrice == null || (confirmedPrice - newPrice).abs() > 0.001) {
            failures[id] = 'Persistence confirmation failed';
            DebugLog.error('persistence_confirmation_failed', details: {
              'id': id,
              'itemNumber': itemNumber,
              'expectedPrice': newPrice,
              'confirmedPrice': confirmedPrice,
            }, flowId: flowId);
            continue;
          }

          // Update local UI state to reflect new price and source
          final itemIndex = _lineItems.indexWhere((li) => li['id'] == id);
          if (itemIndex != -1) {
            final quantity = _lineItems[itemIndex]['quantity'] as double;
            _lineItems[itemIndex]['unitPrice'] = newPrice;
            _lineItems[itemIndex]['total'] = quantity * newPrice;
            _lineItems[itemIndex]['source'] = confirm?['source'] ?? _lineItems[itemIndex]['source'];
          }
          _originalPrices[id] = newPrice;
          _isOverridden[id] = false;
          DebugLog.uiState('override_applied_locally', {
            'id': id,
            'itemNumber': itemNumber,
            'newPrice': newPrice,
          }, flowId: flowId);

          overrides[id] = {
            'unitPrice': newPrice,
            'description': newDescription,
            'originalPrice': _originalPrices[id],
          };
        } catch (e) {
          debugPrint('Error persisting override for $id: $e');
          failures[id] = e.toString();
          DebugLog.error('exception_persisting_override', details: {
            'id': id,
            'error': e.toString(),
          }, flowId: flowId);
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
    DebugLog.uiState('set_loading', {'value': false}, flowId: flowId);

    if (failures.isNotEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to apply ${failures.length} override(s).'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      DebugLog.endFlow(flowId,
          success: false,
          message: 'apply_overrides_failed',
          summary: {
            'failedCount': failures.length,
            'successCount': overrides.length,
          });
      return; // Do not pop on partial failure
    }

    // All persisted and confirmed
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Price overrides applied for ${overrides.length} item(s)'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
    DebugLog.endFlow(flowId,
        success: true,
        message: 'apply_overrides_success',
        summary: {
          'appliedCount': overrides.length,
        });

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
      body: Stack(
        children: [
          _lineItems.isEmpty
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
          if (_isLoading)
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
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
                        const SizedBox(height: 6),
                        SourceBadge(
                          source: (item['source'] as String?) ?? 'fallback',
                          isSmall: true,
                          tooltip:
                              'Pricing source: client-specific, organization, base rate or NDIS default',
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
                        const SizedBox(height: 6),
                        NdisCapChip(
                          priceCap: (item['maxPrice'] as double?),
                          currentPrice: currentPrice,
                          isSmall: true,
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
