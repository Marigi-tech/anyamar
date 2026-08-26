import 'package:anyamar/data/models/enums/user_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
abstract class Person with _$Person {
  const factory Person({
    String? personId,
    required String personName,
    String? personEmail,
    UserType? personUserType,
    String? personPhone,
    String? personNationalId,
    String? agencyName,
    String? relationship,
    @Default(false) isAgency,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
