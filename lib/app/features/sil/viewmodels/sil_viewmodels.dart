import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';

/// The repositories surface server messages as `Exception: <message>`. These
/// strings are shown to support coordinators in snack bars, so drop the Dart
/// noise and keep the message the API actually wrote.
String silErrorMessage(Object error) {
  if (error is SILConsentRequiredException) {
    return error.message;
  }
  final text = error.toString();
  return text.startsWith('Exception: ') ? text.substring(11) : text;
}

// ---------------------------------------------------------------------------
// Properties + occupancy
// ---------------------------------------------------------------------------

class SILPropertiesState {
  final bool isLoading;
  final String? error;
  final List<SILProperty> properties;
  final List<SILOccupancy> occupancy;
  final SILVacancyBoard? vacancyBoard;

  SILPropertiesState({
    this.isLoading = false,
    this.error,
    this.properties = const [],
    this.occupancy = const [],
    this.vacancyBoard,
  });

  SILPropertiesState copyWith({
    bool? isLoading,
    String? error,
    List<SILProperty>? properties,
    List<SILOccupancy>? occupancy,
    SILVacancyBoard? vacancyBoard,
  }) {
    return SILPropertiesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      properties: properties ?? this.properties,
      occupancy: occupancy ?? this.occupancy,
      vacancyBoard: vacancyBoard ?? this.vacancyBoard,
    );
  }
}

class SILPropertiesViewModel extends Notifier<SILPropertiesState> {
  SILRepository get _repository => ref.read(silRepositoryProvider);

  @override
  SILPropertiesState build() {
    ref.watch(silRepositoryProvider);
    return SILPropertiesState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final properties = await _repository.getProperties();
      state = state.copyWith(isLoading: false, properties: properties);
    } catch (e) {
      debugPrint('Error loading SIL properties: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadVacancies(String propertyId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final board = await _repository.getVacancies(propertyId);
      final occupancy = await _repository.getOccupancy(propertyId: propertyId);
      state = state.copyWith(
        isLoading: false,
        vacancyBoard: board,
        occupancy: occupancy,
      );
    } catch (e) {
      debugPrint('Error loading SIL vacancies: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> createProperty(Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.createProperty(body);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> createOccupancy(Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.createOccupancy(body);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> endOccupancy(
    String id, {
    String? endDate,
    String? vacatedReason,
    String? newRoomId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.endOccupancy(
        id,
        endDate: endDate,
        vacatedReason: vacatedReason,
        newRoomId: newRoomId,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final silPropertiesViewModelProvider =
    NotifierProvider<SILPropertiesViewModel, SILPropertiesState>(
      SILPropertiesViewModel.new,
    );

// ---------------------------------------------------------------------------
// Roster
// ---------------------------------------------------------------------------

class SILRosterState {
  final bool isLoading;
  final String? error;
  final SILRoster? roster;

  SILRosterState({this.isLoading = false, this.error, this.roster});

  SILRosterState copyWith({bool? isLoading, String? error, SILRoster? roster}) {
    return SILRosterState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      roster: roster ?? this.roster,
    );
  }
}

class SILRosterViewModel extends Notifier<SILRosterState> {
  SILRepository get _repository => ref.read(silRepositoryProvider);

  @override
  SILRosterState build() {
    ref.watch(silRepositoryProvider);
    return SILRosterState();
  }

  Future<void> load({
    required String propertyId,
    required String weekStarting,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final roster = await _repository.getRoster(
        propertyId: propertyId,
        weekStarting: weekStarting,
      );
      state = state.copyWith(isLoading: false, roster: roster);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> buildRoster({
    required String propertyId,
    required String weekStarting,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final roster = await _repository.buildRoster(
        propertyId: propertyId,
        weekStarting: weekStarting,
      );
      state = state.copyWith(isLoading: false, roster: roster);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> publish() async {
    final roster = state.roster;
    if (roster == null) return false;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final published = await _repository.publishRoster(roster.id);
      state = state.copyWith(isLoading: false, roster: published);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final silRosterViewModelProvider =
    NotifierProvider<SILRosterViewModel, SILRosterState>(
      SILRosterViewModel.new,
    );

// ---------------------------------------------------------------------------
// Quotes
// ---------------------------------------------------------------------------

class SILQuoteState {
  final bool isLoading;
  final String? error;
  final List<SILQuote> quotes;

  SILQuoteState({this.isLoading = false, this.error, this.quotes = const []});

  SILQuoteState copyWith({
    bool? isLoading,
    String? error,
    List<SILQuote>? quotes,
  }) {
    return SILQuoteState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      quotes: quotes ?? this.quotes,
    );
  }
}

class SILQuoteViewModel extends Notifier<SILQuoteState> {
  SILRepository get _repository => ref.read(silRepositoryProvider);

  @override
  SILQuoteState build() {
    ref.watch(silRepositoryProvider);
    return SILQuoteState();
  }

  Future<void> load({String? clientId}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final quotes = await _repository.getQuotes(clientId: clientId);
      state = state.copyWith(isLoading: false, quotes: quotes);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<SILQuote?> create(Map<String, dynamic> body) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final quote = await _repository.createQuote(body);
      await load();
      return quote;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: silErrorMessage(e));
      return null;
    }
  }

  // Milestone 6.1: Digital E-Signature parameters for quote acceptance
  Future<bool> accept(
    String id, {
    String? signedBy,
    String? signatoryRole,
    String? signatureData,
    double? boardAndLodgingWeekly,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payload = <String, dynamic>{};
      if (signedBy != null && signedBy.trim().isNotEmpty) {
        payload['signedBy'] = signedBy.trim();
      }
      if (signatoryRole != null && signatoryRole.trim().isNotEmpty) {
        payload['signatoryRole'] = signatoryRole.trim();
      }
      if (signatureData != null && signatureData.trim().isNotEmpty) {
        payload['signatureData'] = signatureData.trim();
      }
      if (boardAndLodgingWeekly != null) {
        payload['boardAndLodgingWeekly'] = boardAndLodgingWeekly;
      }
      await _repository.acceptQuote(id, signatureData: payload.isNotEmpty ? payload : null);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: silErrorMessage(e));
      return false;
    }
  }

  Future<SILRosterOfCare?> convert(String id, {String? cadence}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final roc = await _repository.convertQuote(id, cadence: cadence);
      await load();
      return roc;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }
}

final silQuoteViewModelProvider =
    NotifierProvider<SILQuoteViewModel, SILQuoteState>(SILQuoteViewModel.new);

// ---------------------------------------------------------------------------
// Rosters of Care & Consent Gate (Milestone 4.2)
// ---------------------------------------------------------------------------

class SILRosterOfCareState {
  final bool isLoading;
  final String? error;
  final List<SILRosterOfCare> rosters;

  SILRosterOfCareState({
    this.isLoading = false,
    this.error,
    this.rosters = const [],
  });

  SILRosterOfCareState copyWith({
    bool? isLoading,
    String? error,
    List<SILRosterOfCare>? rosters,
  }) {
    return SILRosterOfCareState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      rosters: rosters ?? this.rosters,
    );
  }
}

class SILRosterOfCareViewModel extends Notifier<SILRosterOfCareState> {
  SILRepository get _repository => ref.read(silRepositoryProvider);

  @override
  SILRosterOfCareState build() {
    ref.watch(silRepositoryProvider);
    return SILRosterOfCareState();
  }

  Future<void> load({String? clientId}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final rosters = await _repository.getRostersOfCare(clientId: clientId);
      state = state.copyWith(isLoading: false, rosters: rosters);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: silErrorMessage(e));
    }
  }

  /// Activates a draft RoC. Subject to Milestone 4.2 Consent Gate requiring
  /// an active signed Service Agreement or an auditable emergency consent bypass.
  Future<SILRosterOfCare?> activate(
    String id, {
    bool bypassConsent = false,
    String? bypassReason,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await _repository.updateRosterOfCare(id, {
        'status': 'active',
        if (bypassConsent) 'bypassConsent': true,
        if (bypassReason != null && bypassReason.isNotEmpty)
          'bypassReason': bypassReason,
      });
      await load();
      return updated;
    } on SILConsentRequiredException {
      state = state.copyWith(isLoading: false);
      rethrow;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: silErrorMessage(e));
      return null;
    }
  }

  /// Bill one period of an active roster of care with idempotency token support.
  Future<SILRosterOfCareInvoice?> generateInvoice(
    String id, {
    required String from,
    required String to,
    String? dueDate,
    String? idempotencyKey,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final invoice = await _repository.invoiceRosterOfCare(
        id,
        from: from,
        to: to,
        dueDate: dueDate,
        idempotencyKey: idempotencyKey,
      );
      state = state.copyWith(isLoading: false);
      return invoice;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: silErrorMessage(e));
      return null;
    }
  }

  /// Milestone 7.3: Dispatch a SIL invoice PDF to plan manager or participant.
  Future<Map<String, dynamic>?> dispatchInvoice(
    String id, {
    String? dispatchMethod,
    String? recipientEmail,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.dispatchInvoice(
        id,
        dispatchMethod: dispatchMethod,
        recipientEmail: recipientEmail,
      );
      state = state.copyWith(isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: silErrorMessage(e));
      return null;
    }
  }
}

final silRosterOfCareViewModelProvider =
    NotifierProvider<SILRosterOfCareViewModel, SILRosterOfCareState>(
      SILRosterOfCareViewModel.new,
    );
