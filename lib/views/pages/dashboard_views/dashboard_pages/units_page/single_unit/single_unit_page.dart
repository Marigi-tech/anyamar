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
  const SingleUnitWidget({super.key, required this.unit});

  @override
  ConsumerState<SingleUnitWidget> createState() => _SingleUnitWidgetState();
}

class _SingleUnitWidgetState extends ConsumerState<SingleUnitWidget> {
  List<Tenant> allUnitTenants = [];
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    allUnitTenants = appData.tenants
        .where((t) => t.unitId == widget.unit.unitId)
        .toList();
    //todo:set current tenant
    // final Tenant currentTenant = widget.unit.currentTenant;
    final Tenant? currentTenant = appData.tenants
        .where((t) => t.unitId == widget.unit.unitId)
        .singleOrNull;
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Responsiveness.isMobile(context)
            ? Column(
                children: [
                  // --------------------------------------------
                  // Data Row
                  // --------------------------------------------
                  buildUnitSummaryCards(
                    widget.unit,
                    gridCount,
                    currentTenant?.tenantName,
                  ),
                  SizedBox(height: 30.0),
                  UnitInformationColumn(unit: widget.unit),
                  SizedBox(height: 20.0),
                  UnitRentPaymentHistory(unit: widget.unit),
                  SizedBox(height: 20.0),
                  UlitiesChargeWidget(rentObject: widget.unit.unitRent),
                  //Tenant Info
                  TenantDetailsCard(tenant: currentTenant),
                  SizedBox(height: 20.0),
                  QuickActionsUnitWidget(unit: widget.unit),
                  SizedBox(height: 20.0),
                  UnitStatusCard(isOccupied: widget.unit.isOccupied),
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
                          widget.unit,
                          gridCount,
                          currentTenant?.tenantName,
                        ),
                        SizedBox(height: 30.0),
                        UnitInformationColumn(unit: widget.unit),
                        SizedBox(height: 20.0),
                        UnitRentPaymentHistory(unit: widget.unit),
                        SizedBox(height: 20.0),
                        UlitiesChargeWidget(rentObject: widget.unit.unitRent),
                      ],
                    ),
                  ),
                  SizedBox(width: 25.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Tenant Info
                        TenantDetailsCard(tenant: currentTenant),
                        SizedBox(height: 20.0),
                        QuickActionsUnitWidget(unit: widget.unit),
                        SizedBox(height: 20.0),
                        UnitStatusCard(isOccupied: widget.unit.isOccupied),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class SingleUnitPage extends StatelessWidget {
  final Unit unit;
  const SingleUnitPage({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
