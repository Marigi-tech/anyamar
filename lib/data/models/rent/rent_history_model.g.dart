// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RentHistory _$RentHistoryFromJson(Map<String, dynamic> json) => _RentHistory(
  historyId: json['historyId'] as String?,
  tenantId: json['tenantId'] as String,
  unitId: json['unitId'] as String,
  propertyId: json['propertyId'] as String?,
  userId: json['userId'] as String,
  rentalMonths:
      (json['rentalMonths'] as List<dynamic>?)
          ?.map((e) => RentalMonth.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tenantName: json['tenantName'] as String?,
);

Map<String, dynamic> _$RentHistoryToJson(_RentHistory instance) =>
    <String, dynamic>{
      'historyId': instance.historyId,
      'tenantId': instance.tenantId,
      'unitId': instance.unitId,
      'propertyId': instance.propertyId,
      'userId': instance.userId,
      'rentalMonths': instance.rentalMonths.map((e) => e.toJson()).toList(),
      'tenantName': instance.tenantName,
    };
