import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/property_rent_history.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/property_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/tenant_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/tenant_rent_history.dart';

class RentRecordsPerTenantWidget extends ConsumerWidget {
  final List<SingleRentEntry> rentRecords;
  final Tenant tenant;
  final String introText;
  const RentRecordsPerTenantWidget({
    super.key,
    required this.rentRecords,
    required this.tenant,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // --------------------------------------------
          // Data Row
          // --------------------------------------------
          // SinglePropertyPageSummaryCards(property: property),
          SingleTenantPageSummaryCards(tenant: tenant),
          SizedBox(height: 20.0),
          TenantRentHistory(tenant: tenant, introText: '$introText '),
        ],
      ),
    );
  }
}

//Rent records per property
class RentRecordsPerPropertyWidget extends ConsumerWidget {
  final Property property;
  final String introText;
  const RentRecordsPerPropertyWidget({
    super.key,
    required this.property,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // --------------------------------------------
          // Data Row
          // --------------------------------------------
          // SinglePropertyPageSummaryCards(property: property),
          SinglePropertyPageSummaryCards(
            property: property,
            isFromExpenses: false,
            isFromPropertyRentRecords: true,
          ),
          SizedBox(height: 20.0),
          PropertyRentHistory(property: property, introText: '$introText '),
        ],
      ),
    );
  }
}
