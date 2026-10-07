import 'package:anyamar/commons/exports.dart';

class ExpensesPageSummaryCards extends ConsumerWidget {
  const ExpensesPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    final appData = ref.watch(appDataProvider);
    // final totalIncome = appData.finances
    //     .where((record) => record.recordNature != FinancialRecordNature.expense)
    //     .fold<double>(0, (sum, record) => sum + record.amountPaid);
    final totalExpense = appData.finances
        .where((record) => record.recordNature == FinancialRecordNature.expense)
        .fold<double>(0, (sum, record) => sum + record.amountPaid);
    // final occupiedUnits = appData.units.where((u) => u.isOccupied).length;
    // final vacantUnits = appData.units.where((u) => !u.isOccupied).length;
    // final occupancyRate = occupiedUnits / appData.units.length;
    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.numbers,
          title: 'Total records',
          value:
              '${appData.finances.where((e) => e.recordNature == FinancialRecordNature.expense).toList().length}',
          subtitle: 'Total expense records across all properties',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.wallet,
          title: 'Total expenses',
          value: formatMoneyWithCurrency(totalExpense, 'Ksh'),
          subtitle:
              'Total expenses incurred from maintenance of all properties',
          iconCardColor: AppColors.red,
          onPressedCallBack: () {},
          fontSize: 17,
        ),
      ],
    );
  }
}
