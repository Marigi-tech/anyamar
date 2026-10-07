import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/property_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_tabs.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/widgets/quick_property_actions_widget.dart';

class SinglePropertyPage extends ConsumerStatefulWidget {
  final Property property;
  const SinglePropertyPage({super.key, required this.property});

  @override
  ConsumerState<SinglePropertyPage> createState() => _SinglePropertyPageState();
}

class _SinglePropertyPageState extends ConsumerState<SinglePropertyPage> {
  List<Tenant> propertyTenants = [];
  List<Unit> propertyUnits = [];
  List<Unit> occupiedUnits = [];
  double totalExpectedRent = 0.0;
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    propertyUnits = appData.units
        .where((unit) => unit.propertyId == widget.property.propertyId)
        .toList();
    propertyTenants = appData.tenants
        .where(
          (tenant) => propertyUnits.any((unit) => unit.unitId == tenant.unitId),
        )
        .toList();

    // for (var unit in propertyUnits) {

    //   totalExpectedRent +
    //       (unit.unitRent!.rentAmount +
    //           (unit.unitRent?.utilities ?? []).fold<double>(
    //             0,
    //             (sum, utility) => sum + utility.amountPayable,
    //           ));
    // }
    occupiedUnits = propertyUnits.where((u) => u.isOccupied == true).toList();
    totalExpectedRent = occupiedUnits.fold<double>(0.0, (total, unit) {
      final rent = unit.unitRent?.rentAmount ?? 0.0;

      final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
        0.0,
        (sum, utility) => sum + utility.amountPayable,
      );

      return total + rent + utilities;
    });

    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Responsiveness.isMobile(context)
            ? Column(
                children: [
                  // --------------------------------------------
                  // Data Row
                  // --------------------------------------------
                  buildSinglePropertySummaryCards(
                    widget.property,
                    gridCount,
                    propertyTenants.length as double,
                    propertyUnits.length as double,
                    occupiedUnits.length as double,
                    totalExpectedRent,
                  ),
                  SizedBox(height: 30.0),
                  // --------------------------------------------
                  // Property tabs
                  // --------------------------------------------
                  SizedBox(
                    height: 600,
                    child: PropertyTabs(
                      property: widget.property,
                      expectedMonthlyIncome: totalExpectedRent,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --------------------------------------------
                        // Data Row
                        // --------------------------------------------
                        buildSinglePropertySummaryCards(
                          widget.property,
                          gridCount,
                          propertyTenants.length as double,
                          propertyUnits.length as double,
                          occupiedUnits.length as double,
                          totalExpectedRent,
                        ),
                        SizedBox(height: 30.0),
                        // --------------------------------------------
                        // Property tabs
                        // --------------------------------------------
                        SizedBox(
                          height: 600,
                          child: PropertyTabs(
                            property: widget.property,
                            expectedMonthlyIncome: totalExpectedRent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --------------------------------------------
                        // Quick Actions
                        // --------------------------------------------
                        QuickActionsPropertyWidget(property: widget.property),
                        SizedBox(height: 20.0),
                        // --------------------------------------------
                        // Tenant List
                        // --------------------------------------------
                        TenantInformationCardWidget(
                          tenants: propertyTenants,
                          property: widget.property,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
