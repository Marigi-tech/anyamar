import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_income_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/back_button_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_rent_entry_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/rent_entries_summary_cards.dart';
import 'package:anyamar/tables/rent_entries_table.dart';

class ViewAllRentEntriesPageState extends ConsumerWidget {
  final String introText;
  const ViewAllRentEntriesPageState({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: introText,
      pageTitle: 'Rental Income',
      supplementaryText: 'Every rental income made from properties',
      introButton: FinancesBackButtonWidget(),
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add rental record',
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  AddIncomeStatePage(
                    introText: '$introText / add rental record',
                  ),
                );
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
                RentalEntriesTable(introText: introText),
              ],
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuickRentEntryActions(introText: introText),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
