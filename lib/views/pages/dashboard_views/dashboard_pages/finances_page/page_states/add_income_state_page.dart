import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class AddIncomeStatePage extends ConsumerWidget {
  final String introText;

  const AddIncomeStatePage({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Add rental record',
      introRowWidgets: [],
      scrollableDashboardWidget: RentalRecordForm(),
    );
  }
}
