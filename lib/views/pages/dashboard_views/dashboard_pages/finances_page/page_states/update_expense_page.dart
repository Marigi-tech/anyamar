import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/single_financial_record_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class UpdateExpenseRecord extends ConsumerWidget {
  final String introText;
  final FinancialRecord financialRecord;
  const UpdateExpenseRecord({
    super.key,
    required this.financialRecord,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Update financial record',
      supplementaryText: 'financial record : ${financialRecord.recordId}',
      introRowWidgets: [],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        financialRecord: financialRecord,
        introText: introText,
      ),
    );
  }
}

class UpdateRentEntry extends ConsumerWidget {
  final SingleRentEntry rentEntry;
  final String introText;
  const UpdateRentEntry({
    super.key,
    required this.rentEntry,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      introButton: IntroButtonWidget(),
      pageTitle: 'Update  ${rentEntry.rentEntryId}',
      introRowWidgets: [],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        rentEntry: rentEntry,
        introText: introText,
      ),
    );
  }
}
