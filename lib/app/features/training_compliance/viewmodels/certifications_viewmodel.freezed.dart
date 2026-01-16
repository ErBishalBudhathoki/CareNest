// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certifications_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CertificationsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Certification> get certifications => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CertificationsStateCopyWith<CertificationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificationsStateCopyWith<$Res> {
  factory $CertificationsStateCopyWith(
          CertificationsState value, $Res Function(CertificationsState) then) =
      _$CertificationsStateCopyWithImpl<$Res, CertificationsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<Certification> certifications,
      String? errorMessage});
}

/// @nodoc
class _$CertificationsStateCopyWithImpl<$Res, $Val extends CertificationsState>
    implements $CertificationsStateCopyWith<$Res> {
  _$CertificationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? certifications = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      certifications: null == certifications
          ? _value.certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<Certification>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CertificationsStateImplCopyWith<$Res>
    implements $CertificationsStateCopyWith<$Res> {
  factory _$$CertificationsStateImplCopyWith(_$CertificationsStateImpl value,
          $Res Function(_$CertificationsStateImpl) then) =
      __$$CertificationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<Certification> certifications,
      String? errorMessage});
}

/// @nodoc
class __$$CertificationsStateImplCopyWithImpl<$Res>
    extends _$CertificationsStateCopyWithImpl<$Res, _$CertificationsStateImpl>
    implements _$$CertificationsStateImplCopyWith<$Res> {
  __$$CertificationsStateImplCopyWithImpl(_$CertificationsStateImpl _value,
      $Res Function(_$CertificationsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? certifications = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CertificationsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      certifications: null == certifications
          ? _value._certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<Certification>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CertificationsStateImpl implements _CertificationsState {
  const _$CertificationsStateImpl(
      {this.isLoading = false,
      final List<Certification> certifications = const [],
      this.errorMessage})
      : _certifications = certifications;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Certification> _certifications;
  @override
  @JsonKey()
  List<Certification> get certifications {
    if (_certifications is EqualUnmodifiableListView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_certifications);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CertificationsState(isLoading: $isLoading, certifications: $certifications, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificationsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._certifications, _certifications) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_certifications), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificationsStateImplCopyWith<_$CertificationsStateImpl> get copyWith =>
      __$$CertificationsStateImplCopyWithImpl<_$CertificationsStateImpl>(
          this, _$identity);
}

abstract class _CertificationsState implements CertificationsState {
  const factory _CertificationsState(
      {final bool isLoading,
      final List<Certification> certifications,
      final String? errorMessage}) = _$CertificationsStateImpl;

  @override
  bool get isLoading;
  @override
  List<Certification> get certifications;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$CertificationsStateImplCopyWith<_$CertificationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
