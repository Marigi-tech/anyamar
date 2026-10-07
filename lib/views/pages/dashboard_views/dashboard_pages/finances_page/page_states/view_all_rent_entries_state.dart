import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_rent_entry_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/rent_entries_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/rent_entries_table.dart';

class ViewAllRentEntriesPageState extends ConsumerWidget {
  const ViewAllRentEntriesPageState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Finances',
      pageTitle: 'Rental Income',
      supplementaryText: 'Every rental income made from properties',
      introButton: FinancesBackButtonWidget(),
      introRowWidgets: [
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
                RentEntriesPageSummaryCards(),
                SizedBox(height: 15.0),
                RentalEntriesTable(),
              ],
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [QuickRentEntryActions(), SizedBox(height: 20.0)],
            ),
          ),
        ],
      ),
    );
  }
}
