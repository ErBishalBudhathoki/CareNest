import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/debug_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Price Override View
/// Allows users to override prices for NDIS line items before invoice generation
class PriceOverrideView extends ConsumerStatefulWidget {
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
  ConsumerState<PriceOverrideView> createState() => _PriceOverrideViewState();
}

class _PriceOverrideViewState extends ConsumerState<PriceOverrideView> {
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
  late final ApiMethod _apiMethod;
  double? _fallbackBaseRate; // Cached organization fallback base rate

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    _loadLineItems();
  }

  void _initializeControllers() {
    _controllers.clear();
    _isClientSpecific.clear(); // Clear client-specific toggles
    _originalClientSpecific.clear(); // Clear original client-specific states
    for (final item in _lineItems) {
      final ndisItemNumber = item['ndisItemNumber'] as String;
      _controllers[ndisItemNumber] = TextEditingController(
        text: item['unitPrice'].toStringAsFixed(2),
      );

      // Also initialize the legacy controllers for compatibility
      final id = item['id'] as String;
      _descriptionControllers[id] = TextEditingController(
        text: item['description'],
      );
      _priceControllers[id] = TextEditingController(
        text: item['unitPrice'].toString(),
      );
      _quantityControllers[id] = TextEditingController(
        text: item['quantity'].toString(),
      );
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
    final priceChanged =
        (currentPrice - originalPrice).abs() >
        0.01; // Allow for small floating point differences

    // Check if client-specific toggle has changed
    final clientSpecificChanged =
        currentClientSpecific != originalClientSpecific;

    final isModified = priceChanged || clientSpecificChanged;

    // Debug logging
    if (priceChanged || clientSpecificChanged) {
      print(
        'Item $id modification check: price=$currentPrice (was $originalPrice, changed=$priceChanged), clientSpecific=$currentClientSpecific (was $originalClientSpecific, changed=$clientSpecificChanged) -> modified=$isModified',
      );
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
        DebugLog.error(
          'fallback_base_rate_fetch_error',
          details: {
            'organizationId': widget.organizationId,
            'error': e.toString(),
          },
        );
      }

      final List<Map<String, dynamic>> items = [];

      // Process each client assignment to extract employee, client, and NDIS item data
      for (final assignment in widget.clientAssignments) {
        final l10n = AppLocalizations.of(context)!;
        final userEmail =
            assignment['userEmail'] as String? ?? l10n.unknownEmployee;
        final clientEmail =
            assignment['clientEmail'] as String? ?? l10n.unknownClient;
        final userName = assignment['userName'] as String? ?? userEmail;
        final clientName = assignment['clientName'] as String? ?? clientEmail;

        // Get client state from assignment or fetch client details
        String clientState = assignment['clientState'] as String? ?? '';
        if (clientState.isEmpty &&
            clientEmail.isNotEmpty &&
            clientEmail != 'Unknown Client') {
          try {
            final clientDetails = await _apiMethod.getClientDetails(
              clientEmail,
            );
            if (clientDetails != null && clientDetails['success'] == true) {
              clientState = clientDetails['clientState'] as String? ?? '';
            }
          } catch (e) {
            debugPrint(
              'PriceOverrideView: Error fetching client details for state: $e',
            );
          }
        }
        // Default to NSW if no state found
        if (clientState.isEmpty) {
          clientState = 'NSW';
        }
        debugPrint(
          'PriceOverrideView: Using client state: $clientState for $clientEmail',
        );

        final schedule = assignment['schedule'] as List<dynamic>? ?? [];

        for (final scheduleItem in schedule) {
          final ndisItem = scheduleItem['ndisItem'] as Map<String, dynamic>?;
          if (ndisItem != null) {
            final itemNumber = ndisItem['itemNumber'] as String?;
            final itemName = ndisItem['itemName'] as String?;
            final date = scheduleItem['date'] as String? ?? l10n.noDate;
            final startTime = scheduleItem['startTime'] as String? ?? '';
            final endTime = scheduleItem['endTime'] as String? ?? '';

            if (itemNumber != null && itemName != null) {
              // Get pricing information
              final pricingData = await _apiMethod.getPricingLookup(
                widget.organizationId,
                itemNumber,
                clientId: widget.clientId,
              );

              final supportItemDetails = await _apiMethod.getSupportItemDetails(
                itemNumber,
              );

              double currentPrice =
                  _fallbackBaseRate ??
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
                    extractedCap = (standardCaps[clientState] as num)
                        .toDouble();
                    debugPrint(
                      'PriceOverrideView: Found standard cap for $clientState: $extractedCap',
                    );
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
                    extractedCap = (highIntensityCaps[clientState] as num)
                        .toDouble();
                    debugPrint(
                      'PriceOverrideView: Found highIntensity cap for $clientState: $extractedCap',
                    );
                  }
                }

                if (extractedCap != null && extractedCap > 0) {
                  maxPrice = extractedCap;
                  debugPrint(
                    'PriceOverrideView: Using NDIS cap for $itemNumber ($clientState): $maxPrice',
                  );
                }
              }

              // Fallback: use API-provided cap if available and maxPrice is still 0
              if (maxPrice <= 0) {
                final apiCap = (pricingData?['priceCap'] as num?)?.toDouble();
                if (apiCap != null && apiCap > 0) {
                  maxPrice = apiCap;
                  debugPrint(
                    'PriceOverrideView: Using API-provided cap for $itemNumber: $maxPrice',
                  );
                }
              }

              // If still no cap found, log a warning (no fallback to arbitrary value)
              if (maxPrice <= 0) {
                debugPrint(
                  'PriceOverrideView: WARNING - No NDIS price cap found for $itemNumber in state $clientState',
                );
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
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorLoadingLineItems(e.toString()))),
        );
      }
      DebugLog.error('load_line_items_error', details: {'error': e.toString()});
    } finally {
      setState(() {
        _isLoading = false;
      });
      DebugLog.uiState('load_line_items_end', {'isLoading': _isLoading});
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
    final flowId = DebugLog.startFlow(
      'apply_overrides',
      details: {'itemsCount': _lineItems.length},
    );
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
    final String? clientId = widget.clientId.isNotEmpty
        ? widget.clientId
        : null;

    if (userEmail == null || userEmail.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.missingUserContext)));
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
          final l10n = AppLocalizations.of(context)!;
          failures[id] = l10n.invalidPriceEntered;
          DebugLog.error(
            'invalid_price_entered',
            details: {'id': id, 'enteredPrice': newPrice},
            flowId: flowId,
          );
          continue;
        }

        try {
          // Check existing pricing
          DebugLog.uiState('lookup_existing_pricing', {
            'organizationId': orgId,
            'itemNumber': itemNumber,
            'clientId': clientIdForSave,
            'isClientSpecific': shouldBeClientSpecific,
          }, flowId: flowId);
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
          final scopeMatches =
              pricingId != null &&
              lookupIsClientSpecific == shouldBeClientSpecific;

          if (scopeMatches && pricingId.isNotEmpty) {
            // Update existing pricing only when scope matches
            DebugLog.uiState('update_custom_pricing', {
              'pricingId': pricingId,
              'newPrice': newPrice,
              'pricingType': 'fixed',
              'clientSpecific': shouldBeClientSpecific,
            }, flowId: flowId);
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
              DebugLog.uiState('create_client_specific_pricing', {
                'organizationId': orgId,
                'clientId': clientIdForSave,
                'itemNumber': itemNumber,
                'newPrice': newPrice,
                'pricingType': 'fixed',
              }, flowId: flowId);
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
                  (result['message']?.toString().toLowerCase().contains(
                        'already exists',
                      ) ??
                      false)) {
                DebugLog.uiState('create_conflict_fallback_update', {
                  'organizationId': orgId,
                  'clientId': clientIdForSave,
                  'itemNumber': itemNumber,
                  'newPrice': newPrice,
                }, flowId: flowId);
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
                  (result['message']?.toString().toLowerCase().contains(
                        'already exists',
                      ) ??
                      false)) {
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
            final l10n = AppLocalizations.of(context)!;
            failures[id] = (result['message']?.toString() ?? l10n.saveFailed);
            DebugLog.error(
              'persist_override_failed',
              details: {'id': id, 'itemNumber': itemNumber, 'result': result},
              flowId: flowId,
            );
            continue;
          }

          // Confirm persistence by re-fetching lookup
          DebugLog.uiState('confirm_persistence_lookup', {
            'organizationId': orgId,
            'itemNumber': itemNumber,
            'clientId': clientIdForSave,
          }, flowId: flowId);
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
            final l10n = AppLocalizations.of(context)!;
            failures[id] = l10n.persistenceConfirmationFailed;
            DebugLog.error(
              'persistence_confirmation_failed',
              details: {
                'id': id,
                'itemNumber': itemNumber,
                'expectedPrice': newPrice,
                'confirmedPrice': confirmedPrice,
              },
              flowId: flowId,
            );
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
          _originalClientSpecific[id] =
              _isClientSpecific[id] ??
              false; // Update original client-specific state
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
          DebugLog.error(
            'exception_persisting_override',
            details: {'id': id, 'error': e.toString()},
            flowId: flowId,
          );
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
    DebugLog.uiState('set_loading', {'value': false}, flowId: flowId);

    if (failures.isNotEmpty) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.failedToApplyOverrides(failures.length)),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      DebugLog.endFlow(
        flowId,
        success: false,
        message: 'apply_overrides_failed',
        summary: {
          'failedCount': failures.length,
          'successCount': overrides.length,
        },
      );
      return; // Do not pop on partial failure
    }

    // All persisted and confirmed
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.priceOverridesAppliedMessage(overrides.length)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    DebugLog.endFlow(
      flowId,
      success: true,
      message: 'apply_overrides_success',
      summary: {'appliedCount': overrides.length},
    );

    Navigator.pop(context, overrides);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          l10n.priceOverrideTitle,
          style: BauhausDesign.getTextTheme(
            context,
          ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
      ),
      body: Stack(
        children: [
          _lineItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.assignment_outlined,
                        size: 64,
                        color: BauhausDesign.textMuted,
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      Text(
                        l10n.noNdisItemsFound,
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).titleLarge?.copyWith(color: BauhausDesign.textDark),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        l10n.noClientAssignmentsForOverride,
                        textAlign: TextAlign.center,
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildHeader(),
                    Expanded(child: _buildLineItemsList()),
                    _buildActionButtons(),
                  ],
                ),
          if (_isLoading)
            Positioned.fill(
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: BauhausDesign.primary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(bottom: BorderSide(color: BauhausDesign.neutral)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.reviewAndOverridePrices,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.primary,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            l10n.ndisItemsCount(_lineItems.length),
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
  /// Builds a Bauhaus styled line item card.
  Widget _buildLineItemCard(Map<String, dynamic> item) {
    final l10n = AppLocalizations.of(context)!;
    final id = item['id'] as String;
    final ndisItemNumber = item['ndisItemNumber'] as String;
    final quantity = item['quantity'] as double;
    final isOverridden = _isOverridden[id] ?? false;
    final originalPrice = _originalPrices[id] ?? 0.0;
    final currentPrice = item['unitPrice'] as double;
    final employeeName =
        item['employeeName'] as String? ?? l10n.unknownEmployee;
    final clientName = item['clientName'] as String? ?? l10n.unknownClient;
    final scheduleDate = item['scheduleDate'] as String? ?? l10n.noDate;
    final startTime = item['startTime'] as String? ?? '';
    final endTime = item['endTime'] as String? ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: BauhausCard(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: BauhausDesign.space2,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: BauhausDesign.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                BauhausDesign.radiusSm,
                              ),
                              border: Border.all(color: BauhausDesign.primary),
                            ),
                            child: Text(
                              ndisItemNumber,
                              style: BauhausDesign.getTextTheme(context)
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: BauhausDesign.primary,
                                  ),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                          SourceBadge(
                            source: (item['source'] as String?) ?? 'fallback',
                            isSmall: true,
                          ),
                          if (isOverridden) ...[
                            const SizedBox(width: BauhausDesign.space2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: BauhausDesign.space2,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: BauhausDesign.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  BauhausDesign.radiusSm,
                                ),
                                border: Border.all(
                                  color: BauhausDesign.warning,
                                ),
                              ),
                              child: Text(
                                l10n.modifiedLabel,
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(
                                      color: BauhausDesign.warning,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        item['description'] ?? l10n.noDescriptionAvailable,
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (isOverridden)
                  IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: BauhausDesign.textMuted,
                    ),
                    onPressed: () => _resetPrice(id),
                    tooltip: l10n.resetPriceTooltip,
                  ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral),
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.badge_outlined,
                    l10n.employeeLabel,
                    employeeName,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  _buildInfoRow(
                    Icons.person_outline_rounded,
                    l10n.clientLabel,
                    clientName,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  _buildInfoRow(
                    Icons.calendar_today_rounded,
                    l10n.scheduleLabel,
                    '$scheduleDate ${startTime.isNotEmpty && endTime.isNotEmpty ? '($startTime - $endTime)' : ''}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Row(
              children: [
                Expanded(
                  child: _buildPriceCard(
                    label: l10n.currentRateLabel,
                    value: l10n.priceDisplay(
                      l10n.currencySymbol,
                      currentPrice.toStringAsFixed(2),
                    ),
                    icon: Icons.payments_outlined,
                    color: BauhausDesign.primary,
                    subtitle: 'Qty: ${quantity.toStringAsFixed(1)}',
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: _buildPriceCard(
                    label: l10n.ndisCapLabel,
                    value:
                        (item['maxPrice'] != null &&
                            (item['maxPrice'] as num).toDouble() > 0)
                        ? l10n.priceDisplay(
                            l10n.currencySymbol,
                            (item['maxPrice'] as num)
                                .toDouble()
                                .toStringAsFixed(2),
                          )
                        : l10n.naLabel,
                    icon: Icons.shield_outlined,
                    color:
                        (item['maxPrice'] != null &&
                            (item['maxPrice'] as num).toDouble() > 0)
                        ? BauhausDesign.success
                        : BauhausDesign.textMuted,
                    subtitle: item['clientState'] as String? ?? '',
                    isWarning:
                        item['maxPrice'] != null &&
                        (item['maxPrice'] as num).toDouble() > 0 &&
                        currentPrice > (item['maxPrice'] as num).toDouble(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            if (widget.clientId.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: (_isClientSpecific[id] == true)
                      ? BauhausDesign.success.withOpacity(0.05)
                      : BauhausDesign.backgroundLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(
                    color: (_isClientSpecific[id] == true)
                        ? BauhausDesign.success
                        : BauhausDesign.neutral,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      (_isClientSpecific[id] == true)
                          ? Icons.person_rounded
                          : Icons.business_rounded,
                      size: 20,
                      color: (_isClientSpecific[id] == true)
                          ? BauhausDesign.success
                          : BauhausDesign.textMuted,
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.pricingScopeLabel,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                          Text(
                            (_isClientSpecific[id] == true)
                                ? l10n.clientSpecificRateLabel
                                : l10n.orgWideRateLabel,
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).bodySmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _isClientSpecific[id] ?? false,
                      onChanged: (value) {
                        setState(() {
                          _isClientSpecific[id] = value;
                          _updateOverrideStatus(id);
                        });
                      },
                      activeColor: BauhausDesign.success,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.overridePriceLabel,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: BauhausDesign.space2),
                BauhausTextField(
                  controller: _priceControllers[id],
                  hintText: l10n.enterNewPriceHint,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                const SizedBox(height: BauhausDesign.space2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.lineTotalLabel,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.priceDisplay(
                            l10n.currencySymbol,
                            (quantity *
                                    (double.tryParse(
                                          _priceControllers[id]?.text ?? '0',
                                        ) ??
                                        0))
                                .toStringAsFixed(2),
                          ),
                          style: BauhausDesign.getTextTheme(context).bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.primary,
                              ),
                        ),
                        if (isOverridden)
                          Text(
                            l10n.wasPriceLabel(
                              l10n.priceDisplay(
                                l10n.currencySymbol,
                                (quantity * originalPrice).toStringAsFixed(2),
                              ),
                            ),
                            style: BauhausDesign.getTextTheme(context).bodySmall
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (item['maxPrice'] != null &&
                (item['maxPrice'] as num).toDouble() > 0 &&
                (double.tryParse(_priceControllers[id]?.text ?? '0') ?? 0.0) >
                    (item['maxPrice'] as num).toDouble())
              Padding(
                padding: const EdgeInsets.only(top: BauhausDesign.space3),
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(color: BauhausDesign.error),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: BauhausDesign.error,
                        size: 20,
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.priceExceedsCap,
                              style: BauhausDesign.getTextTheme(context)
                                  .labelSmall
                                  ?.copyWith(
                                    color: BauhausDesign.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              l10n.maximumPriceLabel(
                                l10n.priceDisplay(
                                  l10n.currencySymbol,
                                  (item['maxPrice'] as num)
                                      .toDouble()
                                      .toStringAsFixed(2),
                                ),
                              ),
                              style: BauhausDesign.getTextTheme(
                                context,
                              ).bodySmall?.copyWith(color: BauhausDesign.error),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: BauhausDesign.textMuted),
        const SizedBox(width: BauhausDesign.space2),
        Text(
          '$label: ',
          style: BauhausDesign.getTextTheme(
            context,
          ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
        ),
        Expanded(
          child: Text(
            value,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelSmall?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
    bool isWarning = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final displayColor = isWarning ? BauhausDesign.error : color;
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: displayColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: displayColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: displayColor),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  label,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (subtitle != null && subtitle.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  child: Text(
                    subtitle,
                    style: BauhausDesign.getTextTheme(context).labelSmall
                        ?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isWarning ? displayColor : BauhausDesign.textDark,
            ),
          ),
          if (isWarning)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.exceedsCapWarning,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.error,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(top: BorderSide(color: BauhausDesign.neutral)),
      ),
      child: Row(
        children: [
          Expanded(
            child: BauhausActionButton(
              text: l10n.cancel,
              onPressed: () {
                Navigator.pop(context);
              },
              variant: BauhausActionVariant.neutral,
              isOutlined: true,
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          Expanded(
            child: BauhausActionButton(
              text: l10n.applyOverrides,
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _applyOverrides,
              variant: BauhausActionVariant.primary,
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

  const SourceBadge({super.key, required this.source, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    BauhausChipVariant variant;
    String label;

    switch (source.toLowerCase()) {
      case 'custom':
        variant = BauhausChipVariant.primary;
        label = l10n.sourceCustom;
        break;
      case 'client-specific':
      case 'client_specific':
        variant = BauhausChipVariant.warning;
        label = l10n.sourceClientSpecific;
        break;
      case 'organization':
      case 'org':
        variant = BauhausChipVariant.info;
        label = l10n.sourceOrganization;
        break;
      default:
        variant = BauhausChipVariant.neutral;
        label = l10n.sourceNdisCap;
    }

    return BauhausChip(label: label, variant: variant, isSmall: isSmall);
  }
}
