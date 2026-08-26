// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RentHistory {

 String? get historyId; String get tenantId; String get unitId; String? get propertyId; String get userId; List<Map<String, dynamic>> get rentEntries; String? get tenantName;
/// Create a copy of RentHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentHistoryCopyWith<RentHistory> get copyWith => _$RentHistoryCopyWithImpl<RentHistory>(this as RentHistory, _$identity);

  /// Serializes this RentHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentHistory&&(identical(other.historyId, historyId) || other.historyId == historyId)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.rentEntries, rentEntries)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,historyId,tenantId,unitId,propertyId,userId,const DeepCollectionEquality().hash(rentEntries),tenantName);

@override
String toString() {
  return 'RentHistory(historyId: $historyId, tenantId: $tenantId, unitId: $unitId, propertyId: $propertyId, userId: $userId, rentEntries: $rentEntries, tenantName: $tenantName)';
}


}

/// @nodoc
abstract mixin class $RentHistoryCopyWith<$Res>  {
  factory $RentHistoryCopyWith(RentHistory value, $Res Function(RentHistory) _then) = _$RentHistoryCopyWithImpl;
@useResult
$Res call({
 String? historyId, String tenantId, String unitId, String? propertyId, String userId, List<Map<String, dynamic>> rentEntries, String? tenantName
});




}
/// @nodoc
class _$RentHistoryCopyWithImpl<$Res>
    implements $RentHistoryCopyWith<$Res> {
  _$RentHistoryCopyWithImpl(this._self, this._then);

  final RentHistory _self;
  final $Res Function(RentHistory) _then;

/// Create a copy of RentHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? historyId = freezed,Object? tenantId = null,Object? unitId = null,Object? propertyId = freezed,Object? userId = null,Object? rentEntries = null,Object? tenantName = freezed,}) {
  return _then(_self.copyWith(
historyId: freezed == historyId ? _self.historyId : historyId // ignore: cast_nullable_to_non_nullable
as String?,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rentEntries: null == rentEntries ? _self.rentEntries : rentEntries // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,tenantName: freezed == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RentHistory].
extension RentHistoryPatterns on RentHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentHistory value)  $default,){
final _that = this;
switch (_that) {
case _RentHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentHistory value)?  $default,){
final _that = this;
switch (_that) {
case _RentHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? historyId,  String tenantId,  String unitId,  String? propertyId,  String userId,  List<Map<String, dynamic>> rentEntries,  String? tenantName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentHistory() when $default != null:
return $default(_that.historyId,_that.tenantId,_that.unitId,_that.propertyId,_that.userId,_that.rentEntries,_that.tenantName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? historyId,  String tenantId,  String unitId,  String? propertyId,  String userId,  List<Map<String, dynamic>> rentEntries,  String? tenantName)  $default,) {final _that = this;
switch (_that) {
case _RentHistory():
return $default(_that.historyId,_that.tenantId,_that.unitId,_that.propertyId,_that.userId,_that.rentEntries,_that.tenantName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? historyId,  String tenantId,  String unitId,  String? propertyId,  String userId,  List<Map<String, dynamic>> rentEntries,  String? tenantName)?  $default,) {final _that = this;
switch (_that) {
case _RentHistory() when $default != null:
return $default(_that.historyId,_that.tenantId,_that.unitId,_that.propertyId,_that.userId,_that.rentEntries,_that.tenantName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentHistory implements RentHistory {
  const _RentHistory({this.historyId, required this.tenantId, required this.unitId, this.propertyId, required this.userId, final  List<Map<String, dynamic>> rentEntries = const [], this.tenantName}): _rentEntries = rentEntries;
  factory _RentHistory.fromJson(Map<String, dynamic> json) => _$RentHistoryFromJson(json);

@override final  String? historyId;
@override final  String tenantId;
@override final  String unitId;
@override final  String? propertyId;
@override final  String userId;
 final  List<Map<String, dynamic>> _rentEntries;
@override@JsonKey() List<Map<String, dynamic>> get rentEntries {
  if (_rentEntries is EqualUnmodifiableListView) return _rentEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rentEntries);
}

@override final  String? tenantName;

/// Create a copy of RentHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentHistoryCopyWith<_RentHistory> get copyWith => __$RentHistoryCopyWithImpl<_RentHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentHistory&&(identical(other.historyId, historyId) || other.historyId == historyId)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._rentEntries, _rentEntries)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,historyId,tenantId,unitId,propertyId,userId,const DeepCollectionEquality().hash(_rentEntries),tenantName);

@override
String toString() {
  return 'RentHistory(historyId: $historyId, tenantId: $tenantId, unitId: $unitId, propertyId: $propertyId, userId: $userId, rentEntries: $rentEntries, tenantName: $tenantName)';
}


}

/// @nodoc
abstract mixin class _$RentHistoryCopyWith<$Res> implements $RentHistoryCopyWith<$Res> {
  factory _$RentHistoryCopyWith(_RentHistory value, $Res Function(_RentHistory) _then) = __$RentHistoryCopyWithImpl;
@override @useResult
$Res call({
 String? historyId, String tenantId, String unitId, String? propertyId, String userId, List<Map<String, dynamic>> rentEntries, String? tenantName
});




}
/// @nodoc
class __$RentHistoryCopyWithImpl<$Res>
    implements _$RentHistoryCopyWith<$Res> {
  __$RentHistoryCopyWithImpl(this._self, this._then);

  final _RentHistory _self;
  final $Res Function(_RentHistory) _then;

/// Create a copy of RentHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? historyId = freezed,Object? tenantId = null,Object? unitId = null,Object? propertyId = freezed,Object? userId = null,Object? rentEntries = null,Object? tenantName = freezed,}) {
  return _then(_RentHistory(
historyId: freezed == historyId ? _self.historyId : historyId // ignore: cast_nullable_to_non_nullable
as String?,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rentEntries: null == rentEntries ? _self._rentEntries : rentEntries // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,tenantName: freezed == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
