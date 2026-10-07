// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RentalRecord _$RentalRecordFromJson(Map<String, dynamic> json) =>
    _RentalRecord(
      tenantId: json['tenantId'] as String,
      unitId: json['unitId'] as String,
      rentEntry: SingleRentEntry.fromJson(
        json['rentEntry'] as Map<String, dynamic>,
      ),
      rentalMonth: RentalMonth.fromJson(
        json['rentalMonth'] as Map<String, dynamic>,
      ),
      rentHistory: RentHistory.fromJson(
        json['rentHistory'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$RentalRecordToJson(_RentalRecord instance) =>
    <String, dynamic>{
      'tenantId': instance.tenantId,
      'unitId': instance.unitId,
      'rentEntry': instance.rentEntry.toJson(),
      'rentalMonth': instance.rentalMonth.toJson(),
      'rentHistory': instance.rentHistory.toJson(),
    };
