import 'package:anyamar/data/models/enums/unit_type_enum.dart';
import 'package:anyamar/data/models/rent/rent_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_model.freezed.dart';
part 'unit_model.g.dart';

@freezed
abstract class Unit with _$Unit {
  const factory Unit({
    String? unitId,
    required String unitName,
    required String propertyId,
    required String propertyName,
    required String userId,
    String? tenantId,
    Tenant? currentTenant,
    UnitType? unitType,
    required double rentPerMonth,
    Rent? unitRent,
    @Default([]) List<String> previousTenantsLog,
    @Default(false) bool isOccupied,
    DateTime? lastUpdateDate,
    double? numberFloors,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}

extension UnitSearch on Unit {
  bool matchesUnitSearch(String query, List<Tenant> tenants) {
    if (query.isEmpty) return true;
    final search = query.toLowerCase();

    final Tenant? tenantInformation = tenantId != null
        ? tenants.firstWhere((element) => element.tenantId == tenantId)
        : null;

    final statusText = (isOccupied) ? 'occupied' : 'vacant';

    return unitId!.toLowerCase().contains(search) ||
        (unitName).toLowerCase().contains(search) ||
        propertyName.toLowerCase().contains(search) ||
        (tenantInformation?.tenantName ?? '').toLowerCase().contains(search) ||
        statusText.contains(search);
  }
}
