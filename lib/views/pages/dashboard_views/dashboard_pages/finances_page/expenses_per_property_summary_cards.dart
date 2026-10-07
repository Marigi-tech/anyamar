import 'package:anyamar/commons/exports.dart';

class ExpensesPerPropertySummaryCards extends ConsumerWidget {
  final List<Property> properties;
  const ExpensesPerPropertySummaryCards({super.key, required this.properties});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    final appData = ref.watch(appDataProvider);
    final expenses = appData.finances
        .where(
          (expense) => expense.recordNature == FinancialRecordNature.expense,
        )
        .toList();
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
          icon: Icons.wallet,
          title: 'No of Records ',
          value: '${expenses.length}',
          subtitle: 'Number of expense records',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.apartment,
          title: 'Properties ',
          value: '${properties.length}',
          subtitle: 'Number of properties with recorded expenses.',
          iconCardColor: AppColors.primaryBlue,
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
