import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/expense_per_property_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/rent_per_tenant_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_all_expenses_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_all_rent_entries_state.dart';

class QuickFinancesActions extends ConsumerWidget {
  final FinancialRecord? financialRecord;
  final SingleRentEntry? rentEntry;
  final String introText;
  const QuickFinancesActions({
    super.key,
    this.financialRecord,
    this.rentEntry,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGeneralPage = (financialRecord != null || rentEntry != null)
        ? false
        : true;
    return QuickActionsWidget(
      children: [
        //View expense records
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  ViewAllExpensesStatePage(
                    introText: '$introText / expense records',
                  ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Expense Records',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        //View rent records
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  ViewAllRentEntriesPageState(
                    introText: '$introText /  rent records',
                  ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Rent Records',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  ExpensesPerPropertyStatePage(
                    introText: '$introText / expense records per property',
                  ),
                ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Expenses /Property',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  RentPerTenantStatePage(
                    introText: '$introText / rent records per tenant',
                  ),
                ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Rent records / Tenant',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
      ],
    );
  }
}
