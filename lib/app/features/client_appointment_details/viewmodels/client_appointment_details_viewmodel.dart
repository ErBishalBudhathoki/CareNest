import 'package:carenest/app/core/enums/view_state.dart';
import 'package:carenest/app/features/client_appointment_details/models/client_detail_model.dart';
import 'package:carenest/app/features/client_appointment_details/models/visit_history_model.dart';
import 'package:carenest/app/features/client_appointment_details/repositories/client_appointment_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

class ClientAppointmentDetailsViewModel extends ChangeNotifier {
  final ClientAppointmentRepository _repository;
  String _clientId;
  final String? _clientEmail;
  
  ClientDetailModel? _client;
  List<VisitHistoryModel> _visitHistory = [];
  ViewState _state = ViewState.idle;
  String? _errorMessage;

  ClientAppointmentDetailsViewModel(
    this._repository,
    String clientId, {
    String? clientEmail,
  })  : _clientId = clientId,
        _clientEmail = clientEmail {
    _init();
  }

  ClientDetailModel? get client => _client;
  List<VisitHistoryModel> get visitHistory => _visitHistory;
  ViewState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> _init() async {
    _state = ViewState.busy;
    notifyListeners();

    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      final organizationId = prefs.getString('organizationId') ?? '';
      
      if (organizationId.isEmpty) {
        throw Exception('Organization ID not found');
      }

      if (_clientId.trim().isEmpty &&
          _clientEmail != null &&
          _clientEmail.trim().isNotEmpty) {
        final resolved = await _repository.getClientByEmail(
          _clientEmail.trim(),
          organizationId,
        );
        if (resolved != null) {
          _client = resolved;
          _clientId = resolved.id;
        }
      }

      if (_clientId.trim().isEmpty) {
        throw Exception('Client not found');
      }

      // Fetch client details (if not already resolved)
      _client ??= await _repository.getClientDetails(_clientId, organizationId);

      // Fetch visit history
      _visitHistory = await _repository.getVisitHistory(_clientId, organizationId);
      
      _state = ViewState.idle;
    } catch (e) {
      _state = ViewState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<bool> updateCareNotes(String careNotes) async {
    if (_client == null) return false;

    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      final organizationId = prefs.getString('organizationId') ?? '';
      final userEmail = prefs.getString('userEmail') ?? '';

      final success = await _repository.updateCareNotes(
        _clientId,
        careNotes,
        organizationId,
        userEmail,
      );
      if (success) {
        // Optimistic update or refetch
        _client = _client?.copyWith(careNotes: careNotes);
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('ViewModel: Error updating care notes: $e');
      return false;
    }
  }
}
