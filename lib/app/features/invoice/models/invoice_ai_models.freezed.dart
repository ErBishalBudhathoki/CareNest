// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceAnomaly {
  String get anomalyType;
  String get severity;
  String get description;
  String get field;
  dynamic get expectedValue;
  dynamic get actualValue;
  String? get suggestion;

  /// Create a copy of InvoiceAnomaly
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoiceAnomalyCopyWith<InvoiceAnomaly> get copyWith =>
      _$InvoiceAnomalyCopyWithImpl<InvoiceAnomaly>(
          this as InvoiceAnomaly, _$identity);

  /// Serializes this InvoiceAnomaly to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvoiceAnomaly &&
            (identical(other.anomalyType, anomalyType) ||
                other.anomalyType == anomalyType) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other.expectedValue, expectedValue) &&
            const DeepCollectionEquality()
                .equals(other.actualValue, actualValue) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      anomalyType,
      severity,
      description,
      field,
      const DeepCollectionEquality().hash(expectedValue),
      const DeepCollectionEquality().hash(actualValue),
      suggestion);

  @override
  String toString() {
    return 'InvoiceAnomaly(anomalyType: $anomalyType, severity: $severity, description: $description, field: $field, expectedValue: $expectedValue, actualValue: $actualValue, suggestion: $suggestion)';
  }
}

/// @nodoc
abstract mixin class $InvoiceAnomalyCopyWith<$Res> {
  factory $InvoiceAnomalyCopyWith(
          InvoiceAnomaly value, $Res Function(InvoiceAnomaly) _then) =
      _$InvoiceAnomalyCopyWithImpl;
  @useResult
  $Res call(
      {String anomalyType,
      String severity,
      String description,
      String field,
      dynamic expectedValue,
      dynamic actualValue,
      String? suggestion});
}

/// @nodoc
class _$InvoiceAnomalyCopyWithImpl<$Res>
    implements $InvoiceAnomalyCopyWith<$Res> {
  _$InvoiceAnomalyCopyWithImpl(this._self, this._then);

  final InvoiceAnomaly _self;
  final $Res Function(InvoiceAnomaly) _then;

  /// Create a copy of InvoiceAnomaly
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anomalyType = null,
    Object? severity = null,
    Object? description = null,
    Object? field = null,
    Object? expectedValue = freezed,
    Object? actualValue = freezed,
    Object? suggestion = freezed,
  }) {
    return _then(_self.copyWith(
      anomalyType: null == anomalyType
          ? _self.anomalyType
          : anomalyType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      expectedValue: freezed == expectedValue
          ? _self.expectedValue
          : expectedValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      actualValue: freezed == actualValue
          ? _self.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      suggestion: freezed == suggestion
          ? _self.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InvoiceAnomaly].
extension InvoiceAnomalyPatterns on InvoiceAnomaly {
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
    TResult Function(_InvoiceAnomaly value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceAnomaly() when $default != null:
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
    TResult Function(_InvoiceAnomaly value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceAnomaly():
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
    TResult? Function(_InvoiceAnomaly value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceAnomaly() when $default != null:
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
            String anomalyType,
            String severity,
            String description,
            String field,
            dynamic expectedValue,
            dynamic actualValue,
            String? suggestion)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceAnomaly() when $default != null:
        return $default(
            _that.anomalyType,
            _that.severity,
            _that.description,
            _that.field,
            _that.expectedValue,
            _that.actualValue,
            _that.suggestion);
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
            String anomalyType,
            String severity,
            String description,
            String field,
            dynamic expectedValue,
            dynamic actualValue,
            String? suggestion)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceAnomaly():
        return $default(
            _that.anomalyType,
            _that.severity,
            _that.description,
            _that.field,
            _that.expectedValue,
            _that.actualValue,
            _that.suggestion);
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
            String anomalyType,
            String severity,
            String description,
            String field,
            dynamic expectedValue,
            dynamic actualValue,
            String? suggestion)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceAnomaly() when $default != null:
        return $default(
            _that.anomalyType,
            _that.severity,
            _that.description,
            _that.field,
            _that.expectedValue,
            _that.actualValue,
            _that.suggestion);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InvoiceAnomaly implements InvoiceAnomaly {
  const _InvoiceAnomaly(
      {required this.anomalyType,
      required this.severity,
      required this.description,
      required this.field,
      this.expectedValue,
      this.actualValue,
      this.suggestion});
  factory _InvoiceAnomaly.fromJson(Map<String, dynamic> json) =>
      _$InvoiceAnomalyFromJson(json);

  @override
  final String anomalyType;
  @override
  final String severity;
  @override
  final String description;
  @override
  final String field;
  @override
  final dynamic expectedValue;
  @override
  final dynamic actualValue;
  @override
  final String? suggestion;

  /// Create a copy of InvoiceAnomaly
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoiceAnomalyCopyWith<_InvoiceAnomaly> get copyWith =>
      __$InvoiceAnomalyCopyWithImpl<_InvoiceAnomaly>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoiceAnomalyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoiceAnomaly &&
            (identical(other.anomalyType, anomalyType) ||
                other.anomalyType == anomalyType) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other.expectedValue, expectedValue) &&
            const DeepCollectionEquality()
                .equals(other.actualValue, actualValue) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      anomalyType,
      severity,
      description,
      field,
      const DeepCollectionEquality().hash(expectedValue),
      const DeepCollectionEquality().hash(actualValue),
      suggestion);

  @override
  String toString() {
    return 'InvoiceAnomaly(anomalyType: $anomalyType, severity: $severity, description: $description, field: $field, expectedValue: $expectedValue, actualValue: $actualValue, suggestion: $suggestion)';
  }
}

/// @nodoc
abstract mixin class _$InvoiceAnomalyCopyWith<$Res>
    implements $InvoiceAnomalyCopyWith<$Res> {
  factory _$InvoiceAnomalyCopyWith(
          _InvoiceAnomaly value, $Res Function(_InvoiceAnomaly) _then) =
      __$InvoiceAnomalyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String anomalyType,
      String severity,
      String description,
      String field,
      dynamic expectedValue,
      dynamic actualValue,
      String? suggestion});
}

/// @nodoc
class __$InvoiceAnomalyCopyWithImpl<$Res>
    implements _$InvoiceAnomalyCopyWith<$Res> {
  __$InvoiceAnomalyCopyWithImpl(this._self, this._then);

  final _InvoiceAnomaly _self;
  final $Res Function(_InvoiceAnomaly) _then;

  /// Create a copy of InvoiceAnomaly
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? anomalyType = null,
    Object? severity = null,
    Object? description = null,
    Object? field = null,
    Object? expectedValue = freezed,
    Object? actualValue = freezed,
    Object? suggestion = freezed,
  }) {
    return _then(_InvoiceAnomaly(
      anomalyType: null == anomalyType
          ? _self.anomalyType
          : anomalyType // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _self.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      expectedValue: freezed == expectedValue
          ? _self.expectedValue
          : expectedValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      actualValue: freezed == actualValue
          ? _self.actualValue
          : actualValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
      suggestion: freezed == suggestion
          ? _self.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$InvoiceValidation {
  bool get isValid;
  List<InvoiceAnomaly> get anomalies;
  List<String> get warnings;
  double get confidenceScore;
  String? get summary;

  /// Create a copy of InvoiceValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InvoiceValidationCopyWith<InvoiceValidation> get copyWith =>
      _$InvoiceValidationCopyWithImpl<InvoiceValidation>(
          this as InvoiceValidation, _$identity);

  /// Serializes this InvoiceValidation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvoiceValidation &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            const DeepCollectionEquality().equals(other.anomalies, anomalies) &&
            const DeepCollectionEquality().equals(other.warnings, warnings) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isValid,
      const DeepCollectionEquality().hash(anomalies),
      const DeepCollectionEquality().hash(warnings),
      confidenceScore,
      summary);

  @override
  String toString() {
    return 'InvoiceValidation(isValid: $isValid, anomalies: $anomalies, warnings: $warnings, confidenceScore: $confidenceScore, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class $InvoiceValidationCopyWith<$Res> {
  factory $InvoiceValidationCopyWith(
          InvoiceValidation value, $Res Function(InvoiceValidation) _then) =
      _$InvoiceValidationCopyWithImpl;
  @useResult
  $Res call(
      {bool isValid,
      List<InvoiceAnomaly> anomalies,
      List<String> warnings,
      double confidenceScore,
      String? summary});
}

/// @nodoc
class _$InvoiceValidationCopyWithImpl<$Res>
    implements $InvoiceValidationCopyWith<$Res> {
  _$InvoiceValidationCopyWithImpl(this._self, this._then);

  final InvoiceValidation _self;
  final $Res Function(InvoiceValidation) _then;

  /// Create a copy of InvoiceValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
    Object? anomalies = null,
    Object? warnings = null,
    Object? confidenceScore = null,
    Object? summary = freezed,
  }) {
    return _then(_self.copyWith(
      isValid: null == isValid
          ? _self.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      anomalies: null == anomalies
          ? _self.anomalies
          : anomalies // ignore: cast_nullable_to_non_nullable
              as List<InvoiceAnomaly>,
      warnings: null == warnings
          ? _self.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidenceScore: null == confidenceScore
          ? _self.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [InvoiceValidation].
extension InvoiceValidationPatterns on InvoiceValidation {
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
    TResult Function(_InvoiceValidation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceValidation() when $default != null:
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
    TResult Function(_InvoiceValidation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceValidation():
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
    TResult? Function(_InvoiceValidation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceValidation() when $default != null:
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
    TResult Function(bool isValid, List<InvoiceAnomaly> anomalies,
            List<String> warnings, double confidenceScore, String? summary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InvoiceValidation() when $default != null:
        return $default(_that.isValid, _that.anomalies, _that.warnings,
            _that.confidenceScore, _that.summary);
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
    TResult Function(bool isValid, List<InvoiceAnomaly> anomalies,
            List<String> warnings, double confidenceScore, String? summary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceValidation():
        return $default(_that.isValid, _that.anomalies, _that.warnings,
            _that.confidenceScore, _that.summary);
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
    TResult? Function(bool isValid, List<InvoiceAnomaly> anomalies,
            List<String> warnings, double confidenceScore, String? summary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InvoiceValidation() when $default != null:
        return $default(_that.isValid, _that.anomalies, _that.warnings,
            _that.confidenceScore, _that.summary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _InvoiceValidation implements InvoiceValidation {
  const _InvoiceValidation(
      {required this.isValid,
      required final List<InvoiceAnomaly> anomalies,
      required final List<String> warnings,
      required this.confidenceScore,
      this.summary})
      : _anomalies = anomalies,
        _warnings = warnings;
  factory _InvoiceValidation.fromJson(Map<String, dynamic> json) =>
      _$InvoiceValidationFromJson(json);

  @override
  final bool isValid;
  final List<InvoiceAnomaly> _anomalies;
  @override
  List<InvoiceAnomaly> get anomalies {
    if (_anomalies is EqualUnmodifiableListView) return _anomalies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_anomalies);
  }

  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final double confidenceScore;
  @override
  final String? summary;

  /// Create a copy of InvoiceValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InvoiceValidationCopyWith<_InvoiceValidation> get copyWith =>
      __$InvoiceValidationCopyWithImpl<_InvoiceValidation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InvoiceValidationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InvoiceValidation &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            const DeepCollectionEquality()
                .equals(other._anomalies, _anomalies) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isValid,
      const DeepCollectionEquality().hash(_anomalies),
      const DeepCollectionEquality().hash(_warnings),
      confidenceScore,
      summary);

  @override
  String toString() {
    return 'InvoiceValidation(isValid: $isValid, anomalies: $anomalies, warnings: $warnings, confidenceScore: $confidenceScore, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class _$InvoiceValidationCopyWith<$Res>
    implements $InvoiceValidationCopyWith<$Res> {
  factory _$InvoiceValidationCopyWith(
          _InvoiceValidation value, $Res Function(_InvoiceValidation) _then) =
      __$InvoiceValidationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isValid,
      List<InvoiceAnomaly> anomalies,
      List<String> warnings,
      double confidenceScore,
      String? summary});
}

/// @nodoc
class __$InvoiceValidationCopyWithImpl<$Res>
    implements _$InvoiceValidationCopyWith<$Res> {
  __$InvoiceValidationCopyWithImpl(this._self, this._then);

  final _InvoiceValidation _self;
  final $Res Function(_InvoiceValidation) _then;

  /// Create a copy of InvoiceValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isValid = null,
    Object? anomalies = null,
    Object? warnings = null,
    Object? confidenceScore = null,
    Object? summary = freezed,
  }) {
    return _then(_InvoiceValidation(
      isValid: null == isValid
          ? _self.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      anomalies: null == anomalies
          ? _self._anomalies
          : anomalies // ignore: cast_nullable_to_non_nullable
              as List<InvoiceAnomaly>,
      warnings: null == warnings
          ? _self._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidenceScore: null == confidenceScore
          ? _self.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$PaymentPrediction {
  String get invoiceId;
  DateTime get predictedPaymentDate;
  double get probability;
  String get riskLevel;
  List<String> get factors;
  String? get recommendation;

  /// Create a copy of PaymentPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaymentPredictionCopyWith<PaymentPrediction> get copyWith =>
      _$PaymentPredictionCopyWithImpl<PaymentPrediction>(
          this as PaymentPrediction, _$identity);

  /// Serializes this PaymentPrediction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaymentPrediction &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.predictedPaymentDate, predictedPaymentDate) ||
                other.predictedPaymentDate == predictedPaymentDate) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality().equals(other.factors, factors) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceId,
      predictedPaymentDate,
      probability,
      riskLevel,
      const DeepCollectionEquality().hash(factors),
      recommendation);

  @override
  String toString() {
    return 'PaymentPrediction(invoiceId: $invoiceId, predictedPaymentDate: $predictedPaymentDate, probability: $probability, riskLevel: $riskLevel, factors: $factors, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class $PaymentPredictionCopyWith<$Res> {
  factory $PaymentPredictionCopyWith(
          PaymentPrediction value, $Res Function(PaymentPrediction) _then) =
      _$PaymentPredictionCopyWithImpl;
  @useResult
  $Res call(
      {String invoiceId,
      DateTime predictedPaymentDate,
      double probability,
      String riskLevel,
      List<String> factors,
      String? recommendation});
}

/// @nodoc
class _$PaymentPredictionCopyWithImpl<$Res>
    implements $PaymentPredictionCopyWith<$Res> {
  _$PaymentPredictionCopyWithImpl(this._self, this._then);

  final PaymentPrediction _self;
  final $Res Function(PaymentPrediction) _then;

  /// Create a copy of PaymentPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? predictedPaymentDate = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_self.copyWith(
      invoiceId: null == invoiceId
          ? _self.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      predictedPaymentDate: null == predictedPaymentDate
          ? _self.predictedPaymentDate
          : predictedPaymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _self.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaymentPrediction].
extension PaymentPredictionPatterns on PaymentPrediction {
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
    TResult Function(_PaymentPrediction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaymentPrediction() when $default != null:
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
    TResult Function(_PaymentPrediction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentPrediction():
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
    TResult? Function(_PaymentPrediction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentPrediction() when $default != null:
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
            String invoiceId,
            DateTime predictedPaymentDate,
            double probability,
            String riskLevel,
            List<String> factors,
            String? recommendation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaymentPrediction() when $default != null:
        return $default(
            _that.invoiceId,
            _that.predictedPaymentDate,
            _that.probability,
            _that.riskLevel,
            _that.factors,
            _that.recommendation);
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
            String invoiceId,
            DateTime predictedPaymentDate,
            double probability,
            String riskLevel,
            List<String> factors,
            String? recommendation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentPrediction():
        return $default(
            _that.invoiceId,
            _that.predictedPaymentDate,
            _that.probability,
            _that.riskLevel,
            _that.factors,
            _that.recommendation);
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
            String invoiceId,
            DateTime predictedPaymentDate,
            double probability,
            String riskLevel,
            List<String> factors,
            String? recommendation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentPrediction() when $default != null:
        return $default(
            _that.invoiceId,
            _that.predictedPaymentDate,
            _that.probability,
            _that.riskLevel,
            _that.factors,
            _that.recommendation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaymentPrediction implements PaymentPrediction {
  const _PaymentPrediction(
      {required this.invoiceId,
      required this.predictedPaymentDate,
      required this.probability,
      required this.riskLevel,
      required final List<String> factors,
      this.recommendation})
      : _factors = factors;
  factory _PaymentPrediction.fromJson(Map<String, dynamic> json) =>
      _$PaymentPredictionFromJson(json);

  @override
  final String invoiceId;
  @override
  final DateTime predictedPaymentDate;
  @override
  final double probability;
  @override
  final String riskLevel;
  final List<String> _factors;
  @override
  List<String> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  @override
  final String? recommendation;

  /// Create a copy of PaymentPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaymentPredictionCopyWith<_PaymentPrediction> get copyWith =>
      __$PaymentPredictionCopyWithImpl<_PaymentPrediction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaymentPredictionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaymentPrediction &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.predictedPaymentDate, predictedPaymentDate) ||
                other.predictedPaymentDate == predictedPaymentDate) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceId,
      predictedPaymentDate,
      probability,
      riskLevel,
      const DeepCollectionEquality().hash(_factors),
      recommendation);

  @override
  String toString() {
    return 'PaymentPrediction(invoiceId: $invoiceId, predictedPaymentDate: $predictedPaymentDate, probability: $probability, riskLevel: $riskLevel, factors: $factors, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class _$PaymentPredictionCopyWith<$Res>
    implements $PaymentPredictionCopyWith<$Res> {
  factory _$PaymentPredictionCopyWith(
          _PaymentPrediction value, $Res Function(_PaymentPrediction) _then) =
      __$PaymentPredictionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String invoiceId,
      DateTime predictedPaymentDate,
      double probability,
      String riskLevel,
      List<String> factors,
      String? recommendation});
}

/// @nodoc
class __$PaymentPredictionCopyWithImpl<$Res>
    implements _$PaymentPredictionCopyWith<$Res> {
  __$PaymentPredictionCopyWithImpl(this._self, this._then);

  final _PaymentPrediction _self;
  final $Res Function(_PaymentPrediction) _then;

  /// Create a copy of PaymentPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? invoiceId = null,
    Object? predictedPaymentDate = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? factors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_PaymentPrediction(
      invoiceId: null == invoiceId
          ? _self.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      predictedPaymentDate: null == predictedPaymentDate
          ? _self.predictedPaymentDate
          : predictedPaymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      probability: null == probability
          ? _self.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _self.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _self._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AutoGenerateRequest {
  String get organizationId;
  DateTime get startDate;
  DateTime get endDate;
  bool get validateBeforeGeneration;
  bool get groupByClient;

  /// Create a copy of AutoGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AutoGenerateRequestCopyWith<AutoGenerateRequest> get copyWith =>
      _$AutoGenerateRequestCopyWithImpl<AutoGenerateRequest>(
          this as AutoGenerateRequest, _$identity);

  /// Serializes this AutoGenerateRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AutoGenerateRequest &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(
                    other.validateBeforeGeneration, validateBeforeGeneration) ||
                other.validateBeforeGeneration == validateBeforeGeneration) &&
            (identical(other.groupByClient, groupByClient) ||
                other.groupByClient == groupByClient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, startDate,
      endDate, validateBeforeGeneration, groupByClient);

  @override
  String toString() {
    return 'AutoGenerateRequest(organizationId: $organizationId, startDate: $startDate, endDate: $endDate, validateBeforeGeneration: $validateBeforeGeneration, groupByClient: $groupByClient)';
  }
}

/// @nodoc
abstract mixin class $AutoGenerateRequestCopyWith<$Res> {
  factory $AutoGenerateRequestCopyWith(
          AutoGenerateRequest value, $Res Function(AutoGenerateRequest) _then) =
      _$AutoGenerateRequestCopyWithImpl;
  @useResult
  $Res call(
      {String organizationId,
      DateTime startDate,
      DateTime endDate,
      bool validateBeforeGeneration,
      bool groupByClient});
}

/// @nodoc
class _$AutoGenerateRequestCopyWithImpl<$Res>
    implements $AutoGenerateRequestCopyWith<$Res> {
  _$AutoGenerateRequestCopyWithImpl(this._self, this._then);

  final AutoGenerateRequest _self;
  final $Res Function(AutoGenerateRequest) _then;

  /// Create a copy of AutoGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? validateBeforeGeneration = null,
    Object? groupByClient = null,
  }) {
    return _then(_self.copyWith(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validateBeforeGeneration: null == validateBeforeGeneration
          ? _self.validateBeforeGeneration
          : validateBeforeGeneration // ignore: cast_nullable_to_non_nullable
              as bool,
      groupByClient: null == groupByClient
          ? _self.groupByClient
          : groupByClient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AutoGenerateRequest].
extension AutoGenerateRequestPatterns on AutoGenerateRequest {
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
    TResult Function(_AutoGenerateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateRequest() when $default != null:
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
    TResult Function(_AutoGenerateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateRequest():
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
    TResult? Function(_AutoGenerateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateRequest() when $default != null:
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
            String organizationId,
            DateTime startDate,
            DateTime endDate,
            bool validateBeforeGeneration,
            bool groupByClient)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateRequest() when $default != null:
        return $default(_that.organizationId, _that.startDate, _that.endDate,
            _that.validateBeforeGeneration, _that.groupByClient);
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
    TResult Function(String organizationId, DateTime startDate,
            DateTime endDate, bool validateBeforeGeneration, bool groupByClient)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateRequest():
        return $default(_that.organizationId, _that.startDate, _that.endDate,
            _that.validateBeforeGeneration, _that.groupByClient);
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
            String organizationId,
            DateTime startDate,
            DateTime endDate,
            bool validateBeforeGeneration,
            bool groupByClient)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateRequest() when $default != null:
        return $default(_that.organizationId, _that.startDate, _that.endDate,
            _that.validateBeforeGeneration, _that.groupByClient);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AutoGenerateRequest implements AutoGenerateRequest {
  const _AutoGenerateRequest(
      {required this.organizationId,
      required this.startDate,
      required this.endDate,
      this.validateBeforeGeneration = true,
      this.groupByClient = false});
  factory _AutoGenerateRequest.fromJson(Map<String, dynamic> json) =>
      _$AutoGenerateRequestFromJson(json);

  @override
  final String organizationId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final bool validateBeforeGeneration;
  @override
  @JsonKey()
  final bool groupByClient;

  /// Create a copy of AutoGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AutoGenerateRequestCopyWith<_AutoGenerateRequest> get copyWith =>
      __$AutoGenerateRequestCopyWithImpl<_AutoGenerateRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AutoGenerateRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AutoGenerateRequest &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(
                    other.validateBeforeGeneration, validateBeforeGeneration) ||
                other.validateBeforeGeneration == validateBeforeGeneration) &&
            (identical(other.groupByClient, groupByClient) ||
                other.groupByClient == groupByClient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, organizationId, startDate,
      endDate, validateBeforeGeneration, groupByClient);

  @override
  String toString() {
    return 'AutoGenerateRequest(organizationId: $organizationId, startDate: $startDate, endDate: $endDate, validateBeforeGeneration: $validateBeforeGeneration, groupByClient: $groupByClient)';
  }
}

/// @nodoc
abstract mixin class _$AutoGenerateRequestCopyWith<$Res>
    implements $AutoGenerateRequestCopyWith<$Res> {
  factory _$AutoGenerateRequestCopyWith(_AutoGenerateRequest value,
          $Res Function(_AutoGenerateRequest) _then) =
      __$AutoGenerateRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String organizationId,
      DateTime startDate,
      DateTime endDate,
      bool validateBeforeGeneration,
      bool groupByClient});
}

/// @nodoc
class __$AutoGenerateRequestCopyWithImpl<$Res>
    implements _$AutoGenerateRequestCopyWith<$Res> {
  __$AutoGenerateRequestCopyWithImpl(this._self, this._then);

  final _AutoGenerateRequest _self;
  final $Res Function(_AutoGenerateRequest) _then;

  /// Create a copy of AutoGenerateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? organizationId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? validateBeforeGeneration = null,
    Object? groupByClient = null,
  }) {
    return _then(_AutoGenerateRequest(
      organizationId: null == organizationId
          ? _self.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      validateBeforeGeneration: null == validateBeforeGeneration
          ? _self.validateBeforeGeneration
          : validateBeforeGeneration // ignore: cast_nullable_to_non_nullable
              as bool,
      groupByClient: null == groupByClient
          ? _self.groupByClient
          : groupByClient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$AutoGenerateResult {
  int get totalInvoices;
  int get successfulInvoices;
  int get failedInvoices;
  List<String> get invoiceIds;
  List<String> get errors;
  String? get summary;

  /// Create a copy of AutoGenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AutoGenerateResultCopyWith<AutoGenerateResult> get copyWith =>
      _$AutoGenerateResultCopyWithImpl<AutoGenerateResult>(
          this as AutoGenerateResult, _$identity);

  /// Serializes this AutoGenerateResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AutoGenerateResult &&
            (identical(other.totalInvoices, totalInvoices) ||
                other.totalInvoices == totalInvoices) &&
            (identical(other.successfulInvoices, successfulInvoices) ||
                other.successfulInvoices == successfulInvoices) &&
            (identical(other.failedInvoices, failedInvoices) ||
                other.failedInvoices == failedInvoices) &&
            const DeepCollectionEquality()
                .equals(other.invoiceIds, invoiceIds) &&
            const DeepCollectionEquality().equals(other.errors, errors) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalInvoices,
      successfulInvoices,
      failedInvoices,
      const DeepCollectionEquality().hash(invoiceIds),
      const DeepCollectionEquality().hash(errors),
      summary);

  @override
  String toString() {
    return 'AutoGenerateResult(totalInvoices: $totalInvoices, successfulInvoices: $successfulInvoices, failedInvoices: $failedInvoices, invoiceIds: $invoiceIds, errors: $errors, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class $AutoGenerateResultCopyWith<$Res> {
  factory $AutoGenerateResultCopyWith(
          AutoGenerateResult value, $Res Function(AutoGenerateResult) _then) =
      _$AutoGenerateResultCopyWithImpl;
  @useResult
  $Res call(
      {int totalInvoices,
      int successfulInvoices,
      int failedInvoices,
      List<String> invoiceIds,
      List<String> errors,
      String? summary});
}

/// @nodoc
class _$AutoGenerateResultCopyWithImpl<$Res>
    implements $AutoGenerateResultCopyWith<$Res> {
  _$AutoGenerateResultCopyWithImpl(this._self, this._then);

  final AutoGenerateResult _self;
  final $Res Function(AutoGenerateResult) _then;

  /// Create a copy of AutoGenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoices = null,
    Object? successfulInvoices = null,
    Object? failedInvoices = null,
    Object? invoiceIds = null,
    Object? errors = null,
    Object? summary = freezed,
  }) {
    return _then(_self.copyWith(
      totalInvoices: null == totalInvoices
          ? _self.totalInvoices
          : totalInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      successfulInvoices: null == successfulInvoices
          ? _self.successfulInvoices
          : successfulInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      failedInvoices: null == failedInvoices
          ? _self.failedInvoices
          : failedInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceIds: null == invoiceIds
          ? _self.invoiceIds
          : invoiceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _self.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AutoGenerateResult].
extension AutoGenerateResultPatterns on AutoGenerateResult {
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
    TResult Function(_AutoGenerateResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateResult() when $default != null:
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
    TResult Function(_AutoGenerateResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateResult():
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
    TResult? Function(_AutoGenerateResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateResult() when $default != null:
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
            int totalInvoices,
            int successfulInvoices,
            int failedInvoices,
            List<String> invoiceIds,
            List<String> errors,
            String? summary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateResult() when $default != null:
        return $default(
            _that.totalInvoices,
            _that.successfulInvoices,
            _that.failedInvoices,
            _that.invoiceIds,
            _that.errors,
            _that.summary);
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
            int totalInvoices,
            int successfulInvoices,
            int failedInvoices,
            List<String> invoiceIds,
            List<String> errors,
            String? summary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateResult():
        return $default(
            _that.totalInvoices,
            _that.successfulInvoices,
            _that.failedInvoices,
            _that.invoiceIds,
            _that.errors,
            _that.summary);
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
            int totalInvoices,
            int successfulInvoices,
            int failedInvoices,
            List<String> invoiceIds,
            List<String> errors,
            String? summary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AutoGenerateResult() when $default != null:
        return $default(
            _that.totalInvoices,
            _that.successfulInvoices,
            _that.failedInvoices,
            _that.invoiceIds,
            _that.errors,
            _that.summary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AutoGenerateResult implements AutoGenerateResult {
  const _AutoGenerateResult(
      {required this.totalInvoices,
      required this.successfulInvoices,
      required this.failedInvoices,
      required final List<String> invoiceIds,
      required final List<String> errors,
      this.summary})
      : _invoiceIds = invoiceIds,
        _errors = errors;
  factory _AutoGenerateResult.fromJson(Map<String, dynamic> json) =>
      _$AutoGenerateResultFromJson(json);

  @override
  final int totalInvoices;
  @override
  final int successfulInvoices;
  @override
  final int failedInvoices;
  final List<String> _invoiceIds;
  @override
  List<String> get invoiceIds {
    if (_invoiceIds is EqualUnmodifiableListView) return _invoiceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoiceIds);
  }

  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  final String? summary;

  /// Create a copy of AutoGenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AutoGenerateResultCopyWith<_AutoGenerateResult> get copyWith =>
      __$AutoGenerateResultCopyWithImpl<_AutoGenerateResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AutoGenerateResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AutoGenerateResult &&
            (identical(other.totalInvoices, totalInvoices) ||
                other.totalInvoices == totalInvoices) &&
            (identical(other.successfulInvoices, successfulInvoices) ||
                other.successfulInvoices == successfulInvoices) &&
            (identical(other.failedInvoices, failedInvoices) ||
                other.failedInvoices == failedInvoices) &&
            const DeepCollectionEquality()
                .equals(other._invoiceIds, _invoiceIds) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalInvoices,
      successfulInvoices,
      failedInvoices,
      const DeepCollectionEquality().hash(_invoiceIds),
      const DeepCollectionEquality().hash(_errors),
      summary);

  @override
  String toString() {
    return 'AutoGenerateResult(totalInvoices: $totalInvoices, successfulInvoices: $successfulInvoices, failedInvoices: $failedInvoices, invoiceIds: $invoiceIds, errors: $errors, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class _$AutoGenerateResultCopyWith<$Res>
    implements $AutoGenerateResultCopyWith<$Res> {
  factory _$AutoGenerateResultCopyWith(
          _AutoGenerateResult value, $Res Function(_AutoGenerateResult) _then) =
      __$AutoGenerateResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalInvoices,
      int successfulInvoices,
      int failedInvoices,
      List<String> invoiceIds,
      List<String> errors,
      String? summary});
}

/// @nodoc
class __$AutoGenerateResultCopyWithImpl<$Res>
    implements _$AutoGenerateResultCopyWith<$Res> {
  __$AutoGenerateResultCopyWithImpl(this._self, this._then);

  final _AutoGenerateResult _self;
  final $Res Function(_AutoGenerateResult) _then;

  /// Create a copy of AutoGenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalInvoices = null,
    Object? successfulInvoices = null,
    Object? failedInvoices = null,
    Object? invoiceIds = null,
    Object? errors = null,
    Object? summary = freezed,
  }) {
    return _then(_AutoGenerateResult(
      totalInvoices: null == totalInvoices
          ? _self.totalInvoices
          : totalInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      successfulInvoices: null == successfulInvoices
          ? _self.successfulInvoices
          : successfulInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      failedInvoices: null == failedInvoices
          ? _self.failedInvoices
          : failedInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceIds: null == invoiceIds
          ? _self._invoiceIds
          : invoiceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errors: null == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$SmartReminder {
  String get invoiceId;
  DateTime get suggestedSendTime;
  String get channel;
  String get message;
  double get successProbability;
  String? get reason;

  /// Create a copy of SmartReminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SmartReminderCopyWith<SmartReminder> get copyWith =>
      _$SmartReminderCopyWithImpl<SmartReminder>(
          this as SmartReminder, _$identity);

  /// Serializes this SmartReminder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SmartReminder &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.suggestedSendTime, suggestedSendTime) ||
                other.suggestedSendTime == suggestedSendTime) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceId, suggestedSendTime,
      channel, message, successProbability, reason);

  @override
  String toString() {
    return 'SmartReminder(invoiceId: $invoiceId, suggestedSendTime: $suggestedSendTime, channel: $channel, message: $message, successProbability: $successProbability, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class $SmartReminderCopyWith<$Res> {
  factory $SmartReminderCopyWith(
          SmartReminder value, $Res Function(SmartReminder) _then) =
      _$SmartReminderCopyWithImpl;
  @useResult
  $Res call(
      {String invoiceId,
      DateTime suggestedSendTime,
      String channel,
      String message,
      double successProbability,
      String? reason});
}

/// @nodoc
class _$SmartReminderCopyWithImpl<$Res>
    implements $SmartReminderCopyWith<$Res> {
  _$SmartReminderCopyWithImpl(this._self, this._then);

  final SmartReminder _self;
  final $Res Function(SmartReminder) _then;

  /// Create a copy of SmartReminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? suggestedSendTime = null,
    Object? channel = null,
    Object? message = null,
    Object? successProbability = null,
    Object? reason = freezed,
  }) {
    return _then(_self.copyWith(
      invoiceId: null == invoiceId
          ? _self.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedSendTime: null == suggestedSendTime
          ? _self.suggestedSendTime
          : suggestedSendTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _self.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SmartReminder].
extension SmartReminderPatterns on SmartReminder {
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
    TResult Function(_SmartReminder value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartReminder() when $default != null:
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
    TResult Function(_SmartReminder value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminder():
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
    TResult? Function(_SmartReminder value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminder() when $default != null:
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
            String invoiceId,
            DateTime suggestedSendTime,
            String channel,
            String message,
            double successProbability,
            String? reason)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartReminder() when $default != null:
        return $default(_that.invoiceId, _that.suggestedSendTime, _that.channel,
            _that.message, _that.successProbability, _that.reason);
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
            String invoiceId,
            DateTime suggestedSendTime,
            String channel,
            String message,
            double successProbability,
            String? reason)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminder():
        return $default(_that.invoiceId, _that.suggestedSendTime, _that.channel,
            _that.message, _that.successProbability, _that.reason);
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
            String invoiceId,
            DateTime suggestedSendTime,
            String channel,
            String message,
            double successProbability,
            String? reason)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartReminder() when $default != null:
        return $default(_that.invoiceId, _that.suggestedSendTime, _that.channel,
            _that.message, _that.successProbability, _that.reason);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SmartReminder implements SmartReminder {
  const _SmartReminder(
      {required this.invoiceId,
      required this.suggestedSendTime,
      required this.channel,
      required this.message,
      required this.successProbability,
      this.reason});
  factory _SmartReminder.fromJson(Map<String, dynamic> json) =>
      _$SmartReminderFromJson(json);

  @override
  final String invoiceId;
  @override
  final DateTime suggestedSendTime;
  @override
  final String channel;
  @override
  final String message;
  @override
  final double successProbability;
  @override
  final String? reason;

  /// Create a copy of SmartReminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SmartReminderCopyWith<_SmartReminder> get copyWith =>
      __$SmartReminderCopyWithImpl<_SmartReminder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SmartReminderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SmartReminder &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.suggestedSendTime, suggestedSendTime) ||
                other.suggestedSendTime == suggestedSendTime) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.successProbability, successProbability) ||
                other.successProbability == successProbability) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, invoiceId, suggestedSendTime,
      channel, message, successProbability, reason);

  @override
  String toString() {
    return 'SmartReminder(invoiceId: $invoiceId, suggestedSendTime: $suggestedSendTime, channel: $channel, message: $message, successProbability: $successProbability, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class _$SmartReminderCopyWith<$Res>
    implements $SmartReminderCopyWith<$Res> {
  factory _$SmartReminderCopyWith(
          _SmartReminder value, $Res Function(_SmartReminder) _then) =
      __$SmartReminderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String invoiceId,
      DateTime suggestedSendTime,
      String channel,
      String message,
      double successProbability,
      String? reason});
}

/// @nodoc
class __$SmartReminderCopyWithImpl<$Res>
    implements _$SmartReminderCopyWith<$Res> {
  __$SmartReminderCopyWithImpl(this._self, this._then);

  final _SmartReminder _self;
  final $Res Function(_SmartReminder) _then;

  /// Create a copy of SmartReminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? invoiceId = null,
    Object? suggestedSendTime = null,
    Object? channel = null,
    Object? message = null,
    Object? successProbability = null,
    Object? reason = freezed,
  }) {
    return _then(_SmartReminder(
      invoiceId: null == invoiceId
          ? _self.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedSendTime: null == suggestedSendTime
          ? _self.suggestedSendTime
          : suggestedSendTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      successProbability: null == successProbability
          ? _self.successProbability
          : successProbability // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
