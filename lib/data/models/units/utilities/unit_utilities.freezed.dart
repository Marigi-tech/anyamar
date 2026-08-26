// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_utilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnitUtility {

 PropertyUtility get utilityName; double get amountPayable;
/// Create a copy of UnitUtility
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitUtilityCopyWith<UnitUtility> get copyWith => _$UnitUtilityCopyWithImpl<UnitUtility>(this as UnitUtility, _$identity);

  /// Serializes this UnitUtility to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitUtility&&(identical(other.utilityName, utilityName) || other.utilityName == utilityName)&&(identical(other.amountPayable, amountPayable) || other.amountPayable == amountPayable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,utilityName,amountPayable);

@override
String toString() {
  return 'UnitUtility(utilityName: $utilityName, amountPayable: $amountPayable)';
}


}

/// @nodoc
abstract mixin class $UnitUtilityCopyWith<$Res>  {
  factory $UnitUtilityCopyWith(UnitUtility value, $Res Function(UnitUtility) _then) = _$UnitUtilityCopyWithImpl;
@useResult
$Res call({
 PropertyUtility utilityName, double amountPayable
});




}
/// @nodoc
class _$UnitUtilityCopyWithImpl<$Res>
    implements $UnitUtilityCopyWith<$Res> {
  _$UnitUtilityCopyWithImpl(this._self, this._then);

  final UnitUtility _self;
  final $Res Function(UnitUtility) _then;

/// Create a copy of UnitUtility
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? utilityName = null,Object? amountPayable = null,}) {
  return _then(_self.copyWith(
utilityName: null == utilityName ? _self.utilityName : utilityName // ignore: cast_nullable_to_non_nullable
as PropertyUtility,amountPayable: null == amountPayable ? _self.amountPayable : amountPayable // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitUtility].
extension UnitUtilityPatterns on UnitUtility {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitUtility value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitUtility() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitUtility value)  $default,){
final _that = this;
switch (_that) {
case _UnitUtility():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitUtility value)?  $default,){
final _that = this;
switch (_that) {
case _UnitUtility() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PropertyUtility utilityName,  double amountPayable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitUtility() when $default != null:
return $default(_that.utilityName,_that.amountPayable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PropertyUtility utilityName,  double amountPayable)  $default,) {final _that = this;
switch (_that) {
case _UnitUtility():
return $default(_that.utilityName,_that.amountPayable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PropertyUtility utilityName,  double amountPayable)?  $default,) {final _that = this;
switch (_that) {
case _UnitUtility() when $default != null:
return $default(_that.utilityName,_that.amountPayable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitUtility implements UnitUtility {
  const _UnitUtility({required this.utilityName, required this.amountPayable});
  factory _UnitUtility.fromJson(Map<String, dynamic> json) => _$UnitUtilityFromJson(json);

@override final  PropertyUtility utilityName;
@override final  double amountPayable;

/// Create a copy of UnitUtility
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitUtilityCopyWith<_UnitUtility> get copyWith => __$UnitUtilityCopyWithImpl<_UnitUtility>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitUtilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitUtility&&(identical(other.utilityName, utilityName) || other.utilityName == utilityName)&&(identical(other.amountPayable, amountPayable) || other.amountPayable == amountPayable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,utilityName,amountPayable);

@override
String toString() {
  return 'UnitUtility(utilityName: $utilityName, amountPayable: $amountPayable)';
}


}

/// @nodoc
abstract mixin class _$UnitUtilityCopyWith<$Res> implements $UnitUtilityCopyWith<$Res> {
  factory _$UnitUtilityCopyWith(_UnitUtility value, $Res Function(_UnitUtility) _then) = __$UnitUtilityCopyWithImpl;
@override @useResult
$Res call({
 PropertyUtility utilityName, double amountPayable
});




}
/// @nodoc
class __$UnitUtilityCopyWithImpl<$Res>
    implements _$UnitUtilityCopyWith<$Res> {
  __$UnitUtilityCopyWithImpl(this._self, this._then);

  final _UnitUtility _self;
  final $Res Function(_UnitUtility) _then;

/// Create a copy of UnitUtility
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? utilityName = null,Object? amountPayable = null,}) {
  return _then(_UnitUtility(
utilityName: null == utilityName ? _self.utilityName : utilityName // ignore: cast_nullable_to_non_nullable
as PropertyUtility,amountPayable: null == amountPayable ? _self.amountPayable : amountPayable // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
