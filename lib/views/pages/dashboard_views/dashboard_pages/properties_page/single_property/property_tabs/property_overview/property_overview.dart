import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tenants/property_tenants.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_units/property_units.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/widgets/property_overview_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/widgets/quick_property_summary_widget.dart';

class PropertyOverview extends StatelessWidget {
  final Property property;
  final List<Unit> propertyUnits;
  final List<Tenant> propertyTenants;
  final String introText;

  const PropertyOverview({
    super.key,
    required this.property,
    required this.propertyUnits,
    required this.propertyTenants,
    required this.introText,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Responsiveness.isDesktop(context)
              ? Row(
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
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PropertyOverviewWidget(property: property),
                    SizedBox(height: 15.0),
                    QuickPropertySummaryWidget(
                      property: property,
                      propertyUnits: propertyUnits,
                      propertyTenants: propertyTenants,
                    ),
                  ],
                ),
          SizedBox(height: 20.0),
          PropertyUnits(property: property, introText: '$introText / units'),
          SizedBox(height: 20.0),
          PropertyTenants(
            property: property,
            introText: '$introText / tenants',
          ),
        ],
      ),
    );
  }
}
