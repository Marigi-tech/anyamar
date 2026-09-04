// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinancialRecord _$FinancialRecordFromJson(Map<String, dynamic> json) =>
    _FinancialRecord(
      datePaid: DateTime.parse(json['datePaid'] as String),
      amountPaid: (json['amountPaid'] as num).toDouble(),
      recordType: $enumDecode(
        _$FinancialRecordTypesEnumMap,
        json['recordType'],
      ),
      paymentBy: Person.fromJson(json['paymentBy'] as Map<String, dynamic>),
      lastUpdatedDate: json['lastUpdatedDate'] == null
          ? null
          : DateTime.parse(json['lastUpdatedDate'] as String),
      recordNature: $enumDecode(
        _$FinancialRecordNatureEnumMap,
        json['recordNature'],
      ),
      recordId: json['recordId'] as String?,
      paymentMethod: $enumDecodeNullable(
        _$PaymentMethodsEnumMap,
        json['paymentMethod'],
      ),
      userId: json['userId'] as String?,
      propertyId: json['propertyId'] as String?,
    );

Map<String, dynamic> _$FinancialRecordToJson(_FinancialRecord instance) =>
    <String, dynamic>{
      'datePaid': instance.datePaid.toIso8601String(),
      'amountPaid': instance.amountPaid,
      'recordType': _$FinancialRecordTypesEnumMap[instance.recordType]!,
      'paymentBy': instance.paymentBy.toJson(),
      'lastUpdatedDate': instance.lastUpdatedDate?.toIso8601String(),
      'recordNature': _$FinancialRecordNatureEnumMap[instance.recordNature]!,
      'recordId': instance.recordId,
      'paymentMethod': _$PaymentMethodsEnumMap[instance.paymentMethod],
      'userId': instance.userId,
      'propertyId': instance.propertyId,
    };

const _$FinancialRecordTypesEnumMap = {
  FinancialRecordTypes.rent: 'rent',
  FinancialRecordTypes.rentdeposit: 'rentdeposit',
  FinancialRecordTypes.securityExpense: 'securityExpense',
  FinancialRecordTypes.waterExpense: 'waterExpense',
  FinancialRecordTypes.electrityExpense: 'electrityExpense',
  FinancialRecordTypes.otherExpense: 'otherExpense',
  FinancialRecordTypes.otherRevenueSource: 'otherRevenueSource',
};

const _$FinancialRecordNatureEnumMap = {
  FinancialRecordNature.expense: 'expense',
  FinancialRecordNature.revenue: 'revenue',
};

const _$PaymentMethodsEnumMap = {
  PaymentMethods.cash: 'cash',
  PaymentMethods.mpesa: 'mpesa',
  PaymentMethods.bank: 'bank',
  PaymentMethods.paypal: 'paypal',
};
