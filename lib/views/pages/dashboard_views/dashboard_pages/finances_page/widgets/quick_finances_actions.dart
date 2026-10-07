import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';

class QuickFinancesActions extends ConsumerWidget {
  final FinancialRecord? financialRecord;
  final SingleRentEntry? rentEntry;
  const QuickFinancesActions({super.key, this.financialRecord, this.rentEntry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGeneralPage = (financialRecord != null || rentEntry != null)
        ? false
        : true;
    return QuickActionsWidget(
      children: [
        //Update Record
        // if (financialRecord != null || rentEntry != null)
        if (!isGeneralPage)
          QWidget(
            onPressedCallBack: () {
              //If financial record
              if (financialRecord != null) {
                ref
                    .read(financesPageProvider.notifier)
                    .updateFinancialRecord(financialRecord!);
              }
              //If rent Entry
              if (rentEntry != null) {
                ref
                    .read(financesPageProvider.notifier)
                    .updateRentEntryRecord(rentEntry!);
              }
            },
            //     // ref.read(tenantPageProvider.notifier).updateTenant(tenant!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'Update Record',
                  icon: CupertinoIcons.pencil,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (financialRecord != null || rentEntry != null) CardItemSeparator(),
        //Add Expense Record
        QWidget(
          onPressedCallBack: () =>
              ref.read(financesPageProvider.notifier).addExpenseRecord(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                text: 'Add Expense Record',
                icon: CupertinoIcons.add,
              ),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //Add Rent Entry
        QWidget(
          onPressedCallBack: () =>
              ref.read(financesPageProvider.notifier).addIncomeRecord(),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(text: 'Add Rent Entry', icon: CupertinoIcons.add),
              Icon(CupertinoIcons.chevron_right, size: 15),
            ],
          ),
        ),
        CardItemSeparator(),
        //View expense records
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).viewAllExpenses(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Expense records',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        //View rent records
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).viewAllRentalEntries(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Rent records',
                  icon: CupertinoIcons.info,
                ),
                Icon(CupertinoIcons.chevron_right, size: 15),
              ],
            ),
          ),
        if (isGeneralPage) CardItemSeparator(),
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () => ref
                .read(financesPageProvider.notifier)
                .viewExpensesPerProperty(),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View Expenses / Property',
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
