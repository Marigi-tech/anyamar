import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_cards_list.dart';
import 'package:anyamar/tables/units_table.dart';

Widget buildUnitsTable(
  BuildContext context,
  WidgetRef ref,
  List<Unit> units,
  List<Tenant> tenants,
  List<Property> properties,
  bool themeIsDark,
) {
  final gridCount = Responsiveness.isMobile(context) ? 1 : 5;

  return DashboardPageStructure(
    introText: 'Units',
    pageTitle: 'All Units',
    supplementaryText: 'All property Units',
    introRowWidgets: [
      ElevatedButtonWidget(
        buttonTitle: 'Add Unit',
        buttonIcon: const Icon(Icons.add),
        onButtonPressedCallBack: () {
          // ref.read(unitPageProvider.notifier).showAddUnit();
        },
      ),
    ],
    scrollableDashboardWidget: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildUnitntroSummaryCards(units, gridCount),

        const SizedBox(height: 30),
        UnitsTable(units: units, introText: 'units'),
      ],
    ),
  );
}
