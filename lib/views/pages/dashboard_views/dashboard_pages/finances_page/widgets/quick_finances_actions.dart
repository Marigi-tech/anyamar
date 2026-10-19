import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_expenses_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_income_state_page.dart';
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
        if (financialRecord != null || rentEntry != null) CardItemSeparator(),
        //Add Expense Record
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                AddExpensesStatePage(
                  introText: '$introText / add expense record',
                ),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Add expense record',
                icon: CupertinoIcons.add,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //Add Rent Entry
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                AddIncomeStatePage(introText: '$introText / add rent record'),
              ),

          // onPressedCallBack: () =>
          //     ref.read(financesPageProvider.notifier).addIncomeRecord(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add rent record', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //View expense records
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  ViewAllExpensesStatePage(
                    introText: '$introText / all expense records',
                  ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View expense records',
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
                    introText: '$introText / all rent records',
                  ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View rent records',
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
                  text: 'View expenses / property',
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
                    introText: '$introText / rent records per property',
                  ),
                ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View rent records / tenant',
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
