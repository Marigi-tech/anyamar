import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_expenses_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/expenses_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_expenses_actions.dart';
import 'package:anyamar/tables/expenses_table.dart';

class ViewAllExpensesStatePage extends ConsumerWidget {
  final String introText;
  const ViewAllExpensesStatePage({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'All Expenses',
      supplementaryText: 'Every expense incurred in property maintenance',
      introButton: FinancesBackButtonWidget(),
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Expense',
          buttonColor: AppColors.red,
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(AddExpensesStatePage(introText: introText));
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
              children: [
                QuickExpensesActions(introText: introText),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
