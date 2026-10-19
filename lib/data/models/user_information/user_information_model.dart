import 'package:anyamar/commons/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_information_model.freezed.dart';
part 'user_information_model.g.dart';

@freezed
abstract class UserInformation with _$UserInformation {
  const factory UserInformation({
    @Default([]) List<Property> properties,
    @Default([]) List<Tenant> tenants,
    @Default([]) List<Tenant> activeTenants,
    @Default([]) List<Unit> units,
    @Default([]) List<FinancialRecord> finances,
    AppUser? appUser,
    @Default([]) List<RentalRecord> rentalRecords,
    @Default(false) bool isLoading,
  }) = _UserInformation;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);
}

extension UserInformationExtension on UserInformation {
  int get propertyCount => properties.length;

  int get tenantCount => tenants.length;

  int get unitCount => units.length;

  int get occupiedUnitCount => units.where((unit) => unit.isOccupied).length;

  int get vacantUnitCount => units.where((unit) => !unit.isOccupied).length;

  List<Unit> get occupiedUnits =>
      units.where((unit) => unit.isOccupied).toList();

  List<Unit> get vacantUnits =>
      units.where((unit) => !unit.isOccupied).toList();

  List<Tenant> get tenantsWithRentRecords {
    return tenants
        .where(
          (tenant) =>
              rentalRecords.any((record) => record.tenantId == tenant.tenantId),
        )
        .toList();
  }

  int get financeCount => finances.length;

  int get activeTenantAcount => activeTenants.length;

  int get rentRecordsCount => rentalRecords.length;
}
