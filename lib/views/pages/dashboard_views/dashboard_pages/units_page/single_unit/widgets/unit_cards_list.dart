import 'package:anyamar/commons/exports.dart';

//===============================================
// Unit page summary cards
//===============================================
class UnitPageSummaryCards extends ConsumerWidget {
  const UnitPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int gridCount = Responsiveness.isMobile(context) ? 2 : 5;
    final appData = ref.watch(userInformationProvider);
    return PageDisplayCardsWidget(
      gridCount: gridCount,
      cards: getUnitIntroCards(appData.units),
    );
  }
}

//*=============================================
//* Single page summary cards
//*===================================================
class SingleUnitSummaryCards extends ConsumerWidget {
  final Unit unit;
  final String? tenantName;
  const SingleUnitSummaryCards({
    super.key,
    required this.unit,
    this.tenantName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int gridCount = Responsiveness.isMobile(context) ? 2 : 3;

    return PageDisplayCardsWidget(
      gridCount: gridCount,
      cards: getUnitCards(unit, tenantName, ref),
    );
  }
}

List<SummaryCard> getUnitCards(Unit unit, String? tenantName, WidgetRef ref) {
  final totalAmountPayableMonthly = ref
      .read(userInformationProvider.notifier)
      .calculateMonthlyAmountPayable(unit.unitRent);

  final utilitiesCharge = ref
      .read(userInformationProvider.notifier)
      .calculateUtilitiesCharge(unit.unitRent);

  return [
    SummaryCard(
      icon: Icons.home,
      title: 'Unit Type',
      value: '${unit.unitType?.label}',
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.purpleColor,
      fontSize: 12,
    ),

    SummaryCard(
      icon: Icons.wallet,
      title: 'Rent / ${unit.unitRent?.paymentFrequency ?? 'Month'}',
      value:
          '${unit.unitRent?.rentCurrency ?? 'Ksh'} ${formatMoney(unit.unitRent?.rentAmount as num)}',
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.amber,
      fontSize: 12,
    ),

    SummaryCard(
      icon: Icons.wallet,
      title: 'Utilites charge',
      value:
          '${unit.unitRent?.rentCurrency ?? 'Ksh'} ${formatMoney(utilitiesCharge as num)}',
      subtitle: unit.unitRent?.utilities
          ?.map((til) => til.utilityName.label)
          .join(', '),
      onPressedCallBack: () {},
      iconCardColor: AppColors.blackColor,
      fontSize: 12,
    ),

    SummaryCard(
      icon: Icons.attach_money,
      title: 'Expected Total',
      value:
          '${unit.unitRent?.rentCurrency ?? 'Ksh'} ${formatMoney(totalAmountPayableMonthly)}',
      subtitle: 'Every month',
      onPressedCallBack: () {},
      iconCardColor: AppColors.pinkColor,
      fontSize: 12,
    ),
    SummaryCard(
      icon: Icons.people_outline,
      title: 'Status',
      value: unit.isOccupied ? 'Occupied' : 'Vacant',
      subtitle: ' ${unit.isOccupied ? '$tenantName' : ''} ',
      onPressedCallBack: () {},
      iconCardColor: unit.isOccupied ? AppColors.lightGreen : AppColors.red,
      fontSize: 12,
    ),
  ];
}

double occupancyRate(List<Unit> units, List<Unit> occupiedUnits) {
  if (units.isEmpty) return 0.0;
  return occupiedUnits.length / units.length;
}

List<SummaryCard> getUnitIntroCards(List<Unit> units) {
  final totalPayable = units.where((unit) => unit.isOccupied).fold<double>(
    0.0,
    (total, unit) {
      final rent = unit.unitRent?.rentAmount ?? 0.0;

      final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
        0.0,
        (sumTotal, utility) => sumTotal + utility.amountPayable,
      );

      return total + rent + utilities;
    },
  );
  final occupiedUnits = units.where((unit) => unit.isOccupied).toList();
  final vacantUnits = units.where((unit) => !unit.isOccupied).toList();

  return [
    SummaryCard(
      icon: Icons.home,
      title: 'Units',
      value: units.length.toString(),
      subtitle: 'Across all properties',
      onPressedCallBack: () {},
      iconCardColor: AppColors.primaryBlue,
    ),
    SummaryCard(
      icon: Icons.apartment,
      title: 'Occupied Units',
      value: occupiedUnits.length.toString(),
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.lightGreen,
    ),
    SummaryCard(
      icon: Icons.apartment,
      title: 'Vacant Units',
      value: vacantUnits.length.toString(),
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.red,
    ),
    SummaryCard(
      icon: Icons.person_3,
      title: 'Occupancy %',
      value:
          '${(occupancyRate(units, occupiedUnits) * 100).toStringAsFixed(1)} % ',
      subtitle: '',

      onPressedCallBack: () {},
      iconCardColor: AppColors.info,
    ),

    SummaryCard(
      icon: Icons.attach_money,
      title: 'Expected Total',
      value: 'Ksh ${formatMoney(totalPayable)}',
      subtitle: 'Every month',
      onPressedCallBack: () {},
      iconCardColor: AppColors.pinkColor,
    ),
  ];
}
