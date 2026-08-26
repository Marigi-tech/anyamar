// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Unit {

 String? get unitId; String get unitName; String get propertyId; String get propertyName; String get userId; String? get tenantId; Tenant? get currentTenant; UnitType? get unitType; double get rentPerMonth; Rent? get unitRent; List<String> get previousTenantsLog; bool get isOccupied; DateTime? get lastUpdateDate; double? get numberFloors;
/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitCopyWith<Unit> get copyWith => _$UnitCopyWithImpl<Unit>(this as Unit, _$identity);

  /// Serializes this Unit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unit&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.unitName, unitName) || other.unitName == unitName)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.currentTenant, currentTenant) || other.currentTenant == currentTenant)&&(identical(other.unitType, unitType) || other.unitType == unitType)&&(identical(other.rentPerMonth, rentPerMonth) || other.rentPerMonth == rentPerMonth)&&(identical(other.unitRent, unitRent) || other.unitRent == unitRent)&&const DeepCollectionEquality().equals(other.previousTenantsLog, previousTenantsLog)&&(identical(other.isOccupied, isOccupied) || other.isOccupied == isOccupied)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.numberFloors, numberFloors) || other.numberFloors == numberFloors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unitId,unitName,propertyId,propertyName,userId,tenantId,currentTenant,unitType,rentPerMonth,unitRent,const DeepCollectionEquality().hash(previousTenantsLog),isOccupied,lastUpdateDate,numberFloors);

@override
String toString() {
  return 'Unit(unitId: $unitId, unitName: $unitName, propertyId: $propertyId, propertyName: $propertyName, userId: $userId, tenantId: $tenantId, currentTenant: $currentTenant, unitType: $unitType, rentPerMonth: $rentPerMonth, unitRent: $unitRent, previousTenantsLog: $previousTenantsLog, isOccupied: $isOccupied, lastUpdateDate: $lastUpdateDate, numberFloors: $numberFloors)';
}


}

/// @nodoc
abstract mixin class $UnitCopyWith<$Res>  {
  factory $UnitCopyWith(Unit value, $Res Function(Unit) _then) = _$UnitCopyWithImpl;
@useResult
$Res call({
 String? unitId, String unitName, String propertyId, String propertyName, String userId, String? tenantId, Tenant? currentTenant, UnitType? unitType, double rentPerMonth, Rent? unitRent, List<String> previousTenantsLog, bool isOccupied, DateTime? lastUpdateDate, double? numberFloors
});


$TenantCopyWith<$Res>? get currentTenant;$RentCopyWith<$Res>? get unitRent;

}
/// @nodoc
class _$UnitCopyWithImpl<$Res>
    implements $UnitCopyWith<$Res> {
  _$UnitCopyWithImpl(this._self, this._then);

  final Unit _self;
  final $Res Function(Unit) _then;

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unitId = freezed,Object? unitName = null,Object? propertyId = null,Object? propertyName = null,Object? userId = null,Object? tenantId = freezed,Object? currentTenant = freezed,Object? unitType = freezed,Object? rentPerMonth = null,Object? unitRent = freezed,Object? previousTenantsLog = null,Object? isOccupied = null,Object? lastUpdateDate = freezed,Object? numberFloors = freezed,}) {
  return _then(_self.copyWith(
unitId: freezed == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String?,unitName: null == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,currentTenant: freezed == currentTenant ? _self.currentTenant : currentTenant // ignore: cast_nullable_to_non_nullable
as Tenant?,unitType: freezed == unitType ? _self.unitType : unitType // ignore: cast_nullable_to_non_nullable
as UnitType?,rentPerMonth: null == rentPerMonth ? _self.rentPerMonth : rentPerMonth // ignore: cast_nullable_to_non_nullable
as double,unitRent: freezed == unitRent ? _self.unitRent : unitRent // ignore: cast_nullable_to_non_nullable
as Rent?,previousTenantsLog: null == previousTenantsLog ? _self.previousTenantsLog : previousTenantsLog // ignore: cast_nullable_to_non_nullable
as List<String>,isOccupied: null == isOccupied ? _self.isOccupied : isOccupied // ignore: cast_nullable_to_non_nullable
as bool,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,numberFloors: freezed == numberFloors ? _self.numberFloors : numberFloors // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantCopyWith<$Res>? get currentTenant {
    if (_self.currentTenant == null) {
    return null;
  }

  return $TenantCopyWith<$Res>(_self.currentTenant!, (value) {
    return _then(_self.copyWith(currentTenant: value));
  });
}/// Create a copy of Unit
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
}
}


/// Adds pattern-matching-related methods to [Unit].
extension UnitPatterns on Unit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Unit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Unit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Unit value)  $default,){
final _that = this;
switch (_that) {
case _Unit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Unit value)?  $default,){
final _that = this;
switch (_that) {
case _Unit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? unitId,  String unitName,  String propertyId,  String propertyName,  String userId,  String? tenantId,  Tenant? currentTenant,  UnitType? unitType,  double rentPerMonth,  Rent? unitRent,  List<String> previousTenantsLog,  bool isOccupied,  DateTime? lastUpdateDate,  double? numberFloors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Unit() when $default != null:
return $default(_that.unitId,_that.unitName,_that.propertyId,_that.propertyName,_that.userId,_that.tenantId,_that.currentTenant,_that.unitType,_that.rentPerMonth,_that.unitRent,_that.previousTenantsLog,_that.isOccupied,_that.lastUpdateDate,_that.numberFloors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? unitId,  String unitName,  String propertyId,  String propertyName,  String userId,  String? tenantId,  Tenant? currentTenant,  UnitType? unitType,  double rentPerMonth,  Rent? unitRent,  List<String> previousTenantsLog,  bool isOccupied,  DateTime? lastUpdateDate,  double? numberFloors)  $default,) {final _that = this;
switch (_that) {
case _Unit():
return $default(_that.unitId,_that.unitName,_that.propertyId,_that.propertyName,_that.userId,_that.tenantId,_that.currentTenant,_that.unitType,_that.rentPerMonth,_that.unitRent,_that.previousTenantsLog,_that.isOccupied,_that.lastUpdateDate,_that.numberFloors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? unitId,  String unitName,  String propertyId,  String propertyName,  String userId,  String? tenantId,  Tenant? currentTenant,  UnitType? unitType,  double rentPerMonth,  Rent? unitRent,  List<String> previousTenantsLog,  bool isOccupied,  DateTime? lastUpdateDate,  double? numberFloors)?  $default,) {final _that = this;
switch (_that) {
case _Unit() when $default != null:
return $default(_that.unitId,_that.unitName,_that.propertyId,_that.propertyName,_that.userId,_that.tenantId,_that.currentTenant,_that.unitType,_that.rentPerMonth,_that.unitRent,_that.previousTenantsLog,_that.isOccupied,_that.lastUpdateDate,_that.numberFloors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Unit implements Unit {
  const _Unit({this.unitId, required this.unitName, required this.propertyId, required this.propertyName, required this.userId, this.tenantId, this.currentTenant, this.unitType, required this.rentPerMonth, this.unitRent, final  List<String> previousTenantsLog = const [], this.isOccupied = false, this.lastUpdateDate, this.numberFloors}): _previousTenantsLog = previousTenantsLog;
  factory _Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

@override final  String? unitId;
@override final  String unitName;
@override final  String propertyId;
@override final  String propertyName;
@override final  String userId;
@override final  String? tenantId;
@override final  Tenant? currentTenant;
@override final  UnitType? unitType;
@override final  double rentPerMonth;
@override final  Rent? unitRent;
 final  List<String> _previousTenantsLog;
@override@JsonKey() List<String> get previousTenantsLog {
  if (_previousTenantsLog is EqualUnmodifiableListView) return _previousTenantsLog;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previousTenantsLog);
}

@override@JsonKey() final  bool isOccupied;
@override final  DateTime? lastUpdateDate;
@override final  double? numberFloors;

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitCopyWith<_Unit> get copyWith => __$UnitCopyWithImpl<_Unit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unit&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.unitName, unitName) || other.unitName == unitName)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.currentTenant, currentTenant) || other.currentTenant == currentTenant)&&(identical(other.unitType, unitType) || other.unitType == unitType)&&(identical(other.rentPerMonth, rentPerMonth) || other.rentPerMonth == rentPerMonth)&&(identical(other.unitRent, unitRent) || other.unitRent == unitRent)&&const DeepCollectionEquality().equals(other._previousTenantsLog, _previousTenantsLog)&&(identical(other.isOccupied, isOccupied) || other.isOccupied == isOccupied)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.numberFloors, numberFloors) || other.numberFloors == numberFloors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unitId,unitName,propertyId,propertyName,userId,tenantId,currentTenant,unitType,rentPerMonth,unitRent,const DeepCollectionEquality().hash(_previousTenantsLog),isOccupied,lastUpdateDate,numberFloors);

@override
String toString() {
  return 'Unit(unitId: $unitId, unitName: $unitName, propertyId: $propertyId, propertyName: $propertyName, userId: $userId, tenantId: $tenantId, currentTenant: $currentTenant, unitType: $unitType, rentPerMonth: $rentPerMonth, unitRent: $unitRent, previousTenantsLog: $previousTenantsLog, isOccupied: $isOccupied, lastUpdateDate: $lastUpdateDate, numberFloors: $numberFloors)';
}


}

/// @nodoc
abstract mixin class _$UnitCopyWith<$Res> implements $UnitCopyWith<$Res> {
  factory _$UnitCopyWith(_Unit value, $Res Function(_Unit) _then) = __$UnitCopyWithImpl;
@override @useResult
$Res call({
 String? unitId, String unitName, String propertyId, String propertyName, String userId, String? tenantId, Tenant? currentTenant, UnitType? unitType, double rentPerMonth, Rent? unitRent, List<String> previousTenantsLog, bool isOccupied, DateTime? lastUpdateDate, double? numberFloors
});


@override $TenantCopyWith<$Res>? get currentTenant;@override $RentCopyWith<$Res>? get unitRent;

}
/// @nodoc
class __$UnitCopyWithImpl<$Res>
    implements _$UnitCopyWith<$Res> {
  __$UnitCopyWithImpl(this._self, this._then);

  final _Unit _self;
  final $Res Function(_Unit) _then;

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unitId = freezed,Object? unitName = null,Object? propertyId = null,Object? propertyName = null,Object? userId = null,Object? tenantId = freezed,Object? currentTenant = freezed,Object? unitType = freezed,Object? rentPerMonth = null,Object? unitRent = freezed,Object? previousTenantsLog = null,Object? isOccupied = null,Object? lastUpdateDate = freezed,Object? numberFloors = freezed,}) {
  return _then(_Unit(
unitId: freezed == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String?,unitName: null == unitName ? _self.unitName : unitName // ignore: cast_nullable_to_non_nullable
as String,propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,currentTenant: freezed == currentTenant ? _self.currentTenant : currentTenant // ignore: cast_nullable_to_non_nullable
as Tenant?,unitType: freezed == unitType ? _self.unitType : unitType // ignore: cast_nullable_to_non_nullable
as UnitType?,rentPerMonth: null == rentPerMonth ? _self.rentPerMonth : rentPerMonth // ignore: cast_nullable_to_non_nullable
as double,unitRent: freezed == unitRent ? _self.unitRent : unitRent // ignore: cast_nullable_to_non_nullable
as Rent?,previousTenantsLog: null == previousTenantsLog ? _self._previousTenantsLog : previousTenantsLog // ignore: cast_nullable_to_non_nullable
as List<String>,isOccupied: null == isOccupied ? _self.isOccupied : isOccupied // ignore: cast_nullable_to_non_nullable
as bool,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,numberFloors: freezed == numberFloors ? _self.numberFloors : numberFloors // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantCopyWith<$Res>? get currentTenant {
    if (_self.currentTenant == null) {
    return null;
  }

  return $TenantCopyWith<$Res>(_self.currentTenant!, (value) {
    return _then(_self.copyWith(currentTenant: value));
  });
}/// Create a copy of Unit
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
}
}

// dart format on
