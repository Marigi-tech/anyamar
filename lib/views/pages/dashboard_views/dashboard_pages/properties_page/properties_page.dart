import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/forms/add_property_form.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/property_page_summary_cards.dart';
import 'package:anyamar/tables/properties_table.dart';

class PropertiesPage extends ConsumerWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'properties',
      pageTitle: 'All properties',
      supplementaryText: 'Manage all your properties in one place',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Property',
          buttonIcon: const Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  DashboardPageStructure(
                    introText: 'properties / add property',
                    pageTitle: 'Add Property',
                    introRowWidgets: [],
                    introButton: IntroButtonWidget(),
                    scrollableDashboardWidget: AddPropertyForm(),
                  ),
                );
          },
        ),
      ],
      scrollableDashboardWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PropertyPageSummaryCards(),
          const SizedBox(height: 30),
          PropertiesTable(introText: 'properties'),
        ],
      ),
    );
  }
}
