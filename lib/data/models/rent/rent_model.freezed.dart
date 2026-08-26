// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Rent {

 double get rentAmount; double? get rentDeposit; String? get rentCurrency; List<UnitUtility>? get utilities; String? get paymentFrequency;
/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentCopyWith<Rent> get copyWith => _$RentCopyWithImpl<Rent>(this as Rent, _$identity);

  /// Serializes this Rent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rent&&(identical(other.rentAmount, rentAmount) || other.rentAmount == rentAmount)&&(identical(other.rentDeposit, rentDeposit) || other.rentDeposit == rentDeposit)&&(identical(other.rentCurrency, rentCurrency) || other.rentCurrency == rentCurrency)&&const DeepCollectionEquality().equals(other.utilities, utilities)&&(identical(other.paymentFrequency, paymentFrequency) || other.paymentFrequency == paymentFrequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rentAmount,rentDeposit,rentCurrency,const DeepCollectionEquality().hash(utilities),paymentFrequency);

@override
String toString() {
  return 'Rent(rentAmount: $rentAmount, rentDeposit: $rentDeposit, rentCurrency: $rentCurrency, utilities: $utilities, paymentFrequency: $paymentFrequency)';
}


}

/// @nodoc
abstract mixin class $RentCopyWith<$Res>  {
  factory $RentCopyWith(Rent value, $Res Function(Rent) _then) = _$RentCopyWithImpl;
@useResult
$Res call({
 double rentAmount, double? rentDeposit, String? rentCurrency, List<UnitUtility>? utilities, String? paymentFrequency
});




}
/// @nodoc
class _$RentCopyWithImpl<$Res>
    implements $RentCopyWith<$Res> {
  _$RentCopyWithImpl(this._self, this._then);

  final Rent _self;
  final $Res Function(Rent) _then;

/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rentAmount = null,Object? rentDeposit = freezed,Object? rentCurrency = freezed,Object? utilities = freezed,Object? paymentFrequency = freezed,}) {
  return _then(_self.copyWith(
rentAmount: null == rentAmount ? _self.rentAmount : rentAmount // ignore: cast_nullable_to_non_nullable
as double,rentDeposit: freezed == rentDeposit ? _self.rentDeposit : rentDeposit // ignore: cast_nullable_to_non_nullable
as double?,rentCurrency: freezed == rentCurrency ? _self.rentCurrency : rentCurrency // ignore: cast_nullable_to_non_nullable
as String?,utilities: freezed == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as List<UnitUtility>?,paymentFrequency: freezed == paymentFrequency ? _self.paymentFrequency : paymentFrequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Rent].
extension RentPatterns on Rent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rent value)  $default,){
final _that = this;
switch (_that) {
case _Rent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rent value)?  $default,){
final _that = this;
switch (_that) {
case _Rent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double rentAmount,  double? rentDeposit,  String? rentCurrency,  List<UnitUtility>? utilities,  String? paymentFrequency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rent() when $default != null:
return $default(_that.rentAmount,_that.rentDeposit,_that.rentCurrency,_that.utilities,_that.paymentFrequency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double rentAmount,  double? rentDeposit,  String? rentCurrency,  List<UnitUtility>? utilities,  String? paymentFrequency)  $default,) {final _that = this;
switch (_that) {
case _Rent():
return $default(_that.rentAmount,_that.rentDeposit,_that.rentCurrency,_that.utilities,_that.paymentFrequency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double rentAmount,  double? rentDeposit,  String? rentCurrency,  List<UnitUtility>? utilities,  String? paymentFrequency)?  $default,) {final _that = this;
switch (_that) {
case _Rent() when $default != null:
return $default(_that.rentAmount,_that.rentDeposit,_that.rentCurrency,_that.utilities,_that.paymentFrequency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Rent implements Rent {
  const _Rent({required this.rentAmount, this.rentDeposit, this.rentCurrency, final  List<UnitUtility>? utilities = const [], this.paymentFrequency}): _utilities = utilities;
  factory _Rent.fromJson(Map<String, dynamic> json) => _$RentFromJson(json);

@override final  double rentAmount;
@override final  double? rentDeposit;
@override final  String? rentCurrency;
 final  List<UnitUtility>? _utilities;
@override@JsonKey() List<UnitUtility>? get utilities {
  final value = _utilities;
  if (value == null) return null;
  if (_utilities is EqualUnmodifiableListView) return _utilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? paymentFrequency;

/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentCopyWith<_Rent> get copyWith => __$RentCopyWithImpl<_Rent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rent&&(identical(other.rentAmount, rentAmount) || other.rentAmount == rentAmount)&&(identical(other.rentDeposit, rentDeposit) || other.rentDeposit == rentDeposit)&&(identical(other.rentCurrency, rentCurrency) || other.rentCurrency == rentCurrency)&&const DeepCollectionEquality().equals(other._utilities, _utilities)&&(identical(other.paymentFrequency, paymentFrequency) || other.paymentFrequency == paymentFrequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rentAmount,rentDeposit,rentCurrency,const DeepCollectionEquality().hash(_utilities),paymentFrequency);

@override
String toString() {
  return 'Rent(rentAmount: $rentAmount, rentDeposit: $rentDeposit, rentCurrency: $rentCurrency, utilities: $utilities, paymentFrequency: $paymentFrequency)';
}


}

/// @nodoc
abstract mixin class _$RentCopyWith<$Res> implements $RentCopyWith<$Res> {
  factory _$RentCopyWith(_Rent value, $Res Function(_Rent) _then) = __$RentCopyWithImpl;
@override @useResult
$Res call({
 double rentAmount, double? rentDeposit, String? rentCurrency, List<UnitUtility>? utilities, String? paymentFrequency
});




}
/// @nodoc
class __$RentCopyWithImpl<$Res>
    implements _$RentCopyWith<$Res> {
  __$RentCopyWithImpl(this._self, this._then);

  final _Rent _self;
  final $Res Function(_Rent) _then;

/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rentAmount = null,Object? rentDeposit = freezed,Object? rentCurrency = freezed,Object? utilities = freezed,Object? paymentFrequency = freezed,}) {
  return _then(_Rent(
rentAmount: null == rentAmount ? _self.rentAmount : rentAmount // ignore: cast_nullable_to_non_nullable
as double,rentDeposit: freezed == rentDeposit ? _self.rentDeposit : rentDeposit // ignore: cast_nullable_to_non_nullable
as double?,rentCurrency: freezed == rentCurrency ? _self.rentCurrency : rentCurrency // ignore: cast_nullable_to_non_nullable
as String?,utilities: freezed == utilities ? _self._utilities : utilities // ignore: cast_nullable_to_non_nullable
as List<UnitUtility>?,paymentFrequency: freezed == paymentFrequency ? _self.paymentFrequency : paymentFrequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
