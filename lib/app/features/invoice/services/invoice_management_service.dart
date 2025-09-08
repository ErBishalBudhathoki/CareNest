import 'package:carenest/backend/api_method.dart';
import 'package:flutter/foundation.dart';

class InvoiceManagementService {
  final ApiMethod _apiMethod = ApiMethod();

  /// Get list of invoices for an organization
  Future<Map<String, dynamic>> getInvoicesList({
    required String organizationId,
    int page = 1,
    int limit = 20,
    String? status,
    String? search,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'organizationId': organizationId,
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final queryString = queryParams.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final url = '/api/invoices?$queryString';
      debugPrint('DEBUG: Making API call to: $url');
      debugPrint('DEBUG: Query params: $queryParams');

      final result = await _apiMethod.get(url);
      debugPrint('DEBUG: API response received: $result');
      return result;
    } catch (e) {
      debugPrint('DEBUG: Exception in getInvoicesList: $e');
      return {
        'success': false,
        'message': 'Error fetching invoices: $e',
      };
    }
  }

  /// Get details of a specific invoice
  Future<Map<String, dynamic>> getInvoiceDetails({
    required String invoiceId,
    required String organizationId,
  }) async {
    try {
      final result = await _apiMethod
          .get('/api/invoices/$invoiceId?organizationId=$organizationId');
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching invoice details: $e',
      };
    }
  }

  /// Share an invoice
  Future<Map<String, dynamic>> shareInvoice({
    required String invoiceId,
    required String organizationId,
  }) async {
    try {
      final result = await _apiMethod.post(
        '/api/invoices/$invoiceId/share',
        body: {
          'organizationId': organizationId,
        },
      );
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice: $e',
      };
    }
  }

  /// Share invoice as PDF
  Future<Map<String, dynamic>> shareInvoiceAsPdf({
    required String invoiceId,
    required String organizationId,
  }) async {
    try {
      final result = await _apiMethod.post(
        '/api/invoices/$invoiceId/share/pdf',
        body: {
          'organizationId': organizationId,
        },
      );
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice as PDF: $e',
      };
    }
  }

  /// Share invoice via email
  Future<Map<String, dynamic>> shareInvoiceViaEmail({
    required String invoiceId,
    required String organizationId,
    required String recipientEmail,
    String? message,
  }) async {
    try {
      final result = await _apiMethod.post(
        '/api/invoices/$invoiceId/share/email',
        body: {
          'organizationId': organizationId,
          'recipientEmail': recipientEmail,
          if (message != null) 'message': message,
        },
      );
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice via email: $e',
      };
    }
  }

  /// Share invoice via WhatsApp
  Future<Map<String, dynamic>> shareInvoiceViaWhatsApp({
    required String invoiceId,
    required String organizationId,
    required String phoneNumber,
  }) async {
    try {
      final result = await _apiMethod.post(
        '/api/invoices/$invoiceId/share/whatsapp',
        body: {
          'organizationId': organizationId,
          'phoneNumber': phoneNumber,
        },
      );
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error sharing invoice via WhatsApp: $e',
      };
    }
  }

  /// Delete an invoice (soft delete)
  Future<Map<String, dynamic>> deleteInvoice({
    required String invoiceId,
    required String organizationId,
  }) async {
    try {
      final result = await _apiMethod
          .delete('/api/invoices/$invoiceId?organizationId=$organizationId');
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error deleting invoice: $e',
      };
    }
  }

  /// Get invoice statistics for an organization
  Future<Map<String, dynamic>> getInvoiceStats({
    required String organizationId,
  }) async {
    try {
      final result = await _apiMethod
          .get('/api/invoices/stats?organizationId=$organizationId');
      return result;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error fetching invoice stats: $e',
      };
    }
  }
}
