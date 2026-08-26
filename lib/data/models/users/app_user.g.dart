// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  userId: json['userId'] as String?,
  userName: json['userName'] as String,
  userEmail: json['userEmail'] as String,
  userPassword: json['userPassword'] as String,
  userType: json['userType'] as String,
  userPhoneNumber: json['userPhoneNumber'] as String?,
  userNationalId: json['userNationalId'] as String?,
  registrationDate: DateTime.parse(json['registrationDate'] as String),
  isAuthenticated: json['isAuthenticated'] as bool? ?? false,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'userId': instance.userId,
  'userName': instance.userName,
  'userEmail': instance.userEmail,
  'userPassword': instance.userPassword,
  'userType': instance.userType,
  'userPhoneNumber': instance.userPhoneNumber,
  'userNationalId': instance.userNationalId,
  'registrationDate': instance.registrationDate.toIso8601String(),
  'isAuthenticated': instance.isAuthenticated,
};
