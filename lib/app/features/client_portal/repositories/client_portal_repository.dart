import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientPortalRepository {
  final Ref ref;

  ClientPortalRepository(this.ref);

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      final normalized = value.replaceAll(',', '').trim();
      return double.tryParse(normalized) ?? 0.0;
    }
    return 0.0;
  }

  int? _toIntOrNull(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      final normalized = value.trim();
      if (normalized.isEmpty) return null;
      return int.tryParse(normalized);
    }
    return null;
  }

  bool _looksLikeNdisItemNumber(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return false;
    final hasSeparator =
        value.contains('_') || value.contains('-') || value.contains('.');
    final hasDigit = RegExp(r'\d').hasMatch(value);
    return hasSeparator && hasDigit;
  }

  Map<String, dynamic> _normalizeInvoiceLineItem(
    Map<String, dynamic> sourceItem,
  ) {
    final item = Map<String, dynamic>.from(sourceItem);

    final supportItemNumber =
        (item['supportItemNumber'] ??
                item['itemNumber'] ??
                item['ndisItemNumber'])
            ?.toString()
            .trim();
    final supportItemName =
        (item['supportItemName'] ??
                item['description'] ??
                item['itemName'] ??
                item['serviceName'])
            ?.toString()
            .trim();

    final rawQuantity =
        item['quantity'] ?? item['hoursWorked'] ?? item['hours'];
    final rawQuantityStr = rawQuantity?.toString() ?? '';
    final quantityLooksLikeNumber =
        rawQuantity is num || int.tryParse(rawQuantityStr) != null;
    final quantityInt = quantityLooksLikeNumber
        ? _toIntOrNull(rawQuantity)
        : null;

    final unitPrice = _toDouble(
      item['unitPrice'] ?? item['price'] ?? item['rate'],
    );
    final quantityForAmount = quantityInt ?? _toIntOrNull(item['units']) ?? 0;
    final total = _toDouble(
      item['total'] ??
          item['totalPrice'] ??
          item['amount'] ??
          (unitPrice * quantityForAmount),
    );

    final unit = (item['unit'] ?? item['unitType'] ?? '').toString().trim();
    final hoursWorked = _toDouble(item['hoursWorked'] ?? item['hours']);

    final description = (supportItemName != null && supportItemName.isNotEmpty)
        ? supportItemName
        : ((supportItemNumber != null && supportItemNumber.isNotEmpty)
              ? 'Support Item $supportItemNumber'
              : 'Support Item');

    final roundedHours = hoursWorked > 0
        ? double.parse(hoursWorked.toStringAsFixed(2))
        : (quantityLooksLikeNumber ? (quantityInt?.toDouble() ?? 0.0) : 0.0);

    final normalized = <String, dynamic>{
      ...item,
      'supportItemNumber': supportItemNumber,
      'itemNumber': supportItemNumber,
      'supportItemName': supportItemName,
      'description': description,
      'unitPrice': unitPrice,
      'quantity': quantityInt ?? 0,
      'unit': unit.isNotEmpty ? unit : 'hr',
      'total': total,
      'totalPrice': total,
      'hoursWorked': roundedHours,
      'hours':
          roundedHours, // Overwrite raw hours so fallback never shows long decimals
    };

    // If legacy payload stored support item number in quantity, recover it.
    if ((supportItemNumber == null || supportItemNumber.isEmpty) &&
        _looksLikeNdisItemNumber(rawQuantityStr)) {
      normalized['supportItemNumber'] = rawQuantityStr.trim();
      normalized['itemNumber'] = rawQuantityStr.trim();
    }

    return normalized;
  }

  Map<String, dynamic> _normalizeInvoiceDocument(Map<String, dynamic> input) {
    final data = _normalizeDocument(input);

    final workflowRaw = data['workflow'];
    final workflow = workflowRaw is Map
        ? Map<String, dynamic>.from(workflowRaw)
        : <String, dynamic>{};
    if (workflow['createdAt'] == null ||
        workflow['createdAt'].toString().isEmpty) {
      final auditTrail = data['auditTrail'];
      if (auditTrail is Map && auditTrail['createdAt'] != null) {
        workflow['createdAt'] = auditTrail['createdAt'];
      } else if (data['createdAt'] != null) {
        workflow['createdAt'] = data['createdAt'];
      }
    }
    data['workflow'] = workflow;

    final financialSummaryRaw = data['financialSummary'];
    final financialSummary = financialSummaryRaw is Map
        ? Map<String, dynamic>.from(financialSummaryRaw)
        : <String, dynamic>{};
    if (financialSummary['tax'] == null &&
        financialSummary['taxAmount'] != null) {
      financialSummary['tax'] = financialSummary['taxAmount'];
    }
    if (financialSummary['subtotal'] == null) {
      final lineItems = data['lineItems'];
      if (lineItems is List) {
        final subtotal = lineItems
            .whereType<Map>()
            .map(
              (item) => _toDouble(
                item['total'] ?? item['totalPrice'] ?? item['amount'],
              ),
            )
            .fold<double>(0.0, (acc, value) => acc + value);
        financialSummary['subtotal'] = subtotal;
      }
    }
    data['financialSummary'] = financialSummary;

    final lineItemsRaw = data['lineItems'];
    if (lineItemsRaw is List) {
      data['lineItems'] = lineItemsRaw
          .whereType<Map>()
          .map(
            (item) =>
                _normalizeInvoiceLineItem(Map<String, dynamic>.from(item)),
          )
          .toList();
    } else {
      data['lineItems'] = <Map<String, dynamic>>[];
    }

    return data;
  }

  Map<String, dynamic> _normalizeDocument(Map<String, dynamic> input) {
    final data = Map<String, dynamic>.from(input);
    final rawId = data['id'] ?? data['_id'];
    if (rawId != null) {
      data['id'] = rawId.toString();
    }
    return data;
  }

  Future<Map<String, dynamic>> getClientDashboard({
    required String clientId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getClientDashboard(clientId: clientId);
    } catch (e) {
      debugPrint('Error getting client dashboard: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getWorkerLocation({
    required String appointmentId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getWorkerLocation(appointmentId: appointmentId);
    } catch (e) {
      debugPrint('Error getting worker location: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getAppointmentStatus({
    required String appointmentId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getAppointmentStatus(appointmentId: appointmentId);
    } catch (e) {
      debugPrint('Error getting appointment status: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendMessage({
    required Map<String, dynamic> messageData,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.sendClientMessage(messageData: messageData);
    } catch (e) {
      debugPrint('Error sending message: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> submitFeedback({
    required Map<String, dynamic> feedbackData,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.submitServiceFeedback(feedbackData: feedbackData);
    } catch (e) {
      debugPrint('Error submitting feedback: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getServiceHistory({
    required String clientId,
    int? limit,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getServiceHistory(
        clientId: clientId,
        limit: limit,
      );
    } catch (e) {
      debugPrint('Error getting service history: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get appointments for client (for existing client portal views)
  Future<List<dynamic>> getAppointments() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final primaryResponse = await apiMethod.get('client-portal/appointments');
      if (primaryResponse['success'] == true &&
          primaryResponse['data'] != null) {
        return primaryResponse['data'] as List;
      }

      final statusCode = primaryResponse['statusCode'];
      final message =
          primaryResponse['message']?.toString().toLowerCase() ?? '';
      final shouldFallback =
          statusCode == 404 ||
          message.contains('route not found') ||
          message.contains('cannot get');

      if (!shouldFallback) return [];

      final fallbackResponse = await apiMethod.get(
        'client-portal-enhanced/appointments',
      );
      if (fallbackResponse['success'] == true &&
          fallbackResponse['data'] != null) {
        return fallbackResponse['data'] as List;
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get appointment detail (for existing client portal views)
  Future<Map<String, dynamic>> getAppointmentDetail({
    required String assignmentId,
    required String scheduleId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get(
        'client-portal/appointments/$assignmentId/$scheduleId',
      );
      return response;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching appointment detail: $e',
      };
    }
  }

  /// Get invoices for client (for existing client portal views)
  Future<List<dynamic>> getInvoices() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get('client-portal/invoices');
      if (response['success'] == true && response['data'] != null) {
        final rows = (response['data'] as List)
            .whereType<Map>()
            .map(
              (item) =>
                  _normalizeInvoiceDocument(Map<String, dynamic>.from(item)),
            )
            .toList();
        return rows;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get invoice detail (for existing client portal views)
  Future<Map<String, dynamic>> getInvoiceDetail(String invoiceId) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.get('client-portal/invoices/$invoiceId');
      if (response['success'] == true && response['data'] is Map) {
        return {
          ...response,
          'data': _normalizeInvoiceDocument(
            Map<String, dynamic>.from(response['data'] as Map),
          ),
        };
      }
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error fetching invoice detail: $e'};
    }
  }

  /// Approve invoice (for existing client portal views)
  Future<void> approveInvoice(String invoiceId) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      await apiMethod.post('client-portal/invoices/$invoiceId/approve');
    } catch (e) {
      throw Exception('Error approving invoice: $e');
    }
  }

  /// Dispute invoice (for existing client portal views)
  Future<void> disputeInvoice(String invoiceId, String reason) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      await apiMethod.post(
        'client-portal/invoices/$invoiceId/dispute',
        body: {'reason': reason},
      );
    } catch (e) {
      throw Exception('Error disputing invoice: $e');
    }
  }

  /// Request appointment (for existing client portal views)
  Future<Map<String, dynamic>> requestAppointment(
    Map<String, dynamic> requestData,
  ) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final response = await apiMethod.post(
        'client-portal/appointments/request',
        body: requestData,
      );
      return response;
    } catch (e) {
      return {'success': false, 'message': 'Error requesting appointment: $e'};
    }
  }
}

final clientPortalRepositoryProvider = Provider<ClientPortalRepository>((ref) {
  return ClientPortalRepository(ref);
});
