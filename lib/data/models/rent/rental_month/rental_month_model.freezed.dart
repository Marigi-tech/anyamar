// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_month_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RentalMonth {

 String get rentalMonth; Rent? get unitRent; List<SingleRentEntry> get rentEntries; bool? get paymentIsCompleted;
/// Create a copy of RentalMonth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalMonthCopyWith<RentalMonth> get copyWith => _$RentalMonthCopyWithImpl<RentalMonth>(this as RentalMonth, _$identity);

  /// Serializes this RentalMonth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalMonth&&(identical(other.rentalMonth, rentalMonth) || other.rentalMonth == rentalMonth)&&(identical(other.unitRent, unitRent) || other.unitRent == unitRent)&&const DeepCollectionEquality().equals(other.rentEntries, rentEntries)&&(identical(other.paymentIsCompleted, paymentIsCompleted) || other.paymentIsCompleted == paymentIsCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rentalMonth,unitRent,const DeepCollectionEquality().hash(rentEntries),paymentIsCompleted);

@override
String toString() {
  return 'RentalMonth(rentalMonth: $rentalMonth, unitRent: $unitRent, rentEntries: $rentEntries, paymentIsCompleted: $paymentIsCompleted)';
}


}

/// @nodoc
abstract mixin class $RentalMonthCopyWith<$Res>  {
  factory $RentalMonthCopyWith(RentalMonth value, $Res Function(RentalMonth) _then) = _$RentalMonthCopyWithImpl;
@useResult
$Res call({
 String rentalMonth, Rent? unitRent, List<SingleRentEntry> rentEntries, bool? paymentIsCompleted
});


$RentCopyWith<$Res>? get unitRent;

}
/// @nodoc
class _$RentalMonthCopyWithImpl<$Res>
    implements $RentalMonthCopyWith<$Res> {
  _$RentalMonthCopyWithImpl(this._self, this._then);

  final RentalMonth _self;
  final $Res Function(RentalMonth) _then;

/// Create a copy of RentalMonth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rentalMonth = null,Object? unitRent = freezed,Object? rentEntries = null,Object? paymentIsCompleted = freezed,}) {
  return _then(_self.copyWith(
rentalMonth: null == rentalMonth ? _self.rentalMonth : rentalMonth // ignore: cast_nullable_to_non_nullable
as String,unitRent: freezed == unitRent ? _self.unitRent : unitRent // ignore: cast_nullable_to_non_nullable
as Rent?,rentEntries: null == rentEntries ? _self.rentEntries : rentEntries // ignore: cast_nullable_to_non_nullable
as List<SingleRentEntry>,paymentIsCompleted: freezed == paymentIsCompleted ? _self.paymentIsCompleted : paymentIsCompleted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of RentalMonth
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


/// Adds pattern-matching-related methods to [RentalMonth].
extension RentalMonthPatterns on RentalMonth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalMonth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalMonth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalMonth value)  $default,){
final _that = this;
switch (_that) {
case _RentalMonth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalMonth value)?  $default,){
final _that = this;
switch (_that) {
case _RentalMonth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rentalMonth,  Rent? unitRent,  List<SingleRentEntry> rentEntries,  bool? paymentIsCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalMonth() when $default != null:
return $default(_that.rentalMonth,_that.unitRent,_that.rentEntries,_that.paymentIsCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rentalMonth,  Rent? unitRent,  List<SingleRentEntry> rentEntries,  bool? paymentIsCompleted)  $default,) {final _that = this;
switch (_that) {
case _RentalMonth():
return $default(_that.rentalMonth,_that.unitRent,_that.rentEntries,_that.paymentIsCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rentalMonth,  Rent? unitRent,  List<SingleRentEntry> rentEntries,  bool? paymentIsCompleted)?  $default,) {final _that = this;
switch (_that) {
case _RentalMonth() when $default != null:
return $default(_that.rentalMonth,_that.unitRent,_that.rentEntries,_that.paymentIsCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalMonth implements RentalMonth {
  const _RentalMonth({required this.rentalMonth, this.unitRent, final  List<SingleRentEntry> rentEntries = const [], this.paymentIsCompleted}): _rentEntries = rentEntries;
  factory _RentalMonth.fromJson(Map<String, dynamic> json) => _$RentalMonthFromJson(json);

@override final  String rentalMonth;
@override final  Rent? unitRent;
 final  List<SingleRentEntry> _rentEntries;
@override@JsonKey() List<SingleRentEntry> get rentEntries {
  if (_rentEntries is EqualUnmodifiableListView) return _rentEntries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rentEntries);
}

@override final  bool? paymentIsCompleted;

/// Create a copy of RentalMonth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalMonthCopyWith<_RentalMonth> get copyWith => __$RentalMonthCopyWithImpl<_RentalMonth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalMonthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalMonth&&(identical(other.rentalMonth, rentalMonth) || other.rentalMonth == rentalMonth)&&(identical(other.unitRent, unitRent) || other.unitRent == unitRent)&&const DeepCollectionEquality().equals(other._rentEntries, _rentEntries)&&(identical(other.paymentIsCompleted, paymentIsCompleted) || other.paymentIsCompleted == paymentIsCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rentalMonth,unitRent,const DeepCollectionEquality().hash(_rentEntries),paymentIsCompleted);

@override
String toString() {
  return 'RentalMonth(rentalMonth: $rentalMonth, unitRent: $unitRent, rentEntries: $rentEntries, paymentIsCompleted: $paymentIsCompleted)';
}


}

/// @nodoc
abstract mixin class _$RentalMonthCopyWith<$Res> implements $RentalMonthCopyWith<$Res> {
  factory _$RentalMonthCopyWith(_RentalMonth value, $Res Function(_RentalMonth) _then) = __$RentalMonthCopyWithImpl;
@override @useResult
$Res call({
 String rentalMonth, Rent? unitRent, List<SingleRentEntry> rentEntries, bool? paymentIsCompleted
});


@override $RentCopyWith<$Res>? get unitRent;

}
/// @nodoc
class __$RentalMonthCopyWithImpl<$Res>
    implements _$RentalMonthCopyWith<$Res> {
  __$RentalMonthCopyWithImpl(this._self, this._then);

  final _RentalMonth _self;
  final $Res Function(_RentalMonth) _then;

/// Create a copy of RentalMonth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rentalMonth = null,Object? unitRent = freezed,Object? rentEntries = null,Object? paymentIsCompleted = freezed,}) {
  return _then(_RentalMonth(
rentalMonth: null == rentalMonth ? _self.rentalMonth : rentalMonth // ignore: cast_nullable_to_non_nullable
as String,unitRent: freezed == unitRent ? _self.unitRent : unitRent // ignore: cast_nullable_to_non_nullable
as Rent?,rentEntries: null == rentEntries ? _self._rentEntries : rentEntries // ignore: cast_nullable_to_non_nullable
as List<SingleRentEntry>,paymentIsCompleted: freezed == paymentIsCompleted ? _self.paymentIsCompleted : paymentIsCompleted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of RentalMonth
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
