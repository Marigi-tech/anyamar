import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/page_states/tenant_page_states.dart';

class QuickActionsTenantWidget extends ConsumerWidget {
  final Tenant? tenant;
  final String introText;
  const QuickActionsTenantWidget({
    super.key,
    this.tenant,
    required this.introText,
  });

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
                  UpdateTenantState(introText: introText, tenant: tenant!),
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

        CardItemSeparator(),
      ],
    );
  }
}
