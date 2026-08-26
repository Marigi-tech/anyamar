// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Property _$PropertyFromJson(Map<String, dynamic> json) => _Property(
  propertyId: json['propertyId'] as String?,
  propertyName: json['propertyName'] as String,
  propertyLocation: json['propertyLocation'] as String,
  propertyManager: json['propertyManager'] as Map<String, dynamic>?,
  propertyImage: json['propertyImage'] as String?,
  userId: json['userId'] as String,
  propertyUnits:
      (json['propertyUnits'] as List<dynamic>?)
          ?.map((e) => Unit.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  propertyFloors: (json['propertyFloors'] as num?)?.toInt() ?? 0,
  lastUpdatedDate: json['lastUpdatedDate'] == null
      ? null
      : DateTime.parse(json['lastUpdatedDate'] as String),
);

Map<String, dynamic> _$PropertyToJson(_Property instance) => <String, dynamic>{
  'propertyId': instance.propertyId,
  'propertyName': instance.propertyName,
  'propertyLocation': instance.propertyLocation,
  'propertyManager': instance.propertyManager,
  'propertyImage': instance.propertyImage,
  'userId': instance.userId,
  'propertyUnits': instance.propertyUnits.map((e) => e.toJson()).toList(),
  'propertyFloors': instance.propertyFloors,
  'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
};
