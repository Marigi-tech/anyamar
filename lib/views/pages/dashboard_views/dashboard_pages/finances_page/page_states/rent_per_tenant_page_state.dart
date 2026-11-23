import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_income_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/rent_per_tenant.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class RentPerTenantStatePage extends ConsumerWidget {
  final String introText;
  const RentPerTenantStatePage({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Rent records / Tenant',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add rent record',
          onButtonPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                AddIncomeStatePage(introText: '$introText / add rent record'),
              ),
        ),
      ],
      scrollableDashboardWidget: RentPerTenant(introText: introText),
    );
  }
}

// Rent records Per Property
class RentRecordsPerPropertyStatePage extends ConsumerWidget {
  final String introText;
  final Property property;
  const RentRecordsPerPropertyStatePage({
    super.key,
    required this.introText,
    required this.property,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: IntroButtonWidget(),
      pageTitle: 'Rent records / Property',

      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add rent record',
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  AddIncomeStatePage(
                    introText: '$introText / add rental record',
                  ),
                );
          },
        ),
      ],
      scrollableDashboardWidget: RentPerProperty(
        introText: introText,
        property: property,
      ),
    );
  }
}
