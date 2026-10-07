import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/single_financial_record_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';

class ViewRentEntryStatePage extends ConsumerWidget {
  final SingleRentEntry financialRecord;
  const ViewRentEntryStatePage({super.key, required this.financialRecord});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      pageTitle: 'View Record ${financialRecord.rentEntryId}',
      introButton: FinancesBackButtonWidget(),
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Update Record',
          buttonIcon: const Icon(CupertinoIcons.pencil),
          onButtonPressedCallBack: () {
            ref
                .read(financesPageProvider.notifier)
                .updateRentEntryRecord(financialRecord);
          },
        ),
      ],
      scrollableDashboardWidget: SingleFinancialRecordPage(
        rentEntry: financialRecord,
      ),
    );
  }
}
