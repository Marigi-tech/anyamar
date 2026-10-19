import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';

class QuickActionsUnitWidget extends ConsumerWidget {
  final Unit unit;
  final String introText;
  const QuickActionsUnitWidget({super.key, required this.unit, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    Tenant? currentTenant = appData.tenants
        .where(
          (tenant) => tenant.unitId == unit.unitId && tenant.isActive != false,
        )
        .singleOrNull;
    return QuickActionsWidget(
      children: [
        //Update unit
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / update unit',
                  pageTitle: 'Update unit',
                  supplementaryText: '${unit.unitName} | ${unit.propertyName}',

                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: AddOrUpdateUnitForm(unit: unit),
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Update Unit', icon: CupertinoIcons.pencil),
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
                  introText: '$introText / add rent record',
                  pageTitle: 'Add rent record',
                  supplementaryText: '${unit.unitName} | ${unit.propertyName}',
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: RentalRecordForm(
                    unit: unit,
                    tenant: currentTenant,
                  ),
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add rent record', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
       
        CardItemSeparator(),
        if (unit.isOccupied != true)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  DashboardPageStructure(
                    introText: '$introText / add tenant',
                    pageTitle: 'Add tenant',
                    supplementaryText:
                        '${unit.unitName} | ${unit.propertyName}',
                    introRowWidgets: [],
                    introButton: IntroButtonWidget(),
                    scrollableDashboardWidget: TenantForm(currentUnit: unit),
                  ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(text: 'Add tenant', icon: CupertinoIcons.add),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
      ],
    );
  }
}
