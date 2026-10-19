import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';

class QuickActionsTenantWidget extends ConsumerWidget {
  final Tenant? tenant;
  const QuickActionsTenantWidget({super.key, this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QuickActionsWidget(
      children: [
        //Update tenant
        if (tenant != null)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  DashboardPageStructure(
                    introText: 'tenants / tenant / update tenant',
                    pageTitle: tenant?.tenantName,
                    introRowWidgets: [],
                    introButton: IntroButtonWidget(),
                    scrollableDashboardWidget: TenantForm(
                      currentTenant: tenant,
                    ),
                  ),
                ),
            // ref.read(tenantPageProvider.notifier).updateTenant(tenant!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'Update Tenant',
                  icon: CupertinoIcons.pencil,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (tenant != null) CardItemSeparator(),
        //Add Tenant
        // QWidget(
        //   onPressedCallBack: () =>
        //       ref.read(tenantPageProvider.notifier).showAddTenantForm(),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       RowTitleWidget(text: 'Add Tenant', icon: CupertinoIcons.add),
        //       Icon(CupertinoIcons.chevron_right, size: 15),
        //     ],
        //   ),
        // ),
        CardItemSeparator(),
      ],
    );
  }
}
