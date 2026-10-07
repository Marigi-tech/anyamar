import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/single_financial_record_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class UpdateExpenseRecord extends ConsumerWidget {
  final FinancialRecord financialRecord;
  const UpdateExpenseRecord({super.key, required this.financialRecord});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      introButton: FinancesBackButtonWidget(),
      pageTitle: 'Update  ${financialRecord.recordId}',
      introRowWidgets: [],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        financialRecord: financialRecord,
      ),
    );
  }
}

class UpdateRentEntry extends ConsumerWidget {
  final SingleRentEntry rentEntry;
  const UpdateRentEntry({super.key, required this.rentEntry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      introButton: IntroButtonWidget(
        buttonText: 'Back ',
        onPressedCallBack: () {
          ref.read(financesPageProvider.notifier).goBack();
        },
      ),
      pageTitle: 'Update  ${rentEntry.rentEntryId}',
      introRowWidgets: [],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        rentEntry: rentEntry,
      ),
    );
  }
}
