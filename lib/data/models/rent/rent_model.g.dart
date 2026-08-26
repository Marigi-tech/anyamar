// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Rent _$RentFromJson(Map<String, dynamic> json) => _Rent(
  rentAmount: (json['rentAmount'] as num).toDouble(),
  rentDeposit: (json['rentDeposit'] as num?)?.toDouble(),
  rentCurrency: json['rentCurrency'] as String?,
  utilities:
      (json['utilities'] as List<dynamic>?)
          ?.map((e) => UnitUtility.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  paymentFrequency: json['paymentFrequency'] as String?,
);

Map<String, dynamic> _$RentToJson(_Rent instance) => <String, dynamic>{
  'rentAmount': instance.rentAmount,
  'rentDeposit': instance.rentDeposit,
  'rentCurrency': instance.rentCurrency,
  'utilities': instance.utilities?.map((e) => e.toJson()).toList(),
  'paymentFrequency': instance.paymentFrequency,
};
