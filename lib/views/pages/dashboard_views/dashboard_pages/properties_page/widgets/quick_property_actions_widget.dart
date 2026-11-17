import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/property_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/page_states/tenant_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/page_states/unit_page_states.dart';

class QuickActionsPropertyWidget extends ConsumerWidget {
  final Property property;
  final String introText;
  const QuickActionsPropertyWidget({
    super.key,
    required this.property,
    required this.introText,
  });

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
                UpdatePropertyState(introText: introText, property: property),
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
              .openForm(AddUnitState(introText: introText)),

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
              .openForm(AddTenantState(introText: introText)),
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
