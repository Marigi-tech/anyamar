import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/expenses_per_property.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_expenses_page_state.dart';

class ExpensesPerPropertyStatePage extends ConsumerWidget {
  final String introText;
  const ExpensesPerPropertyStatePage({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: IntroButtonWidget(),
      pageTitle: 'Expenses / property',

      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add expense',
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  AddExpensesStatePage(introText: '$introText / add expense'),
                );
          },
        ),
      ],
      scrollableDashboardWidget: ExpensesPerProperty(introText: introText),
    );
  }
}
