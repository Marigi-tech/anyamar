import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/expenses_per_property.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class ExpensesPerPropertyStatePage extends ConsumerWidget {
  final String introText;
  const ExpensesPerPropertyStatePage({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Expenses / Property',
      introRowWidgets: [],
      scrollableDashboardWidget: ExpensesPerProperty(introText: introText),
    );
  }
}


