// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

 String? get userId; String get userName; String get userEmail; String get userPassword; String get userType; String? get userPhoneNumber; String? get userNationalId; DateTime get registrationDate; bool get isAuthenticated;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userPassword, userPassword) || other.userPassword == userPassword)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.userNationalId, userNationalId) || other.userNationalId == userNationalId)&&(identical(other.registrationDate, registrationDate) || other.registrationDate == registrationDate)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,userEmail,userPassword,userType,userPhoneNumber,userNationalId,registrationDate,isAuthenticated);

@override
String toString() {
  return 'AppUser(userId: $userId, userName: $userName, userEmail: $userEmail, userPassword: $userPassword, userType: $userType, userPhoneNumber: $userPhoneNumber, userNationalId: $userNationalId, registrationDate: $registrationDate, isAuthenticated: $isAuthenticated)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String? userId, String userName, String userEmail, String userPassword, String userType, String? userPhoneNumber, String? userNationalId, DateTime registrationDate, bool isAuthenticated
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? userName = null,Object? userEmail = null,Object? userPassword = null,Object? userType = null,Object? userPhoneNumber = freezed,Object? userNationalId = freezed,Object? registrationDate = null,Object? isAuthenticated = null,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userPassword: null == userPassword ? _self.userPassword : userPassword // ignore: cast_nullable_to_non_nullable
as String,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,userNationalId: freezed == userNationalId ? _self.userNationalId : userNationalId // ignore: cast_nullable_to_non_nullable
as String?,registrationDate: null == registrationDate ? _self.registrationDate : registrationDate // ignore: cast_nullable_to_non_nullable
as DateTime,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userId,  String userName,  String userEmail,  String userPassword,  String userType,  String? userPhoneNumber,  String? userNationalId,  DateTime registrationDate,  bool isAuthenticated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.userId,_that.userName,_that.userEmail,_that.userPassword,_that.userType,_that.userPhoneNumber,_that.userNationalId,_that.registrationDate,_that.isAuthenticated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userId,  String userName,  String userEmail,  String userPassword,  String userType,  String? userPhoneNumber,  String? userNationalId,  DateTime registrationDate,  bool isAuthenticated)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.userId,_that.userName,_that.userEmail,_that.userPassword,_that.userType,_that.userPhoneNumber,_that.userNationalId,_that.registrationDate,_that.isAuthenticated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userId,  String userName,  String userEmail,  String userPassword,  String userType,  String? userPhoneNumber,  String? userNationalId,  DateTime registrationDate,  bool isAuthenticated)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.userId,_that.userName,_that.userEmail,_that.userPassword,_that.userType,_that.userPhoneNumber,_that.userNationalId,_that.registrationDate,_that.isAuthenticated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({this.userId, required this.userName, required this.userEmail, required this.userPassword, required this.userType, this.userPhoneNumber, this.userNationalId, required this.registrationDate, this.isAuthenticated = false});
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override final  String? userId;
@override final  String userName;
@override final  String userEmail;
@override final  String userPassword;
@override final  String userType;
@override final  String? userPhoneNumber;
@override final  String? userNationalId;
@override final  DateTime registrationDate;
@override@JsonKey() final  bool isAuthenticated;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.userPassword, userPassword) || other.userPassword == userPassword)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.userPhoneNumber, userPhoneNumber) || other.userPhoneNumber == userPhoneNumber)&&(identical(other.userNationalId, userNationalId) || other.userNationalId == userNationalId)&&(identical(other.registrationDate, registrationDate) || other.registrationDate == registrationDate)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,userEmail,userPassword,userType,userPhoneNumber,userNationalId,registrationDate,isAuthenticated);

@override
String toString() {
  return 'AppUser(userId: $userId, userName: $userName, userEmail: $userEmail, userPassword: $userPassword, userType: $userType, userPhoneNumber: $userPhoneNumber, userNationalId: $userNationalId, registrationDate: $registrationDate, isAuthenticated: $isAuthenticated)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String userName, String userEmail, String userPassword, String userType, String? userPhoneNumber, String? userNationalId, DateTime registrationDate, bool isAuthenticated
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? userName = null,Object? userEmail = null,Object? userPassword = null,Object? userType = null,Object? userPhoneNumber = freezed,Object? userNationalId = freezed,Object? registrationDate = null,Object? isAuthenticated = null,}) {
  return _then(_AppUser(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,userPassword: null == userPassword ? _self.userPassword : userPassword // ignore: cast_nullable_to_non_nullable
as String,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String,userPhoneNumber: freezed == userPhoneNumber ? _self.userPhoneNumber : userPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,userNationalId: freezed == userNationalId ? _self.userNationalId : userNationalId // ignore: cast_nullable_to_non_nullable
as String?,registrationDate: null == registrationDate ? _self.registrationDate : registrationDate // ignore: cast_nullable_to_non_nullable
as DateTime,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
