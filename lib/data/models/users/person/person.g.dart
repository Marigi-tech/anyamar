// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Person _$PersonFromJson(Map<String, dynamic> json) => _Person(
  personId: json['personId'] as String?,
  personName: json['personName'] as String,
  personEmail: json['personEmail'] as String?,
  personUserType: $enumDecodeNullable(
    _$UserTypeEnumMap,
    json['personUserType'],
  ),
  personPhone: json['personPhone'] as String?,
  personNationalId: json['personNationalId'] as String?,
  agencyName: json['agencyName'] as String?,
  relationship: json['relationship'] as String?,
  isAgency: json['isAgency'] ?? false,
);

Map<String, dynamic> _$PersonToJson(_Person instance) => <String, dynamic>{
  'personId': instance.personId,
  'personName': instance.personName,
  'personEmail': instance.personEmail,
  'personUserType': _$UserTypeEnumMap[instance.personUserType],
  'personPhone': instance.personPhone,
  'personNationalId': instance.personNationalId,
  'agencyName': instance.agencyName,
  'relationship': instance.relationship,
  'isAgency': instance.isAgency,
};

const _$UserTypeEnumMap = {
  UserType.landlord: 'landlord',
  UserType.agent: 'agent',
  UserType.caretaker: 'caretaker',
  UserType.otherUser: 'otherUser',
};
