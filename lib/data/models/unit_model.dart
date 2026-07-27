import 'package:anyamar/data/data_sets/tenants.dart';
import 'package:anyamar/data/models/rent_model.dart';
import 'package:anyamar/data/models/tenant_model.dart';

class Unit {
  final String unitId;
  final String? unitName;
  final String propertyId;
  final String? propertyName;
  final String? tenantId;
  final Tenant? currentTenant;
  final Rent unitRent;
  final List<Tenant>? previousTenantsLog;
  final bool? isOccupied;
  // final double? unitRent;
  // final String? rentCurrency; //todo: a rentCurrency model  //TODO: A rent model
  // final String? rentFrequency;
  // final double? rentDeposit;

  Unit({
    required this.unitId,
    required this.unitName,
    required this.propertyId,
    this.tenantId,
    this.isOccupied = false,
    required this.unitRent,

    this.currentTenant,
    this.previousTenantsLog,
    this.propertyName,
  });
  bool matchesUnitSearch(String query) {
    final search = query.toLowerCase();
    final Tenant? tenantInformation = tenantId != null
        ? tenants.firstWhere((element) => element.tenantId == tenantId)
        : null;
    final statusText = (isOccupied ?? false) ? 'occupied' : 'vacant';

    return unitId.toLowerCase().contains(search.toLowerCase()) ||
        (unitName ?? '').toLowerCase().contains(search.toLowerCase()) ||
        (unitId).toLowerCase().contains(search) ||
        (tenantInformation?.tenantName ?? '').toLowerCase().contains(
          search.toLowerCase(),
        ) ||
        (tenantInformation?.tenantPhoneNumber ?? '').toLowerCase().contains(
          search,
        ) ||
        statusText.contains(search);
  }
}
