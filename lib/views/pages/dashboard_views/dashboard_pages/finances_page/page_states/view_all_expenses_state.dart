import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/expenses_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_expenses_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/expenses_table.dart';

class ViewAllExpensesStatePage extends ConsumerWidget {
  const ViewAllExpensesStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      pageTitle: 'All Expenses',
      supplementaryText: 'Every expense incurred in property maintenance',
      introButton: FinancesBackButtonWidget(),
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Expense',
          buttonColor: AppColors.red,
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref.read(financesPageProvider.notifier).addExpenseRecord();
          },
        ),
      ],
      scrollableDashboardWidget: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpensesPageSummaryCards(),
                SizedBox(height: 15.0),
                ExpensesTable(),
              ],
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [QuickExpensesActions(), SizedBox(height: 20.0)],
            ),
          ),
        ],
      ),
    );
  }
}
