import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/debug_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Price Override View
/// Allows users to override prices for NDIS line items before invoice generation
class PriceOverrideView extends StatefulWidget {
  final String clientId;
  final String organizationId;
  final List<Map<String, dynamic>> clientAssignments;

  const PriceOverrideView({
    super.key,
    required this.clientId,
    required this.organizationId,
    required this.clientAssignments,
  });

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
  final Map<String, bool> _isClientSpecific =
      {}; // Track client-specific toggle per item
  final Map<String, bool> _originalClientSpecific =
      {}; // Track original client-specific state
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
    _isClientSpecific.clear(); // Clear client-specific toggles
    _originalClientSpecific.clear(); // Clear original client-specific states
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

      // Initialize client-specific toggle - default to OFF (organization-wide)
      // Only set to true if the current pricing source is already client-specific
      final source = item['source'] as String? ?? '';
      final isCurrentlyClientSpecific =
          source == 'client-specific' || source == 'client_specific';
      _isClientSpecific[id] =
          isCurrentlyClientSpecific; // Default OFF unless already client-specific
      _originalClientSpecific[id] =
          isCurrentlyClientSpecific; // Store original state
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

  /// Check if an item has actually been modified from its original state
  bool _isItemActuallyModified(String id) {
    final currentPrice =
        double.tryParse(_priceControllers[id]?.text ?? '0') ?? 0.0;
    final originalPrice = _originalPrices[id] ?? 0.0;
    final currentClientSpecific = _isClientSpecific[id] ?? false;
    final originalClientSpecific = _originalClientSpecific[id] ?? false;

    // Check if price has changed
    final priceChanged = (currentPrice - originalPrice).abs() >
        0.01; // Allow for small floating point differences

    // Check if client-specific toggle has changed
    final clientSpecificChanged =
        currentClientSpecific != originalClientSpecific;

    final isModified = priceChanged || clientSpecificChanged;

    // Debug logging
    if (priceChanged || clientSpecificChanged) {
      print(
          'Item $id modification check: price=$currentPrice (was $originalPrice, changed=$priceChanged), clientSpecific=$currentClientSpecific (was $originalClientSpecific, changed=$clientSpecificChanged) -> modified=$isModified');
    }

    return isModified;
  }

  /// Update the override status based on actual changes
  void _updateOverrideStatus(String id) {
    setState(() {
      _isOverridden[id] = _isItemActuallyModified(id);
    });
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

        // Get client state from assignment or fetch client details
        String clientState = assignment['clientState'] as String? ?? '';
        if (clientState.isEmpty &&
            clientEmail.isNotEmpty &&
            clientEmail != 'Unknown Client') {
          try {
            final clientDetails =
                await _apiMethod.getClientDetails(clientEmail);
            if (clientDetails != null && clientDetails['success'] == true) {
              clientState = clientDetails['clientState'] as String? ?? '';
            }
          } catch (e) {
            debugPrint(
                'PriceOverrideView: Error fetching client details for state: $e');
          }
        }
        // Default to NSW if no state found
        if (clientState.isEmpty) {
          clientState = 'NSW';
        }
        debugPrint(
            'PriceOverrideView: Using client state: $clientState for $clientEmail');

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

              double currentPrice = _fallbackBaseRate ??
                  30.00; // Default fallback to org base rate
              double maxPrice = 0.0; // Will be set from actual NDIS price caps

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

              // Extract NDIS price cap from supportItemDetails based on client's state
              // Structure: priceCaps.standard.[clientState] or priceCaps.highIntensity.[clientState]
              if (supportItemDetails != null &&
                  supportItemDetails['priceCaps'] != null) {
                final priceCaps =
                    supportItemDetails['priceCaps'] as Map<String, dynamic>;

                double? extractedCap;

                // Check standard provider type first, using client's state
                if (priceCaps['standard'] != null &&
                    priceCaps['standard'] is Map) {
                  final standardCaps =
                      priceCaps['standard'] as Map<String, dynamic>;
                  // Use client's state to get the correct price cap
                  if (standardCaps[clientState] != null &&
                      standardCaps[clientState] is num) {
                    extractedCap =
                        (standardCaps[clientState] as num).toDouble();
                    debugPrint(
                        'PriceOverrideView: Found standard cap for $clientState: $extractedCap');
                  }
                }

                // If no standard cap found for client's state, try highIntensity
                if (extractedCap == null &&
                    priceCaps['highIntensity'] != null &&
                    priceCaps['highIntensity'] is Map) {
                  final highIntensityCaps =
                      priceCaps['highIntensity'] as Map<String, dynamic>;
                  if (highIntensityCaps[clientState] != null &&
                      highIntensityCaps[clientState] is num) {
                    extractedCap =
                        (highIntensityCaps[clientState] as num).toDouble();
                    debugPrint(
                        'PriceOverrideView: Found highIntensity cap for $clientState: $extractedCap');
                  }
                }

                if (extractedCap != null && extractedCap > 0) {
                  maxPrice = extractedCap;
                  debugPrint(
                      'PriceOverrideView: Using NDIS cap for $itemNumber ($clientState): $maxPrice');
                }
              }

              // Fallback: use API-provided cap if available and maxPrice is still 0
              if (maxPrice <= 0) {
                final apiCap = (pricingData?['priceCap'] as num?)?.toDouble();
                if (apiCap != null && apiCap > 0) {
                  maxPrice = apiCap;
                  debugPrint(
                      'PriceOverrideView: Using API-provided cap for $itemNumber: $maxPrice');
                }
              }

              // If still no cap found, log a warning (no fallback to arbitrary value)
              if (maxPrice <= 0) {
                debugPrint(
                    'PriceOverrideView: WARNING - No NDIS price cap found for $itemNumber in state $clientState');
              }

              // Capture pricing source where available
              final src = (pricingData?['source'] as String?) ?? 'fallback';

              // Create unique ID for each assignment-schedule combination
              final uniqueId =
                  '${assignment['assignmentId'] ?? userEmail}_${itemNumber}_${date}_$startTime';

              final unitPrice = double.parse(currentPrice.toStringAsFixed(2));
              final total = double.parse((unitPrice * 1.0).toStringAsFixed(2));
              items.add({
                'id': uniqueId,
                'ndisItemNumber': itemNumber,
                'description': itemName,
                'unitPrice': unitPrice,
                'maxPrice': maxPrice,
                'clientState': clientState, // Include client state for display
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

    // Update override status based on actual changes
    _updateOverrideStatus(itemId);
  }

  void _resetPrice(String itemId) {
    final originalPrice = _originalPrices[itemId] ?? 0.0;
    final originalClientSpecific = _originalClientSpecific[itemId] ?? false;

    _priceControllers[itemId]?.text = originalPrice.toStringAsFixed(2);

    setState(() {
      _isClientSpecific[itemId] = originalClientSpecific;
      _updateOverrideStatus(itemId);
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
    DebugLog.uiState(
        'apply_overrides_button_pressed',
        {
          'pendingOverrides':
              _isOverridden.values.where((v) => v == true).length,
        },
        flowId: flowId);
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
    final String? clientId =
        widget.clientId.isNotEmpty ? widget.clientId : null;

    if (userEmail == null || userEmail.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing user context: userEmail'),
          ),
        );
      }
      return;
    }

    for (final item in _lineItems) {
      final id = item['id'] as String;
      if (_isOverridden[id] == true) {
        final newPrice =
            double.tryParse(_priceControllers[id]?.text ?? '') ?? 0.0;
        final newDescription = _descriptionControllers[id]?.text ?? '';
        final itemNumber = item['ndisItemNumber'] as String? ?? '';
        final itemName = item['description'] as String? ?? 'Item $itemNumber';

        // Use the toggle value to determine if this should be client-specific
        final shouldBeClientSpecific =
            _isClientSpecific[id] == true && widget.clientId.isNotEmpty;
        final clientIdForSave = shouldBeClientSpecific ? widget.clientId : null;

        // Basic validation
        if (newPrice <= 0) {
          failures[id] = 'Invalid price entered';
          DebugLog.error('invalid_price_entered',
              details: {
                'id': id,
                'enteredPrice': newPrice,
              },
              flowId: flowId);
          continue;
        }

        try {
          // Check existing pricing
          DebugLog.uiState(
              'lookup_existing_pricing',
              {
                'organizationId': orgId,
                'itemNumber': itemNumber,
                'clientId': clientIdForSave,
                'isClientSpecific': shouldBeClientSpecific,
              },
              flowId: flowId);
          final lookup = await _apiMethod.getPricingLookup(
            orgId,
            itemNumber,
            clientId: clientIdForSave,
          );

          Map<String, dynamic> result;
          String? pricingId;

          if (lookup != null && lookup['_id'] != null) {
            pricingId = lookup['_id']?.toString();
          }

          // Decide update vs create based on scope match
          final lookupIsClientSpecific = (lookup?['clientSpecific'] == true);
          final scopeMatches = pricingId != null &&
              lookupIsClientSpecific == shouldBeClientSpecific;

          if (scopeMatches && pricingId.isNotEmpty) {
            // Update existing pricing only when scope matches
            DebugLog.uiState(
                'update_custom_pricing',
                {
                  'pricingId': pricingId,
                  'newPrice': newPrice,
                  'pricingType': 'fixed',
                  'clientSpecific': shouldBeClientSpecific,
                },
                flowId: flowId);
            result = await _apiMethod.updateCustomPricing(
              pricingId: pricingId,
              price: newPrice,
              pricingType: 'fixed',
              userEmail: userEmail,
              supportItemName: itemName,
              clientId: shouldBeClientSpecific ? clientIdForSave : null,
              clientSpecific: shouldBeClientSpecific ? true : null,
            );
          } else {
            // Create new pricing for the intended scope; do not convert existing org/client record
            if (shouldBeClientSpecific) {
              DebugLog.uiState(
                  'create_client_specific_pricing',
                  {
                    'organizationId': orgId,
                    'clientId': clientIdForSave,
                    'itemNumber': itemNumber,
                    'newPrice': newPrice,
                    'pricingType': 'fixed',
                  },
                  flowId: flowId);
              result = await _apiMethod.saveClientCustomPricing(
                orgId,
                clientIdForSave!,
                itemNumber,
                newPrice,
                'fixed',
                userEmail,
                supportItemName: itemName,
              );
              // Fallback: if record already exists for intended scope, perform update instead
              if (result['success'] != true &&
                  (result['message']
                          ?.toString()
                          .toLowerCase()
                          .contains('already exists') ??
                      false)) {
                DebugLog.uiState(
                    'create_conflict_fallback_update',
                    {
                      'organizationId': orgId,
                      'clientId': clientIdForSave,
                      'itemNumber': itemNumber,
                      'newPrice': newPrice,
                    },
                    flowId: flowId);
                final existing = await _apiMethod.getPricingLookup(
                  orgId,
                  itemNumber,
                  clientId: clientIdForSave,
                );
                final existingId = existing?['_id']?.toString();
                if (existingId != null && existingId.isNotEmpty) {
                  result = await _apiMethod.updateCustomPricing(
                    pricingId: existingId,
                    price: newPrice,
                    pricingType: 'fixed',
                    userEmail: userEmail,
                    supportItemName: itemName,
                    clientId: clientIdForSave,
                    clientSpecific: true,
                  );
                }
              }
            } else {
              DebugLog.uiState(
                  'create_org_pricing',
                  {
                    'organizationId': orgId,
                    'itemNumber': itemNumber,
                    'newPrice': newPrice,
                    'pricingType': 'fixed',
                  },
                  flowId: flowId);
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
                  (result['message']
                          ?.toString()
                          .toLowerCase()
                          .contains('already exists') ??
                      false)) {
                DebugLog.uiState(
                    'create_conflict_fallback_update',
                    {
                      'organizationId': orgId,
                      'itemNumber': itemNumber,
                      'newPrice': newPrice,
                    },
                    flowId: flowId);
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
            DebugLog.error('persist_override_failed',
                details: {
                  'id': id,
                  'itemNumber': itemNumber,
                  'result': result,
                },
                flowId: flowId);
            continue;
          }

          // Confirm persistence by re-fetching lookup
          DebugLog.uiState(
              'confirm_persistence_lookup',
              {
                'organizationId': orgId,
                'itemNumber': itemNumber,
                'clientId': clientIdForSave,
              },
              flowId: flowId);
          final confirm = await _apiMethod.getPricingLookup(
            orgId,
            itemNumber,
            clientId: clientIdForSave,
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
          if (confirmedPrice == null ||
              (confirmedPrice - newPrice).abs() > 0.001) {
            failures[id] = 'Persistence confirmation failed';
            DebugLog.error('persistence_confirmation_failed',
                details: {
                  'id': id,
                  'itemNumber': itemNumber,
                  'expectedPrice': newPrice,
                  'confirmedPrice': confirmedPrice,
                },
                flowId: flowId);
            continue;
          }

          // Update local UI state to reflect new price and source
          final itemIndex = _lineItems.indexWhere((li) => li['id'] == id);
          if (itemIndex != -1) {
            final quantity = _lineItems[itemIndex]['quantity'] as double;
            _lineItems[itemIndex]['unitPrice'] = newPrice;
            _lineItems[itemIndex]['total'] = quantity * newPrice;
            _lineItems[itemIndex]['source'] =
                confirm?['source'] ?? _lineItems[itemIndex]['source'];
          }
          _originalPrices[id] = newPrice;
          _originalClientSpecific[id] = _isClientSpecific[id] ??
              false; // Update original client-specific state
          _isOverridden[id] = false;
          DebugLog.uiState(
              'override_applied_locally',
              {
                'id': id,
                'itemNumber': itemNumber,
                'newPrice': newPrice,
              },
              flowId: flowId);

          overrides[id] = {
            'unitPrice': newPrice,
            'description': newDescription,
            'originalPrice': _originalPrices[id],
          };
        } catch (e) {
          debugPrint('Error persisting override for $id: $e');
          failures[id] = e.toString();
          DebugLog.error('exception_persisting_override',
              details: {
                'id': id,
                'error': e.toString(),
              },
              flowId: flowId);
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
          content:
              Text('Price overrides applied for ${overrides.length} item(s)'),
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
      appBar: AppBar(
        title: Text(
          'Price Override',
          style: ModernInvoiceDesign.headlineMedium.copyWith(
            color: ModernInvoiceDesign.textOnPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ModernInvoiceDesign.primary,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: ModernInvoiceDesign.textOnPrimary),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          _lineItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 64,
                        color: ModernInvoiceDesign.textOnPrimary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No NDIS items found',
                        style: ModernInvoiceDesign.headlineSmall.copyWith(
                          color: ModernInvoiceDesign.textOnPrimary,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No client assignments with NDIS items available for price override.',
                        textAlign: TextAlign.center,
                        style: ModernInvoiceDesign.bodyMedium.copyWith(
                          color: Color(0xFFFAFAFA),
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
                  color: Colors.black.withValues(alpha: 0.1),
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
        color: ModernInvoiceDesign.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review and Override Prices',
            style: ModernInvoiceDesign.headlineLarge.copyWith(
              color: Colors.white,
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

  /// Builds a modern, animated line item card with fresh teal/emerald color scheme.
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

    // Using theme colors
    final Color tealPrimary = const Color(0xFF007AFF);
    final Color tealLight =
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.7);
    final Color tealDark = Theme.of(context).colorScheme.primary;
    final Color emeraldAccent = const Color(0xFF34C759);
    final Color amberWarning = const Color(0xFFFF9500);
    final Color roseError = const Color(0xFFFF3B30);
    final Color slateDark = const Color(0xFF212121);
    final Color slateLight = const Color(0xFFFAFAFA);
    final Color cardBg = const Color(0xFFFAFAFA);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isOverridden
              ? [const Color(0xFFFFFBEB), const Color(0xFFFEF3C7)]
              : [cardBg, Colors.white],
        ),
        boxShadow: [
          BoxShadow(
            color: (isOverridden ? amberWarning : tealPrimary)
                .withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isOverridden
              ? amberWarning.withOpacity(0.1)
              : tealPrimary.withOpacity(0.1),
          width: isOverridden ? 2 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isOverridden
                      ? [amberWarning, const Color(0xFFFBBF24)]
                      : [tealDark, tealPrimary, tealLight],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [tealPrimary, tealLight]),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: tealPrimary.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2))
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.tag,
                                  size: 14, color: Colors.white),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  ndisItemNumber,
                                  style:
                                      ModernInvoiceDesign.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: SourceBadge(
                            source: (item['source'] as String?) ?? 'fallback',
                            isSmall: true),
                      ),
                      const SizedBox(width: 8),
                      if (isOverridden)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              amberWarning,
                              const Color(0xFFFBBF24)
                            ]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_rounded,
                                  size: 10, color: Colors.white),
                              SizedBox(width: 3),
                              Text('MOD',
                                  style:
                                      ModernInvoiceDesign.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9,
                                  )),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 300.ms)
                            .scale(begin: const Offset(0.8, 0.8)),
                      const SizedBox(width: 6),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _resetPrice(id),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: slateLight.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Icon(Icons.refresh_rounded,
                                size: 18, color: slateLight),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item['description'] ?? 'No description available',
                    style: ModernInvoiceDesign.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: slateDark,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: tealPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: tealPrimary.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.badge_outlined, 'Employee',
                            employeeName, tealPrimary),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.person_outline_rounded, 'Client',
                            clientName, tealPrimary),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                            Icons.calendar_today_rounded,
                            'Schedule',
                            '$scheduleDate ${startTime.isNotEmpty && endTime.isNotEmpty ? '($startTime - $endTime)' : ''}',
                            tealPrimary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPriceCard(
                            label: 'Current Rate',
                            value: '\$${currentPrice.toStringAsFixed(2)}',
                            icon: Icons.payments_outlined,
                            color: tealPrimary,
                            subtitle: 'Qty: ${quantity.toStringAsFixed(1)}'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPriceCard(
                          label: 'NDIS Cap',
                          value: (item['maxPrice'] != null &&
                                  (item['maxPrice'] as num).toDouble() > 0)
                              ? '\$${(item['maxPrice'] as num).toDouble().toStringAsFixed(2)}'
                              : 'N/A',
                          icon: Icons.shield_outlined,
                          color: (item['maxPrice'] != null &&
                                  (item['maxPrice'] as num).toDouble() > 0)
                              ? emeraldAccent
                              : slateLight,
                          subtitle: item['clientState'] as String? ?? '',
                          isWarning: item['maxPrice'] != null &&
                              (item['maxPrice'] as num).toDouble() > 0 &&
                              currentPrice >
                                  (item['maxPrice'] as num).toDouble(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (widget.clientId.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: (_isClientSpecific[id] == true)
                              ? [
                                  emeraldAccent.withOpacity(0.1),
                                  emeraldAccent.withOpacity(0.1)
                                ]
                              : [
                                  slateLight.withOpacity(0.1),
                                  slateLight.withOpacity(0.1)
                                ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: (_isClientSpecific[id] == true)
                                ? emeraldAccent.withOpacity(0.1)
                                : slateLight.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: (_isClientSpecific[id] == true)
                                  ? emeraldAccent.withOpacity(0.1)
                                  : slateLight.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                                (_isClientSpecific[id] == true)
                                    ? Icons.person_rounded
                                    : Icons.business_rounded,
                                size: 20,
                                color: (_isClientSpecific[id] == true)
                                    ? emeraldAccent
                                    : slateLight),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pricing Scope',
                                    style: ModernInvoiceDesign.bodySmall
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: slateDark)),
                                const SizedBox(height: 2),
                                Text(
                                    (_isClientSpecific[id] == true)
                                        ? 'Client-Specific Rate'
                                        : 'Organization-Wide Rate',
                                    style:
                                        ModernInvoiceDesign.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: (_isClientSpecific[id] == true)
                                          ? emeraldAccent
                                          : slateDark,
                                    )),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: Switch.adaptive(
                              value: _isClientSpecific[id] ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _isClientSpecific[id] = value;
                                  _updateOverrideStatus(id);
                                });
                              },
                              activeColor: emeraldAccent,
                              activeTrackColor: emeraldAccent.withOpacity(0.1),
                              inactiveThumbColor: slateLight,
                              inactiveTrackColor: slateLight.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 100.ms),
                    const SizedBox(height: 20),
                  ],
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: tealPrimary.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(Icons.edit_note_rounded,
                              size: 20, color: tealPrimary),
                          const SizedBox(width: 8),
                          Text('Override Price',
                              style: ModernInvoiceDesign.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: slateDark))
                        ]),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _priceControllers[id],
                          decoration: InputDecoration(
                            hintText: 'Enter new price',
                            hintStyle: ModernInvoiceDesign.bodyMedium
                                .copyWith(color: slateLight.withOpacity(0.1)),
                            prefixIcon: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text('\$',
                                    style: ModernInvoiceDesign.bodyMedium
                                        .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: tealPrimary))),
                            suffixIcon: isOverridden
                                ? Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: amberWarning.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Icon(Icons.edit,
                                        size: 16, color: amberWarning))
                                : null,
                            filled: true,
                            fillColor: tealPrimary.withOpacity(0.1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: tealPrimary.withOpacity(0.1))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: tealPrimary.withOpacity(0.1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: tealPrimary, width: 2)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          style: ModernInvoiceDesign.bodyMedium.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: slateDark),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}'))
                          ],
                          onChanged: (value) => _onPriceChanged(id, value),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Line Total',
                                style: ModernInvoiceDesign.bodySmall.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: slateLight)),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      '\$${(quantity * (double.tryParse(_priceControllers[id]?.text ?? '0') ?? 0)).toStringAsFixed(2)}',
                                      style: ModernInvoiceDesign.bodyMedium
                                          .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: tealPrimary)),
                                  if (isOverridden)
                                    Text(
                                        'Was: \$${(quantity * originalPrice).toStringAsFixed(2)}',
                                        style: ModernInvoiceDesign.bodySmall
                                            .copyWith(
                                                fontSize: 12,
                                                color: slateLight,
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (item['maxPrice'] != null &&
                      (item['maxPrice'] as num).toDouble() > 0 &&
                      (double.tryParse(_priceControllers[id]?.text ?? '0') ??
                              0.0) >
                          (item['maxPrice'] as num).toDouble())
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            roseError.withOpacity(0.1),
                            roseError.withOpacity(0.1)
                          ]),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: roseError.withOpacity(0.1)),
                        ),
                        child: Row(children: [
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: roseError.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.warning_amber_rounded,
                                  color: roseError, size: 18)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text('Price Exceeds NDIS Cap',
                                    style: ModernInvoiceDesign.bodySmall
                                        .copyWith(
                                            color: roseError,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text(
                                    'Maximum: \$${(item['maxPrice'] as num).toDouble().toStringAsFixed(2)}',
                                    style: ModernInvoiceDesign.bodySmall
                                        .copyWith(
                                            color: roseError.withValues(
                                                alpha: 0.8))),
                              ])),
                        ]),
                      ).animate().fadeIn().shake(hz: 2, duration: 400.ms),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, duration: 400.ms);
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(children: [
      Icon(icon, size: 16, color: color.withOpacity(0.1)),
      const SizedBox(width: 8),
      Text('$label: ',
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8))),
      Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B)),
              overflow: TextOverflow.ellipsis)),
    ]);
  }

  Widget _buildPriceCard(
      {required String label,
      required String value,
      required IconData icon,
      required Color color,
      String? subtitle,
      bool isWarning = false}) {
    final displayColor = isWarning ? const Color(0xFFF43F5E) : color;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: displayColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: displayColor.withOpacity(0.1))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, size: 16, color: displayColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8)),
                overflow: TextOverflow.ellipsis),
          ),
          if (subtitle != null && subtitle.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6)),
              child: Text(subtitle,
                  style: TextStyle(
                      fontSize: 9, fontWeight: FontWeight.w600, color: color),
                  overflow: TextOverflow.ellipsis),
            ),
        ]),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isWarning ? displayColor : const Color(0xFF1E293B))),
        if (isWarning)
          const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text('Exceeds cap!',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF43F5E)))),
      ]),
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
                foregroundColor: const Color(0xFF757575),
                side: BorderSide(color: const Color(0xFFEEEEEE)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Cancel',
                style: ModernInvoiceDesign.labelLarge.copyWith(
                  color: const Color(0xFF757575),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : _applyOverrides,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
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

class SourceBadge extends StatelessWidget {
  final String source;
  final bool isSmall;

  const SourceBadge({
    super.key,
    required this.source,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (source.toLowerCase()) {
      case 'custom':
        color = Colors.purple;
        label = 'Custom';
        break;
      case 'client-specific':
      case 'client_specific':
        color = Colors.orange;
        label = 'Client';
        break;
      case 'organization':
      case 'org':
        color = Colors.blue;
        label = 'Org';
        break;
      default:
        color = Colors.grey;
        label = 'NDIS';
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : 8,
        vertical: isSmall ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(isSmall ? 4 : 6),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: isSmall ? 10 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
