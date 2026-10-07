import 'package:anyamar/commons/exports.dart';

class RentalMonthBreakdownColumn extends ConsumerWidget {
  final RentalMonth rentalMonth;
  final Tenant tenant;
  const RentalMonthBreakdownColumn({
    super.key,
    required this.rentalMonth,
    required this.tenant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double expectedTotal =
        rentalMonth.unitRent?.rentAmount ??
        0 +
            (rentalMonth.unitRent?.utilities ?? []).fold<double>(
              0,
              (sum, utility) => sum + utility.amountPayable,
            );
    final actualTotal = rentalMonth.rentEntries.fold<double>(
      0,
      (sum, entry) => entry.amountPaid,
    );
    double balance = expectedTotal - actualTotal;
    double excess = actualTotal - expectedTotal;

    return DashboardCardWidget(
      cardTitle: 'Rent breakdown ',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.calendar, text: 'Month/Year'),
              Text(
                rentalMonth.rentalMonth,
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Expected Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.wallet, text: 'Expected total'),
              Text(
                formatMoneyWithCurrency(expectedTotal, 'Ksh'),

                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Actual total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.wallet, text: 'Amount paid'),
              Text(
                formatMoneyWithCurrency(actualTotal, 'Ksh'),

                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),

          //Balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.wallet,
                text: actualTotal > expectedTotal ? 'Excess' : 'Balance',
              ),
              Text(
                formatMoneyWithCurrency(
                  actualTotal > expectedTotal ? excess : balance,
                  'Ksh',
                ),

                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
        ],
      ),
    );
  }
}

//----------------------------------------------------------------------------
// Tenant Info
//------------------------------------------------------------------------------

class RentalMonthTenantInfoColumn extends ConsumerWidget {

  final Tenant tenant;
  const RentalMonthTenantInfoColumn({
    super.key,
  
    required this.tenant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return DashboardCardWidget(
      cardTitle: 'Tenant',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.person, text: 'Tenant'),
              Text(
                tenant.tenantName,
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Phone number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.phone, text: 'Phone number'),
              Text(
                tenant.tenantPhoneNumber.toString(),

                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Email
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.envelope, text: 'Email'),
              Text(
                tenant.tenantEmail ?? '',

                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
      
        ],
      ),
    );
  }
}
