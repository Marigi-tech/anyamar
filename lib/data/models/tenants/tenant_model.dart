import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/rent/rent_model.dart';
import 'package:anyamar/data/models/users/person/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_model.freezed.dart';
part 'tenant_model.g.dart';

@freezed
abstract class Tenant with _$Tenant {
  const factory Tenant({
    required String userId,
    required String tenantName,
    required String unitId,
   Rent? unitRent,
    String? tenantId,
    String? tenantPhoneNumber,
    required String propertyId,
    String? unitName,
    String? tenantEmail,
    String? tenantOccupation, // job
    String? tenantNationalId,
    required DateTime startOfLease,
    DateTime? endOfLease,
    Person?
    nextOfKin, // Include name , phone number and email address of the tenant's next of kin
    final String? nationalId,
    DateTime? lastUpdateDate,
  }) = _Tenant;

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);
}

extension TenantSearch on Tenant {
  bool matchesTenantSearch(String query, List<Property> myProperties) {
    final search = query.toLowerCase();
    final String unitN = unitName ?? unitId;
    final Property propertyDeets = myProperties
        .where((p) => p.propertyId == propertyId)
        .single;
    final String tEmail = tenantEmail ?? '';
    final String tNatId = tenantNationalId ?? '';
    final String tPhone = tenantPhoneNumber ?? '';

    return tenantId!.toLowerCase().contains(search.toLowerCase()) ||
        (tenantName).toLowerCase().contains(search.toLowerCase()) ||
        (unitN).toLowerCase().contains(search) ||
        (tEmail).toLowerCase().contains(search.toLowerCase()) ||
        (tNatId).toLowerCase().contains(search.toLowerCase()) ||
        (tPhone).toLowerCase().contains(search.toLowerCase()) ||
        (propertyId).toLowerCase().contains(search) ||
        (propertyDeets.propertyLocation).toLowerCase().contains(search) ||
        (propertyDeets.propertyName).toLowerCase().contains(search);
  }
}
