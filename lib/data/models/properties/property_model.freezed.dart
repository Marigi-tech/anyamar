// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Property {

 String? get propertyId; String get propertyName; String get propertyLocation; Map<String, dynamic>? get propertyManager; String? get propertyImage; String get userId; List<Unit> get propertyUnits; int get propertyFloors; DateTime? get lastUpdatedDate;
/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertyCopyWith<Property> get copyWith => _$PropertyCopyWithImpl<Property>(this as Property, _$identity);

  /// Serializes this Property to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Property&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.propertyLocation, propertyLocation) || other.propertyLocation == propertyLocation)&&const DeepCollectionEquality().equals(other.propertyManager, propertyManager)&&(identical(other.propertyImage, propertyImage) || other.propertyImage == propertyImage)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.propertyUnits, propertyUnits)&&(identical(other.propertyFloors, propertyFloors) || other.propertyFloors == propertyFloors)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,propertyId,propertyName,propertyLocation,const DeepCollectionEquality().hash(propertyManager),propertyImage,userId,const DeepCollectionEquality().hash(propertyUnits),propertyFloors,lastUpdatedDate);

@override
String toString() {
  return 'Property(propertyId: $propertyId, propertyName: $propertyName, propertyLocation: $propertyLocation, propertyManager: $propertyManager, propertyImage: $propertyImage, userId: $userId, propertyUnits: $propertyUnits, propertyFloors: $propertyFloors, lastUpdatedDate: $lastUpdatedDate)';
}


}

/// @nodoc
abstract mixin class $PropertyCopyWith<$Res>  {
  factory $PropertyCopyWith(Property value, $Res Function(Property) _then) = _$PropertyCopyWithImpl;
@useResult
$Res call({
 String? propertyId, String propertyName, String propertyLocation, Map<String, dynamic>? propertyManager, String? propertyImage, String userId, List<Unit> propertyUnits, int propertyFloors, DateTime? lastUpdatedDate
});




}
/// @nodoc
class _$PropertyCopyWithImpl<$Res>
    implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._self, this._then);

  final Property _self;
  final $Res Function(Property) _then;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? propertyId = freezed,Object? propertyName = null,Object? propertyLocation = null,Object? propertyManager = freezed,Object? propertyImage = freezed,Object? userId = null,Object? propertyUnits = null,Object? propertyFloors = null,Object? lastUpdatedDate = freezed,}) {
  return _then(_self.copyWith(
propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,propertyLocation: null == propertyLocation ? _self.propertyLocation : propertyLocation // ignore: cast_nullable_to_non_nullable
as String,propertyManager: freezed == propertyManager ? _self.propertyManager : propertyManager // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,propertyImage: freezed == propertyImage ? _self.propertyImage : propertyImage // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,propertyUnits: null == propertyUnits ? _self.propertyUnits : propertyUnits // ignore: cast_nullable_to_non_nullable
as List<Unit>,propertyFloors: null == propertyFloors ? _self.propertyFloors : propertyFloors // ignore: cast_nullable_to_non_nullable
as int,lastUpdatedDate: freezed == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Property].
extension PropertyPatterns on Property {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Property value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Property() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Property value)  $default,){
final _that = this;
switch (_that) {
case _Property():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Property value)?  $default,){
final _that = this;
switch (_that) {
case _Property() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? propertyId,  String propertyName,  String propertyLocation,  Map<String, dynamic>? propertyManager,  String? propertyImage,  String userId,  List<Unit> propertyUnits,  int propertyFloors,  DateTime? lastUpdatedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Property() when $default != null:
return $default(_that.propertyId,_that.propertyName,_that.propertyLocation,_that.propertyManager,_that.propertyImage,_that.userId,_that.propertyUnits,_that.propertyFloors,_that.lastUpdatedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? propertyId,  String propertyName,  String propertyLocation,  Map<String, dynamic>? propertyManager,  String? propertyImage,  String userId,  List<Unit> propertyUnits,  int propertyFloors,  DateTime? lastUpdatedDate)  $default,) {final _that = this;
switch (_that) {
case _Property():
return $default(_that.propertyId,_that.propertyName,_that.propertyLocation,_that.propertyManager,_that.propertyImage,_that.userId,_that.propertyUnits,_that.propertyFloors,_that.lastUpdatedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? propertyId,  String propertyName,  String propertyLocation,  Map<String, dynamic>? propertyManager,  String? propertyImage,  String userId,  List<Unit> propertyUnits,  int propertyFloors,  DateTime? lastUpdatedDate)?  $default,) {final _that = this;
switch (_that) {
case _Property() when $default != null:
return $default(_that.propertyId,_that.propertyName,_that.propertyLocation,_that.propertyManager,_that.propertyImage,_that.userId,_that.propertyUnits,_that.propertyFloors,_that.lastUpdatedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Property implements Property {
  const _Property({this.propertyId, required this.propertyName, required this.propertyLocation, final  Map<String, dynamic>? propertyManager, this.propertyImage, required this.userId, final  List<Unit> propertyUnits = const [], this.propertyFloors = 0, this.lastUpdatedDate}): _propertyManager = propertyManager,_propertyUnits = propertyUnits;
  factory _Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

@override final  String? propertyId;
@override final  String propertyName;
@override final  String propertyLocation;
 final  Map<String, dynamic>? _propertyManager;
@override Map<String, dynamic>? get propertyManager {
  final value = _propertyManager;
  if (value == null) return null;
  if (_propertyManager is EqualUnmodifiableMapView) return _propertyManager;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? propertyImage;
@override final  String userId;
 final  List<Unit> _propertyUnits;
@override@JsonKey() List<Unit> get propertyUnits {
  if (_propertyUnits is EqualUnmodifiableListView) return _propertyUnits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_propertyUnits);
}

@override@JsonKey() final  int propertyFloors;
@override final  DateTime? lastUpdatedDate;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PropertyCopyWith<_Property> get copyWith => __$PropertyCopyWithImpl<_Property>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Property&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.propertyLocation, propertyLocation) || other.propertyLocation == propertyLocation)&&const DeepCollectionEquality().equals(other._propertyManager, _propertyManager)&&(identical(other.propertyImage, propertyImage) || other.propertyImage == propertyImage)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._propertyUnits, _propertyUnits)&&(identical(other.propertyFloors, propertyFloors) || other.propertyFloors == propertyFloors)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,propertyId,propertyName,propertyLocation,const DeepCollectionEquality().hash(_propertyManager),propertyImage,userId,const DeepCollectionEquality().hash(_propertyUnits),propertyFloors,lastUpdatedDate);

@override
String toString() {
  return 'Property(propertyId: $propertyId, propertyName: $propertyName, propertyLocation: $propertyLocation, propertyManager: $propertyManager, propertyImage: $propertyImage, userId: $userId, propertyUnits: $propertyUnits, propertyFloors: $propertyFloors, lastUpdatedDate: $lastUpdatedDate)';
}


}

/// @nodoc
abstract mixin class _$PropertyCopyWith<$Res> implements $PropertyCopyWith<$Res> {
  factory _$PropertyCopyWith(_Property value, $Res Function(_Property) _then) = __$PropertyCopyWithImpl;
@override @useResult
$Res call({
 String? propertyId, String propertyName, String propertyLocation, Map<String, dynamic>? propertyManager, String? propertyImage, String userId, List<Unit> propertyUnits, int propertyFloors, DateTime? lastUpdatedDate
});




}
/// @nodoc
class __$PropertyCopyWithImpl<$Res>
    implements _$PropertyCopyWith<$Res> {
  __$PropertyCopyWithImpl(this._self, this._then);

  final _Property _self;
  final $Res Function(_Property) _then;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? propertyId = freezed,Object? propertyName = null,Object? propertyLocation = null,Object? propertyManager = freezed,Object? propertyImage = freezed,Object? userId = null,Object? propertyUnits = null,Object? propertyFloors = null,Object? lastUpdatedDate = freezed,}) {
  return _then(_Property(
propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,propertyLocation: null == propertyLocation ? _self.propertyLocation : propertyLocation // ignore: cast_nullable_to_non_nullable
as String,propertyManager: freezed == propertyManager ? _self._propertyManager : propertyManager // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,propertyImage: freezed == propertyImage ? _self.propertyImage : propertyImage // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,propertyUnits: null == propertyUnits ? _self._propertyUnits : propertyUnits // ignore: cast_nullable_to_non_nullable
as List<Unit>,propertyFloors: null == propertyFloors ? _self.propertyFloors : propertyFloors // ignore: cast_nullable_to_non_nullable
as int,lastUpdatedDate: freezed == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
