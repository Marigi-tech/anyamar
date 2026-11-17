import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/quick_actions_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/tenant_details_card.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_cards_list.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_information_column.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_rent_payment_history.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_status_card.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_utilities.dart';

class SingleUnitWidget extends ConsumerStatefulWidget {
  final Unit unit;
  final String introText;
  const SingleUnitWidget({
    super.key,
    required this.unit,
    required this.introText,
  });

  @override
  ConsumerState<SingleUnitWidget> createState() => _SingleUnitWidgetState();
}

class _SingleUnitWidgetState extends ConsumerState<SingleUnitWidget> {
  List<Tenant> allUnitTenants = [];
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    final Unit unit = appData.units
        .where((unit) => unit.unitId == widget.unit.unitId)
        .single;
    allUnitTenants = appData.tenants
        .where((t) => t.unitId == unit.unitId)
        .toList();
    //todo:set current tenant
    // final Tenant currentTenant = unit.currentTenant;
    final Tenant? currentTenant = appData.tenants
        .where((t) => t.unitId == unit.unitId)
        .singleOrNull;
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    final String introText = widget.introText;

    return DashboardPageStructure(
      introText: widget.introText,
      pageTitle: unit.unitName,
      introRowWidgets: [],
      introButton: IntroButtonWidget(),
      scrollableDashboardWidget: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Responsiveness.isMobile(context)
                ? Column(
                    children: [
                      // --------------------------------------------
                      // Data Row
                      // --------------------------------------------
                      buildUnitSummaryCards(
                        unit,
                        gridCount,
                        currentTenant?.tenantName,
                      ),
                      SizedBox(height: 30.0),
                      UnitInformationColumn(unit: unit),
                      SizedBox(height: 20.0),
                      UnitRentPaymentHistory(
                        unit: unit,
                        introText: '$introText / rent history',
                      ),
                      SizedBox(height: 20.0),
                      UlitiesChargeWidget(rentObject: unit.unitRent),
                      QuickActionsUnitWidget(unit: unit, introText: introText),
                      SizedBox(height: 20.0),
                      //Tenant Info
                      currentTenant != null
                          ? TenantDetailsCard(
                              tenant: currentTenant,
                              introText: introText,
                            )
                          : SizedBox.shrink(),

                      SizedBox(height: 20.0),
                      UnitStatusCard(isOccupied: unit.isOccupied),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // --------------------------------------------
                            // Data Row
                            // --------------------------------------------
                            buildUnitSummaryCards(
                              unit,
                              gridCount,
                              currentTenant?.tenantName,
                            ),
                            SizedBox(height: 30.0),
                            UnitInformationColumn(unit: unit),
                            SizedBox(height: 20.0),
                            UnitRentPaymentHistory(
                              unit: unit,
                              introText: '$introText / rent history',
                            ),
                            SizedBox(height: 20.0),
                            UlitiesChargeWidget(rentObject: unit.unitRent),
                          ],
                        ),
                      ),
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QuickActionsUnitWidget(
                              unit: unit,
                              introText: introText,
                            ),
                            SizedBox(height: 20.0),
                            currentTenant != null
                                ? TenantDetailsCard(
                                    tenant: currentTenant,
                                    introText: introText,
                                  )
                                : SizedBox.shrink(),
                            SizedBox(height: 20.0),
                            if (unit.previousTenantsLog.isNotEmpty)
                              TenantInformationCardWidget(
                                introText: introText,
                                tenantIds: unit.previousTenantsLog,
                              ),
                            if (unit.previousTenantsLog.isNotEmpty)
                              SizedBox(height: 20.0),
                            UnitStatusCard(isOccupied: unit.isOccupied),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
