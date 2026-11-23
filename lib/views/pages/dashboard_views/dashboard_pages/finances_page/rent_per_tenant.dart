import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/tables/rent_per_property.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/rent_per_tenant_summary_cards.dart';
import 'package:anyamar/tables/rent_per_tenant_table.dart';

class RentPerTenant extends ConsumerStatefulWidget {
  final String introText;
  const RentPerTenant({super.key, required this.introText});

  @override
  ConsumerState<RentPerTenant> createState() => _RentPerTenantState();
}

class _RentPerTenantState extends ConsumerState<RentPerTenant> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    final rentRecords = appData.rentalRecords;
    //tenants in rent records
    final tenants = appData.tenants
        .where(
          (tenant) => rentRecords.any(
            (rentRecord) => rentRecord.tenantId == tenant.tenantId,
          ),
        )
        .toList();

    return Column(
      children: [
        // --------------------------------------------
        // Data Row
        // --------------------------------------------
        RentPerTenantSummaryCards(),

        SizedBox(height: 30.0),
        // --------------------------------------------
        // Table
        // --------------------------------------------
        RentPerTenantTable(
          tenants: tenants,
          introText: widget.introText,
          rentEntries: rentRecords.map((record) => record.rentEntry).toList(),
        ),
      ],
    );
  }
}

//* RENT PER PROPERTY
class RentPerProperty extends ConsumerStatefulWidget {
  final String introText;
  final Property property;
  const RentPerProperty({
    super.key,
    required this.introText,
    required this.property,
  });

  @override
  ConsumerState<RentPerProperty> createState() => _RentPerPropertyState();
}

class _RentPerPropertyState extends ConsumerState<RentPerProperty> {
  @override
  Widget build(BuildContext context) {
    // final rentRecords = appData.rentalRecords.;

    return Column(
      children: [
        // --------------------------------------------
        // Data Row
        // --------------------------------------------
        RentPerTenantSummaryCards(property: widget.property),

        SizedBox(height: 30.0),
        // --------------------------------------------
        // Table
        // --------------------------------------------
        RentPerPropertyTable(
          property: widget.property,
          introText: widget.introText,
          // rentEntries: rentRecords.map((record) => record.rentEntry).toList(),
        ),
      ],
    );
  }
}
