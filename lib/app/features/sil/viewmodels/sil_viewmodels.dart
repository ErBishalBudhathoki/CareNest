import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';

/// The repositories surface server messages as `Exception: <message>`. These
/// strings are shown to support coordinators in snack bars, so drop the Dart
/// noise and keep the message the API actually wrote.
String silErrorMessage(Object error) {
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

  Future<bool> accept(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.acceptQuote(id);
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
