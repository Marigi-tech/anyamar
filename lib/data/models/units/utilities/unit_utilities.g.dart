// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_utilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnitUtility _$UnitUtilityFromJson(Map<String, dynamic> json) => _UnitUtility(
  utilityName: $enumDecode(_$PropertyUtilityEnumMap, json['utilityName']),
  amountPayable: (json['amountPayable'] as num).toDouble(),
);

Map<String, dynamic> _$UnitUtilityToJson(_UnitUtility instance) =>
    <String, dynamic>{
      'utilityName': _$PropertyUtilityEnumMap[instance.utilityName]!,
      'amountPayable': instance.amountPayable,
    };

const _$PropertyUtilityEnumMap = {
  PropertyUtility.garbage: 'garbage',
  PropertyUtility.security: 'security',
  PropertyUtility.water: 'water',
  PropertyUtility.electricity: 'electricity',
};
