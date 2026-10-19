import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_status_badge.dart';

class FinancesPageSummaryCards extends ConsumerWidget {
  const FinancesPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 1 : 3;
    final appData = ref.watch(userInformationProvider);
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
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.person,
          title: 'Payment by :',
          value: financialRecord.paymentBy.personName,
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          fontSize: 13,
        ),

        SummaryCard(
          icon: Icons.calendar_month,
          title: 'Payment date',
          value: formatPrettyDate(financialRecord.datePaid),
          subtitle: '',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          fontSize: 13,
        ),

        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Record type',
          value: financialRecord.recordType.label,
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 13,
        ),
        SummaryCard(
          icon: Icons.wallet,
          title: 'Payment method',
          // value: financialRecord.recordNature.label,
          isWidget: true,
          value: PaymentMethodBadge(method: financialRecord.paymentMethod),
          onPressedCallBack: () {},
          fontSize: 13,
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
    final gridCount = Responsiveness.isMobile(context) ? 1 : 4;

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
          fontSize: 13,
        ),

        SummaryCard(
          icon: Icons.calendar_month,
          title: 'Payment Date',
          value: formatPrettyDate(financialRecord.paymentDate),
          subtitle: '',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          fontSize: 13,
        ),

        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Amount',
          value: formatMoneyWithCurrency(financialRecord.amountPaid, 'Ksh'),
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          fontSize: 13,
        ),
        SummaryCard(
          icon: Icons.wallet,
          title: 'Payment method',
          // value: financialRecord.recordNature.label,
          isWidget: true,
          value: PaymentMethodBadge(method: financialRecord.paymentMethod),
          onPressedCallBack: () {},
          fontSize: 13,
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
    // Grid count
    final gridCount = Responsiveness.isMobile(context) ? 2 : 5;
    // Total
    double totalPaid = rentalMonth.rentEntries.fold<double>(
      0,
      (sum, amount) => sum + amount.amountPaid,
    );
    // Expected total
    double expectedTotal = rentalMonth.map((month) {
      double? total;

      if (month.unitRent != null) {
        if (month.unitRent!.utilities != null) {
          total =
              month.unitRent!.rentAmount +
              month.unitRent!.utilities!.fold<double>(
                0,
                (sum, utility) => utility.amountPayable,
              );
        }
        if (month.unitRent?.utilities == null) {
          total = month.unitRent!.rentAmount;
        }
      } else {
        total = 0.0;
      }
      return total ?? 0.0;
    });

    //Payment Status

    PaymentStatus paymentStatus;

    if (totalPaid == 0) {
      paymentStatus = PaymentStatus.pending;
    } else if (totalPaid < expectedTotal) {
      paymentStatus = PaymentStatus.partial;
    } else if (totalPaid == expectedTotal) {
      paymentStatus = PaymentStatus.complete;
    } else if (totalPaid > expectedTotal) {
      paymentStatus = PaymentStatus.excess;
    } else {
      paymentStatus = PaymentStatus.undefined;
    }

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
          // fontSize: 14,
        ),

        SummaryCard(
          icon: Icons.info,
          title: 'No of records',
          value: rentalMonth.rentEntries.length.toString(),
          subtitle: '',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          // fontSize: 14,
        ),
        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Expected total ',
          value: formatMoneyWithCurrency(expectedTotal, 'Ksh'),
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          // fontSize: 14,
        ),

        SummaryCard(
          icon: CupertinoIcons.question,
          title: 'Total Paid ',
          value: formatMoneyWithCurrency(totalPaid, 'Ksh'),
          subtitle: '',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          // fontSize: 14,
        ),
        SummaryCard(
          icon: Icons.wallet,
          title: 'Payment Status',
          isWidget: true,
          iconCardColor: AppColors.amber,
          value: PaymentSatusBadge(status: paymentStatus),
          onPressedCallBack: () {},
        ),
      ],
    );
  }
}
