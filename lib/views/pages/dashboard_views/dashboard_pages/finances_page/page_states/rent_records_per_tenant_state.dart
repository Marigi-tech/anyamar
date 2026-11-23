import 'package:anyamar/commons/exports.dart';

import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/rent_per_tenant_widget.dart';

class RentRecordsPerTenantState extends ConsumerWidget {
  final String introText;
  final Tenant tenant;
  final List<SingleRentEntry> rentRecords;
  const RentRecordsPerTenantState({
    super.key,
    required this.rentRecords,
    required this.introText,
    required this.tenant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'Rent records / tenant ',
      supplementaryText:
          '${tenant.tenantName} | ${tenant.tenantPhoneNumber} | ${tenant.tenantEmail}',
      introButton: IntroButtonWidget(),
      introRowWidgets: [],
      scrollableDashboardWidget: RentRecordsPerTenantWidget(
        introText: '$introText / rent records ',
        rentRecords: rentRecords,
        tenant: tenant,
      ),
    );
  }
}

//Rental records per property
class RentRecordsPerPropertyState extends ConsumerWidget {
  final String introText;
  final Property property;
  const RentRecordsPerPropertyState({
    super.key,
    required this.introText,
    required this.property,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'Rent records / property ',
      supplementaryText: ' Property : ${property.propertyName} ',
      introButton: IntroButtonWidget(),
      introRowWidgets: [],
      scrollableDashboardWidget: RentRecordsPerPropertyWidget(
        introText: '$introText / rent records ',
        property: property,
      ),
    );
  }
}
