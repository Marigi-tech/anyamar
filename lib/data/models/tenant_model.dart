import 'package:anyamar/data/data_sets/properties.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/users/person.dart';

class Tenant {
  final String tenantId;
  final String tenantName;
  final String unitId;
  final String tenantPhoneNumber;
  final String propertyId;
  final String? unitName;
  final String? tenantEmail;
  final String? tenantOccupation; // job
  final String? tenantNationalId;
  final Person?
  nextOfKin; // Include name , phone number and email address of the tenant's next of kin
  final String? nationalId;

  Tenant({
    required this.unitId,
    required this.tenantPhoneNumber,
    required this.propertyId,
    required this.tenantId,
    required this.tenantName,
    this.unitName,
    this.tenantEmail,
    this.nationalId,
    this.nextOfKin,
    this.tenantOccupation,
    this.tenantNationalId
  });
  bool matchesTenantSearch(String query) {
    final search = query.toLowerCase();
    final String unitN = unitName ?? unitId;
    final Property propertyDeets = properties
        .where((p) => p.propertyId == propertyId)
        .single;
    final String tEmail = tenantEmail ?? '';

    return tenantId.toLowerCase().contains(search.toLowerCase()) ||
        (tenantName).toLowerCase().contains(search.toLowerCase()) ||
        (unitN).toLowerCase().contains(search) ||
        (tenantPhoneNumber).toLowerCase().contains(search.toLowerCase()) ||
        (tEmail).toLowerCase().contains(search.toLowerCase()) ||
        (propertyId).toLowerCase().contains(search) ||
        (propertyDeets.propertyLocation).toLowerCase().contains(search) ||
        (propertyDeets.propertyName).toLowerCase().contains(search);
  }
}
