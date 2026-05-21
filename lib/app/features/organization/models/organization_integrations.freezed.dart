// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_integrations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntegrationConfig {
  bool get isConnected;
  String? get apiKey;
  String? get accessToken;
  String? get refreshToken;
  DateTime? get connectedAt;
  DateTime? get lastSyncAt;
  Map<String, dynamic>? get metadata;

  /// Create a copy of IntegrationConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<IntegrationConfig> get copyWith =>
      _$IntegrationConfigCopyWithImpl<IntegrationConfig>(
          this as IntegrationConfig, _$identity);

  /// Serializes this IntegrationConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IntegrationConfig &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.connectedAt, connectedAt) ||
                other.connectedAt == connectedAt) &&
            (identical(other.lastSyncAt, lastSyncAt) ||
                other.lastSyncAt == lastSyncAt) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isConnected,
      apiKey,
      accessToken,
      refreshToken,
      connectedAt,
      lastSyncAt,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'IntegrationConfig(isConnected: $isConnected, apiKey: $apiKey, accessToken: $accessToken, refreshToken: $refreshToken, connectedAt: $connectedAt, lastSyncAt: $lastSyncAt, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $IntegrationConfigCopyWith<$Res> {
  factory $IntegrationConfigCopyWith(
          IntegrationConfig value, $Res Function(IntegrationConfig) _then) =
      _$IntegrationConfigCopyWithImpl;
  @useResult
  $Res call(
      {bool isConnected,
      String? apiKey,
      String? accessToken,
      String? refreshToken,
      DateTime? connectedAt,
      DateTime? lastSyncAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$IntegrationConfigCopyWithImpl<$Res>
    implements $IntegrationConfigCopyWith<$Res> {
  _$IntegrationConfigCopyWithImpl(this._self, this._then);

  final IntegrationConfig _self;
  final $Res Function(IntegrationConfig) _then;

  /// Create a copy of IntegrationConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? apiKey = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? connectedAt = freezed,
    Object? lastSyncAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_self.copyWith(
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      apiKey: freezed == apiKey
          ? _self.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedAt: freezed == connectedAt
          ? _self.connectedAt
          : connectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncAt: freezed == lastSyncAt
          ? _self.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [IntegrationConfig].
extension IntegrationConfigPatterns on IntegrationConfig {
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
    TResult Function(_IntegrationConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IntegrationConfig() when $default != null:
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
    TResult Function(_IntegrationConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntegrationConfig():
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
    TResult? Function(_IntegrationConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntegrationConfig() when $default != null:
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
            bool isConnected,
            String? apiKey,
            String? accessToken,
            String? refreshToken,
            DateTime? connectedAt,
            DateTime? lastSyncAt,
            Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IntegrationConfig() when $default != null:
        return $default(
            _that.isConnected,
            _that.apiKey,
            _that.accessToken,
            _that.refreshToken,
            _that.connectedAt,
            _that.lastSyncAt,
            _that.metadata);
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
            bool isConnected,
            String? apiKey,
            String? accessToken,
            String? refreshToken,
            DateTime? connectedAt,
            DateTime? lastSyncAt,
            Map<String, dynamic>? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntegrationConfig():
        return $default(
            _that.isConnected,
            _that.apiKey,
            _that.accessToken,
            _that.refreshToken,
            _that.connectedAt,
            _that.lastSyncAt,
            _that.metadata);
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
            bool isConnected,
            String? apiKey,
            String? accessToken,
            String? refreshToken,
            DateTime? connectedAt,
            DateTime? lastSyncAt,
            Map<String, dynamic>? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntegrationConfig() when $default != null:
        return $default(
            _that.isConnected,
            _that.apiKey,
            _that.accessToken,
            _that.refreshToken,
            _that.connectedAt,
            _that.lastSyncAt,
            _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _IntegrationConfig implements IntegrationConfig {
  const _IntegrationConfig(
      {this.isConnected = false,
      this.apiKey,
      this.accessToken,
      this.refreshToken,
      this.connectedAt,
      this.lastSyncAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;
  factory _IntegrationConfig.fromJson(Map<String, dynamic> json) =>
      _$IntegrationConfigFromJson(json);

  @override
  @JsonKey()
  final bool isConnected;
  @override
  final String? apiKey;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final DateTime? connectedAt;
  @override
  final DateTime? lastSyncAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of IntegrationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IntegrationConfigCopyWith<_IntegrationConfig> get copyWith =>
      __$IntegrationConfigCopyWithImpl<_IntegrationConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IntegrationConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IntegrationConfig &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.connectedAt, connectedAt) ||
                other.connectedAt == connectedAt) &&
            (identical(other.lastSyncAt, lastSyncAt) ||
                other.lastSyncAt == lastSyncAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isConnected,
      apiKey,
      accessToken,
      refreshToken,
      connectedAt,
      lastSyncAt,
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'IntegrationConfig(isConnected: $isConnected, apiKey: $apiKey, accessToken: $accessToken, refreshToken: $refreshToken, connectedAt: $connectedAt, lastSyncAt: $lastSyncAt, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$IntegrationConfigCopyWith<$Res>
    implements $IntegrationConfigCopyWith<$Res> {
  factory _$IntegrationConfigCopyWith(
          _IntegrationConfig value, $Res Function(_IntegrationConfig) _then) =
      __$IntegrationConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isConnected,
      String? apiKey,
      String? accessToken,
      String? refreshToken,
      DateTime? connectedAt,
      DateTime? lastSyncAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$IntegrationConfigCopyWithImpl<$Res>
    implements _$IntegrationConfigCopyWith<$Res> {
  __$IntegrationConfigCopyWithImpl(this._self, this._then);

  final _IntegrationConfig _self;
  final $Res Function(_IntegrationConfig) _then;

  /// Create a copy of IntegrationConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isConnected = null,
    Object? apiKey = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? connectedAt = freezed,
    Object? lastSyncAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_IntegrationConfig(
      isConnected: null == isConnected
          ? _self.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      apiKey: freezed == apiKey
          ? _self.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedAt: freezed == connectedAt
          ? _self.connectedAt
          : connectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncAt: freezed == lastSyncAt
          ? _self.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$OrganizationIntegrations {
// Accounting
  IntegrationConfig? get xero;
  IntegrationConfig? get myob;
  IntegrationConfig? get quickbooks; // Calendar
  IntegrationConfig? get googleCalendar;
  IntegrationConfig? get outlookCalendar;
  IntegrationConfig? get appleCalendar; // Communication
  IntegrationConfig? get slack;
  IntegrationConfig? get teams;
  IntegrationConfig? get discord; // Payment
  IntegrationConfig? get stripe;
  IntegrationConfig? get paypal;
  IntegrationConfig? get square; // CRM
  IntegrationConfig? get salesforce;
  IntegrationConfig? get hubspot; // Other
  IntegrationConfig? get zapier;
  IntegrationConfig? get webhooks;

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrganizationIntegrationsCopyWith<OrganizationIntegrations> get copyWith =>
      _$OrganizationIntegrationsCopyWithImpl<OrganizationIntegrations>(
          this as OrganizationIntegrations, _$identity);

  /// Serializes this OrganizationIntegrations to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrganizationIntegrations &&
            (identical(other.xero, xero) || other.xero == xero) &&
            (identical(other.myob, myob) || other.myob == myob) &&
            (identical(other.quickbooks, quickbooks) ||
                other.quickbooks == quickbooks) &&
            (identical(other.googleCalendar, googleCalendar) ||
                other.googleCalendar == googleCalendar) &&
            (identical(other.outlookCalendar, outlookCalendar) ||
                other.outlookCalendar == outlookCalendar) &&
            (identical(other.appleCalendar, appleCalendar) ||
                other.appleCalendar == appleCalendar) &&
            (identical(other.slack, slack) || other.slack == slack) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.discord, discord) || other.discord == discord) &&
            (identical(other.stripe, stripe) || other.stripe == stripe) &&
            (identical(other.paypal, paypal) || other.paypal == paypal) &&
            (identical(other.square, square) || other.square == square) &&
            (identical(other.salesforce, salesforce) ||
                other.salesforce == salesforce) &&
            (identical(other.hubspot, hubspot) || other.hubspot == hubspot) &&
            (identical(other.zapier, zapier) || other.zapier == zapier) &&
            (identical(other.webhooks, webhooks) ||
                other.webhooks == webhooks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      xero,
      myob,
      quickbooks,
      googleCalendar,
      outlookCalendar,
      appleCalendar,
      slack,
      teams,
      discord,
      stripe,
      paypal,
      square,
      salesforce,
      hubspot,
      zapier,
      webhooks);

  @override
  String toString() {
    return 'OrganizationIntegrations(xero: $xero, myob: $myob, quickbooks: $quickbooks, googleCalendar: $googleCalendar, outlookCalendar: $outlookCalendar, appleCalendar: $appleCalendar, slack: $slack, teams: $teams, discord: $discord, stripe: $stripe, paypal: $paypal, square: $square, salesforce: $salesforce, hubspot: $hubspot, zapier: $zapier, webhooks: $webhooks)';
  }
}

/// @nodoc
abstract mixin class $OrganizationIntegrationsCopyWith<$Res> {
  factory $OrganizationIntegrationsCopyWith(OrganizationIntegrations value,
          $Res Function(OrganizationIntegrations) _then) =
      _$OrganizationIntegrationsCopyWithImpl;
  @useResult
  $Res call(
      {IntegrationConfig? xero,
      IntegrationConfig? myob,
      IntegrationConfig? quickbooks,
      IntegrationConfig? googleCalendar,
      IntegrationConfig? outlookCalendar,
      IntegrationConfig? appleCalendar,
      IntegrationConfig? slack,
      IntegrationConfig? teams,
      IntegrationConfig? discord,
      IntegrationConfig? stripe,
      IntegrationConfig? paypal,
      IntegrationConfig? square,
      IntegrationConfig? salesforce,
      IntegrationConfig? hubspot,
      IntegrationConfig? zapier,
      IntegrationConfig? webhooks});

  $IntegrationConfigCopyWith<$Res>? get xero;
  $IntegrationConfigCopyWith<$Res>? get myob;
  $IntegrationConfigCopyWith<$Res>? get quickbooks;
  $IntegrationConfigCopyWith<$Res>? get googleCalendar;
  $IntegrationConfigCopyWith<$Res>? get outlookCalendar;
  $IntegrationConfigCopyWith<$Res>? get appleCalendar;
  $IntegrationConfigCopyWith<$Res>? get slack;
  $IntegrationConfigCopyWith<$Res>? get teams;
  $IntegrationConfigCopyWith<$Res>? get discord;
  $IntegrationConfigCopyWith<$Res>? get stripe;
  $IntegrationConfigCopyWith<$Res>? get paypal;
  $IntegrationConfigCopyWith<$Res>? get square;
  $IntegrationConfigCopyWith<$Res>? get salesforce;
  $IntegrationConfigCopyWith<$Res>? get hubspot;
  $IntegrationConfigCopyWith<$Res>? get zapier;
  $IntegrationConfigCopyWith<$Res>? get webhooks;
}

/// @nodoc
class _$OrganizationIntegrationsCopyWithImpl<$Res>
    implements $OrganizationIntegrationsCopyWith<$Res> {
  _$OrganizationIntegrationsCopyWithImpl(this._self, this._then);

  final OrganizationIntegrations _self;
  final $Res Function(OrganizationIntegrations) _then;

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xero = freezed,
    Object? myob = freezed,
    Object? quickbooks = freezed,
    Object? googleCalendar = freezed,
    Object? outlookCalendar = freezed,
    Object? appleCalendar = freezed,
    Object? slack = freezed,
    Object? teams = freezed,
    Object? discord = freezed,
    Object? stripe = freezed,
    Object? paypal = freezed,
    Object? square = freezed,
    Object? salesforce = freezed,
    Object? hubspot = freezed,
    Object? zapier = freezed,
    Object? webhooks = freezed,
  }) {
    return _then(_self.copyWith(
      xero: freezed == xero
          ? _self.xero
          : xero // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      myob: freezed == myob
          ? _self.myob
          : myob // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      quickbooks: freezed == quickbooks
          ? _self.quickbooks
          : quickbooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      googleCalendar: freezed == googleCalendar
          ? _self.googleCalendar
          : googleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      outlookCalendar: freezed == outlookCalendar
          ? _self.outlookCalendar
          : outlookCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      appleCalendar: freezed == appleCalendar
          ? _self.appleCalendar
          : appleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      slack: freezed == slack
          ? _self.slack
          : slack // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      teams: freezed == teams
          ? _self.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      discord: freezed == discord
          ? _self.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      stripe: freezed == stripe
          ? _self.stripe
          : stripe // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      paypal: freezed == paypal
          ? _self.paypal
          : paypal // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      square: freezed == square
          ? _self.square
          : square // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      salesforce: freezed == salesforce
          ? _self.salesforce
          : salesforce // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      hubspot: freezed == hubspot
          ? _self.hubspot
          : hubspot // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      zapier: freezed == zapier
          ? _self.zapier
          : zapier // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      webhooks: freezed == webhooks
          ? _self.webhooks
          : webhooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
    ));
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get xero {
    if (_self.xero == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.xero!, (value) {
      return _then(_self.copyWith(xero: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get myob {
    if (_self.myob == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.myob!, (value) {
      return _then(_self.copyWith(myob: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get quickbooks {
    if (_self.quickbooks == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.quickbooks!, (value) {
      return _then(_self.copyWith(quickbooks: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get googleCalendar {
    if (_self.googleCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.googleCalendar!, (value) {
      return _then(_self.copyWith(googleCalendar: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get outlookCalendar {
    if (_self.outlookCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.outlookCalendar!, (value) {
      return _then(_self.copyWith(outlookCalendar: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get appleCalendar {
    if (_self.appleCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.appleCalendar!, (value) {
      return _then(_self.copyWith(appleCalendar: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get slack {
    if (_self.slack == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.slack!, (value) {
      return _then(_self.copyWith(slack: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get teams {
    if (_self.teams == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.teams!, (value) {
      return _then(_self.copyWith(teams: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get discord {
    if (_self.discord == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.discord!, (value) {
      return _then(_self.copyWith(discord: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get stripe {
    if (_self.stripe == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.stripe!, (value) {
      return _then(_self.copyWith(stripe: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get paypal {
    if (_self.paypal == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.paypal!, (value) {
      return _then(_self.copyWith(paypal: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get square {
    if (_self.square == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.square!, (value) {
      return _then(_self.copyWith(square: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get salesforce {
    if (_self.salesforce == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.salesforce!, (value) {
      return _then(_self.copyWith(salesforce: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get hubspot {
    if (_self.hubspot == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.hubspot!, (value) {
      return _then(_self.copyWith(hubspot: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get zapier {
    if (_self.zapier == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.zapier!, (value) {
      return _then(_self.copyWith(zapier: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get webhooks {
    if (_self.webhooks == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.webhooks!, (value) {
      return _then(_self.copyWith(webhooks: value));
    });
  }
}

/// Adds pattern-matching-related methods to [OrganizationIntegrations].
extension OrganizationIntegrationsPatterns on OrganizationIntegrations {
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
    TResult Function(_OrganizationIntegrations value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrganizationIntegrations() when $default != null:
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
    TResult Function(_OrganizationIntegrations value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationIntegrations():
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
    TResult? Function(_OrganizationIntegrations value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationIntegrations() when $default != null:
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
            IntegrationConfig? xero,
            IntegrationConfig? myob,
            IntegrationConfig? quickbooks,
            IntegrationConfig? googleCalendar,
            IntegrationConfig? outlookCalendar,
            IntegrationConfig? appleCalendar,
            IntegrationConfig? slack,
            IntegrationConfig? teams,
            IntegrationConfig? discord,
            IntegrationConfig? stripe,
            IntegrationConfig? paypal,
            IntegrationConfig? square,
            IntegrationConfig? salesforce,
            IntegrationConfig? hubspot,
            IntegrationConfig? zapier,
            IntegrationConfig? webhooks)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrganizationIntegrations() when $default != null:
        return $default(
            _that.xero,
            _that.myob,
            _that.quickbooks,
            _that.googleCalendar,
            _that.outlookCalendar,
            _that.appleCalendar,
            _that.slack,
            _that.teams,
            _that.discord,
            _that.stripe,
            _that.paypal,
            _that.square,
            _that.salesforce,
            _that.hubspot,
            _that.zapier,
            _that.webhooks);
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
            IntegrationConfig? xero,
            IntegrationConfig? myob,
            IntegrationConfig? quickbooks,
            IntegrationConfig? googleCalendar,
            IntegrationConfig? outlookCalendar,
            IntegrationConfig? appleCalendar,
            IntegrationConfig? slack,
            IntegrationConfig? teams,
            IntegrationConfig? discord,
            IntegrationConfig? stripe,
            IntegrationConfig? paypal,
            IntegrationConfig? square,
            IntegrationConfig? salesforce,
            IntegrationConfig? hubspot,
            IntegrationConfig? zapier,
            IntegrationConfig? webhooks)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationIntegrations():
        return $default(
            _that.xero,
            _that.myob,
            _that.quickbooks,
            _that.googleCalendar,
            _that.outlookCalendar,
            _that.appleCalendar,
            _that.slack,
            _that.teams,
            _that.discord,
            _that.stripe,
            _that.paypal,
            _that.square,
            _that.salesforce,
            _that.hubspot,
            _that.zapier,
            _that.webhooks);
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
            IntegrationConfig? xero,
            IntegrationConfig? myob,
            IntegrationConfig? quickbooks,
            IntegrationConfig? googleCalendar,
            IntegrationConfig? outlookCalendar,
            IntegrationConfig? appleCalendar,
            IntegrationConfig? slack,
            IntegrationConfig? teams,
            IntegrationConfig? discord,
            IntegrationConfig? stripe,
            IntegrationConfig? paypal,
            IntegrationConfig? square,
            IntegrationConfig? salesforce,
            IntegrationConfig? hubspot,
            IntegrationConfig? zapier,
            IntegrationConfig? webhooks)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationIntegrations() when $default != null:
        return $default(
            _that.xero,
            _that.myob,
            _that.quickbooks,
            _that.googleCalendar,
            _that.outlookCalendar,
            _that.appleCalendar,
            _that.slack,
            _that.teams,
            _that.discord,
            _that.stripe,
            _that.paypal,
            _that.square,
            _that.salesforce,
            _that.hubspot,
            _that.zapier,
            _that.webhooks);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OrganizationIntegrations implements OrganizationIntegrations {
  const _OrganizationIntegrations(
      {this.xero,
      this.myob,
      this.quickbooks,
      this.googleCalendar,
      this.outlookCalendar,
      this.appleCalendar,
      this.slack,
      this.teams,
      this.discord,
      this.stripe,
      this.paypal,
      this.square,
      this.salesforce,
      this.hubspot,
      this.zapier,
      this.webhooks});
  factory _OrganizationIntegrations.fromJson(Map<String, dynamic> json) =>
      _$OrganizationIntegrationsFromJson(json);

// Accounting
  @override
  final IntegrationConfig? xero;
  @override
  final IntegrationConfig? myob;
  @override
  final IntegrationConfig? quickbooks;
// Calendar
  @override
  final IntegrationConfig? googleCalendar;
  @override
  final IntegrationConfig? outlookCalendar;
  @override
  final IntegrationConfig? appleCalendar;
// Communication
  @override
  final IntegrationConfig? slack;
  @override
  final IntegrationConfig? teams;
  @override
  final IntegrationConfig? discord;
// Payment
  @override
  final IntegrationConfig? stripe;
  @override
  final IntegrationConfig? paypal;
  @override
  final IntegrationConfig? square;
// CRM
  @override
  final IntegrationConfig? salesforce;
  @override
  final IntegrationConfig? hubspot;
// Other
  @override
  final IntegrationConfig? zapier;
  @override
  final IntegrationConfig? webhooks;

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrganizationIntegrationsCopyWith<_OrganizationIntegrations> get copyWith =>
      __$OrganizationIntegrationsCopyWithImpl<_OrganizationIntegrations>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrganizationIntegrationsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrganizationIntegrations &&
            (identical(other.xero, xero) || other.xero == xero) &&
            (identical(other.myob, myob) || other.myob == myob) &&
            (identical(other.quickbooks, quickbooks) ||
                other.quickbooks == quickbooks) &&
            (identical(other.googleCalendar, googleCalendar) ||
                other.googleCalendar == googleCalendar) &&
            (identical(other.outlookCalendar, outlookCalendar) ||
                other.outlookCalendar == outlookCalendar) &&
            (identical(other.appleCalendar, appleCalendar) ||
                other.appleCalendar == appleCalendar) &&
            (identical(other.slack, slack) || other.slack == slack) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.discord, discord) || other.discord == discord) &&
            (identical(other.stripe, stripe) || other.stripe == stripe) &&
            (identical(other.paypal, paypal) || other.paypal == paypal) &&
            (identical(other.square, square) || other.square == square) &&
            (identical(other.salesforce, salesforce) ||
                other.salesforce == salesforce) &&
            (identical(other.hubspot, hubspot) || other.hubspot == hubspot) &&
            (identical(other.zapier, zapier) || other.zapier == zapier) &&
            (identical(other.webhooks, webhooks) ||
                other.webhooks == webhooks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      xero,
      myob,
      quickbooks,
      googleCalendar,
      outlookCalendar,
      appleCalendar,
      slack,
      teams,
      discord,
      stripe,
      paypal,
      square,
      salesforce,
      hubspot,
      zapier,
      webhooks);

  @override
  String toString() {
    return 'OrganizationIntegrations(xero: $xero, myob: $myob, quickbooks: $quickbooks, googleCalendar: $googleCalendar, outlookCalendar: $outlookCalendar, appleCalendar: $appleCalendar, slack: $slack, teams: $teams, discord: $discord, stripe: $stripe, paypal: $paypal, square: $square, salesforce: $salesforce, hubspot: $hubspot, zapier: $zapier, webhooks: $webhooks)';
  }
}

/// @nodoc
abstract mixin class _$OrganizationIntegrationsCopyWith<$Res>
    implements $OrganizationIntegrationsCopyWith<$Res> {
  factory _$OrganizationIntegrationsCopyWith(_OrganizationIntegrations value,
          $Res Function(_OrganizationIntegrations) _then) =
      __$OrganizationIntegrationsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {IntegrationConfig? xero,
      IntegrationConfig? myob,
      IntegrationConfig? quickbooks,
      IntegrationConfig? googleCalendar,
      IntegrationConfig? outlookCalendar,
      IntegrationConfig? appleCalendar,
      IntegrationConfig? slack,
      IntegrationConfig? teams,
      IntegrationConfig? discord,
      IntegrationConfig? stripe,
      IntegrationConfig? paypal,
      IntegrationConfig? square,
      IntegrationConfig? salesforce,
      IntegrationConfig? hubspot,
      IntegrationConfig? zapier,
      IntegrationConfig? webhooks});

  @override
  $IntegrationConfigCopyWith<$Res>? get xero;
  @override
  $IntegrationConfigCopyWith<$Res>? get myob;
  @override
  $IntegrationConfigCopyWith<$Res>? get quickbooks;
  @override
  $IntegrationConfigCopyWith<$Res>? get googleCalendar;
  @override
  $IntegrationConfigCopyWith<$Res>? get outlookCalendar;
  @override
  $IntegrationConfigCopyWith<$Res>? get appleCalendar;
  @override
  $IntegrationConfigCopyWith<$Res>? get slack;
  @override
  $IntegrationConfigCopyWith<$Res>? get teams;
  @override
  $IntegrationConfigCopyWith<$Res>? get discord;
  @override
  $IntegrationConfigCopyWith<$Res>? get stripe;
  @override
  $IntegrationConfigCopyWith<$Res>? get paypal;
  @override
  $IntegrationConfigCopyWith<$Res>? get square;
  @override
  $IntegrationConfigCopyWith<$Res>? get salesforce;
  @override
  $IntegrationConfigCopyWith<$Res>? get hubspot;
  @override
  $IntegrationConfigCopyWith<$Res>? get zapier;
  @override
  $IntegrationConfigCopyWith<$Res>? get webhooks;
}

/// @nodoc
class __$OrganizationIntegrationsCopyWithImpl<$Res>
    implements _$OrganizationIntegrationsCopyWith<$Res> {
  __$OrganizationIntegrationsCopyWithImpl(this._self, this._then);

  final _OrganizationIntegrations _self;
  final $Res Function(_OrganizationIntegrations) _then;

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? xero = freezed,
    Object? myob = freezed,
    Object? quickbooks = freezed,
    Object? googleCalendar = freezed,
    Object? outlookCalendar = freezed,
    Object? appleCalendar = freezed,
    Object? slack = freezed,
    Object? teams = freezed,
    Object? discord = freezed,
    Object? stripe = freezed,
    Object? paypal = freezed,
    Object? square = freezed,
    Object? salesforce = freezed,
    Object? hubspot = freezed,
    Object? zapier = freezed,
    Object? webhooks = freezed,
  }) {
    return _then(_OrganizationIntegrations(
      xero: freezed == xero
          ? _self.xero
          : xero // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      myob: freezed == myob
          ? _self.myob
          : myob // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      quickbooks: freezed == quickbooks
          ? _self.quickbooks
          : quickbooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      googleCalendar: freezed == googleCalendar
          ? _self.googleCalendar
          : googleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      outlookCalendar: freezed == outlookCalendar
          ? _self.outlookCalendar
          : outlookCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      appleCalendar: freezed == appleCalendar
          ? _self.appleCalendar
          : appleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      slack: freezed == slack
          ? _self.slack
          : slack // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      teams: freezed == teams
          ? _self.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      discord: freezed == discord
          ? _self.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      stripe: freezed == stripe
          ? _self.stripe
          : stripe // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      paypal: freezed == paypal
          ? _self.paypal
          : paypal // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      square: freezed == square
          ? _self.square
          : square // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      salesforce: freezed == salesforce
          ? _self.salesforce
          : salesforce // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      hubspot: freezed == hubspot
          ? _self.hubspot
          : hubspot // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      zapier: freezed == zapier
          ? _self.zapier
          : zapier // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      webhooks: freezed == webhooks
          ? _self.webhooks
          : webhooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
    ));
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get xero {
    if (_self.xero == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.xero!, (value) {
      return _then(_self.copyWith(xero: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get myob {
    if (_self.myob == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.myob!, (value) {
      return _then(_self.copyWith(myob: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get quickbooks {
    if (_self.quickbooks == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.quickbooks!, (value) {
      return _then(_self.copyWith(quickbooks: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get googleCalendar {
    if (_self.googleCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.googleCalendar!, (value) {
      return _then(_self.copyWith(googleCalendar: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get outlookCalendar {
    if (_self.outlookCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.outlookCalendar!, (value) {
      return _then(_self.copyWith(outlookCalendar: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get appleCalendar {
    if (_self.appleCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.appleCalendar!, (value) {
      return _then(_self.copyWith(appleCalendar: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get slack {
    if (_self.slack == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.slack!, (value) {
      return _then(_self.copyWith(slack: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get teams {
    if (_self.teams == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.teams!, (value) {
      return _then(_self.copyWith(teams: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get discord {
    if (_self.discord == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.discord!, (value) {
      return _then(_self.copyWith(discord: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get stripe {
    if (_self.stripe == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.stripe!, (value) {
      return _then(_self.copyWith(stripe: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get paypal {
    if (_self.paypal == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.paypal!, (value) {
      return _then(_self.copyWith(paypal: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get square {
    if (_self.square == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.square!, (value) {
      return _then(_self.copyWith(square: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get salesforce {
    if (_self.salesforce == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.salesforce!, (value) {
      return _then(_self.copyWith(salesforce: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get hubspot {
    if (_self.hubspot == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.hubspot!, (value) {
      return _then(_self.copyWith(hubspot: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get zapier {
    if (_self.zapier == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.zapier!, (value) {
      return _then(_self.copyWith(zapier: value));
    });
  }

  /// Create a copy of OrganizationIntegrations
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get webhooks {
    if (_self.webhooks == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_self.webhooks!, (value) {
      return _then(_self.copyWith(webhooks: value));
    });
  }
}

/// @nodoc
mixin _$OrganizationBrandingConfig {
  String? get primaryColor;
  String? get secondaryColor;
  String? get accentColor;
  String? get logoUrl;
  String? get faviconUrl;
  String? get fontFamily;
  Map<String, dynamic>? get customStyles;

  /// Create a copy of OrganizationBrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrganizationBrandingConfigCopyWith<OrganizationBrandingConfig>
      get copyWith =>
          _$OrganizationBrandingConfigCopyWithImpl<OrganizationBrandingConfig>(
              this as OrganizationBrandingConfig, _$identity);

  /// Serializes this OrganizationBrandingConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrganizationBrandingConfig &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.faviconUrl, faviconUrl) ||
                other.faviconUrl == faviconUrl) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            const DeepCollectionEquality()
                .equals(other.customStyles, customStyles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      primaryColor,
      secondaryColor,
      accentColor,
      logoUrl,
      faviconUrl,
      fontFamily,
      const DeepCollectionEquality().hash(customStyles));

  @override
  String toString() {
    return 'OrganizationBrandingConfig(primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, logoUrl: $logoUrl, faviconUrl: $faviconUrl, fontFamily: $fontFamily, customStyles: $customStyles)';
  }
}

/// @nodoc
abstract mixin class $OrganizationBrandingConfigCopyWith<$Res> {
  factory $OrganizationBrandingConfigCopyWith(OrganizationBrandingConfig value,
          $Res Function(OrganizationBrandingConfig) _then) =
      _$OrganizationBrandingConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? primaryColor,
      String? secondaryColor,
      String? accentColor,
      String? logoUrl,
      String? faviconUrl,
      String? fontFamily,
      Map<String, dynamic>? customStyles});
}

/// @nodoc
class _$OrganizationBrandingConfigCopyWithImpl<$Res>
    implements $OrganizationBrandingConfigCopyWith<$Res> {
  _$OrganizationBrandingConfigCopyWithImpl(this._self, this._then);

  final OrganizationBrandingConfig _self;
  final $Res Function(OrganizationBrandingConfig) _then;

  /// Create a copy of OrganizationBrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
    Object? accentColor = freezed,
    Object? logoUrl = freezed,
    Object? faviconUrl = freezed,
    Object? fontFamily = freezed,
    Object? customStyles = freezed,
  }) {
    return _then(_self.copyWith(
      primaryColor: freezed == primaryColor
          ? _self.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryColor: freezed == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      accentColor: freezed == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      faviconUrl: freezed == faviconUrl
          ? _self.faviconUrl
          : faviconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fontFamily: freezed == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      customStyles: freezed == customStyles
          ? _self.customStyles
          : customStyles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OrganizationBrandingConfig].
extension OrganizationBrandingConfigPatterns on OrganizationBrandingConfig {
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
    TResult Function(_OrganizationBrandingConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrganizationBrandingConfig() when $default != null:
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
    TResult Function(_OrganizationBrandingConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationBrandingConfig():
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
    TResult? Function(_OrganizationBrandingConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationBrandingConfig() when $default != null:
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
            String? primaryColor,
            String? secondaryColor,
            String? accentColor,
            String? logoUrl,
            String? faviconUrl,
            String? fontFamily,
            Map<String, dynamic>? customStyles)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrganizationBrandingConfig() when $default != null:
        return $default(
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.logoUrl,
            _that.faviconUrl,
            _that.fontFamily,
            _that.customStyles);
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
            String? primaryColor,
            String? secondaryColor,
            String? accentColor,
            String? logoUrl,
            String? faviconUrl,
            String? fontFamily,
            Map<String, dynamic>? customStyles)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationBrandingConfig():
        return $default(
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.logoUrl,
            _that.faviconUrl,
            _that.fontFamily,
            _that.customStyles);
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
            String? primaryColor,
            String? secondaryColor,
            String? accentColor,
            String? logoUrl,
            String? faviconUrl,
            String? fontFamily,
            Map<String, dynamic>? customStyles)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrganizationBrandingConfig() when $default != null:
        return $default(
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.logoUrl,
            _that.faviconUrl,
            _that.fontFamily,
            _that.customStyles);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OrganizationBrandingConfig implements OrganizationBrandingConfig {
  const _OrganizationBrandingConfig(
      {this.primaryColor,
      this.secondaryColor,
      this.accentColor,
      this.logoUrl,
      this.faviconUrl,
      this.fontFamily,
      final Map<String, dynamic>? customStyles})
      : _customStyles = customStyles;
  factory _OrganizationBrandingConfig.fromJson(Map<String, dynamic> json) =>
      _$OrganizationBrandingConfigFromJson(json);

  @override
  final String? primaryColor;
  @override
  final String? secondaryColor;
  @override
  final String? accentColor;
  @override
  final String? logoUrl;
  @override
  final String? faviconUrl;
  @override
  final String? fontFamily;
  final Map<String, dynamic>? _customStyles;
  @override
  Map<String, dynamic>? get customStyles {
    final value = _customStyles;
    if (value == null) return null;
    if (_customStyles is EqualUnmodifiableMapView) return _customStyles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of OrganizationBrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrganizationBrandingConfigCopyWith<_OrganizationBrandingConfig>
      get copyWith => __$OrganizationBrandingConfigCopyWithImpl<
          _OrganizationBrandingConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrganizationBrandingConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrganizationBrandingConfig &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.faviconUrl, faviconUrl) ||
                other.faviconUrl == faviconUrl) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            const DeepCollectionEquality()
                .equals(other._customStyles, _customStyles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      primaryColor,
      secondaryColor,
      accentColor,
      logoUrl,
      faviconUrl,
      fontFamily,
      const DeepCollectionEquality().hash(_customStyles));

  @override
  String toString() {
    return 'OrganizationBrandingConfig(primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, logoUrl: $logoUrl, faviconUrl: $faviconUrl, fontFamily: $fontFamily, customStyles: $customStyles)';
  }
}

/// @nodoc
abstract mixin class _$OrganizationBrandingConfigCopyWith<$Res>
    implements $OrganizationBrandingConfigCopyWith<$Res> {
  factory _$OrganizationBrandingConfigCopyWith(
          _OrganizationBrandingConfig value,
          $Res Function(_OrganizationBrandingConfig) _then) =
      __$OrganizationBrandingConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? primaryColor,
      String? secondaryColor,
      String? accentColor,
      String? logoUrl,
      String? faviconUrl,
      String? fontFamily,
      Map<String, dynamic>? customStyles});
}

/// @nodoc
class __$OrganizationBrandingConfigCopyWithImpl<$Res>
    implements _$OrganizationBrandingConfigCopyWith<$Res> {
  __$OrganizationBrandingConfigCopyWithImpl(this._self, this._then);

  final _OrganizationBrandingConfig _self;
  final $Res Function(_OrganizationBrandingConfig) _then;

  /// Create a copy of OrganizationBrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
    Object? accentColor = freezed,
    Object? logoUrl = freezed,
    Object? faviconUrl = freezed,
    Object? fontFamily = freezed,
    Object? customStyles = freezed,
  }) {
    return _then(_OrganizationBrandingConfig(
      primaryColor: freezed == primaryColor
          ? _self.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryColor: freezed == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      accentColor: freezed == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      faviconUrl: freezed == faviconUrl
          ? _self.faviconUrl
          : faviconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fontFamily: freezed == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      customStyles: freezed == customStyles
          ? _self._customStyles
          : customStyles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
