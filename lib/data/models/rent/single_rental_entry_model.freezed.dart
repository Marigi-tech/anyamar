// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_rental_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SingleRentEntry _$SingleRentEntryFromJson(
  Map<String, dynamic> json
) {
    return _SingleRentalEntry.fromJson(
      json
    );
}

/// @nodoc
mixin _$SingleRentEntry {

 DateTime get paymentDate; double get amountPayable; double get amountPaid; double? get balance; PaymentMethods get paymentMethod; String get rentalMonth; DateTime? get lastUpdatedDate; String? get rentEntryId;
/// Create a copy of SingleRentEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SingleRentEntryCopyWith<SingleRentEntry> get copyWith => _$SingleRentEntryCopyWithImpl<SingleRentEntry>(this as SingleRentEntry, _$identity);

  /// Serializes this SingleRentEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SingleRentEntry&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.amountPayable, amountPayable) || other.amountPayable == amountPayable)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.rentalMonth, rentalMonth) || other.rentalMonth == rentalMonth)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate)&&(identical(other.rentEntryId, rentEntryId) || other.rentEntryId == rentEntryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentDate,amountPayable,amountPaid,balance,paymentMethod,rentalMonth,lastUpdatedDate,rentEntryId);

@override
String toString() {
  return 'SingleRentEntry(paymentDate: $paymentDate, amountPayable: $amountPayable, amountPaid: $amountPaid, balance: $balance, paymentMethod: $paymentMethod, rentalMonth: $rentalMonth, lastUpdatedDate: $lastUpdatedDate, rentEntryId: $rentEntryId)';
}


}

/// @nodoc
abstract mixin class $SingleRentEntryCopyWith<$Res>  {
  factory $SingleRentEntryCopyWith(SingleRentEntry value, $Res Function(SingleRentEntry) _then) = _$SingleRentEntryCopyWithImpl;
@useResult
$Res call({
 DateTime paymentDate, double amountPayable, double amountPaid, double? balance, PaymentMethods paymentMethod, String rentalMonth, DateTime? lastUpdatedDate, String? rentEntryId
});




}
/// @nodoc
class _$SingleRentEntryCopyWithImpl<$Res>
    implements $SingleRentEntryCopyWith<$Res> {
  _$SingleRentEntryCopyWithImpl(this._self, this._then);

  final SingleRentEntry _self;
  final $Res Function(SingleRentEntry) _then;

/// Create a copy of SingleRentEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentDate = null,Object? amountPayable = null,Object? amountPaid = null,Object? balance = freezed,Object? paymentMethod = null,Object? rentalMonth = null,Object? lastUpdatedDate = freezed,Object? rentEntryId = freezed,}) {
  return _then(_self.copyWith(
paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,amountPayable: null == amountPayable ? _self.amountPayable : amountPayable // ignore: cast_nullable_to_non_nullable
as double,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethods,rentalMonth: null == rentalMonth ? _self.rentalMonth : rentalMonth // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedDate: freezed == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,rentEntryId: freezed == rentEntryId ? _self.rentEntryId : rentEntryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SingleRentEntry].
extension SingleRentEntryPatterns on SingleRentEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SingleRentalEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SingleRentalEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SingleRentalEntry value)  $default,){
final _that = this;
switch (_that) {
case _SingleRentalEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SingleRentalEntry value)?  $default,){
final _that = this;
switch (_that) {
case _SingleRentalEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime paymentDate,  double amountPayable,  double amountPaid,  double? balance,  PaymentMethods paymentMethod,  String rentalMonth,  DateTime? lastUpdatedDate,  String? rentEntryId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SingleRentalEntry() when $default != null:
return $default(_that.paymentDate,_that.amountPayable,_that.amountPaid,_that.balance,_that.paymentMethod,_that.rentalMonth,_that.lastUpdatedDate,_that.rentEntryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime paymentDate,  double amountPayable,  double amountPaid,  double? balance,  PaymentMethods paymentMethod,  String rentalMonth,  DateTime? lastUpdatedDate,  String? rentEntryId)  $default,) {final _that = this;
switch (_that) {
case _SingleRentalEntry():
return $default(_that.paymentDate,_that.amountPayable,_that.amountPaid,_that.balance,_that.paymentMethod,_that.rentalMonth,_that.lastUpdatedDate,_that.rentEntryId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime paymentDate,  double amountPayable,  double amountPaid,  double? balance,  PaymentMethods paymentMethod,  String rentalMonth,  DateTime? lastUpdatedDate,  String? rentEntryId)?  $default,) {final _that = this;
switch (_that) {
case _SingleRentalEntry() when $default != null:
return $default(_that.paymentDate,_that.amountPayable,_that.amountPaid,_that.balance,_that.paymentMethod,_that.rentalMonth,_that.lastUpdatedDate,_that.rentEntryId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SingleRentalEntry implements SingleRentEntry {
  const _SingleRentalEntry({required this.paymentDate, required this.amountPayable, required this.amountPaid, this.balance, required this.paymentMethod, required this.rentalMonth, this.lastUpdatedDate, this.rentEntryId});
  factory _SingleRentalEntry.fromJson(Map<String, dynamic> json) => _$SingleRentalEntryFromJson(json);

@override final  DateTime paymentDate;
@override final  double amountPayable;
@override final  double amountPaid;
@override final  double? balance;
@override final  PaymentMethods paymentMethod;
@override final  String rentalMonth;
@override final  DateTime? lastUpdatedDate;
@override final  String? rentEntryId;

/// Create a copy of SingleRentEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SingleRentalEntryCopyWith<_SingleRentalEntry> get copyWith => __$SingleRentalEntryCopyWithImpl<_SingleRentalEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SingleRentalEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SingleRentalEntry&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.amountPayable, amountPayable) || other.amountPayable == amountPayable)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.rentalMonth, rentalMonth) || other.rentalMonth == rentalMonth)&&(identical(other.lastUpdatedDate, lastUpdatedDate) || other.lastUpdatedDate == lastUpdatedDate)&&(identical(other.rentEntryId, rentEntryId) || other.rentEntryId == rentEntryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentDate,amountPayable,amountPaid,balance,paymentMethod,rentalMonth,lastUpdatedDate,rentEntryId);

@override
String toString() {
  return 'SingleRentEntry(paymentDate: $paymentDate, amountPayable: $amountPayable, amountPaid: $amountPaid, balance: $balance, paymentMethod: $paymentMethod, rentalMonth: $rentalMonth, lastUpdatedDate: $lastUpdatedDate, rentEntryId: $rentEntryId)';
}


}

/// @nodoc
abstract mixin class _$SingleRentalEntryCopyWith<$Res> implements $SingleRentEntryCopyWith<$Res> {
  factory _$SingleRentalEntryCopyWith(_SingleRentalEntry value, $Res Function(_SingleRentalEntry) _then) = __$SingleRentalEntryCopyWithImpl;
@override @useResult
$Res call({
 DateTime paymentDate, double amountPayable, double amountPaid, double? balance, PaymentMethods paymentMethod, String rentalMonth, DateTime? lastUpdatedDate, String? rentEntryId
});




}
/// @nodoc
class __$SingleRentalEntryCopyWithImpl<$Res>
    implements _$SingleRentalEntryCopyWith<$Res> {
  __$SingleRentalEntryCopyWithImpl(this._self, this._then);

  final _SingleRentalEntry _self;
  final $Res Function(_SingleRentalEntry) _then;

/// Create a copy of SingleRentEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentDate = null,Object? amountPayable = null,Object? amountPaid = null,Object? balance = freezed,Object? paymentMethod = null,Object? rentalMonth = null,Object? lastUpdatedDate = freezed,Object? rentEntryId = freezed,}) {
  return _then(_SingleRentalEntry(
paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,amountPayable: null == amountPayable ? _self.amountPayable : amountPayable // ignore: cast_nullable_to_non_nullable
as double,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethods,rentalMonth: null == rentalMonth ? _self.rentalMonth : rentalMonth // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedDate: freezed == lastUpdatedDate ? _self.lastUpdatedDate : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,rentEntryId: freezed == rentEntryId ? _self.rentEntryId : rentEntryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
