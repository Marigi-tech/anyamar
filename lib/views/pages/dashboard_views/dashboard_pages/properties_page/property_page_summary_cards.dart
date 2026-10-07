import 'package:anyamar/commons/exports.dart';

class PropertyCardsInfo {
  final int propertiesNo;
  final int unitsNo;
  final int occupiedUnitsNo;
  final double occupancyRate;
  final double expectedRent;
  final double collectedRent;
  final int gridCount;

  const PropertyCardsInfo({
    required this.propertiesNo,
    required this.unitsNo,
    required this.occupiedUnitsNo,
    required this.occupancyRate,
    required this.expectedRent,
    required this.collectedRent,
    required this.gridCount,
  });
}

PropertyCardsInfo getPropertyCardsInfo(
  List<Property> properties,
  List<Unit> propertyUnits,
  List<Tenant> propertyTenants,
  int gridCount,
) {
  final units = propertyUnits;

  final unitsNo = units.length;

  final occupiedUnitsNo = units.where((unit) => unit.isOccupied == true).length;

  final occupancyRate = unitsNo == 0 ? 0.0 : (occupiedUnitsNo / unitsNo) * 100;

  final expectedRent = units.fold<double>(0.0, (total, unit) {
    final rent = unit.unitRent?.rentAmount ?? 0.0;

    final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
      0.0,
      (sum, utility) => sum + utility.amountPayable,
    );

    return total + rent + utilities;
  });
  //   double  collectedRent {
  //   double totalCollected = 0;

  //   for (final tenant in tenants) {
  //     final appDataPro = ref.watch(appDataProvider);
  //     RentalRecord? tenantRentRecord = appDataPro.rentRecords
  //         .where((record) => record.rentHistory.tenantId == tenant.tenantId)
  //         .singleOrNull;
  //     if (tenantRentRecord == null) continue;

  //     for (final month in tenantRentRecord.rentHistory.rentalMonths) {
  //       final monthTotalPaid = month.rentEntries.fold<double>(
  //         0,
  //         (sum, entry) => sum + entry.amountPaid,
  //       );

  //       totalCollected += monthTotalPaid;
  //     }
  //   }

  //   return totalCollected;
  // }



  return PropertyCardsInfo(
    propertiesNo: properties.length,
    unitsNo: unitsNo,
    occupiedUnitsNo: occupiedUnitsNo,
    occupancyRate: occupancyRate,
    expectedRent: expectedRent,
    collectedRent: 0.0, // calculate this from rent history
    gridCount: gridCount,
  );
}

Widget buildPropertyPageSummaryCards(PropertyCardsInfo info) {
  final occupancyRate = info.occupancyRate;
  return GridView.count(
    crossAxisCount: info.gridCount,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 14,
    childAspectRatio: 1.55,
    children: [
      SummaryCard(
        icon: Icons.apartment_outlined,
        title: 'Total Properties',
        value: '${info.propertiesNo}',
        subtitle: 'All properties',
        iconCardColor: AppColors.primaryBlue,
        onPressedCallBack: () {},
        // fontSize: 15,
      ),

      SummaryCard(
        icon: Icons.home_outlined,
        title: 'Total Units',
        value: '${info.unitsNo}',
        subtitle: 'Across all properties',
        iconCardColor: AppColors.amber,
        onPressedCallBack: () {},
        fontSize: 15,
      ),

      SummaryCard(
        icon: Icons.people_outline,
        title: 'Occupied Units',
        value: '${info.occupiedUnitsNo}',
        subtitle: '${(occupancyRate * 100).toStringAsFixed(1)}% occupancy',
        iconCardColor: AppColors.lightGreen,
        onPressedCallBack: () {},
        // fontSize: 15,
      ),

      SummaryCard(
        icon: Icons.attach_money,
        title: 'Expected Income / month',
        value: formatMoney(info.expectedRent),
        subtitle: 'This month',
        iconCardColor: AppColors.orange,
        onPressedCallBack: () {},
        // fontSize: 15,
      ),

      SummaryCard(
        icon: Icons.receipt_long_outlined,
        title: 'Collected Income / month',
        value: formatMoney(info.collectedRent),
        subtitle:
            'Ksh ${(info.collectedRent / info.expectedRent * 100).toStringAsFixed(1)}% of expected',
        iconCardColor: AppColors.darkInfo,
        onPressedCallBack: () {},
        // fontSize: 15,
      ),
    ],
  );
}

//Single page

Widget buildSinglePropertySummaryCards(
  Property property,
  int gridCount,
  double noOfTenants,
  double noOfUnits,
  double noOfoccupiedUnits,
  double monthlyRent,
) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: getPropertyCards(
      property,
      noOfTenants,
      noOfUnits,
      noOfoccupiedUnits,
      monthlyRent,
    ).length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: gridCount,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      mainAxisExtent: 105,
    ),
    itemBuilder: (context, index) {
      return getPropertyCards(
        property,
        noOfTenants,
        noOfUnits,
        noOfoccupiedUnits,
        monthlyRent,
      )[index];
    },
  );
}

List<SummaryCard> getPropertyCards(
  property,
  noOfTenants,
  noOfUnits,
  noOfoccupiedUnits,
  monthlyRent,
) {
  return [
    SummaryCard(
      icon: Icons.home,
      title: 'Total units',
      value: '$noOfUnits',
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.primaryBlue,
    ),
    SummaryCard(
      icon: Icons.people_outline,
      title: 'Total tenants',
      value: '$noOfTenants',
      subtitle: 'active tenants ',
      onPressedCallBack: () {},
      iconCardColor: AppColors.amber,
    ),

    SummaryCard(
      icon: Icons.attach_money,
      title: 'Expected Income / Month',
      value: 'Ksh ${formatMoney(monthlyRent as num)}',
      subtitle: '',
      onPressedCallBack: () {},
      iconCardColor: AppColors.orange,
    ),
    SummaryCard(isChartWidget: OccupancyCard(property: property)),
  ];
}
