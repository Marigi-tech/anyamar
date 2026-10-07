import 'package:anyamar/commons/exports.dart';

class FinancesPageSummaryCards extends ConsumerWidget {
  const FinancesPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;
    final appData = ref.watch(appDataProvider);
    final totalIncome = appData.finances
        .where((record) => record.recordNature != FinancialRecordNature.expense)
        .fold<double>(0, (sum, record) => sum + record.amountPaid);
    final totalExpense = appData.finances
        .where((record) => record.recordNature == FinancialRecordNature.expense)
        .fold<double>(0, (sum, record) => sum + record.amountPaid);

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
          value: '${appData.finances.length}',
          subtitle: 'Financial Records across all properties',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.attach_money,
          title: 'Total Income',
          value: formatMoneyWithCurrency(totalIncome, 'Ksh'),
          subtitle: 'Collected from rental income and deposits',
          iconCardColor: AppColors.lightGreen,
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

class SingleFinancialRecordSummaryCards extends ConsumerWidget {
  final FinancialRecord financialRecord;
  const SingleFinancialRecordSummaryCards({
    super.key,
    required this.financialRecord,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;

    final bool isExpense =
        financialRecord.recordNature == FinancialRecordNature.expense;

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.person,
          title: 'Payment By :',
          value: financialRecord.paymentBy.personName,
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.calendar_month,
          title: 'Payment Date',
          value: formatPrettyDate(financialRecord.datePaid),
          subtitle: '',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Financial Record Nature',
          value: financialRecord.recordNature.label,
          subtitle: '',
          iconCardColor: isExpense ? AppColors.red : AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 17,
        ),
      ],
    );
  }
}

class SingleRentEntrySummaryCards extends ConsumerWidget {
  final SingleRentEntry financialRecord;
  const SingleRentEntrySummaryCards({super.key, required this.financialRecord});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.person,
          title: 'Payment By :',
          value: financialRecord.tenantName ?? '',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.calendar_month,
          title: 'Payment Date',
          value: formatPrettyDate(financialRecord.paymentDate),
          subtitle: '',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          fontSize: 17,
        ),

        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Amount',
          value: financialRecord.amountPaid.toString(),
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 17,
        ),
      ],
    );
  }
}

class RentalMonthSummaryCards extends ConsumerWidget {
  final RentalMonth rentalMonth;
  const RentalMonthSummaryCards({super.key, required this.rentalMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;
    double total = rentalMonth.rentEntries.fold<double>(
      0,
      (sum, amount) => sum + amount.amountPaid,
    );

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.calendar_month,
          title: 'Month/Year:',
          value: rentalMonth.rentalMonth,
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          // fontSize: 17,
        ),

        SummaryCard(
          icon: Icons.info,
          title: 'No of records',
          value: rentalMonth.rentEntries.length.toString(),
          subtitle: '',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          // fontSize: 17,
        ),

        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Total ',
          value: formatMoneyWithCurrency(total, 'Ksh'),
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          // fontSize: 17,
        ),
      ],
    );
  }
}
