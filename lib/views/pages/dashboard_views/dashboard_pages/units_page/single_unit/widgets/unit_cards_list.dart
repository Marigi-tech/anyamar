import 'package:anyamar/commons/exports.dart';

Widget buildUnitSummaryCards(Unit unit, int gridCount, String? tenantName) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: getUnitCards(unit, tenantName).length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: gridCount,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      mainAxisExtent: 105,
    ),
    itemBuilder: (context, index) {
      return getUnitCards(unit, tenantName)[index];
    },
  );
}

List<SummaryCard> getUnitCards(Unit unit, String? tenantName) {
  final totalAmountPayableMonthly =
      unit.unitRent!.rentAmount +
      (unit.unitRent?.utilities ?? []).fold<double>(
        0,
        (sum, utility) => sum + utility.amountPayable,
      );

  return [
    SummaryCard(
      icon: Icons.home,
      title: 'Unit Type',
      value: '${unit.unitType?.label}',
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.primaryBlue,
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
      icon: Icons.people_outline,
      title: 'Status',
      value: unit.isOccupied ? 'Occupied' : 'Vacant',
      subtitle: ' ${unit.isOccupied ? '$tenantName' : ''} ',
      onPressedCallBack: () {},
      iconCardColor: unit.isOccupied ? AppColors.lightGreen : AppColors.red,
      fontSize: 12,
    ),

    SummaryCard(
      icon: Icons.attach_money,
      title: 'Expected Total',
      value:
          '${unit.unitRent?.rentCurrency ?? 'Ksh'} ${formatMoney(totalAmountPayableMonthly)}',
      subtitle: 'Every month',
      onPressedCallBack: () {},
      iconCardColor: AppColors.info,
      fontSize: 12,
    ),
  ];
}

Widget buildUnitntroSummaryCards(List<Unit> units, int gridCount) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: getUnitIntroCards(units).length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: gridCount,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      mainAxisExtent: 105,
    ),
    itemBuilder: (context, index) {
      return getUnitIntroCards(units)[index];
    },
  );
}

double occupancyRate(List<Unit> units, List<Unit> occupiedUnits) {
  if (units.isEmpty) return 0.0;
  return occupiedUnits.length / units.length;
}

List<SummaryCard> getUnitIntroCards(List<Unit> units) {
  final totalPayable = units.fold<double>(0.0, (total, unit) {
    final rent = unit.unitRent?.rentAmount ?? 0.0;

    final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
      0.0,
      (sumTotal, utility) => sumTotal + utility.amountPayable,
    );

    return total + rent + utilities;
  });
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
      iconCardColor: AppColors.info,
    ),
  ];
}
