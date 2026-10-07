// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppData {

 List<Property> get properties; List<Tenant> get tenants; List<FinancialRecord> get finances; List<Unit> get units; AppUser? get appUser; List<Tenant> get activeTenants; List<RentalRecord> get rentRecords;
/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppDataCopyWith<AppData> get copyWith => _$AppDataCopyWithImpl<AppData>(this as AppData, _$identity);

  /// Serializes this AppData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppData&&const DeepCollectionEquality().equals(other.properties, properties)&&const DeepCollectionEquality().equals(other.tenants, tenants)&&const DeepCollectionEquality().equals(other.finances, finances)&&const DeepCollectionEquality().equals(other.units, units)&&(identical(other.appUser, appUser) || other.appUser == appUser)&&const DeepCollectionEquality().equals(other.activeTenants, activeTenants)&&const DeepCollectionEquality().equals(other.rentRecords, rentRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(properties),const DeepCollectionEquality().hash(tenants),const DeepCollectionEquality().hash(finances),const DeepCollectionEquality().hash(units),appUser,const DeepCollectionEquality().hash(activeTenants),const DeepCollectionEquality().hash(rentRecords));

@override
String toString() {
  return 'AppData(properties: $properties, tenants: $tenants, finances: $finances, units: $units, appUser: $appUser, activeTenants: $activeTenants, rentRecords: $rentRecords)';
}


}

/// @nodoc
abstract mixin class $AppDataCopyWith<$Res>  {
  factory $AppDataCopyWith(AppData value, $Res Function(AppData) _then) = _$AppDataCopyWithImpl;
@useResult
$Res call({
 List<Property> properties, List<Tenant> tenants, List<FinancialRecord> finances, List<Unit> units, AppUser? appUser, List<Tenant> activeTenants, List<RentalRecord> rentRecords
});


$AppUserCopyWith<$Res>? get appUser;

}
/// @nodoc
class _$AppDataCopyWithImpl<$Res>
    implements $AppDataCopyWith<$Res> {
  _$AppDataCopyWithImpl(this._self, this._then);

  final AppData _self;
  final $Res Function(AppData) _then;

/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? properties = null,Object? tenants = null,Object? finances = null,Object? units = null,Object? appUser = freezed,Object? activeTenants = null,Object? rentRecords = null,}) {
  return _then(_self.copyWith(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,tenants: null == tenants ? _self.tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<Tenant>,finances: null == finances ? _self.finances : finances // ignore: cast_nullable_to_non_nullable
as List<FinancialRecord>,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<Unit>,appUser: freezed == appUser ? _self.appUser : appUser // ignore: cast_nullable_to_non_nullable
as AppUser?,activeTenants: null == activeTenants ? _self.activeTenants : activeTenants // ignore: cast_nullable_to_non_nullable
as List<Tenant>,rentRecords: null == rentRecords ? _self.rentRecords : rentRecords // ignore: cast_nullable_to_non_nullable
as List<RentalRecord>,
  ));
}
/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get appUser {
    if (_self.appUser == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.appUser!, (value) {
    return _then(_self.copyWith(appUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppData].
extension AppDataPatterns on AppData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppData value)  $default,){
final _that = this;
switch (_that) {
case _AppData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppData value)?  $default,){
final _that = this;
switch (_that) {
case _AppData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Property> properties,  List<Tenant> tenants,  List<FinancialRecord> finances,  List<Unit> units,  AppUser? appUser,  List<Tenant> activeTenants,  List<RentalRecord> rentRecords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppData() when $default != null:
return $default(_that.properties,_that.tenants,_that.finances,_that.units,_that.appUser,_that.activeTenants,_that.rentRecords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Property> properties,  List<Tenant> tenants,  List<FinancialRecord> finances,  List<Unit> units,  AppUser? appUser,  List<Tenant> activeTenants,  List<RentalRecord> rentRecords)  $default,) {final _that = this;
switch (_that) {
case _AppData():
return $default(_that.properties,_that.tenants,_that.finances,_that.units,_that.appUser,_that.activeTenants,_that.rentRecords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Property> properties,  List<Tenant> tenants,  List<FinancialRecord> finances,  List<Unit> units,  AppUser? appUser,  List<Tenant> activeTenants,  List<RentalRecord> rentRecords)?  $default,) {final _that = this;
switch (_that) {
case _AppData() when $default != null:
return $default(_that.properties,_that.tenants,_that.finances,_that.units,_that.appUser,_that.activeTenants,_that.rentRecords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppData implements AppData {
  const _AppData({final  List<Property> properties = const [], final  List<Tenant> tenants = const [], final  List<FinancialRecord> finances = const [], final  List<Unit> units = const [], this.appUser, final  List<Tenant> activeTenants = const [], final  List<RentalRecord> rentRecords = const []}): _properties = properties,_tenants = tenants,_finances = finances,_units = units,_activeTenants = activeTenants,_rentRecords = rentRecords;
  factory _AppData.fromJson(Map<String, dynamic> json) => _$AppDataFromJson(json);

 final  List<Property> _properties;
@override@JsonKey() List<Property> get properties {
  if (_properties is EqualUnmodifiableListView) return _properties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_properties);
}

 final  List<Tenant> _tenants;
@override@JsonKey() List<Tenant> get tenants {
  if (_tenants is EqualUnmodifiableListView) return _tenants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tenants);
}

 final  List<FinancialRecord> _finances;
@override@JsonKey() List<FinancialRecord> get finances {
  if (_finances is EqualUnmodifiableListView) return _finances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_finances);
}

 final  List<Unit> _units;
@override@JsonKey() List<Unit> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

@override final  AppUser? appUser;
 final  List<Tenant> _activeTenants;
@override@JsonKey() List<Tenant> get activeTenants {
  if (_activeTenants is EqualUnmodifiableListView) return _activeTenants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeTenants);
}

 final  List<RentalRecord> _rentRecords;
@override@JsonKey() List<RentalRecord> get rentRecords {
  if (_rentRecords is EqualUnmodifiableListView) return _rentRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rentRecords);
}


/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppDataCopyWith<_AppData> get copyWith => __$AppDataCopyWithImpl<_AppData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppData&&const DeepCollectionEquality().equals(other._properties, _properties)&&const DeepCollectionEquality().equals(other._tenants, _tenants)&&const DeepCollectionEquality().equals(other._finances, _finances)&&const DeepCollectionEquality().equals(other._units, _units)&&(identical(other.appUser, appUser) || other.appUser == appUser)&&const DeepCollectionEquality().equals(other._activeTenants, _activeTenants)&&const DeepCollectionEquality().equals(other._rentRecords, _rentRecords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_properties),const DeepCollectionEquality().hash(_tenants),const DeepCollectionEquality().hash(_finances),const DeepCollectionEquality().hash(_units),appUser,const DeepCollectionEquality().hash(_activeTenants),const DeepCollectionEquality().hash(_rentRecords));

@override
String toString() {
  return 'AppData(properties: $properties, tenants: $tenants, finances: $finances, units: $units, appUser: $appUser, activeTenants: $activeTenants, rentRecords: $rentRecords)';
}


}

/// @nodoc
abstract mixin class _$AppDataCopyWith<$Res> implements $AppDataCopyWith<$Res> {
  factory _$AppDataCopyWith(_AppData value, $Res Function(_AppData) _then) = __$AppDataCopyWithImpl;
@override @useResult
$Res call({
 List<Property> properties, List<Tenant> tenants, List<FinancialRecord> finances, List<Unit> units, AppUser? appUser, List<Tenant> activeTenants, List<RentalRecord> rentRecords
});


@override $AppUserCopyWith<$Res>? get appUser;

}
/// @nodoc
class __$AppDataCopyWithImpl<$Res>
    implements _$AppDataCopyWith<$Res> {
  __$AppDataCopyWithImpl(this._self, this._then);

  final _AppData _self;
  final $Res Function(_AppData) _then;

/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? tenants = null,Object? finances = null,Object? units = null,Object? appUser = freezed,Object? activeTenants = null,Object? rentRecords = null,}) {
  return _then(_AppData(
properties: null == properties ? _self._properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,tenants: null == tenants ? _self._tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<Tenant>,finances: null == finances ? _self._finances : finances // ignore: cast_nullable_to_non_nullable
as List<FinancialRecord>,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<Unit>,appUser: freezed == appUser ? _self.appUser : appUser // ignore: cast_nullable_to_non_nullable
as AppUser?,activeTenants: null == activeTenants ? _self._activeTenants : activeTenants // ignore: cast_nullable_to_non_nullable
as List<Tenant>,rentRecords: null == rentRecords ? _self._rentRecords : rentRecords // ignore: cast_nullable_to_non_nullable
as List<RentalRecord>,
  ));
}

/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get appUser {
    if (_self.appUser == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.appUser!, (value) {
    return _then(_self.copyWith(appUser: value));
  });
}
}

// dart format on
