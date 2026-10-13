// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stakeholder_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StakeholderPermissions {

 bool get viewAppointments; bool get viewDocuments; bool get viewInvoices; bool get editProfile; bool get approveServices; bool get manageStakeholders; bool get viewMessages; bool get sendMessages; bool get viewServiceHistory; bool get receiveNotifications;
/// Create a copy of StakeholderPermissions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StakeholderPermissionsCopyWith<StakeholderPermissions> get copyWith => _$StakeholderPermissionsCopyWithImpl<StakeholderPermissions>(this as StakeholderPermissions, _$identity);

  /// Serializes this StakeholderPermissions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StakeholderPermissions&&(identical(other.viewAppointments, viewAppointments) || other.viewAppointments == viewAppointments)&&(identical(other.viewDocuments, viewDocuments) || other.viewDocuments == viewDocuments)&&(identical(other.viewInvoices, viewInvoices) || other.viewInvoices == viewInvoices)&&(identical(other.editProfile, editProfile) || other.editProfile == editProfile)&&(identical(other.approveServices, approveServices) || other.approveServices == approveServices)&&(identical(other.manageStakeholders, manageStakeholders) || other.manageStakeholders == manageStakeholders)&&(identical(other.viewMessages, viewMessages) || other.viewMessages == viewMessages)&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.viewServiceHistory, viewServiceHistory) || other.viewServiceHistory == viewServiceHistory)&&(identical(other.receiveNotifications, receiveNotifications) || other.receiveNotifications == receiveNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,viewAppointments,viewDocuments,viewInvoices,editProfile,approveServices,manageStakeholders,viewMessages,sendMessages,viewServiceHistory,receiveNotifications);

@override
String toString() {
  return 'StakeholderPermissions(viewAppointments: $viewAppointments, viewDocuments: $viewDocuments, viewInvoices: $viewInvoices, editProfile: $editProfile, approveServices: $approveServices, manageStakeholders: $manageStakeholders, viewMessages: $viewMessages, sendMessages: $sendMessages, viewServiceHistory: $viewServiceHistory, receiveNotifications: $receiveNotifications)';
}


}

/// @nodoc
abstract mixin class $StakeholderPermissionsCopyWith<$Res>  {
  factory $StakeholderPermissionsCopyWith(StakeholderPermissions value, $Res Function(StakeholderPermissions) _then) = _$StakeholderPermissionsCopyWithImpl;
@useResult
$Res call({
 bool viewAppointments, bool viewDocuments, bool viewInvoices, bool editProfile, bool approveServices, bool manageStakeholders, bool viewMessages, bool sendMessages, bool viewServiceHistory, bool receiveNotifications
});




}
/// @nodoc
class _$StakeholderPermissionsCopyWithImpl<$Res>
    implements $StakeholderPermissionsCopyWith<$Res> {
  _$StakeholderPermissionsCopyWithImpl(this._self, this._then);

  final StakeholderPermissions _self;
  final $Res Function(StakeholderPermissions) _then;

/// Create a copy of StakeholderPermissions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? viewAppointments = null,Object? viewDocuments = null,Object? viewInvoices = null,Object? editProfile = null,Object? approveServices = null,Object? manageStakeholders = null,Object? viewMessages = null,Object? sendMessages = null,Object? viewServiceHistory = null,Object? receiveNotifications = null,}) {
  return _then(_self.copyWith(
viewAppointments: null == viewAppointments ? _self.viewAppointments : viewAppointments // ignore: cast_nullable_to_non_nullable
as bool,viewDocuments: null == viewDocuments ? _self.viewDocuments : viewDocuments // ignore: cast_nullable_to_non_nullable
as bool,viewInvoices: null == viewInvoices ? _self.viewInvoices : viewInvoices // ignore: cast_nullable_to_non_nullable
as bool,editProfile: null == editProfile ? _self.editProfile : editProfile // ignore: cast_nullable_to_non_nullable
as bool,approveServices: null == approveServices ? _self.approveServices : approveServices // ignore: cast_nullable_to_non_nullable
as bool,manageStakeholders: null == manageStakeholders ? _self.manageStakeholders : manageStakeholders // ignore: cast_nullable_to_non_nullable
as bool,viewMessages: null == viewMessages ? _self.viewMessages : viewMessages // ignore: cast_nullable_to_non_nullable
as bool,sendMessages: null == sendMessages ? _self.sendMessages : sendMessages // ignore: cast_nullable_to_non_nullable
as bool,viewServiceHistory: null == viewServiceHistory ? _self.viewServiceHistory : viewServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,receiveNotifications: null == receiveNotifications ? _self.receiveNotifications : receiveNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StakeholderPermissions].
extension StakeholderPermissionsPatterns on StakeholderPermissions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StakeholderPermissions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StakeholderPermissions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StakeholderPermissions value)  $default,){
final _that = this;
switch (_that) {
case _StakeholderPermissions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StakeholderPermissions value)?  $default,){
final _that = this;
switch (_that) {
case _StakeholderPermissions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool viewAppointments,  bool viewDocuments,  bool viewInvoices,  bool editProfile,  bool approveServices,  bool manageStakeholders,  bool viewMessages,  bool sendMessages,  bool viewServiceHistory,  bool receiveNotifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StakeholderPermissions() when $default != null:
return $default(_that.viewAppointments,_that.viewDocuments,_that.viewInvoices,_that.editProfile,_that.approveServices,_that.manageStakeholders,_that.viewMessages,_that.sendMessages,_that.viewServiceHistory,_that.receiveNotifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool viewAppointments,  bool viewDocuments,  bool viewInvoices,  bool editProfile,  bool approveServices,  bool manageStakeholders,  bool viewMessages,  bool sendMessages,  bool viewServiceHistory,  bool receiveNotifications)  $default,) {final _that = this;
switch (_that) {
case _StakeholderPermissions():
return $default(_that.viewAppointments,_that.viewDocuments,_that.viewInvoices,_that.editProfile,_that.approveServices,_that.manageStakeholders,_that.viewMessages,_that.sendMessages,_that.viewServiceHistory,_that.receiveNotifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool viewAppointments,  bool viewDocuments,  bool viewInvoices,  bool editProfile,  bool approveServices,  bool manageStakeholders,  bool viewMessages,  bool sendMessages,  bool viewServiceHistory,  bool receiveNotifications)?  $default,) {final _that = this;
switch (_that) {
case _StakeholderPermissions() when $default != null:
return $default(_that.viewAppointments,_that.viewDocuments,_that.viewInvoices,_that.editProfile,_that.approveServices,_that.manageStakeholders,_that.viewMessages,_that.sendMessages,_that.viewServiceHistory,_that.receiveNotifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StakeholderPermissions implements StakeholderPermissions {
  const _StakeholderPermissions({this.viewAppointments = false, this.viewDocuments = false, this.viewInvoices = false, this.editProfile = false, this.approveServices = false, this.manageStakeholders = false, this.viewMessages = false, this.sendMessages = false, this.viewServiceHistory = false, this.receiveNotifications = false});
  factory _StakeholderPermissions.fromJson(Map<String, dynamic> json) => _$StakeholderPermissionsFromJson(json);

@override@JsonKey() final  bool viewAppointments;
@override@JsonKey() final  bool viewDocuments;
@override@JsonKey() final  bool viewInvoices;
@override@JsonKey() final  bool editProfile;
@override@JsonKey() final  bool approveServices;
@override@JsonKey() final  bool manageStakeholders;
@override@JsonKey() final  bool viewMessages;
@override@JsonKey() final  bool sendMessages;
@override@JsonKey() final  bool viewServiceHistory;
@override@JsonKey() final  bool receiveNotifications;

/// Create a copy of StakeholderPermissions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StakeholderPermissionsCopyWith<_StakeholderPermissions> get copyWith => __$StakeholderPermissionsCopyWithImpl<_StakeholderPermissions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StakeholderPermissionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StakeholderPermissions&&(identical(other.viewAppointments, viewAppointments) || other.viewAppointments == viewAppointments)&&(identical(other.viewDocuments, viewDocuments) || other.viewDocuments == viewDocuments)&&(identical(other.viewInvoices, viewInvoices) || other.viewInvoices == viewInvoices)&&(identical(other.editProfile, editProfile) || other.editProfile == editProfile)&&(identical(other.approveServices, approveServices) || other.approveServices == approveServices)&&(identical(other.manageStakeholders, manageStakeholders) || other.manageStakeholders == manageStakeholders)&&(identical(other.viewMessages, viewMessages) || other.viewMessages == viewMessages)&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.viewServiceHistory, viewServiceHistory) || other.viewServiceHistory == viewServiceHistory)&&(identical(other.receiveNotifications, receiveNotifications) || other.receiveNotifications == receiveNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,viewAppointments,viewDocuments,viewInvoices,editProfile,approveServices,manageStakeholders,viewMessages,sendMessages,viewServiceHistory,receiveNotifications);

@override
String toString() {
  return 'StakeholderPermissions(viewAppointments: $viewAppointments, viewDocuments: $viewDocuments, viewInvoices: $viewInvoices, editProfile: $editProfile, approveServices: $approveServices, manageStakeholders: $manageStakeholders, viewMessages: $viewMessages, sendMessages: $sendMessages, viewServiceHistory: $viewServiceHistory, receiveNotifications: $receiveNotifications)';
}


}

/// @nodoc
abstract mixin class _$StakeholderPermissionsCopyWith<$Res> implements $StakeholderPermissionsCopyWith<$Res> {
  factory _$StakeholderPermissionsCopyWith(_StakeholderPermissions value, $Res Function(_StakeholderPermissions) _then) = __$StakeholderPermissionsCopyWithImpl;
@override @useResult
$Res call({
 bool viewAppointments, bool viewDocuments, bool viewInvoices, bool editProfile, bool approveServices, bool manageStakeholders, bool viewMessages, bool sendMessages, bool viewServiceHistory, bool receiveNotifications
});




}
/// @nodoc
class __$StakeholderPermissionsCopyWithImpl<$Res>
    implements _$StakeholderPermissionsCopyWith<$Res> {
  __$StakeholderPermissionsCopyWithImpl(this._self, this._then);

  final _StakeholderPermissions _self;
  final $Res Function(_StakeholderPermissions) _then;

/// Create a copy of StakeholderPermissions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? viewAppointments = null,Object? viewDocuments = null,Object? viewInvoices = null,Object? editProfile = null,Object? approveServices = null,Object? manageStakeholders = null,Object? viewMessages = null,Object? sendMessages = null,Object? viewServiceHistory = null,Object? receiveNotifications = null,}) {
  return _then(_StakeholderPermissions(
viewAppointments: null == viewAppointments ? _self.viewAppointments : viewAppointments // ignore: cast_nullable_to_non_nullable
as bool,viewDocuments: null == viewDocuments ? _self.viewDocuments : viewDocuments // ignore: cast_nullable_to_non_nullable
as bool,viewInvoices: null == viewInvoices ? _self.viewInvoices : viewInvoices // ignore: cast_nullable_to_non_nullable
as bool,editProfile: null == editProfile ? _self.editProfile : editProfile // ignore: cast_nullable_to_non_nullable
as bool,approveServices: null == approveServices ? _self.approveServices : approveServices // ignore: cast_nullable_to_non_nullable
as bool,manageStakeholders: null == manageStakeholders ? _self.manageStakeholders : manageStakeholders // ignore: cast_nullable_to_non_nullable
as bool,viewMessages: null == viewMessages ? _self.viewMessages : viewMessages // ignore: cast_nullable_to_non_nullable
as bool,sendMessages: null == sendMessages ? _self.sendMessages : sendMessages // ignore: cast_nullable_to_non_nullable
as bool,viewServiceHistory: null == viewServiceHistory ? _self.viewServiceHistory : viewServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,receiveNotifications: null == receiveNotifications ? _self.receiveNotifications : receiveNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Stakeholder {

 String get id; String get type; String get name; String get email; String get phone; String get company; String get abn; String get linkedUserEmail; String get notes; bool get isActive; StakeholderPermissions get permissions;
/// Create a copy of Stakeholder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StakeholderCopyWith<Stakeholder> get copyWith => _$StakeholderCopyWithImpl<Stakeholder>(this as Stakeholder, _$identity);

  /// Serializes this Stakeholder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stakeholder&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.company, company) || other.company == company)&&(identical(other.abn, abn) || other.abn == abn)&&(identical(other.linkedUserEmail, linkedUserEmail) || other.linkedUserEmail == linkedUserEmail)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.permissions, permissions) || other.permissions == permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,email,phone,company,abn,linkedUserEmail,notes,isActive,permissions);

@override
String toString() {
  return 'Stakeholder(id: $id, type: $type, name: $name, email: $email, phone: $phone, company: $company, abn: $abn, linkedUserEmail: $linkedUserEmail, notes: $notes, isActive: $isActive, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class $StakeholderCopyWith<$Res>  {
  factory $StakeholderCopyWith(Stakeholder value, $Res Function(Stakeholder) _then) = _$StakeholderCopyWithImpl;
@useResult
$Res call({
 String id, String type, String name, String email, String phone, String company, String abn, String linkedUserEmail, String notes, bool isActive, StakeholderPermissions permissions
});


$StakeholderPermissionsCopyWith<$Res> get permissions;

}
/// @nodoc
class _$StakeholderCopyWithImpl<$Res>
    implements $StakeholderCopyWith<$Res> {
  _$StakeholderCopyWithImpl(this._self, this._then);

  final Stakeholder _self;
  final $Res Function(Stakeholder) _then;

/// Create a copy of Stakeholder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? name = null,Object? email = null,Object? phone = null,Object? company = null,Object? abn = null,Object? linkedUserEmail = null,Object? notes = null,Object? isActive = null,Object? permissions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,abn: null == abn ? _self.abn : abn // ignore: cast_nullable_to_non_nullable
as String,linkedUserEmail: null == linkedUserEmail ? _self.linkedUserEmail : linkedUserEmail // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as StakeholderPermissions,
  ));
}
/// Create a copy of Stakeholder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StakeholderPermissionsCopyWith<$Res> get permissions {
  
  return $StakeholderPermissionsCopyWith<$Res>(_self.permissions, (value) {
    return _then(_self.copyWith(permissions: value));
  });
}
}


/// Adds pattern-matching-related methods to [Stakeholder].
extension StakeholderPatterns on Stakeholder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stakeholder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stakeholder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stakeholder value)  $default,){
final _that = this;
switch (_that) {
case _Stakeholder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stakeholder value)?  $default,){
final _that = this;
switch (_that) {
case _Stakeholder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String name,  String email,  String phone,  String company,  String abn,  String linkedUserEmail,  String notes,  bool isActive,  StakeholderPermissions permissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stakeholder() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.email,_that.phone,_that.company,_that.abn,_that.linkedUserEmail,_that.notes,_that.isActive,_that.permissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String name,  String email,  String phone,  String company,  String abn,  String linkedUserEmail,  String notes,  bool isActive,  StakeholderPermissions permissions)  $default,) {final _that = this;
switch (_that) {
case _Stakeholder():
return $default(_that.id,_that.type,_that.name,_that.email,_that.phone,_that.company,_that.abn,_that.linkedUserEmail,_that.notes,_that.isActive,_that.permissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String name,  String email,  String phone,  String company,  String abn,  String linkedUserEmail,  String notes,  bool isActive,  StakeholderPermissions permissions)?  $default,) {final _that = this;
switch (_that) {
case _Stakeholder() when $default != null:
return $default(_that.id,_that.type,_that.name,_that.email,_that.phone,_that.company,_that.abn,_that.linkedUserEmail,_that.notes,_that.isActive,_that.permissions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Stakeholder implements Stakeholder {
  const _Stakeholder({required this.id, this.type = 'other', required this.name, this.email = '', this.phone = '', this.company = '', this.abn = '', this.linkedUserEmail = '', this.notes = '', this.isActive = true, this.permissions = const StakeholderPermissions()});
  factory _Stakeholder.fromJson(Map<String, dynamic> json) => _$StakeholderFromJson(json);

@override final  String id;
@override@JsonKey() final  String type;
@override final  String name;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String company;
@override@JsonKey() final  String abn;
@override@JsonKey() final  String linkedUserEmail;
@override@JsonKey() final  String notes;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  StakeholderPermissions permissions;

/// Create a copy of Stakeholder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StakeholderCopyWith<_Stakeholder> get copyWith => __$StakeholderCopyWithImpl<_Stakeholder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StakeholderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stakeholder&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.company, company) || other.company == company)&&(identical(other.abn, abn) || other.abn == abn)&&(identical(other.linkedUserEmail, linkedUserEmail) || other.linkedUserEmail == linkedUserEmail)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.permissions, permissions) || other.permissions == permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,name,email,phone,company,abn,linkedUserEmail,notes,isActive,permissions);

@override
String toString() {
  return 'Stakeholder(id: $id, type: $type, name: $name, email: $email, phone: $phone, company: $company, abn: $abn, linkedUserEmail: $linkedUserEmail, notes: $notes, isActive: $isActive, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class _$StakeholderCopyWith<$Res> implements $StakeholderCopyWith<$Res> {
  factory _$StakeholderCopyWith(_Stakeholder value, $Res Function(_Stakeholder) _then) = __$StakeholderCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String name, String email, String phone, String company, String abn, String linkedUserEmail, String notes, bool isActive, StakeholderPermissions permissions
});


@override $StakeholderPermissionsCopyWith<$Res> get permissions;

}
/// @nodoc
class __$StakeholderCopyWithImpl<$Res>
    implements _$StakeholderCopyWith<$Res> {
  __$StakeholderCopyWithImpl(this._self, this._then);

  final _Stakeholder _self;
  final $Res Function(_Stakeholder) _then;

/// Create a copy of Stakeholder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? name = null,Object? email = null,Object? phone = null,Object? company = null,Object? abn = null,Object? linkedUserEmail = null,Object? notes = null,Object? isActive = null,Object? permissions = null,}) {
  return _then(_Stakeholder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,abn: null == abn ? _self.abn : abn // ignore: cast_nullable_to_non_nullable
as String,linkedUserEmail: null == linkedUserEmail ? _self.linkedUserEmail : linkedUserEmail // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as StakeholderPermissions,
  ));
}

/// Create a copy of Stakeholder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StakeholderPermissionsCopyWith<$Res> get permissions {
  
  return $StakeholderPermissionsCopyWith<$Res>(_self.permissions, (value) {
    return _then(_self.copyWith(permissions: value));
  });
}
}


/// @nodoc
mixin _$CareTeamEntry {

 String get linkRole; bool get isPrimary; Stakeholder get stakeholder;
/// Create a copy of CareTeamEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CareTeamEntryCopyWith<CareTeamEntry> get copyWith => _$CareTeamEntryCopyWithImpl<CareTeamEntry>(this as CareTeamEntry, _$identity);

  /// Serializes this CareTeamEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CareTeamEntry&&(identical(other.linkRole, linkRole) || other.linkRole == linkRole)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.stakeholder, stakeholder) || other.stakeholder == stakeholder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,linkRole,isPrimary,stakeholder);

@override
String toString() {
  return 'CareTeamEntry(linkRole: $linkRole, isPrimary: $isPrimary, stakeholder: $stakeholder)';
}


}

/// @nodoc
abstract mixin class $CareTeamEntryCopyWith<$Res>  {
  factory $CareTeamEntryCopyWith(CareTeamEntry value, $Res Function(CareTeamEntry) _then) = _$CareTeamEntryCopyWithImpl;
@useResult
$Res call({
 String linkRole, bool isPrimary, Stakeholder stakeholder
});


$StakeholderCopyWith<$Res> get stakeholder;

}
/// @nodoc
class _$CareTeamEntryCopyWithImpl<$Res>
    implements $CareTeamEntryCopyWith<$Res> {
  _$CareTeamEntryCopyWithImpl(this._self, this._then);

  final CareTeamEntry _self;
  final $Res Function(CareTeamEntry) _then;

/// Create a copy of CareTeamEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkRole = null,Object? isPrimary = null,Object? stakeholder = null,}) {
  return _then(_self.copyWith(
linkRole: null == linkRole ? _self.linkRole : linkRole // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,stakeholder: null == stakeholder ? _self.stakeholder : stakeholder // ignore: cast_nullable_to_non_nullable
as Stakeholder,
  ));
}
/// Create a copy of CareTeamEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StakeholderCopyWith<$Res> get stakeholder {
  
  return $StakeholderCopyWith<$Res>(_self.stakeholder, (value) {
    return _then(_self.copyWith(stakeholder: value));
  });
}
}


/// Adds pattern-matching-related methods to [CareTeamEntry].
extension CareTeamEntryPatterns on CareTeamEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CareTeamEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CareTeamEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CareTeamEntry value)  $default,){
final _that = this;
switch (_that) {
case _CareTeamEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CareTeamEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CareTeamEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkRole,  bool isPrimary,  Stakeholder stakeholder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CareTeamEntry() when $default != null:
return $default(_that.linkRole,_that.isPrimary,_that.stakeholder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkRole,  bool isPrimary,  Stakeholder stakeholder)  $default,) {final _that = this;
switch (_that) {
case _CareTeamEntry():
return $default(_that.linkRole,_that.isPrimary,_that.stakeholder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkRole,  bool isPrimary,  Stakeholder stakeholder)?  $default,) {final _that = this;
switch (_that) {
case _CareTeamEntry() when $default != null:
return $default(_that.linkRole,_that.isPrimary,_that.stakeholder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CareTeamEntry implements CareTeamEntry {
  const _CareTeamEntry({this.linkRole = 'other', this.isPrimary = false, required this.stakeholder});
  factory _CareTeamEntry.fromJson(Map<String, dynamic> json) => _$CareTeamEntryFromJson(json);

@override@JsonKey() final  String linkRole;
@override@JsonKey() final  bool isPrimary;
@override final  Stakeholder stakeholder;

/// Create a copy of CareTeamEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CareTeamEntryCopyWith<_CareTeamEntry> get copyWith => __$CareTeamEntryCopyWithImpl<_CareTeamEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CareTeamEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CareTeamEntry&&(identical(other.linkRole, linkRole) || other.linkRole == linkRole)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.stakeholder, stakeholder) || other.stakeholder == stakeholder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,linkRole,isPrimary,stakeholder);

@override
String toString() {
  return 'CareTeamEntry(linkRole: $linkRole, isPrimary: $isPrimary, stakeholder: $stakeholder)';
}


}

/// @nodoc
abstract mixin class _$CareTeamEntryCopyWith<$Res> implements $CareTeamEntryCopyWith<$Res> {
  factory _$CareTeamEntryCopyWith(_CareTeamEntry value, $Res Function(_CareTeamEntry) _then) = __$CareTeamEntryCopyWithImpl;
@override @useResult
$Res call({
 String linkRole, bool isPrimary, Stakeholder stakeholder
});


@override $StakeholderCopyWith<$Res> get stakeholder;

}
/// @nodoc
class __$CareTeamEntryCopyWithImpl<$Res>
    implements _$CareTeamEntryCopyWith<$Res> {
  __$CareTeamEntryCopyWithImpl(this._self, this._then);

  final _CareTeamEntry _self;
  final $Res Function(_CareTeamEntry) _then;

/// Create a copy of CareTeamEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkRole = null,Object? isPrimary = null,Object? stakeholder = null,}) {
  return _then(_CareTeamEntry(
linkRole: null == linkRole ? _self.linkRole : linkRole // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,stakeholder: null == stakeholder ? _self.stakeholder : stakeholder // ignore: cast_nullable_to_non_nullable
as Stakeholder,
  ));
}

/// Create a copy of CareTeamEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StakeholderCopyWith<$Res> get stakeholder {
  
  return $StakeholderCopyWith<$Res>(_self.stakeholder, (value) {
    return _then(_self.copyWith(stakeholder: value));
  });
}
}


/// @nodoc
mixin _$ClientCareTeam {

 String get clientId; String get fundingType; List<CareTeamEntry> get careTeam;
/// Create a copy of ClientCareTeam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientCareTeamCopyWith<ClientCareTeam> get copyWith => _$ClientCareTeamCopyWithImpl<ClientCareTeam>(this as ClientCareTeam, _$identity);

  /// Serializes this ClientCareTeam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientCareTeam&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&const DeepCollectionEquality().equals(other.careTeam, careTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,fundingType,const DeepCollectionEquality().hash(careTeam));

@override
String toString() {
  return 'ClientCareTeam(clientId: $clientId, fundingType: $fundingType, careTeam: $careTeam)';
}


}

/// @nodoc
abstract mixin class $ClientCareTeamCopyWith<$Res>  {
  factory $ClientCareTeamCopyWith(ClientCareTeam value, $Res Function(ClientCareTeam) _then) = _$ClientCareTeamCopyWithImpl;
@useResult
$Res call({
 String clientId, String fundingType, List<CareTeamEntry> careTeam
});




}
/// @nodoc
class _$ClientCareTeamCopyWithImpl<$Res>
    implements $ClientCareTeamCopyWith<$Res> {
  _$ClientCareTeamCopyWithImpl(this._self, this._then);

  final ClientCareTeam _self;
  final $Res Function(ClientCareTeam) _then;

/// Create a copy of ClientCareTeam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = null,Object? fundingType = null,Object? careTeam = null,}) {
  return _then(_self.copyWith(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,careTeam: null == careTeam ? _self.careTeam : careTeam // ignore: cast_nullable_to_non_nullable
as List<CareTeamEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientCareTeam].
extension ClientCareTeamPatterns on ClientCareTeam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientCareTeam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientCareTeam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientCareTeam value)  $default,){
final _that = this;
switch (_that) {
case _ClientCareTeam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientCareTeam value)?  $default,){
final _that = this;
switch (_that) {
case _ClientCareTeam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String clientId,  String fundingType,  List<CareTeamEntry> careTeam)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientCareTeam() when $default != null:
return $default(_that.clientId,_that.fundingType,_that.careTeam);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String clientId,  String fundingType,  List<CareTeamEntry> careTeam)  $default,) {final _that = this;
switch (_that) {
case _ClientCareTeam():
return $default(_that.clientId,_that.fundingType,_that.careTeam);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String clientId,  String fundingType,  List<CareTeamEntry> careTeam)?  $default,) {final _that = this;
switch (_that) {
case _ClientCareTeam() when $default != null:
return $default(_that.clientId,_that.fundingType,_that.careTeam);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientCareTeam implements ClientCareTeam {
  const _ClientCareTeam({required this.clientId, this.fundingType = 'plan_managed', final  List<CareTeamEntry> careTeam = const <CareTeamEntry>[]}): _careTeam = careTeam;
  factory _ClientCareTeam.fromJson(Map<String, dynamic> json) => _$ClientCareTeamFromJson(json);

@override final  String clientId;
@override@JsonKey() final  String fundingType;
 final  List<CareTeamEntry> _careTeam;
@override@JsonKey() List<CareTeamEntry> get careTeam {
  if (_careTeam is EqualUnmodifiableListView) return _careTeam;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_careTeam);
}


/// Create a copy of ClientCareTeam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientCareTeamCopyWith<_ClientCareTeam> get copyWith => __$ClientCareTeamCopyWithImpl<_ClientCareTeam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientCareTeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientCareTeam&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&const DeepCollectionEquality().equals(other._careTeam, _careTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,fundingType,const DeepCollectionEquality().hash(_careTeam));

@override
String toString() {
  return 'ClientCareTeam(clientId: $clientId, fundingType: $fundingType, careTeam: $careTeam)';
}


}

/// @nodoc
abstract mixin class _$ClientCareTeamCopyWith<$Res> implements $ClientCareTeamCopyWith<$Res> {
  factory _$ClientCareTeamCopyWith(_ClientCareTeam value, $Res Function(_ClientCareTeam) _then) = __$ClientCareTeamCopyWithImpl;
@override @useResult
$Res call({
 String clientId, String fundingType, List<CareTeamEntry> careTeam
});




}
/// @nodoc
class __$ClientCareTeamCopyWithImpl<$Res>
    implements _$ClientCareTeamCopyWith<$Res> {
  __$ClientCareTeamCopyWithImpl(this._self, this._then);

  final _ClientCareTeam _self;
  final $Res Function(_ClientCareTeam) _then;

/// Create a copy of ClientCareTeam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = null,Object? fundingType = null,Object? careTeam = null,}) {
  return _then(_ClientCareTeam(
clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,fundingType: null == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String,careTeam: null == careTeam ? _self._careTeam : careTeam // ignore: cast_nullable_to_non_nullable
as List<CareTeamEntry>,
  ));
}


}

// dart format on
