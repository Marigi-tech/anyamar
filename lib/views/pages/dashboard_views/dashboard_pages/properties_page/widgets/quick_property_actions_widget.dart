import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/forms/add_property_form.dart';

class QuickActionsPropertyWidget extends ConsumerWidget {
  final Property property;
  final String introText;
  const QuickActionsPropertyWidget({super.key, required this.property, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return QuickActionsWidget(
      children: [
        //------------------------------------------------------------------------------
        // Update Property
        //---------------------------------------------------------------------------------
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / update property',
                  pageTitle: 'Update Property',
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: AddPropertyForm(
                    currentProperty: property,
                  ),
                ),
              ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Update Property',
                icon: CupertinoIcons.pencil,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //------------------------------------------------------------------------------
        // Add Unit
        //---------------------------------------------------------------------------------
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / add unit',
                  pageTitle: 'Add Unit',
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: AddOrUpdateUnitForm(
                    currentProperty: property,
                  ),
                ),
              ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Unit', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),

        CardItemSeparator(),
        //------------------------------------------------------------------------------
        // Add Tenant
        //---------------------------------------------------------------------------------
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText / add tenant',
                  pageTitle: 'Add Tenant',
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: TenantForm(
                    currentProperty: property,
                  ),
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Tenant', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //------------------------------------------------------------------------------
        // Add Expense Record
        //---------------------------------------------------------------------------------
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '$introText /  add expense record',
                  pageTitle: 'Add Expense Record',
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: ExpenseRecordForm(
                    currentProperty: property,
                  ),
                ),
              ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Expense', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
      ],
    );
  }
}
