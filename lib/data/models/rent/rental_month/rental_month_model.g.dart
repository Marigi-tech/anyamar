// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_month_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RentalMonth _$RentalMonthFromJson(Map<String, dynamic> json) => _RentalMonth(
  rentalMonth: json['rentalMonth'] as String,
  unitRent: json['unitRent'] == null
      ? null
      : Rent.fromJson(json['unitRent'] as Map<String, dynamic>),
  rentEntries:
      (json['rentEntries'] as List<dynamic>?)
          ?.map((e) => SingleRentEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  paymentIsCompleted: json['paymentIsCompleted'] as bool?,
);

Map<String, dynamic> _$RentalMonthToJson(_RentalMonth instance) =>
    <String, dynamic>{
      'rentalMonth': instance.rentalMonth,
      'unitRent': instance.unitRent?.toJson(),
      'rentEntries': instance.rentEntries.map((e) => e.toJson()).toList(),
      'paymentIsCompleted': instance.paymentIsCompleted,
    };
