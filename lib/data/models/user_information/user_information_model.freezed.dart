// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_information_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInformation {

 List<Property> get properties; List<Tenant> get tenants; List<Unit> get units; List<FinancialRecord> get finances; bool get isLoading;
/// Create a copy of UserInformation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInformationCopyWith<UserInformation> get copyWith => _$UserInformationCopyWithImpl<UserInformation>(this as UserInformation, _$identity);

  /// Serializes this UserInformation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInformation&&const DeepCollectionEquality().equals(other.properties, properties)&&const DeepCollectionEquality().equals(other.tenants, tenants)&&const DeepCollectionEquality().equals(other.units, units)&&const DeepCollectionEquality().equals(other.finances, finances)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(properties),const DeepCollectionEquality().hash(tenants),const DeepCollectionEquality().hash(units),const DeepCollectionEquality().hash(finances),isLoading);

@override
String toString() {
  return 'UserInformation(properties: $properties, tenants: $tenants, units: $units, finances: $finances, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $UserInformationCopyWith<$Res>  {
  factory $UserInformationCopyWith(UserInformation value, $Res Function(UserInformation) _then) = _$UserInformationCopyWithImpl;
@useResult
$Res call({
 List<Property> properties, List<Tenant> tenants, List<Unit> units, List<FinancialRecord> finances, bool isLoading
});




}
/// @nodoc
class _$UserInformationCopyWithImpl<$Res>
    implements $UserInformationCopyWith<$Res> {
  _$UserInformationCopyWithImpl(this._self, this._then);

  final UserInformation _self;
  final $Res Function(UserInformation) _then;

/// Create a copy of UserInformation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? properties = null,Object? tenants = null,Object? units = null,Object? finances = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
properties: null == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,tenants: null == tenants ? _self.tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<Tenant>,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<Unit>,finances: null == finances ? _self.finances : finances // ignore: cast_nullable_to_non_nullable
as List<FinancialRecord>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInformation].
extension UserInformationPatterns on UserInformation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInformation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInformation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInformation value)  $default,){
final _that = this;
switch (_that) {
case _UserInformation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInformation value)?  $default,){
final _that = this;
switch (_that) {
case _UserInformation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Property> properties,  List<Tenant> tenants,  List<Unit> units,  List<FinancialRecord> finances,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInformation() when $default != null:
return $default(_that.properties,_that.tenants,_that.units,_that.finances,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Property> properties,  List<Tenant> tenants,  List<Unit> units,  List<FinancialRecord> finances,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _UserInformation():
return $default(_that.properties,_that.tenants,_that.units,_that.finances,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Property> properties,  List<Tenant> tenants,  List<Unit> units,  List<FinancialRecord> finances,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _UserInformation() when $default != null:
return $default(_that.properties,_that.tenants,_that.units,_that.finances,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInformation implements UserInformation {
  const _UserInformation({final  List<Property> properties = const [], final  List<Tenant> tenants = const [], final  List<Unit> units = const [], final  List<FinancialRecord> finances = const [], this.isLoading = false}): _properties = properties,_tenants = tenants,_units = units,_finances = finances;
  factory _UserInformation.fromJson(Map<String, dynamic> json) => _$UserInformationFromJson(json);

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

 final  List<Unit> _units;
@override@JsonKey() List<Unit> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

 final  List<FinancialRecord> _finances;
@override@JsonKey() List<FinancialRecord> get finances {
  if (_finances is EqualUnmodifiableListView) return _finances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_finances);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of UserInformation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInformationCopyWith<_UserInformation> get copyWith => __$UserInformationCopyWithImpl<_UserInformation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInformationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInformation&&const DeepCollectionEquality().equals(other._properties, _properties)&&const DeepCollectionEquality().equals(other._tenants, _tenants)&&const DeepCollectionEquality().equals(other._units, _units)&&const DeepCollectionEquality().equals(other._finances, _finances)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_properties),const DeepCollectionEquality().hash(_tenants),const DeepCollectionEquality().hash(_units),const DeepCollectionEquality().hash(_finances),isLoading);

@override
String toString() {
  return 'UserInformation(properties: $properties, tenants: $tenants, units: $units, finances: $finances, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$UserInformationCopyWith<$Res> implements $UserInformationCopyWith<$Res> {
  factory _$UserInformationCopyWith(_UserInformation value, $Res Function(_UserInformation) _then) = __$UserInformationCopyWithImpl;
@override @useResult
$Res call({
 List<Property> properties, List<Tenant> tenants, List<Unit> units, List<FinancialRecord> finances, bool isLoading
});




}
/// @nodoc
class __$UserInformationCopyWithImpl<$Res>
    implements _$UserInformationCopyWith<$Res> {
  __$UserInformationCopyWithImpl(this._self, this._then);

  final _UserInformation _self;
  final $Res Function(_UserInformation) _then;

/// Create a copy of UserInformation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? properties = null,Object? tenants = null,Object? units = null,Object? finances = null,Object? isLoading = null,}) {
  return _then(_UserInformation(
properties: null == properties ? _self._properties : properties // ignore: cast_nullable_to_non_nullable
as List<Property>,tenants: null == tenants ? _self._tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<Tenant>,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<Unit>,finances: null == finances ? _self._finances : finances // ignore: cast_nullable_to_non_nullable
as List<FinancialRecord>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
