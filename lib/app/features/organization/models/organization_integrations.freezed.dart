// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_integrations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntegrationConfig _$IntegrationConfigFromJson(Map<String, dynamic> json) {
  return _IntegrationConfig.fromJson(json);
}

/// @nodoc
mixin _$IntegrationConfig {
  bool get isConnected => throw _privateConstructorUsedError;
  String? get apiKey => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  DateTime? get connectedAt => throw _privateConstructorUsedError;
  DateTime? get lastSyncAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntegrationConfigCopyWith<IntegrationConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntegrationConfigCopyWith<$Res> {
  factory $IntegrationConfigCopyWith(
          IntegrationConfig value, $Res Function(IntegrationConfig) then) =
      _$IntegrationConfigCopyWithImpl<$Res, IntegrationConfig>;
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
class _$IntegrationConfigCopyWithImpl<$Res, $Val extends IntegrationConfig>
    implements $IntegrationConfigCopyWith<$Res> {
  _$IntegrationConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedAt: freezed == connectedAt
          ? _value.connectedAt
          : connectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncAt: freezed == lastSyncAt
          ? _value.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntegrationConfigImplCopyWith<$Res>
    implements $IntegrationConfigCopyWith<$Res> {
  factory _$$IntegrationConfigImplCopyWith(_$IntegrationConfigImpl value,
          $Res Function(_$IntegrationConfigImpl) then) =
      __$$IntegrationConfigImplCopyWithImpl<$Res>;
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
class __$$IntegrationConfigImplCopyWithImpl<$Res>
    extends _$IntegrationConfigCopyWithImpl<$Res, _$IntegrationConfigImpl>
    implements _$$IntegrationConfigImplCopyWith<$Res> {
  __$$IntegrationConfigImplCopyWithImpl(_$IntegrationConfigImpl _value,
      $Res Function(_$IntegrationConfigImpl) _then)
      : super(_value, _then);

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
    return _then(_$IntegrationConfigImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      connectedAt: freezed == connectedAt
          ? _value.connectedAt
          : connectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSyncAt: freezed == lastSyncAt
          ? _value.lastSyncAt
          : lastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntegrationConfigImpl implements _IntegrationConfig {
  const _$IntegrationConfigImpl(
      {this.isConnected = false,
      this.apiKey,
      this.accessToken,
      this.refreshToken,
      this.connectedAt,
      this.lastSyncAt,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$IntegrationConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntegrationConfigImplFromJson(json);

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

  @override
  String toString() {
    return 'IntegrationConfig(isConnected: $isConnected, apiKey: $apiKey, accessToken: $accessToken, refreshToken: $refreshToken, connectedAt: $connectedAt, lastSyncAt: $lastSyncAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationConfigImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationConfigImplCopyWith<_$IntegrationConfigImpl> get copyWith =>
      __$$IntegrationConfigImplCopyWithImpl<_$IntegrationConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntegrationConfigImplToJson(
      this,
    );
  }
}

abstract class _IntegrationConfig implements IntegrationConfig {
  const factory _IntegrationConfig(
      {final bool isConnected,
      final String? apiKey,
      final String? accessToken,
      final String? refreshToken,
      final DateTime? connectedAt,
      final DateTime? lastSyncAt,
      final Map<String, dynamic>? metadata}) = _$IntegrationConfigImpl;

  factory _IntegrationConfig.fromJson(Map<String, dynamic> json) =
      _$IntegrationConfigImpl.fromJson;

  @override
  bool get isConnected;
  @override
  String? get apiKey;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  DateTime? get connectedAt;
  @override
  DateTime? get lastSyncAt;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationConfigImplCopyWith<_$IntegrationConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationIntegrations _$OrganizationIntegrationsFromJson(
    Map<String, dynamic> json) {
  return _OrganizationIntegrations.fromJson(json);
}

/// @nodoc
mixin _$OrganizationIntegrations {
// Accounting
  IntegrationConfig? get xero => throw _privateConstructorUsedError;
  IntegrationConfig? get myob => throw _privateConstructorUsedError;
  IntegrationConfig? get quickbooks =>
      throw _privateConstructorUsedError; // Calendar
  IntegrationConfig? get googleCalendar => throw _privateConstructorUsedError;
  IntegrationConfig? get outlookCalendar => throw _privateConstructorUsedError;
  IntegrationConfig? get appleCalendar =>
      throw _privateConstructorUsedError; // Communication
  IntegrationConfig? get slack => throw _privateConstructorUsedError;
  IntegrationConfig? get teams => throw _privateConstructorUsedError;
  IntegrationConfig? get discord =>
      throw _privateConstructorUsedError; // Payment
  IntegrationConfig? get stripe => throw _privateConstructorUsedError;
  IntegrationConfig? get paypal => throw _privateConstructorUsedError;
  IntegrationConfig? get square => throw _privateConstructorUsedError; // CRM
  IntegrationConfig? get salesforce => throw _privateConstructorUsedError;
  IntegrationConfig? get hubspot => throw _privateConstructorUsedError; // Other
  IntegrationConfig? get zapier => throw _privateConstructorUsedError;
  IntegrationConfig? get webhooks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationIntegrationsCopyWith<OrganizationIntegrations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationIntegrationsCopyWith<$Res> {
  factory $OrganizationIntegrationsCopyWith(OrganizationIntegrations value,
          $Res Function(OrganizationIntegrations) then) =
      _$OrganizationIntegrationsCopyWithImpl<$Res, OrganizationIntegrations>;
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
class _$OrganizationIntegrationsCopyWithImpl<$Res,
        $Val extends OrganizationIntegrations>
    implements $OrganizationIntegrationsCopyWith<$Res> {
  _$OrganizationIntegrationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      xero: freezed == xero
          ? _value.xero
          : xero // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      myob: freezed == myob
          ? _value.myob
          : myob // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      quickbooks: freezed == quickbooks
          ? _value.quickbooks
          : quickbooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      googleCalendar: freezed == googleCalendar
          ? _value.googleCalendar
          : googleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      outlookCalendar: freezed == outlookCalendar
          ? _value.outlookCalendar
          : outlookCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      appleCalendar: freezed == appleCalendar
          ? _value.appleCalendar
          : appleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      slack: freezed == slack
          ? _value.slack
          : slack // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      discord: freezed == discord
          ? _value.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      stripe: freezed == stripe
          ? _value.stripe
          : stripe // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      paypal: freezed == paypal
          ? _value.paypal
          : paypal // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      square: freezed == square
          ? _value.square
          : square // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      salesforce: freezed == salesforce
          ? _value.salesforce
          : salesforce // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      hubspot: freezed == hubspot
          ? _value.hubspot
          : hubspot // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      zapier: freezed == zapier
          ? _value.zapier
          : zapier // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      webhooks: freezed == webhooks
          ? _value.webhooks
          : webhooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get xero {
    if (_value.xero == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.xero!, (value) {
      return _then(_value.copyWith(xero: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get myob {
    if (_value.myob == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.myob!, (value) {
      return _then(_value.copyWith(myob: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get quickbooks {
    if (_value.quickbooks == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.quickbooks!, (value) {
      return _then(_value.copyWith(quickbooks: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get googleCalendar {
    if (_value.googleCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.googleCalendar!, (value) {
      return _then(_value.copyWith(googleCalendar: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get outlookCalendar {
    if (_value.outlookCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.outlookCalendar!, (value) {
      return _then(_value.copyWith(outlookCalendar: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get appleCalendar {
    if (_value.appleCalendar == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.appleCalendar!, (value) {
      return _then(_value.copyWith(appleCalendar: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get slack {
    if (_value.slack == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.slack!, (value) {
      return _then(_value.copyWith(slack: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get teams {
    if (_value.teams == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.teams!, (value) {
      return _then(_value.copyWith(teams: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get discord {
    if (_value.discord == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.discord!, (value) {
      return _then(_value.copyWith(discord: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get stripe {
    if (_value.stripe == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.stripe!, (value) {
      return _then(_value.copyWith(stripe: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get paypal {
    if (_value.paypal == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.paypal!, (value) {
      return _then(_value.copyWith(paypal: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get square {
    if (_value.square == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.square!, (value) {
      return _then(_value.copyWith(square: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get salesforce {
    if (_value.salesforce == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.salesforce!, (value) {
      return _then(_value.copyWith(salesforce: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get hubspot {
    if (_value.hubspot == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.hubspot!, (value) {
      return _then(_value.copyWith(hubspot: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get zapier {
    if (_value.zapier == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.zapier!, (value) {
      return _then(_value.copyWith(zapier: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntegrationConfigCopyWith<$Res>? get webhooks {
    if (_value.webhooks == null) {
      return null;
    }

    return $IntegrationConfigCopyWith<$Res>(_value.webhooks!, (value) {
      return _then(_value.copyWith(webhooks: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationIntegrationsImplCopyWith<$Res>
    implements $OrganizationIntegrationsCopyWith<$Res> {
  factory _$$OrganizationIntegrationsImplCopyWith(
          _$OrganizationIntegrationsImpl value,
          $Res Function(_$OrganizationIntegrationsImpl) then) =
      __$$OrganizationIntegrationsImplCopyWithImpl<$Res>;
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
class __$$OrganizationIntegrationsImplCopyWithImpl<$Res>
    extends _$OrganizationIntegrationsCopyWithImpl<$Res,
        _$OrganizationIntegrationsImpl>
    implements _$$OrganizationIntegrationsImplCopyWith<$Res> {
  __$$OrganizationIntegrationsImplCopyWithImpl(
      _$OrganizationIntegrationsImpl _value,
      $Res Function(_$OrganizationIntegrationsImpl) _then)
      : super(_value, _then);

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
    return _then(_$OrganizationIntegrationsImpl(
      xero: freezed == xero
          ? _value.xero
          : xero // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      myob: freezed == myob
          ? _value.myob
          : myob // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      quickbooks: freezed == quickbooks
          ? _value.quickbooks
          : quickbooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      googleCalendar: freezed == googleCalendar
          ? _value.googleCalendar
          : googleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      outlookCalendar: freezed == outlookCalendar
          ? _value.outlookCalendar
          : outlookCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      appleCalendar: freezed == appleCalendar
          ? _value.appleCalendar
          : appleCalendar // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      slack: freezed == slack
          ? _value.slack
          : slack // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      discord: freezed == discord
          ? _value.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      stripe: freezed == stripe
          ? _value.stripe
          : stripe // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      paypal: freezed == paypal
          ? _value.paypal
          : paypal // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      square: freezed == square
          ? _value.square
          : square // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      salesforce: freezed == salesforce
          ? _value.salesforce
          : salesforce // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      hubspot: freezed == hubspot
          ? _value.hubspot
          : hubspot // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      zapier: freezed == zapier
          ? _value.zapier
          : zapier // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
      webhooks: freezed == webhooks
          ? _value.webhooks
          : webhooks // ignore: cast_nullable_to_non_nullable
              as IntegrationConfig?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationIntegrationsImpl implements _OrganizationIntegrations {
  const _$OrganizationIntegrationsImpl(
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

  factory _$OrganizationIntegrationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationIntegrationsImplFromJson(json);

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

  @override
  String toString() {
    return 'OrganizationIntegrations(xero: $xero, myob: $myob, quickbooks: $quickbooks, googleCalendar: $googleCalendar, outlookCalendar: $outlookCalendar, appleCalendar: $appleCalendar, slack: $slack, teams: $teams, discord: $discord, stripe: $stripe, paypal: $paypal, square: $square, salesforce: $salesforce, hubspot: $hubspot, zapier: $zapier, webhooks: $webhooks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationIntegrationsImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationIntegrationsImplCopyWith<_$OrganizationIntegrationsImpl>
      get copyWith => __$$OrganizationIntegrationsImplCopyWithImpl<
          _$OrganizationIntegrationsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationIntegrationsImplToJson(
      this,
    );
  }
}

abstract class _OrganizationIntegrations implements OrganizationIntegrations {
  const factory _OrganizationIntegrations(
      {final IntegrationConfig? xero,
      final IntegrationConfig? myob,
      final IntegrationConfig? quickbooks,
      final IntegrationConfig? googleCalendar,
      final IntegrationConfig? outlookCalendar,
      final IntegrationConfig? appleCalendar,
      final IntegrationConfig? slack,
      final IntegrationConfig? teams,
      final IntegrationConfig? discord,
      final IntegrationConfig? stripe,
      final IntegrationConfig? paypal,
      final IntegrationConfig? square,
      final IntegrationConfig? salesforce,
      final IntegrationConfig? hubspot,
      final IntegrationConfig? zapier,
      final IntegrationConfig? webhooks}) = _$OrganizationIntegrationsImpl;

  factory _OrganizationIntegrations.fromJson(Map<String, dynamic> json) =
      _$OrganizationIntegrationsImpl.fromJson;

  @override // Accounting
  IntegrationConfig? get xero;
  @override
  IntegrationConfig? get myob;
  @override
  IntegrationConfig? get quickbooks;
  @override // Calendar
  IntegrationConfig? get googleCalendar;
  @override
  IntegrationConfig? get outlookCalendar;
  @override
  IntegrationConfig? get appleCalendar;
  @override // Communication
  IntegrationConfig? get slack;
  @override
  IntegrationConfig? get teams;
  @override
  IntegrationConfig? get discord;
  @override // Payment
  IntegrationConfig? get stripe;
  @override
  IntegrationConfig? get paypal;
  @override
  IntegrationConfig? get square;
  @override // CRM
  IntegrationConfig? get salesforce;
  @override
  IntegrationConfig? get hubspot;
  @override // Other
  IntegrationConfig? get zapier;
  @override
  IntegrationConfig? get webhooks;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationIntegrationsImplCopyWith<_$OrganizationIntegrationsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrganizationBrandingConfig _$OrganizationBrandingConfigFromJson(
    Map<String, dynamic> json) {
  return _OrganizationBrandingConfig.fromJson(json);
}

/// @nodoc
mixin _$OrganizationBrandingConfig {
  String? get primaryColor => throw _privateConstructorUsedError;
  String? get secondaryColor => throw _privateConstructorUsedError;
  String? get accentColor => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get faviconUrl => throw _privateConstructorUsedError;
  String? get fontFamily => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customStyles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationBrandingConfigCopyWith<OrganizationBrandingConfig>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationBrandingConfigCopyWith<$Res> {
  factory $OrganizationBrandingConfigCopyWith(OrganizationBrandingConfig value,
          $Res Function(OrganizationBrandingConfig) then) =
      _$OrganizationBrandingConfigCopyWithImpl<$Res,
          OrganizationBrandingConfig>;
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
class _$OrganizationBrandingConfigCopyWithImpl<$Res,
        $Val extends OrganizationBrandingConfig>
    implements $OrganizationBrandingConfigCopyWith<$Res> {
  _$OrganizationBrandingConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryColor: freezed == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      accentColor: freezed == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      faviconUrl: freezed == faviconUrl
          ? _value.faviconUrl
          : faviconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      customStyles: freezed == customStyles
          ? _value.customStyles
          : customStyles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrganizationBrandingConfigImplCopyWith<$Res>
    implements $OrganizationBrandingConfigCopyWith<$Res> {
  factory _$$OrganizationBrandingConfigImplCopyWith(
          _$OrganizationBrandingConfigImpl value,
          $Res Function(_$OrganizationBrandingConfigImpl) then) =
      __$$OrganizationBrandingConfigImplCopyWithImpl<$Res>;
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
class __$$OrganizationBrandingConfigImplCopyWithImpl<$Res>
    extends _$OrganizationBrandingConfigCopyWithImpl<$Res,
        _$OrganizationBrandingConfigImpl>
    implements _$$OrganizationBrandingConfigImplCopyWith<$Res> {
  __$$OrganizationBrandingConfigImplCopyWithImpl(
      _$OrganizationBrandingConfigImpl _value,
      $Res Function(_$OrganizationBrandingConfigImpl) _then)
      : super(_value, _then);

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
    return _then(_$OrganizationBrandingConfigImpl(
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryColor: freezed == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      accentColor: freezed == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      faviconUrl: freezed == faviconUrl
          ? _value.faviconUrl
          : faviconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      customStyles: freezed == customStyles
          ? _value._customStyles
          : customStyles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationBrandingConfigImpl implements _OrganizationBrandingConfig {
  const _$OrganizationBrandingConfigImpl(
      {this.primaryColor,
      this.secondaryColor,
      this.accentColor,
      this.logoUrl,
      this.faviconUrl,
      this.fontFamily,
      final Map<String, dynamic>? customStyles})
      : _customStyles = customStyles;

  factory _$OrganizationBrandingConfigImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OrganizationBrandingConfigImplFromJson(json);

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

  @override
  String toString() {
    return 'OrganizationBrandingConfig(primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, logoUrl: $logoUrl, faviconUrl: $faviconUrl, fontFamily: $fontFamily, customStyles: $customStyles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationBrandingConfigImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationBrandingConfigImplCopyWith<_$OrganizationBrandingConfigImpl>
      get copyWith => __$$OrganizationBrandingConfigImplCopyWithImpl<
          _$OrganizationBrandingConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationBrandingConfigImplToJson(
      this,
    );
  }
}

abstract class _OrganizationBrandingConfig
    implements OrganizationBrandingConfig {
  const factory _OrganizationBrandingConfig(
          {final String? primaryColor,
          final String? secondaryColor,
          final String? accentColor,
          final String? logoUrl,
          final String? faviconUrl,
          final String? fontFamily,
          final Map<String, dynamic>? customStyles}) =
      _$OrganizationBrandingConfigImpl;

  factory _OrganizationBrandingConfig.fromJson(Map<String, dynamic> json) =
      _$OrganizationBrandingConfigImpl.fromJson;

  @override
  String? get primaryColor;
  @override
  String? get secondaryColor;
  @override
  String? get accentColor;
  @override
  String? get logoUrl;
  @override
  String? get faviconUrl;
  @override
  String? get fontFamily;
  @override
  Map<String, dynamic>? get customStyles;
  @override
  @JsonKey(ignore: true)
  _$$OrganizationBrandingConfigImplCopyWith<_$OrganizationBrandingConfigImpl>
      get copyWith => throw _privateConstructorUsedError;
}
