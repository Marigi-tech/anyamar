import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_cards_list.dart';
import 'package:anyamar/tables/units_table.dart';

class UnitsPage extends ConsumerWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    List<Unit> units = appData.units.toList();
    final gridCount = Responsiveness.isMobile(context) ? 2 : 5;
    return DashboardPageStructure(
      introText: 'units',
      pageTitle: 'All units',
      supplementaryText:
          'Manage all your units, their tenants and all other related information here ',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Unit',
          buttonIcon: const Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  DashboardPageStructure(
                    introText: 'units / add unit',
                    pageTitle: 'Add Unit',
                    introRowWidgets: [],
                    introButton: IntroButtonWidget(),
                    scrollableDashboardWidget: AddOrUpdateUnitForm(),
                  ),
                );
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
}
