import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/models/users/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_information_model.freezed.dart';
part 'user_information_model.g.dart';

@freezed
abstract class UserInformation with _$UserInformation {
  const factory UserInformation({
    @Default([]) List<Property> properties,
    @Default([]) List<Tenant> tenants,
    @Default([]) List<Unit> units,
    @Default([]) List<FinancialRecord> finances,
    AppUser? appUser,
    @Default(false) bool isLoading,
  }) = _UserInformation;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);
}
