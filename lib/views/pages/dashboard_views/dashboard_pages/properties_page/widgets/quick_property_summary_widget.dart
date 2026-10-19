import 'package:anyamar/commons/exports.dart';

class QuickPropertySummaryWidget extends StatelessWidget {
  final Property property;
  final List<Unit> propertyUnits;
  final List<Tenant> propertyTenants;

  const QuickPropertySummaryWidget({
    super.key,
    required this.property,
    required this.propertyUnits,
    required this.propertyTenants,
  });

  @override
  Widget build(BuildContext context) {
    //expected rent
    double totalExpectedRent = propertyUnits
        .where((unit) => unit.isOccupied == true)
        .map((unit) => unit.unitRent)
        .fold<double>(0.0, (total, unitRent) {
          final rent = unitRent?.rentAmount ?? 0.0;

          final utilities = (unitRent?.utilities ?? []).fold<double>(
            0.0,
            (sum, utility) => sum + utility.amountPayable,
          );

          return total + rent + utilities;
        });
    return DashboardCardWidget(
      cardTitle: 'Quick summary',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.info,
                text: 'Total Units',
                iconColor: AppColors.primaryBlue,
              ),
              Text(
                propertyUnits.length.toString(),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.house,
                text: 'Occupied Units',
                iconColor: AppColors.primaryBlue,
              ),
              Text(
                propertyUnits
                    .where((u) => u.isOccupied)
                    .toList()
                    .length
                    .toString(),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.info,
                text: 'Vacant Units',
                iconColor: AppColors.primaryBlue,
              ),
              Text(
                propertyUnits
                    .where((u) => !u.isOccupied)
                    .toList()
                    .length
                    .toString(),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.people,
                text: 'Tenants',
                iconColor: AppColors.primaryBlue,
              ),
              Text(
                propertyTenants
                    .where((t) => t.endOfLease != null)
                    .toList()
                    .length
                    .toString(),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: Icons.attach_money,
                text: 'Expected Income / Month',
                iconColor: AppColors.primaryBlue,
              ),
              Text(
                formatMoneyWithCurrency(totalExpectedRent, null),
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //todo: monthly expense
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     RowTitleWidget(
          //       icon: Icons.wallet,
          //       text: 'Monthly expense',
          //       iconColor: AppColors.primaryBlue,
          //     ),
          //     Text('Ksh: ....', style: CustomTextStyles.cardDescriptionStyle),
          //   ],
          // ),
        ],
      ),
    );
  }
}
