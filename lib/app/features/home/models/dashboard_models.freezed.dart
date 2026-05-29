// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodaySummary {

 int get appointmentsToday; int get workersOnShift; double get revenueToday; int get pendingApprovals; DateTime get lastUpdated; int get completedAppointments; int get cancelledAppointments; int get activeWorkers; int get availableWorkers;
/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodaySummaryCopyWith<TodaySummary> get copyWith => _$TodaySummaryCopyWithImpl<TodaySummary>(this as TodaySummary, _$identity);

  /// Serializes this TodaySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodaySummary&&(identical(other.appointmentsToday, appointmentsToday) || other.appointmentsToday == appointmentsToday)&&(identical(other.workersOnShift, workersOnShift) || other.workersOnShift == workersOnShift)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.pendingApprovals, pendingApprovals) || other.pendingApprovals == pendingApprovals)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.completedAppointments, completedAppointments) || other.completedAppointments == completedAppointments)&&(identical(other.cancelledAppointments, cancelledAppointments) || other.cancelledAppointments == cancelledAppointments)&&(identical(other.activeWorkers, activeWorkers) || other.activeWorkers == activeWorkers)&&(identical(other.availableWorkers, availableWorkers) || other.availableWorkers == availableWorkers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentsToday,workersOnShift,revenueToday,pendingApprovals,lastUpdated,completedAppointments,cancelledAppointments,activeWorkers,availableWorkers);

@override
String toString() {
  return 'TodaySummary(appointmentsToday: $appointmentsToday, workersOnShift: $workersOnShift, revenueToday: $revenueToday, pendingApprovals: $pendingApprovals, lastUpdated: $lastUpdated, completedAppointments: $completedAppointments, cancelledAppointments: $cancelledAppointments, activeWorkers: $activeWorkers, availableWorkers: $availableWorkers)';
}


}

/// @nodoc
abstract mixin class $TodaySummaryCopyWith<$Res>  {
  factory $TodaySummaryCopyWith(TodaySummary value, $Res Function(TodaySummary) _then) = _$TodaySummaryCopyWithImpl;
@useResult
$Res call({
 int appointmentsToday, int workersOnShift, double revenueToday, int pendingApprovals, DateTime lastUpdated, int completedAppointments, int cancelledAppointments, int activeWorkers, int availableWorkers
});




}
/// @nodoc
class _$TodaySummaryCopyWithImpl<$Res>
    implements $TodaySummaryCopyWith<$Res> {
  _$TodaySummaryCopyWithImpl(this._self, this._then);

  final TodaySummary _self;
  final $Res Function(TodaySummary) _then;

/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentsToday = null,Object? workersOnShift = null,Object? revenueToday = null,Object? pendingApprovals = null,Object? lastUpdated = null,Object? completedAppointments = null,Object? cancelledAppointments = null,Object? activeWorkers = null,Object? availableWorkers = null,}) {
  return _then(_self.copyWith(
appointmentsToday: null == appointmentsToday ? _self.appointmentsToday : appointmentsToday // ignore: cast_nullable_to_non_nullable
as int,workersOnShift: null == workersOnShift ? _self.workersOnShift : workersOnShift // ignore: cast_nullable_to_non_nullable
as int,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as double,pendingApprovals: null == pendingApprovals ? _self.pendingApprovals : pendingApprovals // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,completedAppointments: null == completedAppointments ? _self.completedAppointments : completedAppointments // ignore: cast_nullable_to_non_nullable
as int,cancelledAppointments: null == cancelledAppointments ? _self.cancelledAppointments : cancelledAppointments // ignore: cast_nullable_to_non_nullable
as int,activeWorkers: null == activeWorkers ? _self.activeWorkers : activeWorkers // ignore: cast_nullable_to_non_nullable
as int,availableWorkers: null == availableWorkers ? _self.availableWorkers : availableWorkers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TodaySummary].
extension TodaySummaryPatterns on TodaySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodaySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodaySummary value)  $default,){
final _that = this;
switch (_that) {
case _TodaySummary():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodaySummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int appointmentsToday,  int workersOnShift,  double revenueToday,  int pendingApprovals,  DateTime lastUpdated,  int completedAppointments,  int cancelledAppointments,  int activeWorkers,  int availableWorkers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
return $default(_that.appointmentsToday,_that.workersOnShift,_that.revenueToday,_that.pendingApprovals,_that.lastUpdated,_that.completedAppointments,_that.cancelledAppointments,_that.activeWorkers,_that.availableWorkers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int appointmentsToday,  int workersOnShift,  double revenueToday,  int pendingApprovals,  DateTime lastUpdated,  int completedAppointments,  int cancelledAppointments,  int activeWorkers,  int availableWorkers)  $default,) {final _that = this;
switch (_that) {
case _TodaySummary():
return $default(_that.appointmentsToday,_that.workersOnShift,_that.revenueToday,_that.pendingApprovals,_that.lastUpdated,_that.completedAppointments,_that.cancelledAppointments,_that.activeWorkers,_that.availableWorkers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int appointmentsToday,  int workersOnShift,  double revenueToday,  int pendingApprovals,  DateTime lastUpdated,  int completedAppointments,  int cancelledAppointments,  int activeWorkers,  int availableWorkers)?  $default,) {final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
return $default(_that.appointmentsToday,_that.workersOnShift,_that.revenueToday,_that.pendingApprovals,_that.lastUpdated,_that.completedAppointments,_that.cancelledAppointments,_that.activeWorkers,_that.availableWorkers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodaySummary implements TodaySummary {
  const _TodaySummary({required this.appointmentsToday, required this.workersOnShift, required this.revenueToday, required this.pendingApprovals, required this.lastUpdated, this.completedAppointments = 0, this.cancelledAppointments = 0, this.activeWorkers = 0, this.availableWorkers = 0});
  factory _TodaySummary.fromJson(Map<String, dynamic> json) => _$TodaySummaryFromJson(json);

@override final  int appointmentsToday;
@override final  int workersOnShift;
@override final  double revenueToday;
@override final  int pendingApprovals;
@override final  DateTime lastUpdated;
@override@JsonKey() final  int completedAppointments;
@override@JsonKey() final  int cancelledAppointments;
@override@JsonKey() final  int activeWorkers;
@override@JsonKey() final  int availableWorkers;

/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodaySummaryCopyWith<_TodaySummary> get copyWith => __$TodaySummaryCopyWithImpl<_TodaySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodaySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodaySummary&&(identical(other.appointmentsToday, appointmentsToday) || other.appointmentsToday == appointmentsToday)&&(identical(other.workersOnShift, workersOnShift) || other.workersOnShift == workersOnShift)&&(identical(other.revenueToday, revenueToday) || other.revenueToday == revenueToday)&&(identical(other.pendingApprovals, pendingApprovals) || other.pendingApprovals == pendingApprovals)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.completedAppointments, completedAppointments) || other.completedAppointments == completedAppointments)&&(identical(other.cancelledAppointments, cancelledAppointments) || other.cancelledAppointments == cancelledAppointments)&&(identical(other.activeWorkers, activeWorkers) || other.activeWorkers == activeWorkers)&&(identical(other.availableWorkers, availableWorkers) || other.availableWorkers == availableWorkers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appointmentsToday,workersOnShift,revenueToday,pendingApprovals,lastUpdated,completedAppointments,cancelledAppointments,activeWorkers,availableWorkers);

@override
String toString() {
  return 'TodaySummary(appointmentsToday: $appointmentsToday, workersOnShift: $workersOnShift, revenueToday: $revenueToday, pendingApprovals: $pendingApprovals, lastUpdated: $lastUpdated, completedAppointments: $completedAppointments, cancelledAppointments: $cancelledAppointments, activeWorkers: $activeWorkers, availableWorkers: $availableWorkers)';
}


}

/// @nodoc
abstract mixin class _$TodaySummaryCopyWith<$Res> implements $TodaySummaryCopyWith<$Res> {
  factory _$TodaySummaryCopyWith(_TodaySummary value, $Res Function(_TodaySummary) _then) = __$TodaySummaryCopyWithImpl;
@override @useResult
$Res call({
 int appointmentsToday, int workersOnShift, double revenueToday, int pendingApprovals, DateTime lastUpdated, int completedAppointments, int cancelledAppointments, int activeWorkers, int availableWorkers
});




}
/// @nodoc
class __$TodaySummaryCopyWithImpl<$Res>
    implements _$TodaySummaryCopyWith<$Res> {
  __$TodaySummaryCopyWithImpl(this._self, this._then);

  final _TodaySummary _self;
  final $Res Function(_TodaySummary) _then;

/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentsToday = null,Object? workersOnShift = null,Object? revenueToday = null,Object? pendingApprovals = null,Object? lastUpdated = null,Object? completedAppointments = null,Object? cancelledAppointments = null,Object? activeWorkers = null,Object? availableWorkers = null,}) {
  return _then(_TodaySummary(
appointmentsToday: null == appointmentsToday ? _self.appointmentsToday : appointmentsToday // ignore: cast_nullable_to_non_nullable
as int,workersOnShift: null == workersOnShift ? _self.workersOnShift : workersOnShift // ignore: cast_nullable_to_non_nullable
as int,revenueToday: null == revenueToday ? _self.revenueToday : revenueToday // ignore: cast_nullable_to_non_nullable
as double,pendingApprovals: null == pendingApprovals ? _self.pendingApprovals : pendingApprovals // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,completedAppointments: null == completedAppointments ? _self.completedAppointments : completedAppointments // ignore: cast_nullable_to_non_nullable
as int,cancelledAppointments: null == cancelledAppointments ? _self.cancelledAppointments : cancelledAppointments // ignore: cast_nullable_to_non_nullable
as int,activeWorkers: null == activeWorkers ? _self.activeWorkers : activeWorkers // ignore: cast_nullable_to_non_nullable
as int,availableWorkers: null == availableWorkers ? _self.availableWorkers : availableWorkers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WorkerLocation {

 String get workerId; String get workerName; String get workerEmail; double get latitude; double get longitude; WorkerStatus get status; DateTime get lastUpdated; String? get currentAppointmentId; String? get currentClientName; String? get nextAppointmentId; String? get nextAppointmentTime; double? get speed; double? get heading;
/// Create a copy of WorkerLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkerLocationCopyWith<WorkerLocation> get copyWith => _$WorkerLocationCopyWithImpl<WorkerLocation>(this as WorkerLocation, _$identity);

  /// Serializes this WorkerLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkerLocation&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.workerEmail, workerEmail) || other.workerEmail == workerEmail)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.currentAppointmentId, currentAppointmentId) || other.currentAppointmentId == currentAppointmentId)&&(identical(other.currentClientName, currentClientName) || other.currentClientName == currentClientName)&&(identical(other.nextAppointmentId, nextAppointmentId) || other.nextAppointmentId == nextAppointmentId)&&(identical(other.nextAppointmentTime, nextAppointmentTime) || other.nextAppointmentTime == nextAppointmentTime)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.heading, heading) || other.heading == heading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerId,workerName,workerEmail,latitude,longitude,status,lastUpdated,currentAppointmentId,currentClientName,nextAppointmentId,nextAppointmentTime,speed,heading);

@override
String toString() {
  return 'WorkerLocation(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, latitude: $latitude, longitude: $longitude, status: $status, lastUpdated: $lastUpdated, currentAppointmentId: $currentAppointmentId, currentClientName: $currentClientName, nextAppointmentId: $nextAppointmentId, nextAppointmentTime: $nextAppointmentTime, speed: $speed, heading: $heading)';
}


}

/// @nodoc
abstract mixin class $WorkerLocationCopyWith<$Res>  {
  factory $WorkerLocationCopyWith(WorkerLocation value, $Res Function(WorkerLocation) _then) = _$WorkerLocationCopyWithImpl;
@useResult
$Res call({
 String workerId, String workerName, String workerEmail, double latitude, double longitude, WorkerStatus status, DateTime lastUpdated, String? currentAppointmentId, String? currentClientName, String? nextAppointmentId, String? nextAppointmentTime, double? speed, double? heading
});




}
/// @nodoc
class _$WorkerLocationCopyWithImpl<$Res>
    implements $WorkerLocationCopyWith<$Res> {
  _$WorkerLocationCopyWithImpl(this._self, this._then);

  final WorkerLocation _self;
  final $Res Function(WorkerLocation) _then;

/// Create a copy of WorkerLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? workerId = null,Object? workerName = null,Object? workerEmail = null,Object? latitude = null,Object? longitude = null,Object? status = null,Object? lastUpdated = null,Object? currentAppointmentId = freezed,Object? currentClientName = freezed,Object? nextAppointmentId = freezed,Object? nextAppointmentTime = freezed,Object? speed = freezed,Object? heading = freezed,}) {
  return _then(_self.copyWith(
workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,workerEmail: null == workerEmail ? _self.workerEmail : workerEmail // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WorkerStatus,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,currentAppointmentId: freezed == currentAppointmentId ? _self.currentAppointmentId : currentAppointmentId // ignore: cast_nullable_to_non_nullable
as String?,currentClientName: freezed == currentClientName ? _self.currentClientName : currentClientName // ignore: cast_nullable_to_non_nullable
as String?,nextAppointmentId: freezed == nextAppointmentId ? _self.nextAppointmentId : nextAppointmentId // ignore: cast_nullable_to_non_nullable
as String?,nextAppointmentTime: freezed == nextAppointmentTime ? _self.nextAppointmentTime : nextAppointmentTime // ignore: cast_nullable_to_non_nullable
as String?,speed: freezed == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double?,heading: freezed == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkerLocation].
extension WorkerLocationPatterns on WorkerLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkerLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkerLocation() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkerLocation value)  $default,){
final _that = this;
switch (_that) {
case _WorkerLocation():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkerLocation value)?  $default,){
final _that = this;
switch (_that) {
case _WorkerLocation() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String workerId,  String workerName,  String workerEmail,  double latitude,  double longitude,  WorkerStatus status,  DateTime lastUpdated,  String? currentAppointmentId,  String? currentClientName,  String? nextAppointmentId,  String? nextAppointmentTime,  double? speed,  double? heading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkerLocation() when $default != null:
return $default(_that.workerId,_that.workerName,_that.workerEmail,_that.latitude,_that.longitude,_that.status,_that.lastUpdated,_that.currentAppointmentId,_that.currentClientName,_that.nextAppointmentId,_that.nextAppointmentTime,_that.speed,_that.heading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String workerId,  String workerName,  String workerEmail,  double latitude,  double longitude,  WorkerStatus status,  DateTime lastUpdated,  String? currentAppointmentId,  String? currentClientName,  String? nextAppointmentId,  String? nextAppointmentTime,  double? speed,  double? heading)  $default,) {final _that = this;
switch (_that) {
case _WorkerLocation():
return $default(_that.workerId,_that.workerName,_that.workerEmail,_that.latitude,_that.longitude,_that.status,_that.lastUpdated,_that.currentAppointmentId,_that.currentClientName,_that.nextAppointmentId,_that.nextAppointmentTime,_that.speed,_that.heading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String workerId,  String workerName,  String workerEmail,  double latitude,  double longitude,  WorkerStatus status,  DateTime lastUpdated,  String? currentAppointmentId,  String? currentClientName,  String? nextAppointmentId,  String? nextAppointmentTime,  double? speed,  double? heading)?  $default,) {final _that = this;
switch (_that) {
case _WorkerLocation() when $default != null:
return $default(_that.workerId,_that.workerName,_that.workerEmail,_that.latitude,_that.longitude,_that.status,_that.lastUpdated,_that.currentAppointmentId,_that.currentClientName,_that.nextAppointmentId,_that.nextAppointmentTime,_that.speed,_that.heading);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkerLocation implements WorkerLocation {
  const _WorkerLocation({required this.workerId, required this.workerName, required this.workerEmail, required this.latitude, required this.longitude, required this.status, required this.lastUpdated, this.currentAppointmentId, this.currentClientName, this.nextAppointmentId, this.nextAppointmentTime, this.speed, this.heading});
  factory _WorkerLocation.fromJson(Map<String, dynamic> json) => _$WorkerLocationFromJson(json);

@override final  String workerId;
@override final  String workerName;
@override final  String workerEmail;
@override final  double latitude;
@override final  double longitude;
@override final  WorkerStatus status;
@override final  DateTime lastUpdated;
@override final  String? currentAppointmentId;
@override final  String? currentClientName;
@override final  String? nextAppointmentId;
@override final  String? nextAppointmentTime;
@override final  double? speed;
@override final  double? heading;

/// Create a copy of WorkerLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkerLocationCopyWith<_WorkerLocation> get copyWith => __$WorkerLocationCopyWithImpl<_WorkerLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkerLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkerLocation&&(identical(other.workerId, workerId) || other.workerId == workerId)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.workerEmail, workerEmail) || other.workerEmail == workerEmail)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.currentAppointmentId, currentAppointmentId) || other.currentAppointmentId == currentAppointmentId)&&(identical(other.currentClientName, currentClientName) || other.currentClientName == currentClientName)&&(identical(other.nextAppointmentId, nextAppointmentId) || other.nextAppointmentId == nextAppointmentId)&&(identical(other.nextAppointmentTime, nextAppointmentTime) || other.nextAppointmentTime == nextAppointmentTime)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.heading, heading) || other.heading == heading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,workerId,workerName,workerEmail,latitude,longitude,status,lastUpdated,currentAppointmentId,currentClientName,nextAppointmentId,nextAppointmentTime,speed,heading);

@override
String toString() {
  return 'WorkerLocation(workerId: $workerId, workerName: $workerName, workerEmail: $workerEmail, latitude: $latitude, longitude: $longitude, status: $status, lastUpdated: $lastUpdated, currentAppointmentId: $currentAppointmentId, currentClientName: $currentClientName, nextAppointmentId: $nextAppointmentId, nextAppointmentTime: $nextAppointmentTime, speed: $speed, heading: $heading)';
}


}

/// @nodoc
abstract mixin class _$WorkerLocationCopyWith<$Res> implements $WorkerLocationCopyWith<$Res> {
  factory _$WorkerLocationCopyWith(_WorkerLocation value, $Res Function(_WorkerLocation) _then) = __$WorkerLocationCopyWithImpl;
@override @useResult
$Res call({
 String workerId, String workerName, String workerEmail, double latitude, double longitude, WorkerStatus status, DateTime lastUpdated, String? currentAppointmentId, String? currentClientName, String? nextAppointmentId, String? nextAppointmentTime, double? speed, double? heading
});




}
/// @nodoc
class __$WorkerLocationCopyWithImpl<$Res>
    implements _$WorkerLocationCopyWith<$Res> {
  __$WorkerLocationCopyWithImpl(this._self, this._then);

  final _WorkerLocation _self;
  final $Res Function(_WorkerLocation) _then;

/// Create a copy of WorkerLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? workerId = null,Object? workerName = null,Object? workerEmail = null,Object? latitude = null,Object? longitude = null,Object? status = null,Object? lastUpdated = null,Object? currentAppointmentId = freezed,Object? currentClientName = freezed,Object? nextAppointmentId = freezed,Object? nextAppointmentTime = freezed,Object? speed = freezed,Object? heading = freezed,}) {
  return _then(_WorkerLocation(
workerId: null == workerId ? _self.workerId : workerId // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,workerEmail: null == workerEmail ? _self.workerEmail : workerEmail // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WorkerStatus,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,currentAppointmentId: freezed == currentAppointmentId ? _self.currentAppointmentId : currentAppointmentId // ignore: cast_nullable_to_non_nullable
as String?,currentClientName: freezed == currentClientName ? _self.currentClientName : currentClientName // ignore: cast_nullable_to_non_nullable
as String?,nextAppointmentId: freezed == nextAppointmentId ? _self.nextAppointmentId : nextAppointmentId // ignore: cast_nullable_to_non_nullable
as String?,nextAppointmentTime: freezed == nextAppointmentTime ? _self.nextAppointmentTime : nextAppointmentTime // ignore: cast_nullable_to_non_nullable
as String?,speed: freezed == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double?,heading: freezed == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$QuickAction {

 String get id; String get title; String get icon; int get count; QuickActionType get type; String? get route; Map<String, dynamic>? get metadata;
/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickActionCopyWith<QuickAction> get copyWith => _$QuickActionCopyWithImpl<QuickAction>(this as QuickAction, _$identity);

  /// Serializes this QuickAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickAction&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.count, count) || other.count == count)&&(identical(other.type, type) || other.type == type)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,icon,count,type,route,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'QuickAction(id: $id, title: $title, icon: $icon, count: $count, type: $type, route: $route, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $QuickActionCopyWith<$Res>  {
  factory $QuickActionCopyWith(QuickAction value, $Res Function(QuickAction) _then) = _$QuickActionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String icon, int count, QuickActionType type, String? route, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$QuickActionCopyWithImpl<$Res>
    implements $QuickActionCopyWith<$Res> {
  _$QuickActionCopyWithImpl(this._self, this._then);

  final QuickAction _self;
  final $Res Function(QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? icon = null,Object? count = null,Object? type = null,Object? route = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuickActionType,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickAction].
extension QuickActionPatterns on QuickAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickAction value)  $default,){
final _that = this;
switch (_that) {
case _QuickAction():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickAction value)?  $default,){
final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String icon,  int count,  QuickActionType type,  String? route,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.id,_that.title,_that.icon,_that.count,_that.type,_that.route,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String icon,  int count,  QuickActionType type,  String? route,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _QuickAction():
return $default(_that.id,_that.title,_that.icon,_that.count,_that.type,_that.route,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String icon,  int count,  QuickActionType type,  String? route,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _QuickAction() when $default != null:
return $default(_that.id,_that.title,_that.icon,_that.count,_that.type,_that.route,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuickAction implements QuickAction {
  const _QuickAction({required this.id, required this.title, required this.icon, required this.count, required this.type, this.route, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _QuickAction.fromJson(Map<String, dynamic> json) => _$QuickActionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String icon;
@override final  int count;
@override final  QuickActionType type;
@override final  String? route;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickActionCopyWith<_QuickAction> get copyWith => __$QuickActionCopyWithImpl<_QuickAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuickActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickAction&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.count, count) || other.count == count)&&(identical(other.type, type) || other.type == type)&&(identical(other.route, route) || other.route == route)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,icon,count,type,route,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'QuickAction(id: $id, title: $title, icon: $icon, count: $count, type: $type, route: $route, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$QuickActionCopyWith<$Res> implements $QuickActionCopyWith<$Res> {
  factory _$QuickActionCopyWith(_QuickAction value, $Res Function(_QuickAction) _then) = __$QuickActionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String icon, int count, QuickActionType type, String? route, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$QuickActionCopyWithImpl<$Res>
    implements _$QuickActionCopyWith<$Res> {
  __$QuickActionCopyWithImpl(this._self, this._then);

  final _QuickAction _self;
  final $Res Function(_QuickAction) _then;

/// Create a copy of QuickAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? icon = null,Object? count = null,Object? type = null,Object? route = freezed,Object? metadata = freezed,}) {
  return _then(_QuickAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuickActionType,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ComplianceAlert {

 String get id; ComplianceAlertType get type; String get title; String get description; int get count; ComplianceSeverity get severity; DateTime get dueDate; List<String>? get affectedWorkerIds; String? get actionRoute;
/// Create a copy of ComplianceAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceAlertCopyWith<ComplianceAlert> get copyWith => _$ComplianceAlertCopyWithImpl<ComplianceAlert>(this as ComplianceAlert, _$identity);

  /// Serializes this ComplianceAlert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.count, count) || other.count == count)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other.affectedWorkerIds, affectedWorkerIds)&&(identical(other.actionRoute, actionRoute) || other.actionRoute == actionRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,count,severity,dueDate,const DeepCollectionEquality().hash(affectedWorkerIds),actionRoute);

@override
String toString() {
  return 'ComplianceAlert(id: $id, type: $type, title: $title, description: $description, count: $count, severity: $severity, dueDate: $dueDate, affectedWorkerIds: $affectedWorkerIds, actionRoute: $actionRoute)';
}


}

/// @nodoc
abstract mixin class $ComplianceAlertCopyWith<$Res>  {
  factory $ComplianceAlertCopyWith(ComplianceAlert value, $Res Function(ComplianceAlert) _then) = _$ComplianceAlertCopyWithImpl;
@useResult
$Res call({
 String id, ComplianceAlertType type, String title, String description, int count, ComplianceSeverity severity, DateTime dueDate, List<String>? affectedWorkerIds, String? actionRoute
});




}
/// @nodoc
class _$ComplianceAlertCopyWithImpl<$Res>
    implements $ComplianceAlertCopyWith<$Res> {
  _$ComplianceAlertCopyWithImpl(this._self, this._then);

  final ComplianceAlert _self;
  final $Res Function(ComplianceAlert) _then;

/// Create a copy of ComplianceAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? count = null,Object? severity = null,Object? dueDate = null,Object? affectedWorkerIds = freezed,Object? actionRoute = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ComplianceAlertType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as ComplianceSeverity,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,affectedWorkerIds: freezed == affectedWorkerIds ? _self.affectedWorkerIds : affectedWorkerIds // ignore: cast_nullable_to_non_nullable
as List<String>?,actionRoute: freezed == actionRoute ? _self.actionRoute : actionRoute // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplianceAlert].
extension ComplianceAlertPatterns on ComplianceAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceAlert() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceAlert value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceAlert():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceAlert value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceAlert() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ComplianceAlertType type,  String title,  String description,  int count,  ComplianceSeverity severity,  DateTime dueDate,  List<String>? affectedWorkerIds,  String? actionRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceAlert() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.count,_that.severity,_that.dueDate,_that.affectedWorkerIds,_that.actionRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ComplianceAlertType type,  String title,  String description,  int count,  ComplianceSeverity severity,  DateTime dueDate,  List<String>? affectedWorkerIds,  String? actionRoute)  $default,) {final _that = this;
switch (_that) {
case _ComplianceAlert():
return $default(_that.id,_that.type,_that.title,_that.description,_that.count,_that.severity,_that.dueDate,_that.affectedWorkerIds,_that.actionRoute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ComplianceAlertType type,  String title,  String description,  int count,  ComplianceSeverity severity,  DateTime dueDate,  List<String>? affectedWorkerIds,  String? actionRoute)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceAlert() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.count,_that.severity,_that.dueDate,_that.affectedWorkerIds,_that.actionRoute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplianceAlert implements ComplianceAlert {
  const _ComplianceAlert({required this.id, required this.type, required this.title, required this.description, required this.count, required this.severity, required this.dueDate, final  List<String>? affectedWorkerIds, this.actionRoute}): _affectedWorkerIds = affectedWorkerIds;
  factory _ComplianceAlert.fromJson(Map<String, dynamic> json) => _$ComplianceAlertFromJson(json);

@override final  String id;
@override final  ComplianceAlertType type;
@override final  String title;
@override final  String description;
@override final  int count;
@override final  ComplianceSeverity severity;
@override final  DateTime dueDate;
 final  List<String>? _affectedWorkerIds;
@override List<String>? get affectedWorkerIds {
  final value = _affectedWorkerIds;
  if (value == null) return null;
  if (_affectedWorkerIds is EqualUnmodifiableListView) return _affectedWorkerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? actionRoute;

/// Create a copy of ComplianceAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceAlertCopyWith<_ComplianceAlert> get copyWith => __$ComplianceAlertCopyWithImpl<_ComplianceAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplianceAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.count, count) || other.count == count)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&const DeepCollectionEquality().equals(other._affectedWorkerIds, _affectedWorkerIds)&&(identical(other.actionRoute, actionRoute) || other.actionRoute == actionRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,count,severity,dueDate,const DeepCollectionEquality().hash(_affectedWorkerIds),actionRoute);

@override
String toString() {
  return 'ComplianceAlert(id: $id, type: $type, title: $title, description: $description, count: $count, severity: $severity, dueDate: $dueDate, affectedWorkerIds: $affectedWorkerIds, actionRoute: $actionRoute)';
}


}

/// @nodoc
abstract mixin class _$ComplianceAlertCopyWith<$Res> implements $ComplianceAlertCopyWith<$Res> {
  factory _$ComplianceAlertCopyWith(_ComplianceAlert value, $Res Function(_ComplianceAlert) _then) = __$ComplianceAlertCopyWithImpl;
@override @useResult
$Res call({
 String id, ComplianceAlertType type, String title, String description, int count, ComplianceSeverity severity, DateTime dueDate, List<String>? affectedWorkerIds, String? actionRoute
});




}
/// @nodoc
class __$ComplianceAlertCopyWithImpl<$Res>
    implements _$ComplianceAlertCopyWith<$Res> {
  __$ComplianceAlertCopyWithImpl(this._self, this._then);

  final _ComplianceAlert _self;
  final $Res Function(_ComplianceAlert) _then;

/// Create a copy of ComplianceAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = null,Object? count = null,Object? severity = null,Object? dueDate = null,Object? affectedWorkerIds = freezed,Object? actionRoute = freezed,}) {
  return _then(_ComplianceAlert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ComplianceAlertType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as ComplianceSeverity,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,affectedWorkerIds: freezed == affectedWorkerIds ? _self._affectedWorkerIds : affectedWorkerIds // ignore: cast_nullable_to_non_nullable
as List<String>?,actionRoute: freezed == actionRoute ? _self.actionRoute : actionRoute // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RevenueDataPoint {

 DateTime get date; double get revenue; double get expenses; double get profit; String? get label;
/// Create a copy of RevenueDataPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueDataPointCopyWith<RevenueDataPoint> get copyWith => _$RevenueDataPointCopyWithImpl<RevenueDataPoint>(this as RevenueDataPoint, _$identity);

  /// Serializes this RevenueDataPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueDataPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,revenue,expenses,profit,label);

@override
String toString() {
  return 'RevenueDataPoint(date: $date, revenue: $revenue, expenses: $expenses, profit: $profit, label: $label)';
}


}

/// @nodoc
abstract mixin class $RevenueDataPointCopyWith<$Res>  {
  factory $RevenueDataPointCopyWith(RevenueDataPoint value, $Res Function(RevenueDataPoint) _then) = _$RevenueDataPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, double revenue, double expenses, double profit, String? label
});




}
/// @nodoc
class _$RevenueDataPointCopyWithImpl<$Res>
    implements $RevenueDataPointCopyWith<$Res> {
  _$RevenueDataPointCopyWithImpl(this._self, this._then);

  final RevenueDataPoint _self;
  final $Res Function(RevenueDataPoint) _then;

/// Create a copy of RevenueDataPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? revenue = null,Object? expenses = null,Object? profit = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueDataPoint].
extension RevenueDataPointPatterns on RevenueDataPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueDataPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueDataPoint() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueDataPoint value)  $default,){
final _that = this;
switch (_that) {
case _RevenueDataPoint():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueDataPoint value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueDataPoint() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double revenue,  double expenses,  double profit,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueDataPoint() when $default != null:
return $default(_that.date,_that.revenue,_that.expenses,_that.profit,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double revenue,  double expenses,  double profit,  String? label)  $default,) {final _that = this;
switch (_that) {
case _RevenueDataPoint():
return $default(_that.date,_that.revenue,_that.expenses,_that.profit,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double revenue,  double expenses,  double profit,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _RevenueDataPoint() when $default != null:
return $default(_that.date,_that.revenue,_that.expenses,_that.profit,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueDataPoint implements RevenueDataPoint {
  const _RevenueDataPoint({required this.date, required this.revenue, required this.expenses, required this.profit, this.label});
  factory _RevenueDataPoint.fromJson(Map<String, dynamic> json) => _$RevenueDataPointFromJson(json);

@override final  DateTime date;
@override final  double revenue;
@override final  double expenses;
@override final  double profit;
@override final  String? label;

/// Create a copy of RevenueDataPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueDataPointCopyWith<_RevenueDataPoint> get copyWith => __$RevenueDataPointCopyWithImpl<_RevenueDataPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueDataPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueDataPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.expenses, expenses) || other.expenses == expenses)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,revenue,expenses,profit,label);

@override
String toString() {
  return 'RevenueDataPoint(date: $date, revenue: $revenue, expenses: $expenses, profit: $profit, label: $label)';
}


}

/// @nodoc
abstract mixin class _$RevenueDataPointCopyWith<$Res> implements $RevenueDataPointCopyWith<$Res> {
  factory _$RevenueDataPointCopyWith(_RevenueDataPoint value, $Res Function(_RevenueDataPoint) _then) = __$RevenueDataPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double revenue, double expenses, double profit, String? label
});




}
/// @nodoc
class __$RevenueDataPointCopyWithImpl<$Res>
    implements _$RevenueDataPointCopyWith<$Res> {
  __$RevenueDataPointCopyWithImpl(this._self, this._then);

  final _RevenueDataPoint _self;
  final $Res Function(_RevenueDataPoint) _then;

/// Create a copy of RevenueDataPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? revenue = null,Object? expenses = null,Object? profit = null,Object? label = freezed,}) {
  return _then(_RevenueDataPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,expenses: null == expenses ? _self.expenses : expenses // ignore: cast_nullable_to_non_nullable
as double,profit: null == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as double,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RevenueComparison {

 double get todayRevenue; double get yesterdayRevenue; double get weekToDateRevenue; double get monthToDateRevenue; double get todayVsYesterdayPercent; double get weekVsLastWeekPercent; double get monthVsLastMonthPercent; TrendDirection get todayTrend; TrendDirection get weekTrend; TrendDirection get monthTrend; List<RevenueDataPoint> get last7Days; List<RevenueDataPoint> get last30Days;
/// Create a copy of RevenueComparison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueComparisonCopyWith<RevenueComparison> get copyWith => _$RevenueComparisonCopyWithImpl<RevenueComparison>(this as RevenueComparison, _$identity);

  /// Serializes this RevenueComparison to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueComparison&&(identical(other.todayRevenue, todayRevenue) || other.todayRevenue == todayRevenue)&&(identical(other.yesterdayRevenue, yesterdayRevenue) || other.yesterdayRevenue == yesterdayRevenue)&&(identical(other.weekToDateRevenue, weekToDateRevenue) || other.weekToDateRevenue == weekToDateRevenue)&&(identical(other.monthToDateRevenue, monthToDateRevenue) || other.monthToDateRevenue == monthToDateRevenue)&&(identical(other.todayVsYesterdayPercent, todayVsYesterdayPercent) || other.todayVsYesterdayPercent == todayVsYesterdayPercent)&&(identical(other.weekVsLastWeekPercent, weekVsLastWeekPercent) || other.weekVsLastWeekPercent == weekVsLastWeekPercent)&&(identical(other.monthVsLastMonthPercent, monthVsLastMonthPercent) || other.monthVsLastMonthPercent == monthVsLastMonthPercent)&&(identical(other.todayTrend, todayTrend) || other.todayTrend == todayTrend)&&(identical(other.weekTrend, weekTrend) || other.weekTrend == weekTrend)&&(identical(other.monthTrend, monthTrend) || other.monthTrend == monthTrend)&&const DeepCollectionEquality().equals(other.last7Days, last7Days)&&const DeepCollectionEquality().equals(other.last30Days, last30Days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayRevenue,yesterdayRevenue,weekToDateRevenue,monthToDateRevenue,todayVsYesterdayPercent,weekVsLastWeekPercent,monthVsLastMonthPercent,todayTrend,weekTrend,monthTrend,const DeepCollectionEquality().hash(last7Days),const DeepCollectionEquality().hash(last30Days));

@override
String toString() {
  return 'RevenueComparison(todayRevenue: $todayRevenue, yesterdayRevenue: $yesterdayRevenue, weekToDateRevenue: $weekToDateRevenue, monthToDateRevenue: $monthToDateRevenue, todayVsYesterdayPercent: $todayVsYesterdayPercent, weekVsLastWeekPercent: $weekVsLastWeekPercent, monthVsLastMonthPercent: $monthVsLastMonthPercent, todayTrend: $todayTrend, weekTrend: $weekTrend, monthTrend: $monthTrend, last7Days: $last7Days, last30Days: $last30Days)';
}


}

/// @nodoc
abstract mixin class $RevenueComparisonCopyWith<$Res>  {
  factory $RevenueComparisonCopyWith(RevenueComparison value, $Res Function(RevenueComparison) _then) = _$RevenueComparisonCopyWithImpl;
@useResult
$Res call({
 double todayRevenue, double yesterdayRevenue, double weekToDateRevenue, double monthToDateRevenue, double todayVsYesterdayPercent, double weekVsLastWeekPercent, double monthVsLastMonthPercent, TrendDirection todayTrend, TrendDirection weekTrend, TrendDirection monthTrend, List<RevenueDataPoint> last7Days, List<RevenueDataPoint> last30Days
});




}
/// @nodoc
class _$RevenueComparisonCopyWithImpl<$Res>
    implements $RevenueComparisonCopyWith<$Res> {
  _$RevenueComparisonCopyWithImpl(this._self, this._then);

  final RevenueComparison _self;
  final $Res Function(RevenueComparison) _then;

/// Create a copy of RevenueComparison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayRevenue = null,Object? yesterdayRevenue = null,Object? weekToDateRevenue = null,Object? monthToDateRevenue = null,Object? todayVsYesterdayPercent = null,Object? weekVsLastWeekPercent = null,Object? monthVsLastMonthPercent = null,Object? todayTrend = null,Object? weekTrend = null,Object? monthTrend = null,Object? last7Days = null,Object? last30Days = null,}) {
  return _then(_self.copyWith(
todayRevenue: null == todayRevenue ? _self.todayRevenue : todayRevenue // ignore: cast_nullable_to_non_nullable
as double,yesterdayRevenue: null == yesterdayRevenue ? _self.yesterdayRevenue : yesterdayRevenue // ignore: cast_nullable_to_non_nullable
as double,weekToDateRevenue: null == weekToDateRevenue ? _self.weekToDateRevenue : weekToDateRevenue // ignore: cast_nullable_to_non_nullable
as double,monthToDateRevenue: null == monthToDateRevenue ? _self.monthToDateRevenue : monthToDateRevenue // ignore: cast_nullable_to_non_nullable
as double,todayVsYesterdayPercent: null == todayVsYesterdayPercent ? _self.todayVsYesterdayPercent : todayVsYesterdayPercent // ignore: cast_nullable_to_non_nullable
as double,weekVsLastWeekPercent: null == weekVsLastWeekPercent ? _self.weekVsLastWeekPercent : weekVsLastWeekPercent // ignore: cast_nullable_to_non_nullable
as double,monthVsLastMonthPercent: null == monthVsLastMonthPercent ? _self.monthVsLastMonthPercent : monthVsLastMonthPercent // ignore: cast_nullable_to_non_nullable
as double,todayTrend: null == todayTrend ? _self.todayTrend : todayTrend // ignore: cast_nullable_to_non_nullable
as TrendDirection,weekTrend: null == weekTrend ? _self.weekTrend : weekTrend // ignore: cast_nullable_to_non_nullable
as TrendDirection,monthTrend: null == monthTrend ? _self.monthTrend : monthTrend // ignore: cast_nullable_to_non_nullable
as TrendDirection,last7Days: null == last7Days ? _self.last7Days : last7Days // ignore: cast_nullable_to_non_nullable
as List<RevenueDataPoint>,last30Days: null == last30Days ? _self.last30Days : last30Days // ignore: cast_nullable_to_non_nullable
as List<RevenueDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueComparison].
extension RevenueComparisonPatterns on RevenueComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueComparison() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueComparison value)  $default,){
final _that = this;
switch (_that) {
case _RevenueComparison():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueComparison value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueComparison() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double todayRevenue,  double yesterdayRevenue,  double weekToDateRevenue,  double monthToDateRevenue,  double todayVsYesterdayPercent,  double weekVsLastWeekPercent,  double monthVsLastMonthPercent,  TrendDirection todayTrend,  TrendDirection weekTrend,  TrendDirection monthTrend,  List<RevenueDataPoint> last7Days,  List<RevenueDataPoint> last30Days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueComparison() when $default != null:
return $default(_that.todayRevenue,_that.yesterdayRevenue,_that.weekToDateRevenue,_that.monthToDateRevenue,_that.todayVsYesterdayPercent,_that.weekVsLastWeekPercent,_that.monthVsLastMonthPercent,_that.todayTrend,_that.weekTrend,_that.monthTrend,_that.last7Days,_that.last30Days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double todayRevenue,  double yesterdayRevenue,  double weekToDateRevenue,  double monthToDateRevenue,  double todayVsYesterdayPercent,  double weekVsLastWeekPercent,  double monthVsLastMonthPercent,  TrendDirection todayTrend,  TrendDirection weekTrend,  TrendDirection monthTrend,  List<RevenueDataPoint> last7Days,  List<RevenueDataPoint> last30Days)  $default,) {final _that = this;
switch (_that) {
case _RevenueComparison():
return $default(_that.todayRevenue,_that.yesterdayRevenue,_that.weekToDateRevenue,_that.monthToDateRevenue,_that.todayVsYesterdayPercent,_that.weekVsLastWeekPercent,_that.monthVsLastMonthPercent,_that.todayTrend,_that.weekTrend,_that.monthTrend,_that.last7Days,_that.last30Days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double todayRevenue,  double yesterdayRevenue,  double weekToDateRevenue,  double monthToDateRevenue,  double todayVsYesterdayPercent,  double weekVsLastWeekPercent,  double monthVsLastMonthPercent,  TrendDirection todayTrend,  TrendDirection weekTrend,  TrendDirection monthTrend,  List<RevenueDataPoint> last7Days,  List<RevenueDataPoint> last30Days)?  $default,) {final _that = this;
switch (_that) {
case _RevenueComparison() when $default != null:
return $default(_that.todayRevenue,_that.yesterdayRevenue,_that.weekToDateRevenue,_that.monthToDateRevenue,_that.todayVsYesterdayPercent,_that.weekVsLastWeekPercent,_that.monthVsLastMonthPercent,_that.todayTrend,_that.weekTrend,_that.monthTrend,_that.last7Days,_that.last30Days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevenueComparison implements RevenueComparison {
  const _RevenueComparison({required this.todayRevenue, required this.yesterdayRevenue, required this.weekToDateRevenue, required this.monthToDateRevenue, required this.todayVsYesterdayPercent, required this.weekVsLastWeekPercent, required this.monthVsLastMonthPercent, required this.todayTrend, required this.weekTrend, required this.monthTrend, required final  List<RevenueDataPoint> last7Days, required final  List<RevenueDataPoint> last30Days}): _last7Days = last7Days,_last30Days = last30Days;
  factory _RevenueComparison.fromJson(Map<String, dynamic> json) => _$RevenueComparisonFromJson(json);

@override final  double todayRevenue;
@override final  double yesterdayRevenue;
@override final  double weekToDateRevenue;
@override final  double monthToDateRevenue;
@override final  double todayVsYesterdayPercent;
@override final  double weekVsLastWeekPercent;
@override final  double monthVsLastMonthPercent;
@override final  TrendDirection todayTrend;
@override final  TrendDirection weekTrend;
@override final  TrendDirection monthTrend;
 final  List<RevenueDataPoint> _last7Days;
@override List<RevenueDataPoint> get last7Days {
  if (_last7Days is EqualUnmodifiableListView) return _last7Days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_last7Days);
}

 final  List<RevenueDataPoint> _last30Days;
@override List<RevenueDataPoint> get last30Days {
  if (_last30Days is EqualUnmodifiableListView) return _last30Days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_last30Days);
}


/// Create a copy of RevenueComparison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueComparisonCopyWith<_RevenueComparison> get copyWith => __$RevenueComparisonCopyWithImpl<_RevenueComparison>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueComparisonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueComparison&&(identical(other.todayRevenue, todayRevenue) || other.todayRevenue == todayRevenue)&&(identical(other.yesterdayRevenue, yesterdayRevenue) || other.yesterdayRevenue == yesterdayRevenue)&&(identical(other.weekToDateRevenue, weekToDateRevenue) || other.weekToDateRevenue == weekToDateRevenue)&&(identical(other.monthToDateRevenue, monthToDateRevenue) || other.monthToDateRevenue == monthToDateRevenue)&&(identical(other.todayVsYesterdayPercent, todayVsYesterdayPercent) || other.todayVsYesterdayPercent == todayVsYesterdayPercent)&&(identical(other.weekVsLastWeekPercent, weekVsLastWeekPercent) || other.weekVsLastWeekPercent == weekVsLastWeekPercent)&&(identical(other.monthVsLastMonthPercent, monthVsLastMonthPercent) || other.monthVsLastMonthPercent == monthVsLastMonthPercent)&&(identical(other.todayTrend, todayTrend) || other.todayTrend == todayTrend)&&(identical(other.weekTrend, weekTrend) || other.weekTrend == weekTrend)&&(identical(other.monthTrend, monthTrend) || other.monthTrend == monthTrend)&&const DeepCollectionEquality().equals(other._last7Days, _last7Days)&&const DeepCollectionEquality().equals(other._last30Days, _last30Days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayRevenue,yesterdayRevenue,weekToDateRevenue,monthToDateRevenue,todayVsYesterdayPercent,weekVsLastWeekPercent,monthVsLastMonthPercent,todayTrend,weekTrend,monthTrend,const DeepCollectionEquality().hash(_last7Days),const DeepCollectionEquality().hash(_last30Days));

@override
String toString() {
  return 'RevenueComparison(todayRevenue: $todayRevenue, yesterdayRevenue: $yesterdayRevenue, weekToDateRevenue: $weekToDateRevenue, monthToDateRevenue: $monthToDateRevenue, todayVsYesterdayPercent: $todayVsYesterdayPercent, weekVsLastWeekPercent: $weekVsLastWeekPercent, monthVsLastMonthPercent: $monthVsLastMonthPercent, todayTrend: $todayTrend, weekTrend: $weekTrend, monthTrend: $monthTrend, last7Days: $last7Days, last30Days: $last30Days)';
}


}

/// @nodoc
abstract mixin class _$RevenueComparisonCopyWith<$Res> implements $RevenueComparisonCopyWith<$Res> {
  factory _$RevenueComparisonCopyWith(_RevenueComparison value, $Res Function(_RevenueComparison) _then) = __$RevenueComparisonCopyWithImpl;
@override @useResult
$Res call({
 double todayRevenue, double yesterdayRevenue, double weekToDateRevenue, double monthToDateRevenue, double todayVsYesterdayPercent, double weekVsLastWeekPercent, double monthVsLastMonthPercent, TrendDirection todayTrend, TrendDirection weekTrend, TrendDirection monthTrend, List<RevenueDataPoint> last7Days, List<RevenueDataPoint> last30Days
});




}
/// @nodoc
class __$RevenueComparisonCopyWithImpl<$Res>
    implements _$RevenueComparisonCopyWith<$Res> {
  __$RevenueComparisonCopyWithImpl(this._self, this._then);

  final _RevenueComparison _self;
  final $Res Function(_RevenueComparison) _then;

/// Create a copy of RevenueComparison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayRevenue = null,Object? yesterdayRevenue = null,Object? weekToDateRevenue = null,Object? monthToDateRevenue = null,Object? todayVsYesterdayPercent = null,Object? weekVsLastWeekPercent = null,Object? monthVsLastMonthPercent = null,Object? todayTrend = null,Object? weekTrend = null,Object? monthTrend = null,Object? last7Days = null,Object? last30Days = null,}) {
  return _then(_RevenueComparison(
todayRevenue: null == todayRevenue ? _self.todayRevenue : todayRevenue // ignore: cast_nullable_to_non_nullable
as double,yesterdayRevenue: null == yesterdayRevenue ? _self.yesterdayRevenue : yesterdayRevenue // ignore: cast_nullable_to_non_nullable
as double,weekToDateRevenue: null == weekToDateRevenue ? _self.weekToDateRevenue : weekToDateRevenue // ignore: cast_nullable_to_non_nullable
as double,monthToDateRevenue: null == monthToDateRevenue ? _self.monthToDateRevenue : monthToDateRevenue // ignore: cast_nullable_to_non_nullable
as double,todayVsYesterdayPercent: null == todayVsYesterdayPercent ? _self.todayVsYesterdayPercent : todayVsYesterdayPercent // ignore: cast_nullable_to_non_nullable
as double,weekVsLastWeekPercent: null == weekVsLastWeekPercent ? _self.weekVsLastWeekPercent : weekVsLastWeekPercent // ignore: cast_nullable_to_non_nullable
as double,monthVsLastMonthPercent: null == monthVsLastMonthPercent ? _self.monthVsLastMonthPercent : monthVsLastMonthPercent // ignore: cast_nullable_to_non_nullable
as double,todayTrend: null == todayTrend ? _self.todayTrend : todayTrend // ignore: cast_nullable_to_non_nullable
as TrendDirection,weekTrend: null == weekTrend ? _self.weekTrend : weekTrend // ignore: cast_nullable_to_non_nullable
as TrendDirection,monthTrend: null == monthTrend ? _self.monthTrend : monthTrend // ignore: cast_nullable_to_non_nullable
as TrendDirection,last7Days: null == last7Days ? _self._last7Days : last7Days // ignore: cast_nullable_to_non_nullable
as List<RevenueDataPoint>,last30Days: null == last30Days ? _self._last30Days : last30Days // ignore: cast_nullable_to_non_nullable
as List<RevenueDataPoint>,
  ));
}


}


/// @nodoc
mixin _$DashboardState {

 TodaySummary? get todaySummary; List<WorkerLocation>? get workerLocations; List<QuickAction>? get quickActions; List<ComplianceAlert>? get complianceAlerts; RevenueComparison? get revenueComparison; bool get isLoading; String? get error; DateTime? get lastRefreshed;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);

  /// Serializes this DashboardState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.todaySummary, todaySummary) || other.todaySummary == todaySummary)&&const DeepCollectionEquality().equals(other.workerLocations, workerLocations)&&const DeepCollectionEquality().equals(other.quickActions, quickActions)&&const DeepCollectionEquality().equals(other.complianceAlerts, complianceAlerts)&&(identical(other.revenueComparison, revenueComparison) || other.revenueComparison == revenueComparison)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.lastRefreshed, lastRefreshed) || other.lastRefreshed == lastRefreshed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todaySummary,const DeepCollectionEquality().hash(workerLocations),const DeepCollectionEquality().hash(quickActions),const DeepCollectionEquality().hash(complianceAlerts),revenueComparison,isLoading,error,lastRefreshed);

@override
String toString() {
  return 'DashboardState(todaySummary: $todaySummary, workerLocations: $workerLocations, quickActions: $quickActions, complianceAlerts: $complianceAlerts, revenueComparison: $revenueComparison, isLoading: $isLoading, error: $error, lastRefreshed: $lastRefreshed)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 TodaySummary? todaySummary, List<WorkerLocation>? workerLocations, List<QuickAction>? quickActions, List<ComplianceAlert>? complianceAlerts, RevenueComparison? revenueComparison, bool isLoading, String? error, DateTime? lastRefreshed
});


$TodaySummaryCopyWith<$Res>? get todaySummary;$RevenueComparisonCopyWith<$Res>? get revenueComparison;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todaySummary = freezed,Object? workerLocations = freezed,Object? quickActions = freezed,Object? complianceAlerts = freezed,Object? revenueComparison = freezed,Object? isLoading = null,Object? error = freezed,Object? lastRefreshed = freezed,}) {
  return _then(_self.copyWith(
todaySummary: freezed == todaySummary ? _self.todaySummary : todaySummary // ignore: cast_nullable_to_non_nullable
as TodaySummary?,workerLocations: freezed == workerLocations ? _self.workerLocations : workerLocations // ignore: cast_nullable_to_non_nullable
as List<WorkerLocation>?,quickActions: freezed == quickActions ? _self.quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>?,complianceAlerts: freezed == complianceAlerts ? _self.complianceAlerts : complianceAlerts // ignore: cast_nullable_to_non_nullable
as List<ComplianceAlert>?,revenueComparison: freezed == revenueComparison ? _self.revenueComparison : revenueComparison // ignore: cast_nullable_to_non_nullable
as RevenueComparison?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,lastRefreshed: freezed == lastRefreshed ? _self.lastRefreshed : lastRefreshed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodaySummaryCopyWith<$Res>? get todaySummary {
    if (_self.todaySummary == null) {
    return null;
  }

  return $TodaySummaryCopyWith<$Res>(_self.todaySummary!, (value) {
    return _then(_self.copyWith(todaySummary: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevenueComparisonCopyWith<$Res>? get revenueComparison {
    if (_self.revenueComparison == null) {
    return null;
  }

  return $RevenueComparisonCopyWith<$Res>(_self.revenueComparison!, (value) {
    return _then(_self.copyWith(revenueComparison: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodaySummary? todaySummary,  List<WorkerLocation>? workerLocations,  List<QuickAction>? quickActions,  List<ComplianceAlert>? complianceAlerts,  RevenueComparison? revenueComparison,  bool isLoading,  String? error,  DateTime? lastRefreshed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.todaySummary,_that.workerLocations,_that.quickActions,_that.complianceAlerts,_that.revenueComparison,_that.isLoading,_that.error,_that.lastRefreshed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodaySummary? todaySummary,  List<WorkerLocation>? workerLocations,  List<QuickAction>? quickActions,  List<ComplianceAlert>? complianceAlerts,  RevenueComparison? revenueComparison,  bool isLoading,  String? error,  DateTime? lastRefreshed)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.todaySummary,_that.workerLocations,_that.quickActions,_that.complianceAlerts,_that.revenueComparison,_that.isLoading,_that.error,_that.lastRefreshed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodaySummary? todaySummary,  List<WorkerLocation>? workerLocations,  List<QuickAction>? quickActions,  List<ComplianceAlert>? complianceAlerts,  RevenueComparison? revenueComparison,  bool isLoading,  String? error,  DateTime? lastRefreshed)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.todaySummary,_that.workerLocations,_that.quickActions,_that.complianceAlerts,_that.revenueComparison,_that.isLoading,_that.error,_that.lastRefreshed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardState implements DashboardState {
  const _DashboardState({this.todaySummary, final  List<WorkerLocation>? workerLocations, final  List<QuickAction>? quickActions, final  List<ComplianceAlert>? complianceAlerts, this.revenueComparison, this.isLoading = false, this.error, this.lastRefreshed}): _workerLocations = workerLocations,_quickActions = quickActions,_complianceAlerts = complianceAlerts;
  factory _DashboardState.fromJson(Map<String, dynamic> json) => _$DashboardStateFromJson(json);

@override final  TodaySummary? todaySummary;
 final  List<WorkerLocation>? _workerLocations;
@override List<WorkerLocation>? get workerLocations {
  final value = _workerLocations;
  if (value == null) return null;
  if (_workerLocations is EqualUnmodifiableListView) return _workerLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<QuickAction>? _quickActions;
@override List<QuickAction>? get quickActions {
  final value = _quickActions;
  if (value == null) return null;
  if (_quickActions is EqualUnmodifiableListView) return _quickActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ComplianceAlert>? _complianceAlerts;
@override List<ComplianceAlert>? get complianceAlerts {
  final value = _complianceAlerts;
  if (value == null) return null;
  if (_complianceAlerts is EqualUnmodifiableListView) return _complianceAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  RevenueComparison? revenueComparison;
@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override final  DateTime? lastRefreshed;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.todaySummary, todaySummary) || other.todaySummary == todaySummary)&&const DeepCollectionEquality().equals(other._workerLocations, _workerLocations)&&const DeepCollectionEquality().equals(other._quickActions, _quickActions)&&const DeepCollectionEquality().equals(other._complianceAlerts, _complianceAlerts)&&(identical(other.revenueComparison, revenueComparison) || other.revenueComparison == revenueComparison)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.lastRefreshed, lastRefreshed) || other.lastRefreshed == lastRefreshed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todaySummary,const DeepCollectionEquality().hash(_workerLocations),const DeepCollectionEquality().hash(_quickActions),const DeepCollectionEquality().hash(_complianceAlerts),revenueComparison,isLoading,error,lastRefreshed);

@override
String toString() {
  return 'DashboardState(todaySummary: $todaySummary, workerLocations: $workerLocations, quickActions: $quickActions, complianceAlerts: $complianceAlerts, revenueComparison: $revenueComparison, isLoading: $isLoading, error: $error, lastRefreshed: $lastRefreshed)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 TodaySummary? todaySummary, List<WorkerLocation>? workerLocations, List<QuickAction>? quickActions, List<ComplianceAlert>? complianceAlerts, RevenueComparison? revenueComparison, bool isLoading, String? error, DateTime? lastRefreshed
});


@override $TodaySummaryCopyWith<$Res>? get todaySummary;@override $RevenueComparisonCopyWith<$Res>? get revenueComparison;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todaySummary = freezed,Object? workerLocations = freezed,Object? quickActions = freezed,Object? complianceAlerts = freezed,Object? revenueComparison = freezed,Object? isLoading = null,Object? error = freezed,Object? lastRefreshed = freezed,}) {
  return _then(_DashboardState(
todaySummary: freezed == todaySummary ? _self.todaySummary : todaySummary // ignore: cast_nullable_to_non_nullable
as TodaySummary?,workerLocations: freezed == workerLocations ? _self._workerLocations : workerLocations // ignore: cast_nullable_to_non_nullable
as List<WorkerLocation>?,quickActions: freezed == quickActions ? _self._quickActions : quickActions // ignore: cast_nullable_to_non_nullable
as List<QuickAction>?,complianceAlerts: freezed == complianceAlerts ? _self._complianceAlerts : complianceAlerts // ignore: cast_nullable_to_non_nullable
as List<ComplianceAlert>?,revenueComparison: freezed == revenueComparison ? _self.revenueComparison : revenueComparison // ignore: cast_nullable_to_non_nullable
as RevenueComparison?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,lastRefreshed: freezed == lastRefreshed ? _self.lastRefreshed : lastRefreshed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodaySummaryCopyWith<$Res>? get todaySummary {
    if (_self.todaySummary == null) {
    return null;
  }

  return $TodaySummaryCopyWith<$Res>(_self.todaySummary!, (value) {
    return _then(_self.copyWith(todaySummary: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevenueComparisonCopyWith<$Res>? get revenueComparison {
    if (_self.revenueComparison == null) {
    return null;
  }

  return $RevenueComparisonCopyWith<$Res>(_self.revenueComparison!, (value) {
    return _then(_self.copyWith(revenueComparison: value));
  });
}
}

// dart format on
