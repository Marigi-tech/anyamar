// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Unit _$UnitFromJson(Map<String, dynamic> json) => _Unit(
  unitId: json['unitId'] as String?,
  unitName: json['unitName'] as String,
  propertyId: json['propertyId'] as String,
  propertyName: json['propertyName'] as String,
  userId: json['userId'] as String,
  tenantId: json['tenantId'] as String?,
  currentTenant: json['currentTenant'] == null
      ? null
      : Tenant.fromJson(json['currentTenant'] as Map<String, dynamic>),
  unitType: $enumDecodeNullable(_$UnitTypeEnumMap, json['unitType']),
  rentPerMonth: (json['rentPerMonth'] as num).toDouble(),
  unitRent: json['unitRent'] == null
      ? null
      : Rent.fromJson(json['unitRent'] as Map<String, dynamic>),
  previousTenantsLog:
      (json['previousTenantsLog'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isOccupied: json['isOccupied'] as bool? ?? false,
  lastUpdateDate: json['lastUpdateDate'] == null
      ? null
      : DateTime.parse(json['lastUpdateDate'] as String),
  numberFloors: (json['numberFloors'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UnitToJson(_Unit instance) => <String, dynamic>{
  'unitId': instance.unitId,
  'unitName': instance.unitName,
  'propertyId': instance.propertyId,
  'propertyName': instance.propertyName,
  'userId': instance.userId,
  'tenantId': instance.tenantId,
  'currentTenant': instance.currentTenant?.toJson(),
  'unitType': _$UnitTypeEnumMap[instance.unitType],
  'rentPerMonth': instance.rentPerMonth,
  'unitRent': instance.unitRent?.toJson(),
  'previousTenantsLog': instance.previousTenantsLog,
  'isOccupied': instance.isOccupied,
  'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
  'numberFloors': instance.numberFloors,
};

const _$UnitTypeEnumMap = {
  UnitType.bedsitter: 'bedsitter',
  UnitType.singleRoom: 'singleRoom',
  UnitType.double: 'double',
  UnitType.airBnB: 'airBnB',
  UnitType.oneBedroom: 'oneBedroom',
  UnitType.twoBedroom: 'twoBedroom',
  UnitType.threeBedroom: 'threeBedroom',
  UnitType.fourBedroom: 'fourBedroom',
  UnitType.mansionette: 'mansionette',
  UnitType.mansion: 'mansion',
  UnitType.townHouse: 'townHouse',
  UnitType.agent: 'agent',
  UnitType.caretaker: 'caretaker',
  UnitType.otherEmployee: 'otherEmployee',
};
