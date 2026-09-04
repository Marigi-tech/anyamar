// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinancialRecord {

 DateTime get datePaid; double get amountPaid; FinancialRecordTypes get recordType; Person get paymentBy; DateTime? get lastUpdatedDate; FinancialRecordNature get recordNature; String? get recordId; PaymentMethods? get paymentMethod; String? get userId; String? get propertyId;
/// Create a copy of FinancialRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialRecordCopyWith<FinancialRecord> get copyWith => _$FinancialRecordCopyWithImpl<FinancialRecord>(this as FinancialRecord, _$identity);

  /// Serializes this FinancialRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialRecord&&(identical(other.datePaid, datePaid) || other.datePaid == datePaid)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.paymentBy, paymentBy) || other.paymentBy == paymentBy)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate)&&(identical(other.recordNature, recordNature) || other.recordNature == recordNature)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datePaid,amountPaid,recordType,paymentBy,lastUpdatedDate,recordNature,recordId,paymentMethod,userId,propertyId);

@override
String toString() {
  return 'FinancialRecord(datePaid: $datePaid, amountPaid: $amountPaid, recordType: $recordType, paymentBy: $paymentBy, lastUpdatedDate: $lastUpdatedDate, recordNature: $recordNature, recordId: $recordId, paymentMethod: $paymentMethod, userId: $userId, propertyId: $propertyId)';
}


}

/// @nodoc
abstract mixin class $FinancialRecordCopyWith<$Res>  {
  factory $FinancialRecordCopyWith(FinancialRecord value, $Res Function(FinancialRecord) _then) = _$FinancialRecordCopyWithImpl;
@useResult
$Res call({
 DateTime datePaid, double amountPaid, FinancialRecordTypes recordType, Person paymentBy, DateTime? lastUpdatedDate, FinancialRecordNature recordNature, String? recordId, PaymentMethods? paymentMethod, String? userId, String? propertyId
});


$PersonCopyWith<$Res> get paymentBy;

}
/// @nodoc
class _$FinancialRecordCopyWithImpl<$Res>
    implements $FinancialRecordCopyWith<$Res> {
  _$FinancialRecordCopyWithImpl(this._self, this._then);

  final FinancialRecord _self;
  final $Res Function(FinancialRecord) _then;

/// Create a copy of FinancialRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? datePaid = null,Object? amountPaid = null,Object? recordType = null,Object? paymentBy = null,Object? lastUpdatedDate = freezed,Object? recordNature = null,Object? recordId = freezed,Object? paymentMethod = freezed,Object? userId = freezed,Object? propertyId = freezed,}) {
  return _then(_self.copyWith(
datePaid: null == datePaid ? _self.datePaid : datePaid // ignore: cast_nullable_to_non_nullable
as DateTime,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as FinancialRecordTypes,paymentBy: null == paymentBy ? _self.paymentBy : paymentBy // ignore: cast_nullable_to_non_nullable
as Person,lastUpdatedDate: freezed == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,recordNature: null == recordNature ? _self.recordNature : recordNature // ignore: cast_nullable_to_non_nullable
as FinancialRecordNature,recordId: freezed == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethods?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FinancialRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get paymentBy {
  
  return $PersonCopyWith<$Res>(_self.paymentBy, (value) {
    return _then(_self.copyWith(paymentBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialRecord].
extension FinancialRecordPatterns on FinancialRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialRecord value)  $default,){
final _that = this;
switch (_that) {
case _FinancialRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialRecord value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime datePaid,  double amountPaid,  FinancialRecordTypes recordType,  Person paymentBy,  DateTime? lastUpdatedDate,  FinancialRecordNature recordNature,  String? recordId,  PaymentMethods? paymentMethod,  String? userId,  String? propertyId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialRecord() when $default != null:
return $default(_that.datePaid,_that.amountPaid,_that.recordType,_that.paymentBy,_that.lastUpdatedDate,_that.recordNature,_that.recordId,_that.paymentMethod,_that.userId,_that.propertyId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime datePaid,  double amountPaid,  FinancialRecordTypes recordType,  Person paymentBy,  DateTime? lastUpdatedDate,  FinancialRecordNature recordNature,  String? recordId,  PaymentMethods? paymentMethod,  String? userId,  String? propertyId)  $default,) {final _that = this;
switch (_that) {
case _FinancialRecord():
return $default(_that.datePaid,_that.amountPaid,_that.recordType,_that.paymentBy,_that.lastUpdatedDate,_that.recordNature,_that.recordId,_that.paymentMethod,_that.userId,_that.propertyId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime datePaid,  double amountPaid,  FinancialRecordTypes recordType,  Person paymentBy,  DateTime? lastUpdatedDate,  FinancialRecordNature recordNature,  String? recordId,  PaymentMethods? paymentMethod,  String? userId,  String? propertyId)?  $default,) {final _that = this;
switch (_that) {
case _FinancialRecord() when $default != null:
return $default(_that.datePaid,_that.amountPaid,_that.recordType,_that.paymentBy,_that.lastUpdatedDate,_that.recordNature,_that.recordId,_that.paymentMethod,_that.userId,_that.propertyId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancialRecord implements FinancialRecord {
  const _FinancialRecord({required this.datePaid, required this.amountPaid, required this.recordType, required this.paymentBy, this.lastUpdatedDate, required this.recordNature, this.recordId, this.paymentMethod, this.userId, this.propertyId});
  factory _FinancialRecord.fromJson(Map<String, dynamic> json) => _$FinancialRecordFromJson(json);

@override final  DateTime datePaid;
@override final  double amountPaid;
@override final  FinancialRecordTypes recordType;
@override final  Person paymentBy;
@override final  DateTime? lastUpdatedDate;
@override final  FinancialRecordNature recordNature;
@override final  String? recordId;
@override final  PaymentMethods? paymentMethod;
@override final  String? userId;
@override final  String? propertyId;

/// Create a copy of FinancialRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialRecordCopyWith<_FinancialRecord> get copyWith => __$FinancialRecordCopyWithImpl<_FinancialRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialRecord&&(identical(other.datePaid, datePaid) || other.datePaid == datePaid)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.paymentBy, paymentBy) || other.paymentBy == paymentBy)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate)&&(identical(other.recordNature, recordNature) || other.recordNature == recordNature)&&(identical(other.recordId, recordId) || other.recordId == recordId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datePaid,amountPaid,recordType,paymentBy,lastUpdatedDate,recordNature,recordId,paymentMethod,userId,propertyId);

@override
String toString() {
  return 'FinancialRecord(datePaid: $datePaid, amountPaid: $amountPaid, recordType: $recordType, paymentBy: $paymentBy, lastUpdatedDate: $lastUpdatedDate, recordNature: $recordNature, recordId: $recordId, paymentMethod: $paymentMethod, userId: $userId, propertyId: $propertyId)';
}


}

/// @nodoc
abstract mixin class _$FinancialRecordCopyWith<$Res> implements $FinancialRecordCopyWith<$Res> {
  factory _$FinancialRecordCopyWith(_FinancialRecord value, $Res Function(_FinancialRecord) _then) = __$FinancialRecordCopyWithImpl;
@override @useResult
$Res call({
 DateTime datePaid, double amountPaid, FinancialRecordTypes recordType, Person paymentBy, DateTime? lastUpdatedDate, FinancialRecordNature recordNature, String? recordId, PaymentMethods? paymentMethod, String? userId, String? propertyId
});


@override $PersonCopyWith<$Res> get paymentBy;

}
/// @nodoc
class __$FinancialRecordCopyWithImpl<$Res>
    implements _$FinancialRecordCopyWith<$Res> {
  __$FinancialRecordCopyWithImpl(this._self, this._then);

  final _FinancialRecord _self;
  final $Res Function(_FinancialRecord) _then;

/// Create a copy of FinancialRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? datePaid = null,Object? amountPaid = null,Object? recordType = null,Object? paymentBy = null,Object? lastUpdatedDate = freezed,Object? recordNature = null,Object? recordId = freezed,Object? paymentMethod = freezed,Object? userId = freezed,Object? propertyId = freezed,}) {
  return _then(_FinancialRecord(
datePaid: null == datePaid ? _self.datePaid : datePaid // ignore: cast_nullable_to_non_nullable
as DateTime,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as FinancialRecordTypes,paymentBy: null == paymentBy ? _self.paymentBy : paymentBy // ignore: cast_nullable_to_non_nullable
as Person,lastUpdatedDate: freezed == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,recordNature: null == recordNature ? _self.recordNature : recordNature // ignore: cast_nullable_to_non_nullable
as FinancialRecordNature,recordId: freezed == recordId ? _self.recordId : recordId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethods?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FinancialRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get paymentBy {
  
  return $PersonCopyWith<$Res>(_self.paymentBy, (value) {
    return _then(_self.copyWith(paymentBy: value));
  });
}
}

// dart format on
