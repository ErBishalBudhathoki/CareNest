// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientDetailModel {
  String get id;
  String get clientFirstName;
  String get clientLastName;
  String get clientEmail;
  String? get clientPhone;
  String? get clientAddress;
  String? get clientCity;
  String? get clientState;
  String? get clientZip;
  String? get careNotes;
  Map<String, dynamic>? get preferences;
  Map<String, dynamic>? get emergencyContact;
  List<String>? get medicalConditions;
  Map<String, dynamic>? get riskAssessment;
  bool get isActivated;

  /// Create a copy of ClientDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientDetailModelCopyWith<ClientDetailModel> get copyWith =>
      _$ClientDetailModelCopyWithImpl<ClientDetailModel>(
          this as ClientDetailModel, _$identity);

  /// Serializes this ClientDetailModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientDetailModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientFirstName, clientFirstName) ||
                other.clientFirstName == clientFirstName) &&
            (identical(other.clientLastName, clientLastName) ||
                other.clientLastName == clientLastName) &&
            (identical(other.clientEmail, clientEmail) ||
                other.clientEmail == clientEmail) &&
            (identical(other.clientPhone, clientPhone) ||
                other.clientPhone == clientPhone) &&
            (identical(other.clientAddress, clientAddress) ||
                other.clientAddress == clientAddress) &&
            (identical(other.clientCity, clientCity) ||
                other.clientCity == clientCity) &&
            (identical(other.clientState, clientState) ||
                other.clientState == clientState) &&
            (identical(other.clientZip, clientZip) ||
                other.clientZip == clientZip) &&
            (identical(other.careNotes, careNotes) ||
                other.careNotes == careNotes) &&
            const DeepCollectionEquality()
                .equals(other.preferences, preferences) &&
            const DeepCollectionEquality()
                .equals(other.emergencyContact, emergencyContact) &&
            const DeepCollectionEquality()
                .equals(other.medicalConditions, medicalConditions) &&
            const DeepCollectionEquality()
                .equals(other.riskAssessment, riskAssessment) &&
            (identical(other.isActivated, isActivated) ||
                other.isActivated == isActivated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientFirstName,
      clientLastName,
      clientEmail,
      clientPhone,
      clientAddress,
      clientCity,
      clientState,
      clientZip,
      careNotes,
      const DeepCollectionEquality().hash(preferences),
      const DeepCollectionEquality().hash(emergencyContact),
      const DeepCollectionEquality().hash(medicalConditions),
      const DeepCollectionEquality().hash(riskAssessment),
      isActivated);

  @override
  String toString() {
    return 'ClientDetailModel(id: $id, clientFirstName: $clientFirstName, clientLastName: $clientLastName, clientEmail: $clientEmail, clientPhone: $clientPhone, clientAddress: $clientAddress, clientCity: $clientCity, clientState: $clientState, clientZip: $clientZip, careNotes: $careNotes, preferences: $preferences, emergencyContact: $emergencyContact, medicalConditions: $medicalConditions, riskAssessment: $riskAssessment, isActivated: $isActivated)';
  }
}

/// @nodoc
abstract mixin class $ClientDetailModelCopyWith<$Res> {
  factory $ClientDetailModelCopyWith(
          ClientDetailModel value, $Res Function(ClientDetailModel) _then) =
      _$ClientDetailModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String clientFirstName,
      String clientLastName,
      String clientEmail,
      String? clientPhone,
      String? clientAddress,
      String? clientCity,
      String? clientState,
      String? clientZip,
      String? careNotes,
      Map<String, dynamic>? preferences,
      Map<String, dynamic>? emergencyContact,
      List<String>? medicalConditions,
      Map<String, dynamic>? riskAssessment,
      bool isActivated});
}

/// @nodoc
class _$ClientDetailModelCopyWithImpl<$Res>
    implements $ClientDetailModelCopyWith<$Res> {
  _$ClientDetailModelCopyWithImpl(this._self, this._then);

  final ClientDetailModel _self;
  final $Res Function(ClientDetailModel) _then;

  /// Create a copy of ClientDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientFirstName = null,
    Object? clientLastName = null,
    Object? clientEmail = null,
    Object? clientPhone = freezed,
    Object? clientAddress = freezed,
    Object? clientCity = freezed,
    Object? clientState = freezed,
    Object? clientZip = freezed,
    Object? careNotes = freezed,
    Object? preferences = freezed,
    Object? emergencyContact = freezed,
    Object? medicalConditions = freezed,
    Object? riskAssessment = freezed,
    Object? isActivated = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientFirstName: null == clientFirstName
          ? _self.clientFirstName
          : clientFirstName // ignore: cast_nullable_to_non_nullable
              as String,
      clientLastName: null == clientLastName
          ? _self.clientLastName
          : clientLastName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _self.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      clientPhone: freezed == clientPhone
          ? _self.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      clientAddress: freezed == clientAddress
          ? _self.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      clientCity: freezed == clientCity
          ? _self.clientCity
          : clientCity // ignore: cast_nullable_to_non_nullable
              as String?,
      clientState: freezed == clientState
          ? _self.clientState
          : clientState // ignore: cast_nullable_to_non_nullable
              as String?,
      clientZip: freezed == clientZip
          ? _self.clientZip
          : clientZip // ignore: cast_nullable_to_non_nullable
              as String?,
      careNotes: freezed == careNotes
          ? _self.careNotes
          : careNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      preferences: freezed == preferences
          ? _self.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      emergencyContact: freezed == emergencyContact
          ? _self.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      medicalConditions: freezed == medicalConditions
          ? _self.medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      riskAssessment: freezed == riskAssessment
          ? _self.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isActivated: null == isActivated
          ? _self.isActivated
          : isActivated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientDetailModel].
extension ClientDetailModelPatterns on ClientDetailModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ClientDetailModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientDetailModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ClientDetailModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDetailModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ClientDetailModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDetailModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String clientFirstName,
            String clientLastName,
            String clientEmail,
            String? clientPhone,
            String? clientAddress,
            String? clientCity,
            String? clientState,
            String? clientZip,
            String? careNotes,
            Map<String, dynamic>? preferences,
            Map<String, dynamic>? emergencyContact,
            List<String>? medicalConditions,
            Map<String, dynamic>? riskAssessment,
            bool isActivated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientDetailModel() when $default != null:
        return $default(
            _that.id,
            _that.clientFirstName,
            _that.clientLastName,
            _that.clientEmail,
            _that.clientPhone,
            _that.clientAddress,
            _that.clientCity,
            _that.clientState,
            _that.clientZip,
            _that.careNotes,
            _that.preferences,
            _that.emergencyContact,
            _that.medicalConditions,
            _that.riskAssessment,
            _that.isActivated);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String clientFirstName,
            String clientLastName,
            String clientEmail,
            String? clientPhone,
            String? clientAddress,
            String? clientCity,
            String? clientState,
            String? clientZip,
            String? careNotes,
            Map<String, dynamic>? preferences,
            Map<String, dynamic>? emergencyContact,
            List<String>? medicalConditions,
            Map<String, dynamic>? riskAssessment,
            bool isActivated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDetailModel():
        return $default(
            _that.id,
            _that.clientFirstName,
            _that.clientLastName,
            _that.clientEmail,
            _that.clientPhone,
            _that.clientAddress,
            _that.clientCity,
            _that.clientState,
            _that.clientZip,
            _that.careNotes,
            _that.preferences,
            _that.emergencyContact,
            _that.medicalConditions,
            _that.riskAssessment,
            _that.isActivated);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String clientFirstName,
            String clientLastName,
            String clientEmail,
            String? clientPhone,
            String? clientAddress,
            String? clientCity,
            String? clientState,
            String? clientZip,
            String? careNotes,
            Map<String, dynamic>? preferences,
            Map<String, dynamic>? emergencyContact,
            List<String>? medicalConditions,
            Map<String, dynamic>? riskAssessment,
            bool isActivated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientDetailModel() when $default != null:
        return $default(
            _that.id,
            _that.clientFirstName,
            _that.clientLastName,
            _that.clientEmail,
            _that.clientPhone,
            _that.clientAddress,
            _that.clientCity,
            _that.clientState,
            _that.clientZip,
            _that.careNotes,
            _that.preferences,
            _that.emergencyContact,
            _that.medicalConditions,
            _that.riskAssessment,
            _that.isActivated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClientDetailModel implements ClientDetailModel {
  const _ClientDetailModel(
      {required this.id,
      required this.clientFirstName,
      required this.clientLastName,
      required this.clientEmail,
      this.clientPhone,
      this.clientAddress,
      this.clientCity,
      this.clientState,
      this.clientZip,
      this.careNotes,
      final Map<String, dynamic>? preferences,
      final Map<String, dynamic>? emergencyContact,
      final List<String>? medicalConditions,
      final Map<String, dynamic>? riskAssessment,
      this.isActivated = false})
      : _preferences = preferences,
        _emergencyContact = emergencyContact,
        _medicalConditions = medicalConditions,
        _riskAssessment = riskAssessment;
  factory _ClientDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ClientDetailModelFromJson(json);

  @override
  final String id;
  @override
  final String clientFirstName;
  @override
  final String clientLastName;
  @override
  final String clientEmail;
  @override
  final String? clientPhone;
  @override
  final String? clientAddress;
  @override
  final String? clientCity;
  @override
  final String? clientState;
  @override
  final String? clientZip;
  @override
  final String? careNotes;
  final Map<String, dynamic>? _preferences;
  @override
  Map<String, dynamic>? get preferences {
    final value = _preferences;
    if (value == null) return null;
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _emergencyContact;
  @override
  Map<String, dynamic>? get emergencyContact {
    final value = _emergencyContact;
    if (value == null) return null;
    if (_emergencyContact is EqualUnmodifiableMapView) return _emergencyContact;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _medicalConditions;
  @override
  List<String>? get medicalConditions {
    final value = _medicalConditions;
    if (value == null) return null;
    if (_medicalConditions is EqualUnmodifiableListView)
      return _medicalConditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _riskAssessment;
  @override
  Map<String, dynamic>? get riskAssessment {
    final value = _riskAssessment;
    if (value == null) return null;
    if (_riskAssessment is EqualUnmodifiableMapView) return _riskAssessment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isActivated;

  /// Create a copy of ClientDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientDetailModelCopyWith<_ClientDetailModel> get copyWith =>
      __$ClientDetailModelCopyWithImpl<_ClientDetailModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientDetailModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientDetailModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientFirstName, clientFirstName) ||
                other.clientFirstName == clientFirstName) &&
            (identical(other.clientLastName, clientLastName) ||
                other.clientLastName == clientLastName) &&
            (identical(other.clientEmail, clientEmail) ||
                other.clientEmail == clientEmail) &&
            (identical(other.clientPhone, clientPhone) ||
                other.clientPhone == clientPhone) &&
            (identical(other.clientAddress, clientAddress) ||
                other.clientAddress == clientAddress) &&
            (identical(other.clientCity, clientCity) ||
                other.clientCity == clientCity) &&
            (identical(other.clientState, clientState) ||
                other.clientState == clientState) &&
            (identical(other.clientZip, clientZip) ||
                other.clientZip == clientZip) &&
            (identical(other.careNotes, careNotes) ||
                other.careNotes == careNotes) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            const DeepCollectionEquality()
                .equals(other._emergencyContact, _emergencyContact) &&
            const DeepCollectionEquality()
                .equals(other._medicalConditions, _medicalConditions) &&
            const DeepCollectionEquality()
                .equals(other._riskAssessment, _riskAssessment) &&
            (identical(other.isActivated, isActivated) ||
                other.isActivated == isActivated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientFirstName,
      clientLastName,
      clientEmail,
      clientPhone,
      clientAddress,
      clientCity,
      clientState,
      clientZip,
      careNotes,
      const DeepCollectionEquality().hash(_preferences),
      const DeepCollectionEquality().hash(_emergencyContact),
      const DeepCollectionEquality().hash(_medicalConditions),
      const DeepCollectionEquality().hash(_riskAssessment),
      isActivated);

  @override
  String toString() {
    return 'ClientDetailModel(id: $id, clientFirstName: $clientFirstName, clientLastName: $clientLastName, clientEmail: $clientEmail, clientPhone: $clientPhone, clientAddress: $clientAddress, clientCity: $clientCity, clientState: $clientState, clientZip: $clientZip, careNotes: $careNotes, preferences: $preferences, emergencyContact: $emergencyContact, medicalConditions: $medicalConditions, riskAssessment: $riskAssessment, isActivated: $isActivated)';
  }
}

/// @nodoc
abstract mixin class _$ClientDetailModelCopyWith<$Res>
    implements $ClientDetailModelCopyWith<$Res> {
  factory _$ClientDetailModelCopyWith(
          _ClientDetailModel value, $Res Function(_ClientDetailModel) _then) =
      __$ClientDetailModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String clientFirstName,
      String clientLastName,
      String clientEmail,
      String? clientPhone,
      String? clientAddress,
      String? clientCity,
      String? clientState,
      String? clientZip,
      String? careNotes,
      Map<String, dynamic>? preferences,
      Map<String, dynamic>? emergencyContact,
      List<String>? medicalConditions,
      Map<String, dynamic>? riskAssessment,
      bool isActivated});
}

/// @nodoc
class __$ClientDetailModelCopyWithImpl<$Res>
    implements _$ClientDetailModelCopyWith<$Res> {
  __$ClientDetailModelCopyWithImpl(this._self, this._then);

  final _ClientDetailModel _self;
  final $Res Function(_ClientDetailModel) _then;

  /// Create a copy of ClientDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? clientFirstName = null,
    Object? clientLastName = null,
    Object? clientEmail = null,
    Object? clientPhone = freezed,
    Object? clientAddress = freezed,
    Object? clientCity = freezed,
    Object? clientState = freezed,
    Object? clientZip = freezed,
    Object? careNotes = freezed,
    Object? preferences = freezed,
    Object? emergencyContact = freezed,
    Object? medicalConditions = freezed,
    Object? riskAssessment = freezed,
    Object? isActivated = null,
  }) {
    return _then(_ClientDetailModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientFirstName: null == clientFirstName
          ? _self.clientFirstName
          : clientFirstName // ignore: cast_nullable_to_non_nullable
              as String,
      clientLastName: null == clientLastName
          ? _self.clientLastName
          : clientLastName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _self.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      clientPhone: freezed == clientPhone
          ? _self.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      clientAddress: freezed == clientAddress
          ? _self.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      clientCity: freezed == clientCity
          ? _self.clientCity
          : clientCity // ignore: cast_nullable_to_non_nullable
              as String?,
      clientState: freezed == clientState
          ? _self.clientState
          : clientState // ignore: cast_nullable_to_non_nullable
              as String?,
      clientZip: freezed == clientZip
          ? _self.clientZip
          : clientZip // ignore: cast_nullable_to_non_nullable
              as String?,
      careNotes: freezed == careNotes
          ? _self.careNotes
          : careNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      preferences: freezed == preferences
          ? _self._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      emergencyContact: freezed == emergencyContact
          ? _self._emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      medicalConditions: freezed == medicalConditions
          ? _self._medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      riskAssessment: freezed == riskAssessment
          ? _self._riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isActivated: null == isActivated
          ? _self.isActivated
          : isActivated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
