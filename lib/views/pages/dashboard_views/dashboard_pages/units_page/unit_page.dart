import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/page_states/unit_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_cards_list.dart';
import 'package:anyamar/tables/units_table.dart';

class UnitsPage extends ConsumerWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    List<Unit> units = appData.units.toList();

    return DashboardPageStructure(
      introText: 'units',
      pageTitle: 'All Units',
      supplementaryText:
          'Manage all your units, their tenants and all other related information here ',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Unit',
          buttonIcon: const Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(AddUnitState(introText: 'units'));
          },
        ),
      ],
      scrollableDashboardWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UnitPageSummaryCards(),
          const SizedBox(height: 30),
          UnitsTable(units: units, introText: 'units'),
        ],
      ),
    );
  }
}
