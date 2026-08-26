// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Person {

 String? get personId; String get personName; String? get personEmail; UserType? get personUserType; String? get personPhone; String? get personNationalId; String? get agencyName; String? get relationship; dynamic get isAgency;
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCopyWith<Person> get copyWith => _$PersonCopyWithImpl<Person>(this as Person, _$identity);

  /// Serializes this Person to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Person&&(identical(other.personId, personId) || other.personId == personId)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.personEmail, personEmail) || other.personEmail == personEmail)&&(identical(other.personUserType, personUserType) || other.personUserType == personUserType)&&(identical(other.personPhone, personPhone) || other.personPhone == personPhone)&&(identical(other.personNationalId, personNationalId) || other.personNationalId == personNationalId)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&const DeepCollectionEquality().equals(other.isAgency, isAgency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personId,personName,personEmail,personUserType,personPhone,personNationalId,agencyName,relationship,const DeepCollectionEquality().hash(isAgency));

@override
String toString() {
  return 'Person(personId: $personId, personName: $personName, personEmail: $personEmail, personUserType: $personUserType, personPhone: $personPhone, personNationalId: $personNationalId, agencyName: $agencyName, relationship: $relationship, isAgency: $isAgency)';
}


}

/// @nodoc
abstract mixin class $PersonCopyWith<$Res>  {
  factory $PersonCopyWith(Person value, $Res Function(Person) _then) = _$PersonCopyWithImpl;
@useResult
$Res call({
 String? personId, String personName, String? personEmail, UserType? personUserType, String? personPhone, String? personNationalId, String? agencyName, String? relationship, dynamic isAgency
});




}
/// @nodoc
class _$PersonCopyWithImpl<$Res>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._self, this._then);

  final Person _self;
  final $Res Function(Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personId = freezed,Object? personName = null,Object? personEmail = freezed,Object? personUserType = freezed,Object? personPhone = freezed,Object? personNationalId = freezed,Object? agencyName = freezed,Object? relationship = freezed,Object? isAgency = freezed,}) {
  return _then(_self.copyWith(
personId: freezed == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as String?,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,personEmail: freezed == personEmail ? _self.personEmail : personEmail // ignore: cast_nullable_to_non_nullable
as String?,personUserType: freezed == personUserType ? _self.personUserType : personUserType // ignore: cast_nullable_to_non_nullable
as UserType?,personPhone: freezed == personPhone ? _self.personPhone : personPhone // ignore: cast_nullable_to_non_nullable
as String?,personNationalId: freezed == personNationalId ? _self.personNationalId : personNationalId // ignore: cast_nullable_to_non_nullable
as String?,agencyName: freezed == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String?,relationship: freezed == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String?,isAgency: freezed == isAgency ? _self.isAgency : isAgency // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [Person].
extension PersonPatterns on Person {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Person value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Person value)  $default,){
final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Person value)?  $default,){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? personId,  String personName,  String? personEmail,  UserType? personUserType,  String? personPhone,  String? personNationalId,  String? agencyName,  String? relationship,  dynamic isAgency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.personId,_that.personName,_that.personEmail,_that.personUserType,_that.personPhone,_that.personNationalId,_that.agencyName,_that.relationship,_that.isAgency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? personId,  String personName,  String? personEmail,  UserType? personUserType,  String? personPhone,  String? personNationalId,  String? agencyName,  String? relationship,  dynamic isAgency)  $default,) {final _that = this;
switch (_that) {
case _Person():
return $default(_that.personId,_that.personName,_that.personEmail,_that.personUserType,_that.personPhone,_that.personNationalId,_that.agencyName,_that.relationship,_that.isAgency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? personId,  String personName,  String? personEmail,  UserType? personUserType,  String? personPhone,  String? personNationalId,  String? agencyName,  String? relationship,  dynamic isAgency)?  $default,) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.personId,_that.personName,_that.personEmail,_that.personUserType,_that.personPhone,_that.personNationalId,_that.agencyName,_that.relationship,_that.isAgency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Person implements Person {
  const _Person({this.personId, required this.personName, this.personEmail, this.personUserType, this.personPhone, this.personNationalId, this.agencyName, this.relationship, this.isAgency = false});
  factory _Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

@override final  String? personId;
@override final  String personName;
@override final  String? personEmail;
@override final  UserType? personUserType;
@override final  String? personPhone;
@override final  String? personNationalId;
@override final  String? agencyName;
@override final  String? relationship;
@override@JsonKey() final  dynamic isAgency;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonCopyWith<_Person> get copyWith => __$PersonCopyWithImpl<_Person>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Person&&(identical(other.personId, personId) || other.personId == personId)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.personEmail, personEmail) || other.personEmail == personEmail)&&(identical(other.personUserType, personUserType) || other.personUserType == personUserType)&&(identical(other.personPhone, personPhone) || other.personPhone == personPhone)&&(identical(other.personNationalId, personNationalId) || other.personNationalId == personNationalId)&&(identical(other.agencyName, agencyName) || other.agencyName == agencyName)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&const DeepCollectionEquality().equals(other.isAgency, isAgency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personId,personName,personEmail,personUserType,personPhone,personNationalId,agencyName,relationship,const DeepCollectionEquality().hash(isAgency));

@override
String toString() {
  return 'Person(personId: $personId, personName: $personName, personEmail: $personEmail, personUserType: $personUserType, personPhone: $personPhone, personNationalId: $personNationalId, agencyName: $agencyName, relationship: $relationship, isAgency: $isAgency)';
}


}

/// @nodoc
abstract mixin class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) _then) = __$PersonCopyWithImpl;
@override @useResult
$Res call({
 String? personId, String personName, String? personEmail, UserType? personUserType, String? personPhone, String? personNationalId, String? agencyName, String? relationship, dynamic isAgency
});




}
/// @nodoc
class __$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(this._self, this._then);

  final _Person _self;
  final $Res Function(_Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personId = freezed,Object? personName = null,Object? personEmail = freezed,Object? personUserType = freezed,Object? personPhone = freezed,Object? personNationalId = freezed,Object? agencyName = freezed,Object? relationship = freezed,Object? isAgency = freezed,}) {
  return _then(_Person(
personId: freezed == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as String?,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,personEmail: freezed == personEmail ? _self.personEmail : personEmail // ignore: cast_nullable_to_non_nullable
as String?,personUserType: freezed == personUserType ? _self.personUserType : personUserType // ignore: cast_nullable_to_non_nullable
as UserType?,personPhone: freezed == personPhone ? _self.personPhone : personPhone // ignore: cast_nullable_to_non_nullable
as String?,personNationalId: freezed == personNationalId ? _self.personNationalId : personNationalId // ignore: cast_nullable_to_non_nullable
as String?,agencyName: freezed == agencyName ? _self.agencyName : agencyName // ignore: cast_nullable_to_non_nullable
as String?,relationship: freezed == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String?,isAgency: freezed == isAgency ? _self.isAgency : isAgency // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
