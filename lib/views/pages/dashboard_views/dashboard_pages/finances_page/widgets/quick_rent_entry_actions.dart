import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_income_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/rent_per_tenant_page_state.dart';

class QuickRentEntryActions extends ConsumerWidget {
  final SingleRentEntry? rentEntry;
  final String introText;
  const QuickRentEntryActions({
    super.key,
    this.rentEntry,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGeneralPage = rentEntry == null ? true : false;
    return QuickActionsWidget(
      children: [
        if (isGeneralPage)
          //Add Rent Entry
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  AddIncomeStatePage(
                    introText: '$introText / add rental record',
                  ),
                ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'Add rental record',
                  icon: CupertinoIcons.add,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        //View Rental Income
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(workspaceProvider.notifier)
                .openForm(
                  RentPerTenantStatePage(
                    introText: '$introText / rental records per tenant',
                  ),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View rental records / tenant',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
      ],
    );
  }
}
