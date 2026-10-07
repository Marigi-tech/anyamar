// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppData _$AppDataFromJson(Map<String, dynamic> json) => _AppData(
  properties:
      (json['properties'] as List<dynamic>?)
          ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tenants:
      (json['tenants'] as List<dynamic>?)
          ?.map((e) => Tenant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  finances:
      (json['finances'] as List<dynamic>?)
          ?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  units:
      (json['units'] as List<dynamic>?)
          ?.map((e) => Unit.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  appUser: json['appUser'] == null
      ? null
      : AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
  activeTenants:
      (json['activeTenants'] as List<dynamic>?)
          ?.map((e) => Tenant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rentRecords:
      (json['rentRecords'] as List<dynamic>?)
          ?.map((e) => RentalRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppDataToJson(_AppData instance) => <String, dynamic>{
  'properties': instance.properties.map((e) => e.toJson()).toList(),
  'tenants': instance.tenants.map((e) => e.toJson()).toList(),
  'finances': instance.finances.map((e) => e.toJson()).toList(),
  'units': instance.units.map((e) => e.toJson()).toList(),
  'appUser': instance.appUser?.toJson(),
  'activeTenants': instance.activeTenants.map((e) => e.toJson()).toList(),
  'rentRecords': instance.rentRecords.map((e) => e.toJson()).toList(),
};
