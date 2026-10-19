import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/forms/end_tenant_lease_form.dart';

class SinglePageQuickActionsWidget extends ConsumerWidget {
  final Tenant tenant;
  final String introText;
  const SinglePageQuickActionsWidget({
    super.key,
    required this.tenant,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    final units = appData.units;
    Unit unit = units.where((unit) => unit.unitId == tenant.unitId).single;
    return QuickActionsWidget(
      children: [
        //Update Tenant
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / update tenant',
                  pageTitle: tenant.tenantName,
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: TenantForm(currentTenant: tenant),
                ),
              ),
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
        CardItemSeparator(),
        //Add rent Entry
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / add rental record',
                  pageTitle: tenant.tenantName,
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: RentalRecordForm(tenant: tenant),
                ),
              ),
          // ref.read(tenantPageProvider.notifier).addRentEntry(tenant),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Add rental record',
                icon: CupertinoIcons.add,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),

        //End lease
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / end lease',
                  pageTitle: tenant.tenantName,
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: EndTenantLeaseForm(tenant: tenant),
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'End tenant\'s lease',
                icon: CupertinoIcons.stop,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //View unit
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / unit',
                  pageTitle: unit.unitName,
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: SingleUnitWidget(
                    unit: unit,
                    introText: '$introText / unit',
                  ),
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'View Unit', icon: Icons.house),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
      ],
    );
  }
}
