import 'package:test_app/data/data_sets/tenants.dart';
import 'package:test_app/data/models/tenant_model.dart';

class Unit {
  final String unitId;
  final String? unitName;
  final String propertyId;
  final String? tenantId;
  final bool? isOccupied;
  final double? unitRent;
  final String? rentCurrency; //todo: a rentCurrency model

  Unit({
    required this.unitId,
    required this.unitName,
    required this.propertyId,
    this.tenantId,
    this.isOccupied = false,
    this.unitRent,
    this.rentCurrency,
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
  // factory Unit.fromMap(Map<String, dynamic> map) {
  //   return Unit(
  //     unitId: map['unitId'] ?? '',
  //     unitName: map['unitName'],
  //     propertyId: map['propertyId'] ?? '',
  //     tenantInformation: map['tenantInformation'] != null
  //         ? Tenant.fromMap(map['tenantInformation'])
  //         : null,
  //     isOccupied: map['isOccupied'] ?? false,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'unitId': unitId,
  //     'unitName': unitName,
  //     'propertyId': propertyId,
  //     'tenantInformation': tenantInformation.toMap(),
  //     'isOccupied': isOccupied,
  //   };
  // }
}
