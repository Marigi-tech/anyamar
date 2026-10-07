import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tenants/property_tenants.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_units/property_units.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/widgets/property_overview_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/widgets/quick_property_summary_widget.dart';

class PropertyOverview extends StatelessWidget {
  final Property property;
  final List<Unit> propertyUnits;
  final List<Tenant> propertyTenants;
  final double expectedMonthlyIncome;
  const PropertyOverview({
    super.key,
    required this.property,
    required this.propertyUnits,
    required this.propertyTenants,
    required this.expectedMonthlyIncome,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: PropertyOverviewWidget(property: property)),
              SizedBox(width: 20.0),
              Expanded(
                child: QuickPropertySummaryWidget(
                  property: property,
                  propertyUnits: propertyUnits,
                  propertyTenants: propertyTenants,
                  expectedMonthlyIncome: expectedMonthlyIncome,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          DashboardCardWidget(
            cardTitle: 'Units',

            buttonWidget1: AppTextButton(
              buttonTitle: 'View all',

              onPressedCallBack: () {},
            ),
            child: PropertyUnits(property: property),
          ),
          SizedBox(height: 20.0),
          DashboardCardWidget(
            cardTitle: 'Tenants',
            buttonWidget1: AppTextButton(
              buttonTitle: 'View all',

              onPressedCallBack: () {},
            ),
            child: PropertyTenants(property: property),
          ),
        ],
      ),
    );
  }
}
