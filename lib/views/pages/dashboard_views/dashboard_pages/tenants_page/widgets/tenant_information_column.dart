import 'package:anyamar/commons/exports.dart';

class TenantInformationColumn extends ConsumerWidget {
  final Tenant tenant;
  const TenantInformationColumn({super.key, required this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);
    Unit currentUnit = appData.units
        .where((u) => u.unitId == tenant.unitId)
        .single;
    Rent? rentObject = tenant.unitRent ?? currentUnit.unitRent;
    final double? rent = rentObject?.rentAmount;
    final double? rentDeposit = rentObject?.rentDeposit;
    final double totalPerMonth = rentObject != null
        ? rentObject.rentAmount +
              (rentObject.utilities ?? []).fold<double>(
                0,
                (sum, utility) => sum + utility.amountPayable,
              )
        : 0.0;
    final double totalUtilities = (rentObject?.utilities ?? []).fold<double>(
      0,
      (sum, utility) => sum + utility.amountPayable,
    );

    return DashboardCardWidget(
      cardTitle: 'Tenant details',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Tenant Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.info, text: 'Tenant name '),
              Text(
                tenant.tenantName,
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Tenant Phone
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: CupertinoIcons.phone, text: 'Phone'),
              Text(
                tenant.tenantPhoneNumber ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Tenant Email
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
          CardItemSeparator(),
          //National ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.creditcard,
                text: 'National ID / Passport number',
              ),
              Text(
                tenant.nationalId ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Tenant Occupation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.question_circle,
                text: 'Occupation',
              ),
              Text(
                tenant.tenantOccupation ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Rent Deposit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.attach_money, text: 'Rent deposit'),
              Text(
                formatMoneyWithCurrency(rentDeposit ?? 0.0, 'Ksh'),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Rent / Month
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.attach_money,
                text: 'Rent / ${rentObject?.paymentFrequency ?? 'Month'}',
              ),
              Text(
                formatMoneyWithCurrency(
                  rent ?? 0.0,
                  rentObject?.rentCurrency ?? 'Ksh',
                ),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Total Utilities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.attach_money,
                text: 'Total Utilities Charge',
              ),
              Text(
                formatMoneyWithCurrency(
                  totalUtilities,
                  rentObject?.rentCurrency ?? 'Ksh',
                ),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.attach_money,
                text:
                    'Total Amount / ${rentObject?.paymentFrequency ?? 'Month'}',
              ),
              Text(
                formatMoneyWithCurrency(
                  totalPerMonth,
                  rentObject?.rentCurrency ?? 'Ksh',
                ),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
