// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_matching_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkerMatch _$WorkerMatchFromJson(Map<String, dynamic> json) {
  return _WorkerMatch.fromJson(json);
}

/// @nodoc
mixin _$WorkerMatch {
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get workerEmail => throw _privateConstructorUsedError;
  double get matchScore => throw _privateConstructorUsedError;
  String get matchLevel => throw _privateConstructorUsedError;
  List<MatchFactor> get factors => throw _privateConstructorUsedError;
  List<String> get conflicts => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  double? get travelTime => throw _privateConstructorUsedError;
  double? get noShowProbability => throw _privateConstructorUsedError;
  Map<String, dynamic>? get workerProfile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkerMatchCopyWith<WorkerMatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkerMatchCopyWith<$Res> {
  factory $WorkerMatchCopyWith(
          WorkerMatch value, $Res Function(WorkerMatch) then) =
      _$WorkerMatchCopyWithImpl<$Res, WorkerMatch>;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String workerEmail,
      double matchScore,
      String matchLevel,
      List<MatchFactor> factors,
      List<String> conflicts,
      double? distance,
      double? travelTime,
      double? noShowProbability,
      Map<String, dynamic>? workerProfile});
}

/// @nodoc
class _$WorkerMatchCopyWithImpl<$Res, $Val extends WorkerMatch>
    implements $WorkerMatchCopyWith<$Res> {
  _$WorkerMatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? matchScore = null,
    Object? matchLevel = null,
    Object? factors = null,
    Object? conflicts = null,
    Object? distance = freezed,
    Object? travelTime = freezed,
    Object? noShowProbability = freezed,
    Object? workerProfile = freezed,
  }) {
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      workerEmail: null == workerEmail
          ? _value.workerEmail
          : workerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      matchLevel: null == matchLevel
          ? _value.matchLevel
          : matchLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value.factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<MatchFactor>,
      conflicts: null == conflicts
          ? _value.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTime: freezed == travelTime
          ? _value.travelTime
          : travelTime // ignore: cast_nullable_to_non_nullable
              as double?,
      noShowProbability: freezed == noShowProbability
          ? _value.noShowProbability
          : noShowProbability // ignore: cast_nullable_to_non_nullable
              as double?,
      workerProfile: freezed == workerProfile
          ? _value.workerProfile
          : workerProfile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkerMatchImplCopyWith<$Res>
    implements $WorkerMatchCopyWith<$Res> {
  factory _$$WorkerMatchImplCopyWith(
          _$WorkerMatchImpl value, $Res Function(_$WorkerMatchImpl) then) =
      __$$WorkerMatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      String workerEmail,
      double matchScore,
      String matchLevel,
      List<MatchFactor> factors,
      List<String> conflicts,
      double? distance,
      double? travelTime,
      double? noShowProbability,
      Map<String, dynamic>? workerProfile});
}

/// @nodoc
class __$$WorkerMatchImplCopyWithImpl<$Res>
    extends _$WorkerMatchCopyWithImpl<$Res, _$WorkerMatchImpl>
    implements _$$WorkerMatchImplCopyWith<$Res> {
  __$$WorkerMatchImplCopyWithImpl(
      _$WorkerMatchImpl _value, $Res Function(_$WorkerMatchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? workerEmail = null,
    Object? matchScore = null,
    Object? matchLevel = null,
    Object? factors = null,
    Object? conflicts = null,
    Object? distance = freezed,
    Object? travelTime = freezed,
    Object? noShowProbability = freezed,
    Object? workerProfile = freezed,
  }) {
    return _then(_$WorkerMatchImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      workerEmail: null == workerEmail
          ? _value.workerEmail
          : workerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      matchLevel: null == matchLevel
          ? _value.matchLevel
          : matchLevel // ignore: cast_nullable_to_non_nullable
              as String,
      factors: null == factors
          ? _value._factors
          : factors // ignore: cast_nullable_to_non_nullable
              as List<MatchFactor>,
      conflicts: null == conflicts
          ? _value._conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTime: freezed == travelTime
          ? _value.travelTime
          : travelTime // ignore: cast_nullable_to_non_nullable
              as double?,
      noShowProbability: freezed == noShowProbability
          ? _value.noShowProbability
          : noShowProbability // ignore: cast_nullable_to_non_nullable
              as double?,
      workerProfile: freezed == workerProfile
          ? _value._workerProfile
          : workerProfile // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkerMatchImpl implements _WorkerMatch {
  const _$WorkerMatchImpl(
      {required this.workerId,
      required this.workerName,
      required this.workerEmail,
      required this.matchScore,
      required this.matchLevel,
      required final List<MatchFactor> factors,
      required final List<String> conflicts,
      this.distance,
      this.travelTime,
      this.noShowProbability,
      final Map<String, dynamic>? workerProfile})
      : _factors = factors,
        _conflicts = conflicts,
        _workerProfile = workerProfile;

  factory _$WorkerMatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkerMatchImplFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String workerEmail;
  @override
  final double matchScore;
  @override
  final String matchLevel;
  final List<MatchFactor> _factors;
  @override
  List<MatchFactor> get factors {
    if (_factors is EqualUnmodifiableListView) return _factors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factors);
  }

  final List<String> _conflicts;
  @override
  List<String> get conflicts {
    if (_conflicts is EqualUnmodifiableListView) return _conflicts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflicts);
  }

  @override
  final double? distance;
  @override
  final double? travelTime;
  @override
  final double? noShowProbability;
  final Map<String, dynamic>? _workerProfile;
  @override
  Map<String, dynamic>? get workerProfile {
    final value = _workerProfile;
    if (value == null) return null;
    if (_workerProfile is EqualUnmodifiableMapView) return _workerProfile;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WorkerMatch(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, matchScore: $matchScore, matchLevel: $matchLevel, factors: $factors, conflicts: $conflicts, distance: $distance, travelTime: $travelTime, noShowProbability: $noShowProbability, workerProfile: $workerProfile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkerMatchImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.workerEmail, workerEmail) ||
                other.workerEmail == workerEmail) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.matchLevel, matchLevel) ||
                other.matchLevel == matchLevel) &&
            const DeepCollectionEquality().equals(other._factors, _factors) &&
            const DeepCollectionEquality()
                .equals(other._conflicts, _conflicts) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.travelTime, travelTime) ||
                other.travelTime == travelTime) &&
            (identical(other.noShowProbability, noShowProbability) ||
                other.noShowProbability == noShowProbability) &&
            const DeepCollectionEquality()
                .equals(other._workerProfile, _workerProfile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      workerEmail,
      matchScore,
      matchLevel,
      const DeepCollectionEquality().hash(_factors),
      const DeepCollectionEquality().hash(_conflicts),
      distance,
      travelTime,
      noShowProbability,
      const DeepCollectionEquality().hash(_workerProfile));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkerMatchImplCopyWith<_$WorkerMatchImpl> get copyWith =>
      __$$WorkerMatchImplCopyWithImpl<_$WorkerMatchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkerMatchImplToJson(
      this,
    );
  }
}

abstract class _WorkerMatch implements WorkerMatch {
  const factory _WorkerMatch(
      {required final String workerId,
      required final String workerName,
      required final String workerEmail,
      required final double matchScore,
      required final String matchLevel,
      required final List<MatchFactor> factors,
      required final List<String> conflicts,
      final double? distance,
      final double? travelTime,
      final double? noShowProbability,
      final Map<String, dynamic>? workerProfile}) = _$WorkerMatchImpl;

  factory _WorkerMatch.fromJson(Map<String, dynamic> json) =
      _$WorkerMatchImpl.fromJson;

  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get workerEmail;
  @override
  double get matchScore;
  @override
  String get matchLevel;
  @override
  List<MatchFactor> get factors;
  @override
  List<String> get conflicts;
  @override
  double? get distance;
  @override
  double? get travelTime;
  @override
  double? get noShowProbability;
  @override
  Map<String, dynamic>? get workerProfile;
  @override
  @JsonKey(ignore: true)
  _$$WorkerMatchImplCopyWith<_$WorkerMatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchFactor _$MatchFactorFromJson(Map<String, dynamic> json) {
  return _MatchFactor.fromJson(json);
}

/// @nodoc
mixin _$MatchFactor {
  String get factor => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchFactorCopyWith<MatchFactor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchFactorCopyWith<$Res> {
  factory $MatchFactorCopyWith(
          MatchFactor value, $Res Function(MatchFactor) then) =
      _$MatchFactorCopyWithImpl<$Res, MatchFactor>;
  @useResult
  $Res call({String factor, double score, double weight, String description});
}

/// @nodoc
class _$MatchFactorCopyWithImpl<$Res, $Val extends MatchFactor>
    implements $MatchFactorCopyWith<$Res> {
  _$MatchFactorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? score = null,
    Object? weight = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchFactorImplCopyWith<$Res>
    implements $MatchFactorCopyWith<$Res> {
  factory _$$MatchFactorImplCopyWith(
          _$MatchFactorImpl value, $Res Function(_$MatchFactorImpl) then) =
      __$$MatchFactorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String factor, double score, double weight, String description});
}

/// @nodoc
class __$$MatchFactorImplCopyWithImpl<$Res>
    extends _$MatchFactorCopyWithImpl<$Res, _$MatchFactorImpl>
    implements _$$MatchFactorImplCopyWith<$Res> {
  __$$MatchFactorImplCopyWithImpl(
      _$MatchFactorImpl _value, $Res Function(_$MatchFactorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? factor = null,
    Object? score = null,
    Object? weight = null,
    Object? description = null,
  }) {
    return _then(_$MatchFactorImpl(
      factor: null == factor
          ? _value.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchFactorImpl implements _MatchFactor {
  const _$MatchFactorImpl(
      {required this.factor,
      required this.score,
      required this.weight,
      required this.description});

  factory _$MatchFactorImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchFactorImplFromJson(json);

  @override
  final String factor;
  @override
  final double score;
  @override
  final double weight;
  @override
  final String description;

  @override
  String toString() {
    return 'MatchFactor(factor: $factor, score: $score, weight: $weight, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchFactorImpl &&
            (identical(other.factor, factor) || other.factor == factor) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, factor, score, weight, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchFactorImplCopyWith<_$MatchFactorImpl> get copyWith =>
      __$$MatchFactorImplCopyWithImpl<_$MatchFactorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchFactorImplToJson(
      this,
    );
  }
}

abstract class _MatchFactor implements MatchFactor {
  const factory _MatchFactor(
      {required final String factor,
      required final double score,
      required final double weight,
      required final String description}) = _$MatchFactorImpl;

  factory _MatchFactor.fromJson(Map<String, dynamic> json) =
      _$MatchFactorImpl.fromJson;

  @override
  String get factor;
  @override
  double get score;
  @override
  double get weight;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$MatchFactorImplCopyWith<_$MatchFactorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftRecommendation _$ShiftRecommendationFromJson(Map<String, dynamic> json) {
  return _ShiftRecommendation.fromJson(json);
}

/// @nodoc
mixin _$ShiftRecommendation {
  String get shiftId => throw _privateConstructorUsedError;
  DateTime get shiftDate => throw _privateConstructorUsedError;
  String get shiftTime => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;
  String get clientName => throw _privateConstructorUsedError;
  List<WorkerMatch> get recommendedWorkers =>
      throw _privateConstructorUsedError;
  String? get currentAssignment => throw _privateConstructorUsedError;
  bool? get isUrgent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftRecommendationCopyWith<ShiftRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftRecommendationCopyWith<$Res> {
  factory $ShiftRecommendationCopyWith(
          ShiftRecommendation value, $Res Function(ShiftRecommendation) then) =
      _$ShiftRecommendationCopyWithImpl<$Res, ShiftRecommendation>;
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      String clientName,
      List<WorkerMatch> recommendedWorkers,
      String? currentAssignment,
      bool? isUrgent});
}

/// @nodoc
class _$ShiftRecommendationCopyWithImpl<$Res, $Val extends ShiftRecommendation>
    implements $ShiftRecommendationCopyWith<$Res> {
  _$ShiftRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? clientName = null,
    Object? recommendedWorkers = null,
    Object? currentAssignment = freezed,
    Object? isUrgent = freezed,
  }) {
    return _then(_value.copyWith(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedWorkers: null == recommendedWorkers
          ? _value.recommendedWorkers
          : recommendedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerMatch>,
      currentAssignment: freezed == currentAssignment
          ? _value.currentAssignment
          : currentAssignment // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: freezed == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftRecommendationImplCopyWith<$Res>
    implements $ShiftRecommendationCopyWith<$Res> {
  factory _$$ShiftRecommendationImplCopyWith(_$ShiftRecommendationImpl value,
          $Res Function(_$ShiftRecommendationImpl) then) =
      __$$ShiftRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String shiftId,
      DateTime shiftDate,
      String shiftTime,
      String service,
      String clientName,
      List<WorkerMatch> recommendedWorkers,
      String? currentAssignment,
      bool? isUrgent});
}

/// @nodoc
class __$$ShiftRecommendationImplCopyWithImpl<$Res>
    extends _$ShiftRecommendationCopyWithImpl<$Res, _$ShiftRecommendationImpl>
    implements _$$ShiftRecommendationImplCopyWith<$Res> {
  __$$ShiftRecommendationImplCopyWithImpl(_$ShiftRecommendationImpl _value,
      $Res Function(_$ShiftRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? shiftDate = null,
    Object? shiftTime = null,
    Object? service = null,
    Object? clientName = null,
    Object? recommendedWorkers = null,
    Object? currentAssignment = freezed,
    Object? isUrgent = freezed,
  }) {
    return _then(_$ShiftRecommendationImpl(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftDate: null == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shiftTime: null == shiftTime
          ? _value.shiftTime
          : shiftTime // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedWorkers: null == recommendedWorkers
          ? _value._recommendedWorkers
          : recommendedWorkers // ignore: cast_nullable_to_non_nullable
              as List<WorkerMatch>,
      currentAssignment: freezed == currentAssignment
          ? _value.currentAssignment
          : currentAssignment // ignore: cast_nullable_to_non_nullable
              as String?,
      isUrgent: freezed == isUrgent
          ? _value.isUrgent
          : isUrgent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftRecommendationImpl implements _ShiftRecommendation {
  const _$ShiftRecommendationImpl(
      {required this.shiftId,
      required this.shiftDate,
      required this.shiftTime,
      required this.service,
      required this.clientName,
      required final List<WorkerMatch> recommendedWorkers,
      this.currentAssignment,
      this.isUrgent})
      : _recommendedWorkers = recommendedWorkers;

  factory _$ShiftRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftRecommendationImplFromJson(json);

  @override
  final String shiftId;
  @override
  final DateTime shiftDate;
  @override
  final String shiftTime;
  @override
  final String service;
  @override
  final String clientName;
  final List<WorkerMatch> _recommendedWorkers;
  @override
  List<WorkerMatch> get recommendedWorkers {
    if (_recommendedWorkers is EqualUnmodifiableListView)
      return _recommendedWorkers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedWorkers);
  }

  @override
  final String? currentAssignment;
  @override
  final bool? isUrgent;

  @override
  String toString() {
    return 'ShiftRecommendation(shiftId: $shiftId, shiftDate: $shiftDate, shiftTime: $shiftTime, service: $service, clientName: $clientName, recommendedWorkers: $recommendedWorkers, currentAssignment: $currentAssignment, isUrgent: $isUrgent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftRecommendationImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.shiftTime, shiftTime) ||
                other.shiftTime == shiftTime) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality()
                .equals(other._recommendedWorkers, _recommendedWorkers) &&
            (identical(other.currentAssignment, currentAssignment) ||
                other.currentAssignment == currentAssignment) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      shiftId,
      shiftDate,
      shiftTime,
      service,
      clientName,
      const DeepCollectionEquality().hash(_recommendedWorkers),
      currentAssignment,
      isUrgent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftRecommendationImplCopyWith<_$ShiftRecommendationImpl> get copyWith =>
      __$$ShiftRecommendationImplCopyWithImpl<_$ShiftRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftRecommendationImplToJson(
      this,
    );
  }
}

abstract class _ShiftRecommendation implements ShiftRecommendation {
  const factory _ShiftRecommendation(
      {required final String shiftId,
      required final DateTime shiftDate,
      required final String shiftTime,
      required final String service,
      required final String clientName,
      required final List<WorkerMatch> recommendedWorkers,
      final String? currentAssignment,
      final bool? isUrgent}) = _$ShiftRecommendationImpl;

  factory _ShiftRecommendation.fromJson(Map<String, dynamic> json) =
      _$ShiftRecommendationImpl.fromJson;

  @override
  String get shiftId;
  @override
  DateTime get shiftDate;
  @override
  String get shiftTime;
  @override
  String get service;
  @override
  String get clientName;
  @override
  List<WorkerMatch> get recommendedWorkers;
  @override
  String? get currentAssignment;
  @override
  bool? get isUrgent;
  @override
  @JsonKey(ignore: true)
  _$$ShiftRecommendationImplCopyWith<_$ShiftRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AutoFillRequest _$AutoFillRequestFromJson(Map<String, dynamic> json) {
  return _AutoFillRequest.fromJson(json);
}

/// @nodoc
mixin _$AutoFillRequest {
  String get organizationId => throw _privateConstructorUsedError;
  List<String> get shiftIds => throw _privateConstructorUsedError;
  MatchingCriteria get criteria => throw _privateConstructorUsedError;
  bool? get allowConflicts => throw _privateConstructorUsedError;
  bool? get optimizeRoute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutoFillRequestCopyWith<AutoFillRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoFillRequestCopyWith<$Res> {
  factory $AutoFillRequestCopyWith(
          AutoFillRequest value, $Res Function(AutoFillRequest) then) =
      _$AutoFillRequestCopyWithImpl<$Res, AutoFillRequest>;
  @useResult
  $Res call(
      {String organizationId,
      List<String> shiftIds,
      MatchingCriteria criteria,
      bool? allowConflicts,
      bool? optimizeRoute});

  $MatchingCriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class _$AutoFillRequestCopyWithImpl<$Res, $Val extends AutoFillRequest>
    implements $AutoFillRequestCopyWith<$Res> {
  _$AutoFillRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? shiftIds = null,
    Object? criteria = null,
    Object? allowConflicts = freezed,
    Object? optimizeRoute = freezed,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftIds: null == shiftIds
          ? _value.shiftIds
          : shiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as MatchingCriteria,
      allowConflicts: freezed == allowConflicts
          ? _value.allowConflicts
          : allowConflicts // ignore: cast_nullable_to_non_nullable
              as bool?,
      optimizeRoute: freezed == optimizeRoute
          ? _value.optimizeRoute
          : optimizeRoute // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchingCriteriaCopyWith<$Res> get criteria {
    return $MatchingCriteriaCopyWith<$Res>(_value.criteria, (value) {
      return _then(_value.copyWith(criteria: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AutoFillRequestImplCopyWith<$Res>
    implements $AutoFillRequestCopyWith<$Res> {
  factory _$$AutoFillRequestImplCopyWith(_$AutoFillRequestImpl value,
          $Res Function(_$AutoFillRequestImpl) then) =
      __$$AutoFillRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      List<String> shiftIds,
      MatchingCriteria criteria,
      bool? allowConflicts,
      bool? optimizeRoute});

  @override
  $MatchingCriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class __$$AutoFillRequestImplCopyWithImpl<$Res>
    extends _$AutoFillRequestCopyWithImpl<$Res, _$AutoFillRequestImpl>
    implements _$$AutoFillRequestImplCopyWith<$Res> {
  __$$AutoFillRequestImplCopyWithImpl(
      _$AutoFillRequestImpl _value, $Res Function(_$AutoFillRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? shiftIds = null,
    Object? criteria = null,
    Object? allowConflicts = freezed,
    Object? optimizeRoute = freezed,
  }) {
    return _then(_$AutoFillRequestImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftIds: null == shiftIds
          ? _value._shiftIds
          : shiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as MatchingCriteria,
      allowConflicts: freezed == allowConflicts
          ? _value.allowConflicts
          : allowConflicts // ignore: cast_nullable_to_non_nullable
              as bool?,
      optimizeRoute: freezed == optimizeRoute
          ? _value.optimizeRoute
          : optimizeRoute // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoFillRequestImpl implements _AutoFillRequest {
  const _$AutoFillRequestImpl(
      {required this.organizationId,
      required final List<String> shiftIds,
      required this.criteria,
      this.allowConflicts,
      this.optimizeRoute})
      : _shiftIds = shiftIds;

  factory _$AutoFillRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutoFillRequestImplFromJson(json);

  @override
  final String organizationId;
  final List<String> _shiftIds;
  @override
  List<String> get shiftIds {
    if (_shiftIds is EqualUnmodifiableListView) return _shiftIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shiftIds);
  }

  @override
  final MatchingCriteria criteria;
  @override
  final bool? allowConflicts;
  @override
  final bool? optimizeRoute;

  @override
  String toString() {
    return 'AutoFillRequest(organizationId: $organizationId, shiftIds: $shiftIds, criteria: $criteria, allowConflicts: $allowConflicts, optimizeRoute: $optimizeRoute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoFillRequestImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality().equals(other._shiftIds, _shiftIds) &&
            (identical(other.criteria, criteria) ||
                other.criteria == criteria) &&
            (identical(other.allowConflicts, allowConflicts) ||
                other.allowConflicts == allowConflicts) &&
            (identical(other.optimizeRoute, optimizeRoute) ||
                other.optimizeRoute == optimizeRoute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      const DeepCollectionEquality().hash(_shiftIds),
      criteria,
      allowConflicts,
      optimizeRoute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoFillRequestImplCopyWith<_$AutoFillRequestImpl> get copyWith =>
      __$$AutoFillRequestImplCopyWithImpl<_$AutoFillRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoFillRequestImplToJson(
      this,
    );
  }
}

abstract class _AutoFillRequest implements AutoFillRequest {
  const factory _AutoFillRequest(
      {required final String organizationId,
      required final List<String> shiftIds,
      required final MatchingCriteria criteria,
      final bool? allowConflicts,
      final bool? optimizeRoute}) = _$AutoFillRequestImpl;

  factory _AutoFillRequest.fromJson(Map<String, dynamic> json) =
      _$AutoFillRequestImpl.fromJson;

  @override
  String get organizationId;
  @override
  List<String> get shiftIds;
  @override
  MatchingCriteria get criteria;
  @override
  bool? get allowConflicts;
  @override
  bool? get optimizeRoute;
  @override
  @JsonKey(ignore: true)
  _$$AutoFillRequestImplCopyWith<_$AutoFillRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AutoFillResult _$AutoFillResultFromJson(Map<String, dynamic> json) {
  return _AutoFillResult.fromJson(json);
}

/// @nodoc
mixin _$AutoFillResult {
  int get totalShifts => throw _privateConstructorUsedError;
  int get filledShifts => throw _privateConstructorUsedError;
  int get unfilledShifts => throw _privateConstructorUsedError;
  List<ShiftAssignment> get assignments => throw _privateConstructorUsedError;
  List<String> get unfilledShiftIds => throw _privateConstructorUsedError;
  String? get optimizationSummary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutoFillResultCopyWith<AutoFillResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoFillResultCopyWith<$Res> {
  factory $AutoFillResultCopyWith(
          AutoFillResult value, $Res Function(AutoFillResult) then) =
      _$AutoFillResultCopyWithImpl<$Res, AutoFillResult>;
  @useResult
  $Res call(
      {int totalShifts,
      int filledShifts,
      int unfilledShifts,
      List<ShiftAssignment> assignments,
      List<String> unfilledShiftIds,
      String? optimizationSummary});
}

/// @nodoc
class _$AutoFillResultCopyWithImpl<$Res, $Val extends AutoFillResult>
    implements $AutoFillResultCopyWith<$Res> {
  _$AutoFillResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalShifts = null,
    Object? filledShifts = null,
    Object? unfilledShifts = null,
    Object? assignments = null,
    Object? unfilledShiftIds = null,
    Object? optimizationSummary = freezed,
  }) {
    return _then(_value.copyWith(
      totalShifts: null == totalShifts
          ? _value.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      filledShifts: null == filledShifts
          ? _value.filledShifts
          : filledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      unfilledShifts: null == unfilledShifts
          ? _value.unfilledShifts
          : unfilledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignments: null == assignments
          ? _value.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ShiftAssignment>,
      unfilledShiftIds: null == unfilledShiftIds
          ? _value.unfilledShiftIds
          : unfilledShiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optimizationSummary: freezed == optimizationSummary
          ? _value.optimizationSummary
          : optimizationSummary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AutoFillResultImplCopyWith<$Res>
    implements $AutoFillResultCopyWith<$Res> {
  factory _$$AutoFillResultImplCopyWith(_$AutoFillResultImpl value,
          $Res Function(_$AutoFillResultImpl) then) =
      __$$AutoFillResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalShifts,
      int filledShifts,
      int unfilledShifts,
      List<ShiftAssignment> assignments,
      List<String> unfilledShiftIds,
      String? optimizationSummary});
}

/// @nodoc
class __$$AutoFillResultImplCopyWithImpl<$Res>
    extends _$AutoFillResultCopyWithImpl<$Res, _$AutoFillResultImpl>
    implements _$$AutoFillResultImplCopyWith<$Res> {
  __$$AutoFillResultImplCopyWithImpl(
      _$AutoFillResultImpl _value, $Res Function(_$AutoFillResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalShifts = null,
    Object? filledShifts = null,
    Object? unfilledShifts = null,
    Object? assignments = null,
    Object? unfilledShiftIds = null,
    Object? optimizationSummary = freezed,
  }) {
    return _then(_$AutoFillResultImpl(
      totalShifts: null == totalShifts
          ? _value.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      filledShifts: null == filledShifts
          ? _value.filledShifts
          : filledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      unfilledShifts: null == unfilledShifts
          ? _value.unfilledShifts
          : unfilledShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignments: null == assignments
          ? _value._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<ShiftAssignment>,
      unfilledShiftIds: null == unfilledShiftIds
          ? _value._unfilledShiftIds
          : unfilledShiftIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      optimizationSummary: freezed == optimizationSummary
          ? _value.optimizationSummary
          : optimizationSummary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AutoFillResultImpl implements _AutoFillResult {
  const _$AutoFillResultImpl(
      {required this.totalShifts,
      required this.filledShifts,
      required this.unfilledShifts,
      required final List<ShiftAssignment> assignments,
      required final List<String> unfilledShiftIds,
      this.optimizationSummary})
      : _assignments = assignments,
        _unfilledShiftIds = unfilledShiftIds;

  factory _$AutoFillResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AutoFillResultImplFromJson(json);

  @override
  final int totalShifts;
  @override
  final int filledShifts;
  @override
  final int unfilledShifts;
  final List<ShiftAssignment> _assignments;
  @override
  List<ShiftAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  final List<String> _unfilledShiftIds;
  @override
  List<String> get unfilledShiftIds {
    if (_unfilledShiftIds is EqualUnmodifiableListView)
      return _unfilledShiftIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unfilledShiftIds);
  }

  @override
  final String? optimizationSummary;

  @override
  String toString() {
    return 'AutoFillResult(totalShifts: $totalShifts, filledShifts: $filledShifts, unfilledShifts: $unfilledShifts, assignments: $assignments, unfilledShiftIds: $unfilledShiftIds, optimizationSummary: $optimizationSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoFillResultImpl &&
            (identical(other.totalShifts, totalShifts) ||
                other.totalShifts == totalShifts) &&
            (identical(other.filledShifts, filledShifts) ||
                other.filledShifts == filledShifts) &&
            (identical(other.unfilledShifts, unfilledShifts) ||
                other.unfilledShifts == unfilledShifts) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            const DeepCollectionEquality()
                .equals(other._unfilledShiftIds, _unfilledShiftIds) &&
            (identical(other.optimizationSummary, optimizationSummary) ||
                other.optimizationSummary == optimizationSummary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalShifts,
      filledShifts,
      unfilledShifts,
      const DeepCollectionEquality().hash(_assignments),
      const DeepCollectionEquality().hash(_unfilledShiftIds),
      optimizationSummary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoFillResultImplCopyWith<_$AutoFillResultImpl> get copyWith =>
      __$$AutoFillResultImplCopyWithImpl<_$AutoFillResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AutoFillResultImplToJson(
      this,
    );
  }
}

abstract class _AutoFillResult implements AutoFillResult {
  const factory _AutoFillResult(
      {required final int totalShifts,
      required final int filledShifts,
      required final int unfilledShifts,
      required final List<ShiftAssignment> assignments,
      required final List<String> unfilledShiftIds,
      final String? optimizationSummary}) = _$AutoFillResultImpl;

  factory _AutoFillResult.fromJson(Map<String, dynamic> json) =
      _$AutoFillResultImpl.fromJson;

  @override
  int get totalShifts;
  @override
  int get filledShifts;
  @override
  int get unfilledShifts;
  @override
  List<ShiftAssignment> get assignments;
  @override
  List<String> get unfilledShiftIds;
  @override
  String? get optimizationSummary;
  @override
  @JsonKey(ignore: true)
  _$$AutoFillResultImplCopyWith<_$AutoFillResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftAssignment _$ShiftAssignmentFromJson(Map<String, dynamic> json) {
  return _ShiftAssignment.fromJson(json);
}

/// @nodoc
mixin _$ShiftAssignment {
  String get shiftId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  double get matchScore => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  List<String>? get warnings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftAssignmentCopyWith<ShiftAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftAssignmentCopyWith<$Res> {
  factory $ShiftAssignmentCopyWith(
          ShiftAssignment value, $Res Function(ShiftAssignment) then) =
      _$ShiftAssignmentCopyWithImpl<$Res, ShiftAssignment>;
  @useResult
  $Res call(
      {String shiftId,
      String workerId,
      String workerName,
      double matchScore,
      String reason,
      List<String>? warnings});
}

/// @nodoc
class _$ShiftAssignmentCopyWithImpl<$Res, $Val extends ShiftAssignment>
    implements $ShiftAssignmentCopyWith<$Res> {
  _$ShiftAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? matchScore = null,
    Object? reason = null,
    Object? warnings = freezed,
  }) {
    return _then(_value.copyWith(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: freezed == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftAssignmentImplCopyWith<$Res>
    implements $ShiftAssignmentCopyWith<$Res> {
  factory _$$ShiftAssignmentImplCopyWith(_$ShiftAssignmentImpl value,
          $Res Function(_$ShiftAssignmentImpl) then) =
      __$$ShiftAssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String shiftId,
      String workerId,
      String workerName,
      double matchScore,
      String reason,
      List<String>? warnings});
}

/// @nodoc
class __$$ShiftAssignmentImplCopyWithImpl<$Res>
    extends _$ShiftAssignmentCopyWithImpl<$Res, _$ShiftAssignmentImpl>
    implements _$$ShiftAssignmentImplCopyWith<$Res> {
  __$$ShiftAssignmentImplCopyWithImpl(
      _$ShiftAssignmentImpl _value, $Res Function(_$ShiftAssignmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? matchScore = null,
    Object? reason = null,
    Object? warnings = freezed,
  }) {
    return _then(_$ShiftAssignmentImpl(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: freezed == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftAssignmentImpl implements _ShiftAssignment {
  const _$ShiftAssignmentImpl(
      {required this.shiftId,
      required this.workerId,
      required this.workerName,
      required this.matchScore,
      required this.reason,
      final List<String>? warnings})
      : _warnings = warnings;

  factory _$ShiftAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftAssignmentImplFromJson(json);

  @override
  final String shiftId;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final double matchScore;
  @override
  final String reason;
  final List<String>? _warnings;
  @override
  List<String>? get warnings {
    final value = _warnings;
    if (value == null) return null;
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ShiftAssignment(shiftId: $shiftId, workerId: $workerId, workerName: $workerName, matchScore: $matchScore, reason: $reason, warnings: $warnings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftAssignmentImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, shiftId, workerId, workerName,
      matchScore, reason, const DeepCollectionEquality().hash(_warnings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftAssignmentImplCopyWith<_$ShiftAssignmentImpl> get copyWith =>
      __$$ShiftAssignmentImplCopyWithImpl<_$ShiftAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftAssignmentImplToJson(
      this,
    );
  }
}

abstract class _ShiftAssignment implements ShiftAssignment {
  const factory _ShiftAssignment(
      {required final String shiftId,
      required final String workerId,
      required final String workerName,
      required final double matchScore,
      required final String reason,
      final List<String>? warnings}) = _$ShiftAssignmentImpl;

  factory _ShiftAssignment.fromJson(Map<String, dynamic> json) =
      _$ShiftAssignmentImpl.fromJson;

  @override
  String get shiftId;
  @override
  String get workerId;
  @override
  String get workerName;
  @override
  double get matchScore;
  @override
  String get reason;
  @override
  List<String>? get warnings;
  @override
  @JsonKey(ignore: true)
  _$$ShiftAssignmentImplCopyWith<_$ShiftAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchingCriteria _$MatchingCriteriaFromJson(Map<String, dynamic> json) {
  return _MatchingCriteria.fromJson(json);
}

/// @nodoc
mixin _$MatchingCriteria {
  bool get requireSkillMatch => throw _privateConstructorUsedError;
  bool get checkAvailability => throw _privateConstructorUsedError;
  bool get considerDistance => throw _privateConstructorUsedError;
  bool get checkPreferences => throw _privateConstructorUsedError;
  bool get allowOvertime => throw _privateConstructorUsedError;
  double get maxDistance => throw _privateConstructorUsedError;
  double get minMatchScore => throw _privateConstructorUsedError;
  List<String>? get priorityFactors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchingCriteriaCopyWith<MatchingCriteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchingCriteriaCopyWith<$Res> {
  factory $MatchingCriteriaCopyWith(
          MatchingCriteria value, $Res Function(MatchingCriteria) then) =
      _$MatchingCriteriaCopyWithImpl<$Res, MatchingCriteria>;
  @useResult
  $Res call(
      {bool requireSkillMatch,
      bool checkAvailability,
      bool considerDistance,
      bool checkPreferences,
      bool allowOvertime,
      double maxDistance,
      double minMatchScore,
      List<String>? priorityFactors});
}

/// @nodoc
class _$MatchingCriteriaCopyWithImpl<$Res, $Val extends MatchingCriteria>
    implements $MatchingCriteriaCopyWith<$Res> {
  _$MatchingCriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requireSkillMatch = null,
    Object? checkAvailability = null,
    Object? considerDistance = null,
    Object? checkPreferences = null,
    Object? allowOvertime = null,
    Object? maxDistance = null,
    Object? minMatchScore = null,
    Object? priorityFactors = freezed,
  }) {
    return _then(_value.copyWith(
      requireSkillMatch: null == requireSkillMatch
          ? _value.requireSkillMatch
          : requireSkillMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      checkAvailability: null == checkAvailability
          ? _value.checkAvailability
          : checkAvailability // ignore: cast_nullable_to_non_nullable
              as bool,
      considerDistance: null == considerDistance
          ? _value.considerDistance
          : considerDistance // ignore: cast_nullable_to_non_nullable
              as bool,
      checkPreferences: null == checkPreferences
          ? _value.checkPreferences
          : checkPreferences // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOvertime: null == allowOvertime
          ? _value.allowOvertime
          : allowOvertime // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDistance: null == maxDistance
          ? _value.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double,
      minMatchScore: null == minMatchScore
          ? _value.minMatchScore
          : minMatchScore // ignore: cast_nullable_to_non_nullable
              as double,
      priorityFactors: freezed == priorityFactors
          ? _value.priorityFactors
          : priorityFactors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchingCriteriaImplCopyWith<$Res>
    implements $MatchingCriteriaCopyWith<$Res> {
  factory _$$MatchingCriteriaImplCopyWith(_$MatchingCriteriaImpl value,
          $Res Function(_$MatchingCriteriaImpl) then) =
      __$$MatchingCriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool requireSkillMatch,
      bool checkAvailability,
      bool considerDistance,
      bool checkPreferences,
      bool allowOvertime,
      double maxDistance,
      double minMatchScore,
      List<String>? priorityFactors});
}

/// @nodoc
class __$$MatchingCriteriaImplCopyWithImpl<$Res>
    extends _$MatchingCriteriaCopyWithImpl<$Res, _$MatchingCriteriaImpl>
    implements _$$MatchingCriteriaImplCopyWith<$Res> {
  __$$MatchingCriteriaImplCopyWithImpl(_$MatchingCriteriaImpl _value,
      $Res Function(_$MatchingCriteriaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requireSkillMatch = null,
    Object? checkAvailability = null,
    Object? considerDistance = null,
    Object? checkPreferences = null,
    Object? allowOvertime = null,
    Object? maxDistance = null,
    Object? minMatchScore = null,
    Object? priorityFactors = freezed,
  }) {
    return _then(_$MatchingCriteriaImpl(
      requireSkillMatch: null == requireSkillMatch
          ? _value.requireSkillMatch
          : requireSkillMatch // ignore: cast_nullable_to_non_nullable
              as bool,
      checkAvailability: null == checkAvailability
          ? _value.checkAvailability
          : checkAvailability // ignore: cast_nullable_to_non_nullable
              as bool,
      considerDistance: null == considerDistance
          ? _value.considerDistance
          : considerDistance // ignore: cast_nullable_to_non_nullable
              as bool,
      checkPreferences: null == checkPreferences
          ? _value.checkPreferences
          : checkPreferences // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOvertime: null == allowOvertime
          ? _value.allowOvertime
          : allowOvertime // ignore: cast_nullable_to_non_nullable
              as bool,
      maxDistance: null == maxDistance
          ? _value.maxDistance
          : maxDistance // ignore: cast_nullable_to_non_nullable
              as double,
      minMatchScore: null == minMatchScore
          ? _value.minMatchScore
          : minMatchScore // ignore: cast_nullable_to_non_nullable
              as double,
      priorityFactors: freezed == priorityFactors
          ? _value._priorityFactors
          : priorityFactors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchingCriteriaImpl implements _MatchingCriteria {
  const _$MatchingCriteriaImpl(
      {this.requireSkillMatch = true,
      this.checkAvailability = true,
      this.considerDistance = true,
      this.checkPreferences = true,
      this.allowOvertime = false,
      this.maxDistance = 30.0,
      this.minMatchScore = 0.6,
      final List<String>? priorityFactors})
      : _priorityFactors = priorityFactors;

  factory _$MatchingCriteriaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchingCriteriaImplFromJson(json);

  @override
  @JsonKey()
  final bool requireSkillMatch;
  @override
  @JsonKey()
  final bool checkAvailability;
  @override
  @JsonKey()
  final bool considerDistance;
  @override
  @JsonKey()
  final bool checkPreferences;
  @override
  @JsonKey()
  final bool allowOvertime;
  @override
  @JsonKey()
  final double maxDistance;
  @override
  @JsonKey()
  final double minMatchScore;
  final List<String>? _priorityFactors;
  @override
  List<String>? get priorityFactors {
    final value = _priorityFactors;
    if (value == null) return null;
    if (_priorityFactors is EqualUnmodifiableListView) return _priorityFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MatchingCriteria(requireSkillMatch: $requireSkillMatch, checkAvailability: $checkAvailability, considerDistance: $considerDistance, checkPreferences: $checkPreferences, allowOvertime: $allowOvertime, maxDistance: $maxDistance, minMatchScore: $minMatchScore, priorityFactors: $priorityFactors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchingCriteriaImpl &&
            (identical(other.requireSkillMatch, requireSkillMatch) ||
                other.requireSkillMatch == requireSkillMatch) &&
            (identical(other.checkAvailability, checkAvailability) ||
                other.checkAvailability == checkAvailability) &&
            (identical(other.considerDistance, considerDistance) ||
                other.considerDistance == considerDistance) &&
            (identical(other.checkPreferences, checkPreferences) ||
                other.checkPreferences == checkPreferences) &&
            (identical(other.allowOvertime, allowOvertime) ||
                other.allowOvertime == allowOvertime) &&
            (identical(other.maxDistance, maxDistance) ||
                other.maxDistance == maxDistance) &&
            (identical(other.minMatchScore, minMatchScore) ||
                other.minMatchScore == minMatchScore) &&
            const DeepCollectionEquality()
                .equals(other._priorityFactors, _priorityFactors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requireSkillMatch,
      checkAvailability,
      considerDistance,
      checkPreferences,
      allowOvertime,
      maxDistance,
      minMatchScore,
      const DeepCollectionEquality().hash(_priorityFactors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchingCriteriaImplCopyWith<_$MatchingCriteriaImpl> get copyWith =>
      __$$MatchingCriteriaImplCopyWithImpl<_$MatchingCriteriaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchingCriteriaImplToJson(
      this,
    );
  }
}

abstract class _MatchingCriteria implements MatchingCriteria {
  const factory _MatchingCriteria(
      {final bool requireSkillMatch,
      final bool checkAvailability,
      final bool considerDistance,
      final bool checkPreferences,
      final bool allowOvertime,
      final double maxDistance,
      final double minMatchScore,
      final List<String>? priorityFactors}) = _$MatchingCriteriaImpl;

  factory _MatchingCriteria.fromJson(Map<String, dynamic> json) =
      _$MatchingCriteriaImpl.fromJson;

  @override
  bool get requireSkillMatch;
  @override
  bool get checkAvailability;
  @override
  bool get considerDistance;
  @override
  bool get checkPreferences;
  @override
  bool get allowOvertime;
  @override
  double get maxDistance;
  @override
  double get minMatchScore;
  @override
  List<String>? get priorityFactors;
  @override
  @JsonKey(ignore: true)
  _$$MatchingCriteriaImplCopyWith<_$MatchingCriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteOptimization _$RouteOptimizationFromJson(Map<String, dynamic> json) {
  return _RouteOptimization.fromJson(json);
}

/// @nodoc
mixin _$RouteOptimization {
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  List<OptimizedShift> get shifts => throw _privateConstructorUsedError;
  double get totalDistance => throw _privateConstructorUsedError;
  double get totalTravelTime => throw _privateConstructorUsedError;
  double get efficiencyScore => throw _privateConstructorUsedError;
  String? get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteOptimizationCopyWith<RouteOptimization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteOptimizationCopyWith<$Res> {
  factory $RouteOptimizationCopyWith(
          RouteOptimization value, $Res Function(RouteOptimization) then) =
      _$RouteOptimizationCopyWithImpl<$Res, RouteOptimization>;
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      List<OptimizedShift> shifts,
      double totalDistance,
      double totalTravelTime,
      double efficiencyScore,
      String? recommendations});
}

/// @nodoc
class _$RouteOptimizationCopyWithImpl<$Res, $Val extends RouteOptimization>
    implements $RouteOptimizationCopyWith<$Res> {
  _$RouteOptimizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? shifts = null,
    Object? totalDistance = null,
    Object? totalTravelTime = null,
    Object? efficiencyScore = null,
    Object? recommendations = freezed,
  }) {
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      shifts: null == shifts
          ? _value.shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<OptimizedShift>,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalTravelTime: null == totalTravelTime
          ? _value.totalTravelTime
          : totalTravelTime // ignore: cast_nullable_to_non_nullable
              as double,
      efficiencyScore: null == efficiencyScore
          ? _value.efficiencyScore
          : efficiencyScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: freezed == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteOptimizationImplCopyWith<$Res>
    implements $RouteOptimizationCopyWith<$Res> {
  factory _$$RouteOptimizationImplCopyWith(_$RouteOptimizationImpl value,
          $Res Function(_$RouteOptimizationImpl) then) =
      __$$RouteOptimizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workerId,
      String workerName,
      List<OptimizedShift> shifts,
      double totalDistance,
      double totalTravelTime,
      double efficiencyScore,
      String? recommendations});
}

/// @nodoc
class __$$RouteOptimizationImplCopyWithImpl<$Res>
    extends _$RouteOptimizationCopyWithImpl<$Res, _$RouteOptimizationImpl>
    implements _$$RouteOptimizationImplCopyWith<$Res> {
  __$$RouteOptimizationImplCopyWithImpl(_$RouteOptimizationImpl _value,
      $Res Function(_$RouteOptimizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? workerName = null,
    Object? shifts = null,
    Object? totalDistance = null,
    Object? totalTravelTime = null,
    Object? efficiencyScore = null,
    Object? recommendations = freezed,
  }) {
    return _then(_$RouteOptimizationImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      workerName: null == workerName
          ? _value.workerName
          : workerName // ignore: cast_nullable_to_non_nullable
              as String,
      shifts: null == shifts
          ? _value._shifts
          : shifts // ignore: cast_nullable_to_non_nullable
              as List<OptimizedShift>,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      totalTravelTime: null == totalTravelTime
          ? _value.totalTravelTime
          : totalTravelTime // ignore: cast_nullable_to_non_nullable
              as double,
      efficiencyScore: null == efficiencyScore
          ? _value.efficiencyScore
          : efficiencyScore // ignore: cast_nullable_to_non_nullable
              as double,
      recommendations: freezed == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteOptimizationImpl implements _RouteOptimization {
  const _$RouteOptimizationImpl(
      {required this.workerId,
      required this.workerName,
      required final List<OptimizedShift> shifts,
      required this.totalDistance,
      required this.totalTravelTime,
      required this.efficiencyScore,
      this.recommendations})
      : _shifts = shifts;

  factory _$RouteOptimizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteOptimizationImplFromJson(json);

  @override
  final String workerId;
  @override
  final String workerName;
  final List<OptimizedShift> _shifts;
  @override
  List<OptimizedShift> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  @override
  final double totalDistance;
  @override
  final double totalTravelTime;
  @override
  final double efficiencyScore;
  @override
  final String? recommendations;

  @override
  String toString() {
    return 'RouteOptimization(workerId: $workerId, workerName: $workerName, shifts: $shifts, totalDistance: $totalDistance, totalTravelTime: $totalTravelTime, efficiencyScore: $efficiencyScore, recommendations: $recommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteOptimizationImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            const DeepCollectionEquality().equals(other._shifts, _shifts) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalTravelTime, totalTravelTime) ||
                other.totalTravelTime == totalTravelTime) &&
            (identical(other.efficiencyScore, efficiencyScore) ||
                other.efficiencyScore == efficiencyScore) &&
            (identical(other.recommendations, recommendations) ||
                other.recommendations == recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      workerName,
      const DeepCollectionEquality().hash(_shifts),
      totalDistance,
      totalTravelTime,
      efficiencyScore,
      recommendations);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteOptimizationImplCopyWith<_$RouteOptimizationImpl> get copyWith =>
      __$$RouteOptimizationImplCopyWithImpl<_$RouteOptimizationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteOptimizationImplToJson(
      this,
    );
  }
}

abstract class _RouteOptimization implements RouteOptimization {
  const factory _RouteOptimization(
      {required final String workerId,
      required final String workerName,
      required final List<OptimizedShift> shifts,
      required final double totalDistance,
      required final double totalTravelTime,
      required final double efficiencyScore,
      final String? recommendations}) = _$RouteOptimizationImpl;

  factory _RouteOptimization.fromJson(Map<String, dynamic> json) =
      _$RouteOptimizationImpl.fromJson;

  @override
  String get workerId;
  @override
  String get workerName;
  @override
  List<OptimizedShift> get shifts;
  @override
  double get totalDistance;
  @override
  double get totalTravelTime;
  @override
  double get efficiencyScore;
  @override
  String? get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$RouteOptimizationImplCopyWith<_$RouteOptimizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OptimizedShift _$OptimizedShiftFromJson(Map<String, dynamic> json) {
  return _OptimizedShift.fromJson(json);
}

/// @nodoc
mixin _$OptimizedShift {
  String get shiftId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double? get distanceFromPrevious => throw _privateConstructorUsedError;
  double? get travelTimeFromPrevious => throw _privateConstructorUsedError;
  int? get sequenceOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptimizedShiftCopyWith<OptimizedShift> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptimizedShiftCopyWith<$Res> {
  factory $OptimizedShiftCopyWith(
          OptimizedShift value, $Res Function(OptimizedShift) then) =
      _$OptimizedShiftCopyWithImpl<$Res, OptimizedShift>;
  @useResult
  $Res call(
      {String shiftId,
      DateTime startTime,
      DateTime endTime,
      String location,
      double latitude,
      double longitude,
      double? distanceFromPrevious,
      double? travelTimeFromPrevious,
      int? sequenceOrder});
}

/// @nodoc
class _$OptimizedShiftCopyWithImpl<$Res, $Val extends OptimizedShift>
    implements $OptimizedShiftCopyWith<$Res> {
  _$OptimizedShiftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distanceFromPrevious = freezed,
    Object? travelTimeFromPrevious = freezed,
    Object? sequenceOrder = freezed,
  }) {
    return _then(_value.copyWith(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distanceFromPrevious: freezed == distanceFromPrevious
          ? _value.distanceFromPrevious
          : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTimeFromPrevious: freezed == travelTimeFromPrevious
          ? _value.travelTimeFromPrevious
          : travelTimeFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      sequenceOrder: freezed == sequenceOrder
          ? _value.sequenceOrder
          : sequenceOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptimizedShiftImplCopyWith<$Res>
    implements $OptimizedShiftCopyWith<$Res> {
  factory _$$OptimizedShiftImplCopyWith(_$OptimizedShiftImpl value,
          $Res Function(_$OptimizedShiftImpl) then) =
      __$$OptimizedShiftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String shiftId,
      DateTime startTime,
      DateTime endTime,
      String location,
      double latitude,
      double longitude,
      double? distanceFromPrevious,
      double? travelTimeFromPrevious,
      int? sequenceOrder});
}

/// @nodoc
class __$$OptimizedShiftImplCopyWithImpl<$Res>
    extends _$OptimizedShiftCopyWithImpl<$Res, _$OptimizedShiftImpl>
    implements _$$OptimizedShiftImplCopyWith<$Res> {
  __$$OptimizedShiftImplCopyWithImpl(
      _$OptimizedShiftImpl _value, $Res Function(_$OptimizedShiftImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distanceFromPrevious = freezed,
    Object? travelTimeFromPrevious = freezed,
    Object? sequenceOrder = freezed,
  }) {
    return _then(_$OptimizedShiftImpl(
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distanceFromPrevious: freezed == distanceFromPrevious
          ? _value.distanceFromPrevious
          : distanceFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      travelTimeFromPrevious: freezed == travelTimeFromPrevious
          ? _value.travelTimeFromPrevious
          : travelTimeFromPrevious // ignore: cast_nullable_to_non_nullable
              as double?,
      sequenceOrder: freezed == sequenceOrder
          ? _value.sequenceOrder
          : sequenceOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OptimizedShiftImpl implements _OptimizedShift {
  const _$OptimizedShiftImpl(
      {required this.shiftId,
      required this.startTime,
      required this.endTime,
      required this.location,
      required this.latitude,
      required this.longitude,
      this.distanceFromPrevious,
      this.travelTimeFromPrevious,
      this.sequenceOrder});

  factory _$OptimizedShiftImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptimizedShiftImplFromJson(json);

  @override
  final String shiftId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String location;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double? distanceFromPrevious;
  @override
  final double? travelTimeFromPrevious;
  @override
  final int? sequenceOrder;

  @override
  String toString() {
    return 'OptimizedShift(shiftId: $shiftId, startTime: $startTime, endTime: $endTime, location: $location, latitude: $latitude, longitude: $longitude, distanceFromPrevious: $distanceFromPrevious, travelTimeFromPrevious: $travelTimeFromPrevious, sequenceOrder: $sequenceOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptimizedShiftImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distanceFromPrevious, distanceFromPrevious) ||
                other.distanceFromPrevious == distanceFromPrevious) &&
            (identical(other.travelTimeFromPrevious, travelTimeFromPrevious) ||
                other.travelTimeFromPrevious == travelTimeFromPrevious) &&
            (identical(other.sequenceOrder, sequenceOrder) ||
                other.sequenceOrder == sequenceOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      shiftId,
      startTime,
      endTime,
      location,
      latitude,
      longitude,
      distanceFromPrevious,
      travelTimeFromPrevious,
      sequenceOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OptimizedShiftImplCopyWith<_$OptimizedShiftImpl> get copyWith =>
      __$$OptimizedShiftImplCopyWithImpl<_$OptimizedShiftImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptimizedShiftImplToJson(
      this,
    );
  }
}

abstract class _OptimizedShift implements OptimizedShift {
  const factory _OptimizedShift(
      {required final String shiftId,
      required final DateTime startTime,
      required final DateTime endTime,
      required final String location,
      required final double latitude,
      required final double longitude,
      final double? distanceFromPrevious,
      final double? travelTimeFromPrevious,
      final int? sequenceOrder}) = _$OptimizedShiftImpl;

  factory _OptimizedShift.fromJson(Map<String, dynamic> json) =
      _$OptimizedShiftImpl.fromJson;

  @override
  String get shiftId;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get location;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double? get distanceFromPrevious;
  @override
  double? get travelTimeFromPrevious;
  @override
  int? get sequenceOrder;
  @override
  @JsonKey(ignore: true)
  _$$OptimizedShiftImplCopyWith<_$OptimizedShiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduleOptimization _$ScheduleOptimizationFromJson(Map<String, dynamic> json) {
  return _ScheduleOptimization.fromJson(json);
}

/// @nodoc
mixin _$ScheduleOptimization {
  String get organizationId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get totalShifts => throw _privateConstructorUsedError;
  int get assignedShifts => throw _privateConstructorUsedError;
  double get overallEfficiency => throw _privateConstructorUsedError;
  List<RouteOptimization> get workerRoutes =>
      throw _privateConstructorUsedError;
  List<String> get warnings => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleOptimizationCopyWith<ScheduleOptimization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleOptimizationCopyWith<$Res> {
  factory $ScheduleOptimizationCopyWith(ScheduleOptimization value,
          $Res Function(ScheduleOptimization) then) =
      _$ScheduleOptimizationCopyWithImpl<$Res, ScheduleOptimization>;
  @useResult
  $Res call(
      {String organizationId,
      DateTime date,
      int totalShifts,
      int assignedShifts,
      double overallEfficiency,
      List<RouteOptimization> workerRoutes,
      List<String> warnings,
      String? summary});
}

/// @nodoc
class _$ScheduleOptimizationCopyWithImpl<$Res,
        $Val extends ScheduleOptimization>
    implements $ScheduleOptimizationCopyWith<$Res> {
  _$ScheduleOptimizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? date = null,
    Object? totalShifts = null,
    Object? assignedShifts = null,
    Object? overallEfficiency = null,
    Object? workerRoutes = null,
    Object? warnings = null,
    Object? summary = freezed,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalShifts: null == totalShifts
          ? _value.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignedShifts: null == assignedShifts
          ? _value.assignedShifts
          : assignedShifts // ignore: cast_nullable_to_non_nullable
              as int,
      overallEfficiency: null == overallEfficiency
          ? _value.overallEfficiency
          : overallEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      workerRoutes: null == workerRoutes
          ? _value.workerRoutes
          : workerRoutes // ignore: cast_nullable_to_non_nullable
              as List<RouteOptimization>,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleOptimizationImplCopyWith<$Res>
    implements $ScheduleOptimizationCopyWith<$Res> {
  factory _$$ScheduleOptimizationImplCopyWith(_$ScheduleOptimizationImpl value,
          $Res Function(_$ScheduleOptimizationImpl) then) =
      __$$ScheduleOptimizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      DateTime date,
      int totalShifts,
      int assignedShifts,
      double overallEfficiency,
      List<RouteOptimization> workerRoutes,
      List<String> warnings,
      String? summary});
}

/// @nodoc
class __$$ScheduleOptimizationImplCopyWithImpl<$Res>
    extends _$ScheduleOptimizationCopyWithImpl<$Res, _$ScheduleOptimizationImpl>
    implements _$$ScheduleOptimizationImplCopyWith<$Res> {
  __$$ScheduleOptimizationImplCopyWithImpl(_$ScheduleOptimizationImpl _value,
      $Res Function(_$ScheduleOptimizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? date = null,
    Object? totalShifts = null,
    Object? assignedShifts = null,
    Object? overallEfficiency = null,
    Object? workerRoutes = null,
    Object? warnings = null,
    Object? summary = freezed,
  }) {
    return _then(_$ScheduleOptimizationImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalShifts: null == totalShifts
          ? _value.totalShifts
          : totalShifts // ignore: cast_nullable_to_non_nullable
              as int,
      assignedShifts: null == assignedShifts
          ? _value.assignedShifts
          : assignedShifts // ignore: cast_nullable_to_non_nullable
              as int,
      overallEfficiency: null == overallEfficiency
          ? _value.overallEfficiency
          : overallEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      workerRoutes: null == workerRoutes
          ? _value._workerRoutes
          : workerRoutes // ignore: cast_nullable_to_non_nullable
              as List<RouteOptimization>,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleOptimizationImpl implements _ScheduleOptimization {
  const _$ScheduleOptimizationImpl(
      {required this.organizationId,
      required this.date,
      required this.totalShifts,
      required this.assignedShifts,
      required this.overallEfficiency,
      required final List<RouteOptimization> workerRoutes,
      required final List<String> warnings,
      this.summary})
      : _workerRoutes = workerRoutes,
        _warnings = warnings;

  factory _$ScheduleOptimizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleOptimizationImplFromJson(json);

  @override
  final String organizationId;
  @override
  final DateTime date;
  @override
  final int totalShifts;
  @override
  final int assignedShifts;
  @override
  final double overallEfficiency;
  final List<RouteOptimization> _workerRoutes;
  @override
  List<RouteOptimization> get workerRoutes {
    if (_workerRoutes is EqualUnmodifiableListView) return _workerRoutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workerRoutes);
  }

  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final String? summary;

  @override
  String toString() {
    return 'ScheduleOptimization(organizationId: $organizationId, date: $date, totalShifts: $totalShifts, assignedShifts: $assignedShifts, overallEfficiency: $overallEfficiency, workerRoutes: $workerRoutes, warnings: $warnings, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleOptimizationImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.totalShifts, totalShifts) ||
                other.totalShifts == totalShifts) &&
            (identical(other.assignedShifts, assignedShifts) ||
                other.assignedShifts == assignedShifts) &&
            (identical(other.overallEfficiency, overallEfficiency) ||
                other.overallEfficiency == overallEfficiency) &&
            const DeepCollectionEquality()
                .equals(other._workerRoutes, _workerRoutes) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      date,
      totalShifts,
      assignedShifts,
      overallEfficiency,
      const DeepCollectionEquality().hash(_workerRoutes),
      const DeepCollectionEquality().hash(_warnings),
      summary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleOptimizationImplCopyWith<_$ScheduleOptimizationImpl>
      get copyWith =>
          __$$ScheduleOptimizationImplCopyWithImpl<_$ScheduleOptimizationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleOptimizationImplToJson(
      this,
    );
  }
}

abstract class _ScheduleOptimization implements ScheduleOptimization {
  const factory _ScheduleOptimization(
      {required final String organizationId,
      required final DateTime date,
      required final int totalShifts,
      required final int assignedShifts,
      required final double overallEfficiency,
      required final List<RouteOptimization> workerRoutes,
      required final List<String> warnings,
      final String? summary}) = _$ScheduleOptimizationImpl;

  factory _ScheduleOptimization.fromJson(Map<String, dynamic> json) =
      _$ScheduleOptimizationImpl.fromJson;

  @override
  String get organizationId;
  @override
  DateTime get date;
  @override
  int get totalShifts;
  @override
  int get assignedShifts;
  @override
  double get overallEfficiency;
  @override
  List<RouteOptimization> get workerRoutes;
  @override
  List<String> get warnings;
  @override
  String? get summary;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleOptimizationImplCopyWith<_$ScheduleOptimizationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NoShowPrediction _$NoShowPredictionFromJson(Map<String, dynamic> json) {
  return _NoShowPrediction.fromJson(json);
}

/// @nodoc
mixin _$NoShowPrediction {
  String get workerId => throw _privateConstructorUsedError;
  String get shiftId => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  List<String> get riskFactors => throw _privateConstructorUsedError;
  String? get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoShowPredictionCopyWith<NoShowPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoShowPredictionCopyWith<$Res> {
  factory $NoShowPredictionCopyWith(
          NoShowPrediction value, $Res Function(NoShowPrediction) then) =
      _$NoShowPredictionCopyWithImpl<$Res, NoShowPrediction>;
  @useResult
  $Res call(
      {String workerId,
      String shiftId,
      double probability,
      String riskLevel,
      List<String> riskFactors,
      String? recommendation});
}

/// @nodoc
class _$NoShowPredictionCopyWithImpl<$Res, $Val extends NoShowPrediction>
    implements $NoShowPredictionCopyWith<$Res> {
  _$NoShowPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? shiftId = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? riskFactors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_value.copyWith(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      riskFactors: null == riskFactors
          ? _value.riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoShowPredictionImplCopyWith<$Res>
    implements $NoShowPredictionCopyWith<$Res> {
  factory _$$NoShowPredictionImplCopyWith(_$NoShowPredictionImpl value,
          $Res Function(_$NoShowPredictionImpl) then) =
      __$$NoShowPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String workerId,
      String shiftId,
      double probability,
      String riskLevel,
      List<String> riskFactors,
      String? recommendation});
}

/// @nodoc
class __$$NoShowPredictionImplCopyWithImpl<$Res>
    extends _$NoShowPredictionCopyWithImpl<$Res, _$NoShowPredictionImpl>
    implements _$$NoShowPredictionImplCopyWith<$Res> {
  __$$NoShowPredictionImplCopyWithImpl(_$NoShowPredictionImpl _value,
      $Res Function(_$NoShowPredictionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workerId = null,
    Object? shiftId = null,
    Object? probability = null,
    Object? riskLevel = null,
    Object? riskFactors = null,
    Object? recommendation = freezed,
  }) {
    return _then(_$NoShowPredictionImpl(
      workerId: null == workerId
          ? _value.workerId
          : workerId // ignore: cast_nullable_to_non_nullable
              as String,
      shiftId: null == shiftId
          ? _value.shiftId
          : shiftId // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      riskFactors: null == riskFactors
          ? _value._riskFactors
          : riskFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoShowPredictionImpl implements _NoShowPrediction {
  const _$NoShowPredictionImpl(
      {required this.workerId,
      required this.shiftId,
      required this.probability,
      required this.riskLevel,
      required final List<String> riskFactors,
      this.recommendation})
      : _riskFactors = riskFactors;

  factory _$NoShowPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoShowPredictionImplFromJson(json);

  @override
  final String workerId;
  @override
  final String shiftId;
  @override
  final double probability;
  @override
  final String riskLevel;
  final List<String> _riskFactors;
  @override
  List<String> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  @override
  final String? recommendation;

  @override
  String toString() {
    return 'NoShowPrediction(workerId: $workerId, shiftId: $shiftId, probability: $probability, riskLevel: $riskLevel, riskFactors: $riskFactors, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoShowPredictionImpl &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality()
                .equals(other._riskFactors, _riskFactors) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      workerId,
      shiftId,
      probability,
      riskLevel,
      const DeepCollectionEquality().hash(_riskFactors),
      recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoShowPredictionImplCopyWith<_$NoShowPredictionImpl> get copyWith =>
      __$$NoShowPredictionImplCopyWithImpl<_$NoShowPredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoShowPredictionImplToJson(
      this,
    );
  }
}

abstract class _NoShowPrediction implements NoShowPrediction {
  const factory _NoShowPrediction(
      {required final String workerId,
      required final String shiftId,
      required final double probability,
      required final String riskLevel,
      required final List<String> riskFactors,
      final String? recommendation}) = _$NoShowPredictionImpl;

  factory _NoShowPrediction.fromJson(Map<String, dynamic> json) =
      _$NoShowPredictionImpl.fromJson;

  @override
  String get workerId;
  @override
  String get shiftId;
  @override
  double get probability;
  @override
  String get riskLevel;
  @override
  List<String> get riskFactors;
  @override
  String? get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$NoShowPredictionImplCopyWith<_$NoShowPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
