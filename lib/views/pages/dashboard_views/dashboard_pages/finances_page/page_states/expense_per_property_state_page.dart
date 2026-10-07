import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/expenses_per_property.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/rent_per_tenant.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class ExpensesPerPropertyStatePage extends ConsumerWidget {
  const ExpensesPerPropertyStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Expenses / Property',
      introRowWidgets: [],
      scrollableDashboardWidget: ExpensesPerProperty(),
    );
  }
}

class RentPerTenantStatePage extends ConsumerWidget {
  const RentPerTenantStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Rent / Tenant',
      introRowWidgets: [],
      scrollableDashboardWidget: RentPerTenant(),
    );
  }
}
