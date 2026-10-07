// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RentalRecord {

 String get tenantId; String get unitId; SingleRentEntry get rentEntry; RentalMonth get rentalMonth; RentHistory get rentHistory;
/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalRecordCopyWith<RentalRecord> get copyWith => _$RentalRecordCopyWithImpl<RentalRecord>(this as RentalRecord, _$identity);

  /// Serializes this RentalRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalRecord&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.rentEntry, rentEntry) || other.rentEntry == rentEntry)&&(identical(other.rentalMonth, rentalMonth) || other.rentalMonth == rentalMonth)&&(identical(other.rentHistory, rentHistory) || other.rentHistory == rentHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tenantId,unitId,rentEntry,rentalMonth,rentHistory);

@override
String toString() {
  return 'RentalRecord(tenantId: $tenantId, unitId: $unitId, rentEntry: $rentEntry, rentalMonth: $rentalMonth, rentHistory: $rentHistory)';
}


}

/// @nodoc
abstract mixin class $RentalRecordCopyWith<$Res>  {
  factory $RentalRecordCopyWith(RentalRecord value, $Res Function(RentalRecord) _then) = _$RentalRecordCopyWithImpl;
@useResult
$Res call({
 String tenantId, String unitId, SingleRentEntry rentEntry, RentalMonth rentalMonth, RentHistory rentHistory
});


$SingleRentEntryCopyWith<$Res> get rentEntry;$RentalMonthCopyWith<$Res> get rentalMonth;$RentHistoryCopyWith<$Res> get rentHistory;

}
/// @nodoc
class _$RentalRecordCopyWithImpl<$Res>
    implements $RentalRecordCopyWith<$Res> {
  _$RentalRecordCopyWithImpl(this._self, this._then);

  final RentalRecord _self;
  final $Res Function(RentalRecord) _then;

/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenantId = null,Object? unitId = null,Object? rentEntry = null,Object? rentalMonth = null,Object? rentHistory = null,}) {
  return _then(_self.copyWith(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,rentEntry: null == rentEntry ? _self.rentEntry : rentEntry // ignore: cast_nullable_to_non_nullable
as SingleRentEntry,rentalMonth: null == rentalMonth ? _self.rentalMonth : rentalMonth // ignore: cast_nullable_to_non_nullable
as RentalMonth,rentHistory: null == rentHistory ? _self.rentHistory : rentHistory // ignore: cast_nullable_to_non_nullable
as RentHistory,
  ));
}
/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SingleRentEntryCopyWith<$Res> get rentEntry {
  
  return $SingleRentEntryCopyWith<$Res>(_self.rentEntry, (value) {
    return _then(_self.copyWith(rentEntry: value));
  });
}/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentalMonthCopyWith<$Res> get rentalMonth {
  
  return $RentalMonthCopyWith<$Res>(_self.rentalMonth, (value) {
    return _then(_self.copyWith(rentalMonth: value));
  });
}/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentHistoryCopyWith<$Res> get rentHistory {
  
  return $RentHistoryCopyWith<$Res>(_self.rentHistory, (value) {
    return _then(_self.copyWith(rentHistory: value));
  });
}
}


/// Adds pattern-matching-related methods to [RentalRecord].
extension RentalRecordPatterns on RentalRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalRecord value)  $default,){
final _that = this;
switch (_that) {
case _RentalRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalRecord value)?  $default,){
final _that = this;
switch (_that) {
case _RentalRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tenantId,  String unitId,  SingleRentEntry rentEntry,  RentalMonth rentalMonth,  RentHistory rentHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalRecord() when $default != null:
return $default(_that.tenantId,_that.unitId,_that.rentEntry,_that.rentalMonth,_that.rentHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tenantId,  String unitId,  SingleRentEntry rentEntry,  RentalMonth rentalMonth,  RentHistory rentHistory)  $default,) {final _that = this;
switch (_that) {
case _RentalRecord():
return $default(_that.tenantId,_that.unitId,_that.rentEntry,_that.rentalMonth,_that.rentHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tenantId,  String unitId,  SingleRentEntry rentEntry,  RentalMonth rentalMonth,  RentHistory rentHistory)?  $default,) {final _that = this;
switch (_that) {
case _RentalRecord() when $default != null:
return $default(_that.tenantId,_that.unitId,_that.rentEntry,_that.rentalMonth,_that.rentHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalRecord implements RentalRecord {
  const _RentalRecord({required this.tenantId, required this.unitId, required this.rentEntry, required this.rentalMonth, required this.rentHistory});
  factory _RentalRecord.fromJson(Map<String, dynamic> json) => _$RentalRecordFromJson(json);

@override final  String tenantId;
@override final  String unitId;
@override final  SingleRentEntry rentEntry;
@override final  RentalMonth rentalMonth;
@override final  RentHistory rentHistory;

/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalRecordCopyWith<_RentalRecord> get copyWith => __$RentalRecordCopyWithImpl<_RentalRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalRecord&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.unitId, unitId) || other.unitId == unitId)&&(identical(other.rentEntry, rentEntry) || other.rentEntry == rentEntry)&&(identical(other.rentalMonth, rentalMonth) || other.rentalMonth == rentalMonth)&&(identical(other.rentHistory, rentHistory) || other.rentHistory == rentHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tenantId,unitId,rentEntry,rentalMonth,rentHistory);

@override
String toString() {
  return 'RentalRecord(tenantId: $tenantId, unitId: $unitId, rentEntry: $rentEntry, rentalMonth: $rentalMonth, rentHistory: $rentHistory)';
}


}

/// @nodoc
abstract mixin class _$RentalRecordCopyWith<$Res> implements $RentalRecordCopyWith<$Res> {
  factory _$RentalRecordCopyWith(_RentalRecord value, $Res Function(_RentalRecord) _then) = __$RentalRecordCopyWithImpl;
@override @useResult
$Res call({
 String tenantId, String unitId, SingleRentEntry rentEntry, RentalMonth rentalMonth, RentHistory rentHistory
});


@override $SingleRentEntryCopyWith<$Res> get rentEntry;@override $RentalMonthCopyWith<$Res> get rentalMonth;@override $RentHistoryCopyWith<$Res> get rentHistory;

}
/// @nodoc
class __$RentalRecordCopyWithImpl<$Res>
    implements _$RentalRecordCopyWith<$Res> {
  __$RentalRecordCopyWithImpl(this._self, this._then);

  final _RentalRecord _self;
  final $Res Function(_RentalRecord) _then;

/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenantId = null,Object? unitId = null,Object? rentEntry = null,Object? rentalMonth = null,Object? rentHistory = null,}) {
  return _then(_RentalRecord(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,unitId: null == unitId ? _self.unitId : unitId // ignore: cast_nullable_to_non_nullable
as String,rentEntry: null == rentEntry ? _self.rentEntry : rentEntry // ignore: cast_nullable_to_non_nullable
as SingleRentEntry,rentalMonth: null == rentalMonth ? _self.rentalMonth : rentalMonth // ignore: cast_nullable_to_non_nullable
as RentalMonth,rentHistory: null == rentHistory ? _self.rentHistory : rentHistory // ignore: cast_nullable_to_non_nullable
as RentHistory,
  ));
}

/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SingleRentEntryCopyWith<$Res> get rentEntry {
  
  return $SingleRentEntryCopyWith<$Res>(_self.rentEntry, (value) {
    return _then(_self.copyWith(rentEntry: value));
  });
}/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentalMonthCopyWith<$Res> get rentalMonth {
  
  return $RentalMonthCopyWith<$Res>(_self.rentalMonth, (value) {
    return _then(_self.copyWith(rentalMonth: value));
  });
}/// Create a copy of RentalRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentHistoryCopyWith<$Res> get rentHistory {
  
  return $RentHistoryCopyWith<$Res>(_self.rentHistory, (value) {
    return _then(_self.copyWith(rentHistory: value));
  });
}
}

// dart format on
