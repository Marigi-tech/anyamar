import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/unit_model.dart';

class Tenant {
  final String tenantId;
  final String tenantName;
  final String unitId;
  final String tenantPhoneNumber;
  final String propertyId;
  final String? unitName;

  Tenant({
    required this.unitId,
    required this.tenantPhoneNumber,
    required this.propertyId,
    required this.tenantId,
    required this.tenantName,
    this.unitName,
  });
  bool matchesTenantSearch(String query) {
    final search = query.toLowerCase();
    final String unitN = unitName ?? unitId;
    final Property propertyDeets = properties
        .where((p) => p.propertyId == propertyId)
        .single;
    final Unit unitDeets = units.where((u) => u.tenantId == tenantId).single;

    return tenantId.toLowerCase().contains(search.toLowerCase()) ||
        (tenantName).toLowerCase().contains(search.toLowerCase()) ||
        (unitN).toLowerCase().contains(search) ||
        (tenantPhoneNumber).toLowerCase().contains(search.toLowerCase()) ||
        (propertyId).toLowerCase().contains(search) ||
        (propertyDeets.propertyLocation).toLowerCase().contains(search) ||
        (propertyDeets.propertyName).toLowerCase().contains(search) ||
        (unitDeets.unitType.label).toLowerCase().contains(search);
  }
}
