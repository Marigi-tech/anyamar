import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_expenses_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/expense_per_property_state_page.dart';

class QuickExpensesActions extends ConsumerWidget {
  final FinancialRecord? expenseRecord;
  final String introText;

  const QuickExpensesActions({super.key, this.expenseRecord, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGeneralPage = (expenseRecord == null) ? true : false;
    return QuickActionsWidget(
      children: [
        if (!isGeneralPage) CardItemSeparator(),
        //Add Expense Record
        QWidget(
          onPressedCallBack: () => ref
              .read(workspaceProvider.notifier)
              .openForm(
                AddExpensesStatePage(
                  introText: '$introText / add expense record',
                ),
              ),
          // onPressedCallBack: () =>
          //     ref.read(financesPageProvider.notifier).addExpenseRecord(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Add Expense Record',
                icon: CupertinoIcons.add,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //View properties with the expenses
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref.read(workspaceProvider.notifier).openForm(ExpensesPerPropertyStatePage(introText: '$introText / expenses per property',)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Expenses / Property',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        // if (isGeneralPage)
        //   QWidget(
        //     onPressedCallBack: () =>
        //         ref.read(financesPageProvider.notifier).financesTable(),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         RowTitleWidget(
        //           text: 'View all financial records',
        //           icon: CupertinoIcons.info,
        //         ),
        //         Icon(CupertinoIcons.chevron_right, size: 15),
        //       ],
        //     ),
        //   ),
      ],
    );
  }
}
