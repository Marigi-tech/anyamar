import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';

class QuickExpensesActions extends ConsumerWidget {
  final FinancialRecord? expenseRecord;

  const QuickExpensesActions({super.key, this.expenseRecord});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isGeneralPage = (expenseRecord == null) ? true : false;
    return QuickActionsWidget(
      children: [
        //Update Record
        if (!isGeneralPage)
          QWidget(
            onPressedCallBack: () {
              //If financial record
              if (expenseRecord != null) {
                ref
                    .read(financesPageProvider.notifier)
                    .updateFinancialRecord(expenseRecord!);
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
        if (!isGeneralPage) CardItemSeparator(),
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
        //View properties with the expenses
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).viewExpensesPerProperty(),
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
        if (isGeneralPage) CardItemSeparator(),
        if (isGeneralPage)
          QWidget(
            onPressedCallBack: () =>
                ref.read(financesPageProvider.notifier).financesTable(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowTitleWidget(
                  text: 'View all financial records',
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
