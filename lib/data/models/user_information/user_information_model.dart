import 'package:anyamar/commons/exports.dart';

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
    @Default([]) List<RentalRecord> rentalRecords,
    @Default(false) bool isLoading,
    AppData? appData,
  }) = _UserInformation;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);
}
