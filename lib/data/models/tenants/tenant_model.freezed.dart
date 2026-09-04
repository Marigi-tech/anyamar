// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tenant {

 String get userId; String get tenantName; String get unitId; Rent? get unitRent; String? get tenantId; String? get tenantPhoneNumber; String get propertyId; String? get unitName; String? get tenantEmail; String? get tenantOccupation;// job
 String? get tenantNationalId; DateTime get startOfLease; DateTime? get endOfLease; Person? get nextOfKin;// Include name , phone number and email address of the tenant's next of kin
 String? get nationalId; DateTime? get lastUpdateDate;
/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantCopyWith<Tenant> get copyWith => _$TenantCopyWithImpl<Tenant>(this as Tenant, _$identity);

  /// Serializes this Tenant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tenant&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.unitRent, unitRent) || other.unitRent == unitRent)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.tenantPhoneNumber, tenantPhoneNumber) || other.tenantPhoneNumber == tenantPhoneNumber)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.unitName, unitName) || other.unitName == unitName)&&(identical(other.tenantEmail, tenantEmail) || other.tenantEmail == tenantEmail)&&(identical(other.tenantOccupation, tenantOccupation) || other.tenantOccupation == tenantOccupation)&&(identical(other.tenantNationalId, tenantNationalId) || other.tenantNationalId == tenantNationalId)&&(identical(other.startOfLease, startOfLease) || other.startOfLease == startOfLease)&&(identical(other.endOfLease, endOfLease) || other.endOfLease == endOfLease)&&(identical(other.nextOfKin, nextOfKin) || other.nextOfKin == nextOfKin)&&(identical(other.nationalId, nationalId) || other.nationalId == nationalId)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,tenantName,unitId,unitRent,tenantId,tenantPhoneNumber,propertyId,unitName,tenantEmail,tenantOccupation,tenantNationalId,startOfLease,endOfLease,nextOfKin,nationalId,lastUpdateDate);

@override
String toString() {
  return 'Tenant(userId: $userId, tenantName: $tenantName, unitId: $unitId, unitRent: $unitRent, tenantId: $tenantId, tenantPhoneNumber: $tenantPhoneNumber, propertyId: $propertyId, unitName: $unitName, tenantEmail: $tenantEmail, tenantOccupation: $tenantOccupation, tenantNationalId: $tenantNationalId, startOfLease: $startOfLease, endOfLease: $endOfLease, nextOfKin: $nextOfKin, nationalId: $nationalId, lastUpdateDate: $lastUpdateDate)';
}


}

/// @nodoc
abstract mixin class $TenantCopyWith<$Res>  {
  factory $TenantCopyWith(Tenant value, $Res Function(Tenant) _then) = _$TenantCopyWithImpl;
@useResult
$Res call({
 String userId, String tenantName, String unitId, Rent? unitRent, String? tenantId, String? tenantPhoneNumber, String propertyId, String? unitName, String? tenantEmail, String? tenantOccupation, String? tenantNationalId, DateTime startOfLease, DateTime? endOfLease, Person? nextOfKin, String? nationalId, DateTime? lastUpdateDate
});


$RentCopyWith<$Res>? get unitRent;$PersonCopyWith<$Res>? get nextOfKin;

}
/// @nodoc
class _$TenantCopyWithImpl<$Res>
    implements $TenantCopyWith<$Res> {
  _$TenantCopyWithImpl(this._self, this._then);

  final Tenant _self;
  final $Res Function(Tenant) _then;

/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? tenantName = null,Object? unitId = null,Object? unitRent = freezed,Object? tenantId = freezed,Object? tenantPhoneNumber = freezed,Object? propertyId = null,Object? unitName = freezed,Object? tenantEmail = freezed,Object? tenantOccupation = freezed,Object? tenantNationalId = freezed,Object? startOfLease = null,Object? endOfLease = freezed,Object? nextOfKin = freezed,Object? nationalId = freezed,Object? lastUpdateDate = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,unitRent: freezed == unitRent ? _self.unitRent : unitRent // ignore: cast_nullable_to_non_nullable
as Rent?,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,tenantPhoneNumber: freezed == tenantPhoneNumber ? _self.tenantPhoneNumber : tenantPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,unitName: freezed == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String?,tenantEmail: freezed == tenantEmail ? _self.tenantEmail : tenantEmail // ignore: cast_nullable_to_non_nullable
as String?,tenantOccupation: freezed == tenantOccupation ? _self.tenantOccupation : tenantOccupation // ignore: cast_nullable_to_non_nullable
as String?,tenantNationalId: freezed == tenantNationalId ? _self.tenantNationalId : tenantNationalId // ignore: cast_nullable_to_non_nullable
as String?,startOfLease: null == startOfLease ? _self.startOfLease : startOfLease // ignore: cast_nullable_to_non_nullable
as DateTime,endOfLease: freezed == endOfLease ? _self.endOfLease : endOfLease // ignore: cast_nullable_to_non_nullable
as DateTime?,nextOfKin: freezed == nextOfKin ? _self.nextOfKin : nextOfKin // ignore: cast_nullable_to_non_nullable
as Person?,nationalId: freezed == nationalId ? _self.nationalId : nationalId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentCopyWith<$Res>? get unitRent {
    if (_self.unitRent == null) {
    return null;
  }

  return $RentCopyWith<$Res>(_self.unitRent!, (value) {
    return _then(_self.copyWith(unitRent: value));
  });
}/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res>? get nextOfKin {
    if (_self.nextOfKin == null) {
    return null;
  }

  return $PersonCopyWith<$Res>(_self.nextOfKin!, (value) {
    return _then(_self.copyWith(nextOfKin: value));
  });
}
}


/// Adds pattern-matching-related methods to [Tenant].
extension TenantPatterns on Tenant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tenant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tenant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tenant value)  $default,){
final _that = this;
switch (_that) {
case _Tenant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tenant value)?  $default,){
final _that = this;
switch (_that) {
case _Tenant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String tenantName,  String unitId,  Rent? unitRent,  String? tenantId,  String? tenantPhoneNumber,  String propertyId,  String? unitName,  String? tenantEmail,  String? tenantOccupation,  String? tenantNationalId,  DateTime startOfLease,  DateTime? endOfLease,  Person? nextOfKin,  String? nationalId,  DateTime? lastUpdateDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tenant() when $default != null:
return $default(_that.userId,_that.tenantName,_that.unitId,_that.unitRent,_that.tenantId,_that.tenantPhoneNumber,_that.propertyId,_that.unitName,_that.tenantEmail,_that.tenantOccupation,_that.tenantNationalId,_that.startOfLease,_that.endOfLease,_that.nextOfKin,_that.nationalId,_that.lastUpdateDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String tenantName,  String unitId,  Rent? unitRent,  String? tenantId,  String? tenantPhoneNumber,  String propertyId,  String? unitName,  String? tenantEmail,  String? tenantOccupation,  String? tenantNationalId,  DateTime startOfLease,  DateTime? endOfLease,  Person? nextOfKin,  String? nationalId,  DateTime? lastUpdateDate)  $default,) {final _that = this;
switch (_that) {
case _Tenant():
return $default(_that.userId,_that.tenantName,_that.unitId,_that.unitRent,_that.tenantId,_that.tenantPhoneNumber,_that.propertyId,_that.unitName,_that.tenantEmail,_that.tenantOccupation,_that.tenantNationalId,_that.startOfLease,_that.endOfLease,_that.nextOfKin,_that.nationalId,_that.lastUpdateDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String tenantName,  String unitId,  Rent? unitRent,  String? tenantId,  String? tenantPhoneNumber,  String propertyId,  String? unitName,  String? tenantEmail,  String? tenantOccupation,  String? tenantNationalId,  DateTime startOfLease,  DateTime? endOfLease,  Person? nextOfKin,  String? nationalId,  DateTime? lastUpdateDate)?  $default,) {final _that = this;
switch (_that) {
case _Tenant() when $default != null:
return $default(_that.userId,_that.tenantName,_that.unitId,_that.unitRent,_that.tenantId,_that.tenantPhoneNumber,_that.propertyId,_that.unitName,_that.tenantEmail,_that.tenantOccupation,_that.tenantNationalId,_that.startOfLease,_that.endOfLease,_that.nextOfKin,_that.nationalId,_that.lastUpdateDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tenant implements Tenant {
  const _Tenant({required this.userId, required this.tenantName, required this.unitId, this.unitRent, this.tenantId, this.tenantPhoneNumber, required this.propertyId, this.unitName, this.tenantEmail, this.tenantOccupation, this.tenantNationalId, required this.startOfLease, this.endOfLease, this.nextOfKin, this.nationalId, this.lastUpdateDate});
  factory _Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

@override final  String userId;
@override final  String tenantName;
@override final  String unitId;
@override final  Rent? unitRent;
@override final  String? tenantId;
@override final  String? tenantPhoneNumber;
@override final  String propertyId;
@override final  String? unitName;
@override final  String? tenantEmail;
@override final  String? tenantOccupation;
// job
@override final  String? tenantNationalId;
@override final  DateTime startOfLease;
@override final  DateTime? endOfLease;
@override final  Person? nextOfKin;
// Include name , phone number and email address of the tenant's next of kin
@override final  String? nationalId;
@override final  DateTime? lastUpdateDate;

/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantCopyWith<_Tenant> get copyWith => __$TenantCopyWithImpl<_Tenant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tenant&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.unitRent, unitRent) || other.unitRent == unitRent)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.tenantPhoneNumber, tenantPhoneNumber) || other.tenantPhoneNumber == tenantPhoneNumber)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.unitName, unitName) || other.unitName == unitName)&&(identical(other.tenantEmail, tenantEmail) || other.tenantEmail == tenantEmail)&&(identical(other.tenantOccupation, tenantOccupation) || other.tenantOccupation == tenantOccupation)&&(identical(other.tenantNationalId, tenantNationalId) || other.tenantNationalId == tenantNationalId)&&(identical(other.startOfLease, startOfLease) || other.startOfLease == startOfLease)&&(identical(other.endOfLease, endOfLease) || other.endOfLease == endOfLease)&&(identical(other.nextOfKin, nextOfKin) || other.nextOfKin == nextOfKin)&&(identical(other.nationalId, nationalId) || other.nationalId == nationalId)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,tenantName,unitId,unitRent,tenantId,tenantPhoneNumber,propertyId,unitName,tenantEmail,tenantOccupation,tenantNationalId,startOfLease,endOfLease,nextOfKin,nationalId,lastUpdateDate);

@override
String toString() {
  return 'Tenant(userId: $userId, tenantName: $tenantName, unitId: $unitId, unitRent: $unitRent, tenantId: $tenantId, tenantPhoneNumber: $tenantPhoneNumber, propertyId: $propertyId, unitName: $unitName, tenantEmail: $tenantEmail, tenantOccupation: $tenantOccupation, tenantNationalId: $tenantNationalId, startOfLease: $startOfLease, endOfLease: $endOfLease, nextOfKin: $nextOfKin, nationalId: $nationalId, lastUpdateDate: $lastUpdateDate)';
}


}

/// @nodoc
abstract mixin class _$TenantCopyWith<$Res> implements $TenantCopyWith<$Res> {
  factory _$TenantCopyWith(_Tenant value, $Res Function(_Tenant) _then) = __$TenantCopyWithImpl;
@override @useResult
$Res call({
 String userId, String tenantName, String unitId, Rent? unitRent, String? tenantId, String? tenantPhoneNumber, String propertyId, String? unitName, String? tenantEmail, String? tenantOccupation, String? tenantNationalId, DateTime startOfLease, DateTime? endOfLease, Person? nextOfKin, String? nationalId, DateTime? lastUpdateDate
});


@override $RentCopyWith<$Res>? get unitRent;@override $PersonCopyWith<$Res>? get nextOfKin;

}
/// @nodoc
class __$TenantCopyWithImpl<$Res>
    implements _$TenantCopyWith<$Res> {
  __$TenantCopyWithImpl(this._self, this._then);

  final _Tenant _self;
  final $Res Function(_Tenant) _then;

/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? tenantName = null,Object? unitId = null,Object? unitRent = freezed,Object? tenantId = freezed,Object? tenantPhoneNumber = freezed,Object? propertyId = null,Object? unitName = freezed,Object? tenantEmail = freezed,Object? tenantOccupation = freezed,Object? tenantNationalId = freezed,Object? startOfLease = null,Object? endOfLease = freezed,Object? nextOfKin = freezed,Object? nationalId = freezed,Object? lastUpdateDate = freezed,}) {
  return _then(_Tenant(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,unitRent: freezed == unitRent ? _self.unitRent : unitRent // ignore: cast_nullable_to_non_nullable
as Rent?,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,tenantPhoneNumber: freezed == tenantPhoneNumber ? _self.tenantPhoneNumber : tenantPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,unitName: freezed == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String?,tenantEmail: freezed == tenantEmail ? _self.tenantEmail : tenantEmail // ignore: cast_nullable_to_non_nullable
as String?,tenantOccupation: freezed == tenantOccupation ? _self.tenantOccupation : tenantOccupation // ignore: cast_nullable_to_non_nullable
as String?,tenantNationalId: freezed == tenantNationalId ? _self.tenantNationalId : tenantNationalId // ignore: cast_nullable_to_non_nullable
as String?,startOfLease: null == startOfLease ? _self.startOfLease : startOfLease // ignore: cast_nullable_to_non_nullable
as DateTime,endOfLease: freezed == endOfLease ? _self.endOfLease : endOfLease // ignore: cast_nullable_to_non_nullable
as DateTime?,nextOfKin: freezed == nextOfKin ? _self.nextOfKin : nextOfKin // ignore: cast_nullable_to_non_nullable
as Person?,nationalId: freezed == nationalId ? _self.nationalId : nationalId // ignore: cast_nullable_to_non_nullable
as String?,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentCopyWith<$Res>? get unitRent {
    if (_self.unitRent == null) {
    return null;
  }

  return $RentCopyWith<$Res>(_self.unitRent!, (value) {
    return _then(_self.copyWith(unitRent: value));
  });
}/// Create a copy of Tenant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res>? get nextOfKin {
    if (_self.nextOfKin == null) {
    return null;
  }

  return $PersonCopyWith<$Res>(_self.nextOfKin!, (value) {
    return _then(_self.copyWith(nextOfKin: value));
  });
}
}

// dart format on
