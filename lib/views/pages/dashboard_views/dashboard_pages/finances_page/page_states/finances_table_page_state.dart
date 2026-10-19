import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_expenses_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_income_state_page.dart';

import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_finances_actions.dart';

class FinancesTablePage extends ConsumerWidget {
  final String introText;
  const FinancesTablePage({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'All Financial records',
      supplementaryText:
          'Every financial record is managed here, including all rental entries and expenses',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add expense',
          buttonColor: AppColors.red,
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  AddExpensesStatePage(
                    introText: '$introText / add expense record',
                  ),
                );
          },
        ),
        SizedBox(width: 20.0),
        ElevatedButtonWidget(
          buttonTitle: 'Add rental record',
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  AddIncomeStatePage(introText: '$introText / add rent record'),
                );
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
                FinancesPageSummaryCards(),
                SizedBox(height: 15.0),
                FinancesTable(introText: 'finances'),
              ],
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuickFinancesActions(introText: introText),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
