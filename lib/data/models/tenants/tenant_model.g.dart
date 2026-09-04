// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tenant _$TenantFromJson(Map<String, dynamic> json) => _Tenant(
  userId: json['userId'] as String,
  tenantName: json['tenantName'] as String,
  unitId: json['unitId'] as String,
  unitRent: json['unitRent'] == null
      ? null
      : Rent.fromJson(json['unitRent'] as Map<String, dynamic>),
  tenantId: json['tenantId'] as String?,
  tenantPhoneNumber: json['tenantPhoneNumber'] as String?,
  propertyId: json['propertyId'] as String,
  unitName: json['unitName'] as String?,
  tenantEmail: json['tenantEmail'] as String?,
  tenantOccupation: json['tenantOccupation'] as String?,
  tenantNationalId: json['tenantNationalId'] as String?,
  startOfLease: DateTime.parse(json['startOfLease'] as String),
  endOfLease: json['endOfLease'] == null
      ? null
      : DateTime.parse(json['endOfLease'] as String),
  nextOfKin: json['nextOfKin'] == null
      ? null
      : Person.fromJson(json['nextOfKin'] as Map<String, dynamic>),
  nationalId: json['nationalId'] as String?,
  lastUpdateDate: json['lastUpdateDate'] == null
      ? null
      : DateTime.parse(json['lastUpdateDate'] as String),
);

Map<String, dynamic> _$TenantToJson(_Tenant instance) => <String, dynamic>{
  'userId': instance.userId,
  'tenantName': instance.tenantName,
  'unitId': instance.unitId,
  'unitRent': instance.unitRent?.toJson(),
  'tenantId': instance.tenantId,
  'tenantPhoneNumber': instance.tenantPhoneNumber,
  'propertyId': instance.propertyId,
  'unitName': instance.unitName,
  'tenantEmail': instance.tenantEmail,
  'tenantOccupation': instance.tenantOccupation,
  'tenantNationalId': instance.tenantNationalId,
  'startOfLease': instance.startOfLease.toIso8601String(),
  'endOfLease': instance.endOfLease?.toIso8601String(),
  'nextOfKin': instance.nextOfKin?.toJson(),
  'nationalId': instance.nationalId,
  'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
};
