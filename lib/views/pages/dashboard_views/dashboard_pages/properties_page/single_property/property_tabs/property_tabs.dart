import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_overview/property_overview.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_records/property_records.dart';

import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tenants/property_tenants.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_units/property_units.dart';

class PropertyTabs extends ConsumerWidget {
  final Property property;
  final double expectedMonthlyIncome;

  const PropertyTabs({super.key, required this.property, required this.expectedMonthlyIncome});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);

    final propertyUnits = appData.units
        .where((unit) => unit.propertyId == property.propertyId)
        .toList();

    final propertyTenants = appData.tenants
        .where(
          (tenant) => propertyUnits.any((unit) => unit.unitId == tenant.unitId),
        )
        .toList();
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // TAB BAR
          // ==========================================================
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: AppColorsConstant.transparentColor,
              indicatorColor: AppColors.primaryBlue,
              labelStyle: CustomTextStyles.cardDescriptionStyle.copyWith(
                fontStyle: FontStyle.normal,
              ),
              unselectedLabelStyle: CustomTextStyles.cardDescriptionStyle
                  .copyWith(fontStyle: FontStyle.normal),
              indicatorWeight: 1 / pixelRatio,
              labelPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Units'),
                Tab(text: 'Tenants'),
                Tab(text: 'Finances'),
                Tab(text: 'Reports'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ==========================================================
          // TAB CONTENT
          // ==========================================================
          SizedBox(
            height: MediaQuery.of(context).size.height * .70,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                //Property Overview
                PropertyOverview(
                  property: property,
                  propertyUnits: propertyUnits,
                  propertyTenants: propertyTenants,
                  expectedMonthlyIncome: expectedMonthlyIncome,
                ),
                //Property Units
                PropertyUnits(property: property),
                //Property Tenants
                PropertyTenants(property: property),
                //Finances
                PropertyRecords(property: property),
                //Reports
                Text('Reports'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
