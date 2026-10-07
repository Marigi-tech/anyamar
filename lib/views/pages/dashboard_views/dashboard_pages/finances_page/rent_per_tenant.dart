import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/rent_per_tenant_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/rent_per_tenant_table.dart';

class RentPerTenant extends ConsumerStatefulWidget {
  const RentPerTenant({super.key});

  @override
  ConsumerState<RentPerTenant> createState() => _RentPerTenantState();
}

class _RentPerTenantState extends ConsumerState<RentPerTenant> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    final rentRecords = appData.rentRecords;
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
          rentEntries: rentRecords.map((record) => record.rentEntry).toList(),
        ),
      ],
    );
  }
}
