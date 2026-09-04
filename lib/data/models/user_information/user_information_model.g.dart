// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInformation _$UserInformationFromJson(Map<String, dynamic> json) =>
    _UserInformation(
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
      units:
          (json['units'] as List<dynamic>?)
              ?.map((e) => Unit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      finances:
          (json['finances'] as List<dynamic>?)
              ?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      appUser: json['appUser'] == null
          ? null
          : AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInformationToJson(_UserInformation instance) =>
    <String, dynamic>{
      'properties': instance.properties.map((e) => e.toJson()).toList(),
      'tenants': instance.tenants.map((e) => e.toJson()).toList(),
      'units': instance.units.map((e) => e.toJson()).toList(),
      'finances': instance.finances.map((e) => e.toJson()).toList(),
      'appUser': instance.appUser?.toJson(),
      'isLoading': instance.isLoading,
    };
