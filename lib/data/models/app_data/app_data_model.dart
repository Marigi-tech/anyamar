import 'package:anyamar/commons/exports.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data_model.freezed.dart';
part 'app_data_model.g.dart';

@freezed
abstract class AppData with _$AppData {
  const factory AppData({
    @Default([]) List<Property> properties,
    @Default([]) List<Tenant> tenants,
    @Default([]) List<FinancialRecord> finances,
    @Default([]) List<Unit> units,
    AppUser? appUser,
    @Default([]) List<Tenant> activeTenants,
    @Default([]) List<RentalRecord> rentRecords,
  }) = _AppData;

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);
}

extension AppDataExtension on AppData {
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
              rentRecords.any((record) => record.tenantId == tenant.tenantId),
        )
        .toList();
  }

  int get financeCount => finances.length;

  int get activeTenantAcount => activeTenants.length;

  int get rentRecordsCount => rentRecords.length;
}
