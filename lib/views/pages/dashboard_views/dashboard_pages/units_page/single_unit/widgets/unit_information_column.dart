import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/reusable_widgets/cards/card_row_title_widget.dart';

class UnitInformationColumn extends ConsumerWidget {
  final Unit unit;
  const UnitInformationColumn({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAmountPayableMonthly =
        unit.unitRent!.rentAmount +
        (unit.unitRent?.utilities ?? []).fold<double>(
          0,
          (sum, utility) => sum + utility.amountPayable,
        );
    double? totalUtilitiesCharge = unit.unitRent?.utilities?.fold<double>(
      0,
      (sum, utility) => sum + utility.amountPayable,
    );
    //Get tenant in unit
    Tenant? unitTenant = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((t) => t.tenantId == unit.tenantId)
        .singleOrNull;
    Property? unitProperty = ref
        .watch(userInformationProvider.select((state) => state.properties))
        .where((p) => p.propertyId == unit.propertyId)
        .singleOrNull;

    return DashboardCardWidget(
      cardTitle: 'Unit details',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.info,
                text: 'Unit name/ code',
              ),
              Text(unit.unitName, style: CustomTextStyles.cardDescriptionStyle),
            ],
          ),
          CardItemSeparator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.apartment, text: 'Unit type'),
              Text(
                unit.unitType?.label ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Property
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.home, text: 'Property'),
              Text(
                unitProperty?.propertyName ?? '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),

          CardItemSeparator(),

          // Current Tenant Information
          unitTenant != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RowTitleWidget(
                      icon: CupertinoIcons.person,
                      text: 'Current Tenant',
                    ),

                    Text(
                      unitTenant.tenantName,
                      style: CustomTextStyles.cardDescriptionStyle,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // If there is no tenant display vacancy badge
                  children: [
                    RowTitleWidget(icon: CupertinoIcons.person, text: 'Status'),
                    UnitVacancyBadge(isOccupied: unit.isOccupied),
                  ],
                ),
          CardItemSeparator(),
          //Rent Deposit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.money_dollar,
                text: 'Rent Deposit ',
              ),
              Text(
                unit.unitRent?.rentDeposit != null
                    ? unit.unitRent?.rentCurrency != null
                          ? '${unit.unitRent?.rentCurrency} ${formatMoney(unit.unitRent!.rentDeposit!)}'
                          : 'Ksh ${formatMoney(unit.unitRent!.rentDeposit!)} '
                    : '0.0',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Rent
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.money_dollar,
                text: 'Rent / ${unit.unitRent?.paymentFrequency ?? 'Month'} ',
              ),
              Text(
                unit.unitRent?.rentAmount != null
                    ? unit.unitRent?.rentCurrency != null
                          ? '${unit.unitRent?.rentCurrency}   ${formatMoney(unit.unitRent!.rentAmount)} '
                          : ' Ksh ${formatMoney(unit.unitRent!.rentAmount)}'
                    : '0.0',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Utilities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.money_dollar,
                text:
                    'Utilities / ${unit.unitRent?.paymentFrequency ?? 'Month'} ',
              ),
              Text(
                totalUtilitiesCharge != null
                    ? unit.unitRent?.rentCurrency != null
                          ? '${unit.unitRent?.rentCurrency}   ${formatMoney(totalUtilitiesCharge)} '
                          : ' Ksh ${formatMoney(totalUtilitiesCharge)}'
                    : '0.0',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Total amount payable
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(
                icon: CupertinoIcons.question,
                text: 'Total / ${unit.unitRent?.paymentFrequency ?? 'Month'}',
              ),

              Text(
                '${unit.unitRent?.rentCurrency ?? 'Ksh'} ${formatMoney(totalAmountPayableMonthly)}',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),
          //Last updated
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowTitleWidget(icon: Icons.calendar_month, text: 'Last updated'),
              Text(
                unit.lastUpdateDate != null
                    ? formatStandardDate(unit.lastUpdateDate!)
                    : '',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
            ],
          ),
          CardItemSeparator(),

          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
