import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_overview/property_overview.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_tenants/property_tenants.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_units/property_units.dart';

class PropertyTabs extends StatelessWidget {
  final Property property;
  const PropertyTabs({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
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
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Units'),
              Tab(text: 'Tenants'),
              Tab(text: 'Reports'),
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
                  Center(child: Text('Reports')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
