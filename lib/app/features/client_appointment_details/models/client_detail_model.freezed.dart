// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientDetailModel _$ClientDetailModelFromJson(Map<String, dynamic> json) {
  return _ClientDetailModel.fromJson(json);
}

/// @nodoc
mixin _$ClientDetailModel {
  String get id => throw _privateConstructorUsedError;
  String get clientFirstName => throw _privateConstructorUsedError;
  String get clientLastName => throw _privateConstructorUsedError;
  String get clientEmail => throw _privateConstructorUsedError;
  String? get clientPhone => throw _privateConstructorUsedError;
  String? get clientAddress => throw _privateConstructorUsedError;
  String? get clientCity => throw _privateConstructorUsedError;
  String? get clientState => throw _privateConstructorUsedError;
  String? get clientZip => throw _privateConstructorUsedError;
  String? get careNotes => throw _privateConstructorUsedError;
  Map<String, dynamic>? get preferences => throw _privateConstructorUsedError;
  Map<String, dynamic>? get emergencyContact =>
      throw _privateConstructorUsedError;
  List<String>? get medicalConditions => throw _privateConstructorUsedError;
  Map<String, dynamic>? get riskAssessment =>
      throw _privateConstructorUsedError;
  bool get isActivated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientDetailModelCopyWith<ClientDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientDetailModelCopyWith<$Res> {
  factory $ClientDetailModelCopyWith(
          ClientDetailModel value, $Res Function(ClientDetailModel) then) =
      _$ClientDetailModelCopyWithImpl<$Res, ClientDetailModel>;
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
class _$ClientDetailModelCopyWithImpl<$Res, $Val extends ClientDetailModel>
    implements $ClientDetailModelCopyWith<$Res> {
  _$ClientDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientFirstName: null == clientFirstName
          ? _value.clientFirstName
          : clientFirstName // ignore: cast_nullable_to_non_nullable
              as String,
      clientLastName: null == clientLastName
          ? _value.clientLastName
          : clientLastName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _value.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      clientAddress: freezed == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      clientCity: freezed == clientCity
          ? _value.clientCity
          : clientCity // ignore: cast_nullable_to_non_nullable
              as String?,
      clientState: freezed == clientState
          ? _value.clientState
          : clientState // ignore: cast_nullable_to_non_nullable
              as String?,
      clientZip: freezed == clientZip
          ? _value.clientZip
          : clientZip // ignore: cast_nullable_to_non_nullable
              as String?,
      careNotes: freezed == careNotes
          ? _value.careNotes
          : careNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      medicalConditions: freezed == medicalConditions
          ? _value.medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      riskAssessment: freezed == riskAssessment
          ? _value.riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isActivated: null == isActivated
          ? _value.isActivated
          : isActivated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientDetailModelImplCopyWith<$Res>
    implements $ClientDetailModelCopyWith<$Res> {
  factory _$$ClientDetailModelImplCopyWith(_$ClientDetailModelImpl value,
          $Res Function(_$ClientDetailModelImpl) then) =
      __$$ClientDetailModelImplCopyWithImpl<$Res>;
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
class __$$ClientDetailModelImplCopyWithImpl<$Res>
    extends _$ClientDetailModelCopyWithImpl<$Res, _$ClientDetailModelImpl>
    implements _$$ClientDetailModelImplCopyWith<$Res> {
  __$$ClientDetailModelImplCopyWithImpl(_$ClientDetailModelImpl _value,
      $Res Function(_$ClientDetailModelImpl) _then)
      : super(_value, _then);

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
    return _then(_$ClientDetailModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientFirstName: null == clientFirstName
          ? _value.clientFirstName
          : clientFirstName // ignore: cast_nullable_to_non_nullable
              as String,
      clientLastName: null == clientLastName
          ? _value.clientLastName
          : clientLastName // ignore: cast_nullable_to_non_nullable
              as String,
      clientEmail: null == clientEmail
          ? _value.clientEmail
          : clientEmail // ignore: cast_nullable_to_non_nullable
              as String,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      clientAddress: freezed == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      clientCity: freezed == clientCity
          ? _value.clientCity
          : clientCity // ignore: cast_nullable_to_non_nullable
              as String?,
      clientState: freezed == clientState
          ? _value.clientState
          : clientState // ignore: cast_nullable_to_non_nullable
              as String?,
      clientZip: freezed == clientZip
          ? _value.clientZip
          : clientZip // ignore: cast_nullable_to_non_nullable
              as String?,
      careNotes: freezed == careNotes
          ? _value.careNotes
          : careNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      preferences: freezed == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      emergencyContact: freezed == emergencyContact
          ? _value._emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      medicalConditions: freezed == medicalConditions
          ? _value._medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      riskAssessment: freezed == riskAssessment
          ? _value._riskAssessment
          : riskAssessment // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isActivated: null == isActivated
          ? _value.isActivated
          : isActivated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientDetailModelImpl implements _ClientDetailModel {
  const _$ClientDetailModelImpl(
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

  factory _$ClientDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientDetailModelImplFromJson(json);

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

  @override
  String toString() {
    return 'ClientDetailModel(id: $id, clientFirstName: $clientFirstName, clientLastName: $clientLastName, clientEmail: $clientEmail, clientPhone: $clientPhone, clientAddress: $clientAddress, clientCity: $clientCity, clientState: $clientState, clientZip: $clientZip, careNotes: $careNotes, preferences: $preferences, emergencyContact: $emergencyContact, medicalConditions: $medicalConditions, riskAssessment: $riskAssessment, isActivated: $isActivated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientDetailModelImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientDetailModelImplCopyWith<_$ClientDetailModelImpl> get copyWith =>
      __$$ClientDetailModelImplCopyWithImpl<_$ClientDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientDetailModelImplToJson(
      this,
    );
  }
}

abstract class _ClientDetailModel implements ClientDetailModel {
  const factory _ClientDetailModel(
      {required final String id,
      required final String clientFirstName,
      required final String clientLastName,
      required final String clientEmail,
      final String? clientPhone,
      final String? clientAddress,
      final String? clientCity,
      final String? clientState,
      final String? clientZip,
      final String? careNotes,
      final Map<String, dynamic>? preferences,
      final Map<String, dynamic>? emergencyContact,
      final List<String>? medicalConditions,
      final Map<String, dynamic>? riskAssessment,
      final bool isActivated}) = _$ClientDetailModelImpl;

  factory _ClientDetailModel.fromJson(Map<String, dynamic> json) =
      _$ClientDetailModelImpl.fromJson;

  @override
  String get id;
  @override
  String get clientFirstName;
  @override
  String get clientLastName;
  @override
  String get clientEmail;
  @override
  String? get clientPhone;
  @override
  String? get clientAddress;
  @override
  String? get clientCity;
  @override
  String? get clientState;
  @override
  String? get clientZip;
  @override
  String? get careNotes;
  @override
  Map<String, dynamic>? get preferences;
  @override
  Map<String, dynamic>? get emergencyContact;
  @override
  List<String>? get medicalConditions;
  @override
  Map<String, dynamic>? get riskAssessment;
  @override
  bool get isActivated;
  @override
  @JsonKey(ignore: true)
  _$$ClientDetailModelImplCopyWith<_$ClientDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
