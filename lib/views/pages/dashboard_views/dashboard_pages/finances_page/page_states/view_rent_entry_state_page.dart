import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/single_financial_record_page.dart';

class ViewRentEntryStatePage extends ConsumerWidget {
  final SingleRentEntry financialRecord;
  final String introText;
  const ViewRentEntryStatePage({
    super.key,
    required this.financialRecord,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'Rent record ',
      supplementaryText: 'rent record : ${financialRecord.rentEntryId}',
      introButton: IntroButtonWidget(),
      introRowWidgets: [],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        rentEntry: financialRecord,
        introText: introText,
      ),
    );
  }
}
