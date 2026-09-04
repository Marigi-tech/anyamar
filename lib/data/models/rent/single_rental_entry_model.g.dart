// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_rental_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SingleRentalEntry _$SingleRentalEntryFromJson(Map<String, dynamic> json) =>
    _SingleRentalEntry(
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      amountPayable: (json['amountPayable'] as num).toDouble(),
      amountPaid: (json['amountPaid'] as num).toDouble(),
      balance: (json['balance'] as num?)?.toDouble(),
      paymentMethod: $enumDecode(
        _$PaymentMethodsEnumMap,
        json['paymentMethod'],
      ),
      rentalMonth: json['rentalMonth'] as String,
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
      rentEntryId: json['rentEntryId'] as String?,
      transactionCode: json['transactionCode'] as String?,
    );

Map<String, dynamic> _$SingleRentalEntryToJson(_SingleRentalEntry instance) =>
    <String, dynamic>{
      'paymentDate': instance.paymentDate.toIso8601String(),
      'amountPayable': instance.amountPayable,
      'amountPaid': instance.amountPaid,
      'balance': instance.balance,
      'paymentMethod': _$PaymentMethodsEnumMap[instance.paymentMethod]!,
      'rentalMonth': instance.rentalMonth,
      'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
      'rentEntryId': instance.rentEntryId,
      'transactionCode': instance.transactionCode,
    };

const _$PaymentMethodsEnumMap = {
  PaymentMethods.cash: 'cash',
  PaymentMethods.mpesa: 'mpesa',
  PaymentMethods.bank: 'bank',
  PaymentMethods.paypal: 'paypal',
};
