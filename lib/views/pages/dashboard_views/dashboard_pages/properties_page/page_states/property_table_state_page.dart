import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/property_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/properties_table.dart';

class PropertyTableStatePage extends ConsumerWidget {
  const PropertyTableStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);
    final gridCount = Responsiveness.isMobile(context) ? 1 : 5;
    return DashboardPageStructure(
      introText: 'Properties',
      pageTitle: 'All properties',
      supplementaryText: 'Manage all your properties in one place',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Property',
          buttonIcon: const Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref.read(propertyPageProvider.notifier).showAddProperty();
          },
        ),
      ],
      scrollableDashboardWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildPropertyPageSummaryCards(
            getPropertyCardsInfo(
              appData.properties,
              appData.units,
              appData.tenants,
              gridCount,
            ),
          ),
          const SizedBox(height: 30),
          PropertiesTable(),
        ],
      ),
    );
  }
}
