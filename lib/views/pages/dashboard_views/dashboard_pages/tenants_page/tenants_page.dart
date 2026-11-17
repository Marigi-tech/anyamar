import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/page_states/tenant_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/tenant_page_summary_cards.dart';

class TenantsPage extends ConsumerWidget {
  const TenantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'tenants',
      pageTitle: 'All Tenants',
      supplementaryText:
          'Manage all your tenants and their related information in one place',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Tenant',
          buttonIcon: const Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(AddTenantState(introText: 'tenants'));
          },
        ),
      ],
      scrollableDashboardWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TenantPageSummaryCards(),
          const SizedBox(height: 30),
          TenantsTable(introText: 'tenants'),
        ],
      ),
    );
  }
}
