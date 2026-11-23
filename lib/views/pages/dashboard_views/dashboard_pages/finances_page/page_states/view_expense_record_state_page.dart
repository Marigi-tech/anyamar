import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/single_financial_record_page.dart';

class ViewExpenseRecordStatePage extends ConsumerWidget {
  final FinancialRecord financialRecord;
  final String introText;
  const ViewExpenseRecordStatePage({
    super.key,
    required this.financialRecord,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'Expense record ',
      supplementaryText: 'expense record : ${financialRecord.recordId}',
      introButton: IntroButtonWidget(),
      introRowWidgets: [
        
      ],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        financialRecord: financialRecord,
        introText: introText,
      ),
    );
  }
}
