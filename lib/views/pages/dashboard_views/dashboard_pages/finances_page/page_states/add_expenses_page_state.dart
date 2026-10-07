import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class AddExpensesStatePage extends ConsumerWidget {
  const AddExpensesStatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Add  Expense ',
      introRowWidgets: [],
      scrollableDashboardWidget: ExpenseRecordForm(),
    );
  }
}
