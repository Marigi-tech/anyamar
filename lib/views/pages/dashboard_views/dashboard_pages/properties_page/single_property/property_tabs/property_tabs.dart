import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_overview/property_overview.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_records/property_records.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tenants/property_tenants.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_units/property_units.dart';

class PropertyTabs extends ConsumerWidget {
  final Property property;
  const PropertyTabs({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Tenant> propertyTenants = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    List<Unit> propertyUnits = ref
        .watch(userInformationProvider.select((state) => state.units))
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    List<FinancialRecord> propertyRecords = ref
        .watch(userInformationProvider.select((state) => state.finances))
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            indicatorColor: AppColorsConstant.lightGreenColor,
            indicatorWeight: 2,
            unselectedLabelColor: AppColorsConstant.blueGreyColor,
            dividerColor: AppColorsConstant.transparentColor,
            overlayColor: null,
            labelPadding: EdgeInsets.symmetric(vertical: 3),
            indicatorSize: TabBarIndicatorSize.label,
            dividerHeight: 1,
            indicatorPadding: EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 6,
            ),
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Units [${propertyUnits.length}]'),
              Tab(text: 'Tenants [${propertyTenants.length}]'),
              Tab(text: 'Financial Records [${propertyRecords.length}]'),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TabBarView(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: PropertyOverview(property: property),
                    ),
                  ),
                  // Center(child: Text('Overview')),
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: PropertyUnits(property: property),
                    ),
                  ),

                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: PropertyTenants(property: property),
                    ),
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: PropertyRecords(property: property),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
