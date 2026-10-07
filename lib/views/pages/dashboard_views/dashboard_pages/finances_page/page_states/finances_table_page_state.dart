import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';

import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_finances_actions.dart';

class FinancesTablePage extends ConsumerWidget {
  const FinancesTablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      pageTitle: 'All Financial records',
      supplementaryText:
          'Every financial record is managed here, including all rental entries and expenses',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add Expense',
          buttonColor: AppColors.red,
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref.read(financesPageProvider.notifier).addExpenseRecord();
          },
        ),
        SizedBox(width: 20.0),
        ElevatedButtonWidget(
          buttonTitle: 'Add Rental Entry',
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref.read(financesPageProvider.notifier).addIncomeRecord();
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
                FinancesTable(),
              ],
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [QuickFinancesActions(), SizedBox(height: 20.0)],
            ),
          ),
        ],
      ),
    );
  }
}
