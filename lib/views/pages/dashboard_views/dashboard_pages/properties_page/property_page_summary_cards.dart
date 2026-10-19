import 'package:anyamar/commons/exports.dart';

//============================================================
// MAIN PAGE SUMMARY CARDS
//============================================================

class PropertyPageSummaryCards extends ConsumerWidget {
  const PropertyPageSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridCount = Responsiveness.isMobile(context) ? 2 : 5;
    final appData = ref.watch(userInformationProvider);
    final properties = appData.properties;

    final propertyUnits = appData.units
        .where(
          (unit) => properties
              .map((property) => property.propertyId)
              .any((propertyId) => unit.propertyId == propertyId),
        )
        .toList();
    final occupiedUnits = appData.units
        .where(
          (unit) => properties
              .map((property) => property.propertyId)
              .any(
                (propertyId) =>
                    unit.propertyId == propertyId && unit.isOccupied == true,
              ),
        )
        .toList();

    final occupancyRate = occupiedUnits.length / propertyUnits.length;
    double? expectedRent = occupiedUnits.fold<double>(0.0, (total, unit) {
      final rent = unit.unitRent?.rentAmount ?? 0.0;

      final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
        0.0,
        (sum, utility) => sum + utility.amountPayable,
      );

      return total + rent + utilities;
    });
    List<RentalRecord> collectedRentRecords = appData.rentalRecords
        .where(
          (record) => propertyUnits
              .map((unit) => unit.unitId)
              .toList()
              .any(
                (unitId) =>
                    record.unitId == unitId &&
                    record.rentalMonth.rentalMonth ==
                        formatMonthAndYearName(DateTime.now()),
              ),
        )
        .toList();

    double? collectedRent = collectedRentRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.rentEntry.amountPaid,
    );

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      mainAxisSpacing: 5,
      childAspectRatio: 1.55,
      children: [
        SummaryCard(
          icon: Icons.apartment_outlined,
          title: 'Total Properties',
          value: '${properties.length}',
          subtitle: 'All properties',
          iconCardColor: AppColors.primaryBlue,
          onPressedCallBack: () {},
          // fontSize: 15,
        ),

        SummaryCard(
          icon: Icons.home_outlined,
          title: 'Total Units',
          value: '${propertyUnits.length}',
          subtitle: 'Across all properties',
          iconCardColor: AppColors.amber,
          onPressedCallBack: () {},
          fontSize: 15,
        ),

        SummaryCard(
          icon: Icons.people_outline,
          title: 'Occupied Units',
          value: '${occupiedUnits.length}',
          subtitle: '${(occupancyRate * 100).toStringAsFixed(1)}% occupancy',
          iconCardColor: AppColors.lightGreen,
          onPressedCallBack: () {},
          // fontSize: 15,
        ),

        SummaryCard(
          icon: Icons.attach_money,
          title: 'Expected Income / month',
          value: formatMoneyWithCurrency(expectedRent, 'Ksh'),
          subtitle: 'This month',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          // fontSize: 15,
        ),

        SummaryCard(
          icon: Icons.receipt_long_outlined,
          title: 'Collected Income / month',
          value: formatMoneyWithCurrency(collectedRent, 'Ksh'),
          subtitle:
              'Ksh ${(collectedRent / expectedRent * 100).toStringAsFixed(1)}% of expected',
          iconCardColor: AppColors.darkInfo,
          onPressedCallBack: () {},
          // fontSize: 15,
        ),
      ],
    );
  }
}

//============================================================
// SINGLE PROPERTY PAGE SUMMARY CARDS
//============================================================

class SinglePropertyPageSummaryCards extends ConsumerStatefulWidget {
  final Property property;
  const SinglePropertyPageSummaryCards({super.key, required this.property});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SinglePropertyPageSummaryCardsState();
}

class _SinglePropertyPageSummaryCardsState
    extends ConsumerState<SinglePropertyPageSummaryCards> {
  @override
  Widget build(BuildContext context) {
    final gridCount = Responsiveness.isMobile(context) ? 2 : 5;
    final appData = ref.watch(userInformationProvider);
    //units in the property
    final noOfUnits = appData.units
        .where((unit) => unit.propertyId == widget.property.propertyId)
        .toList();
    //tenants in the property
    final propertyTenants = appData.tenants
        .where(
          (tenant) => noOfUnits.any((unit) => unit.unitId == tenant.unitId),
        )
        .toList();
    //occupied units
    final occupiedUnits = noOfUnits.where((u) => u.isOccupied == true).toList();
    //expected rent
    double totalExpectedRent = occupiedUnits
        .map((unit) => unit.unitRent)
        .fold<double>(0.0, (total, unitRent) {
          final rent = unitRent?.rentAmount ?? 0.0;

          final utilities = (unitRent?.utilities ?? []).fold<double>(
            0.0,
            (sum, utility) => sum + utility.amountPayable,
          );

          return total + rent + utilities;
        });

    List<RentalRecord> collectedRentRecords = appData.rentalRecords
        .where(
          (record) => noOfUnits
              .map((unit) => unit.unitId)
              .toList()
              .any(
                (unitId) =>
                    record.unitId == unitId &&
                    record.rentalMonth.rentalMonth ==
                        formatMonthAndYearName(DateTime.now()),
              ),
        )
        .toList();

    double? collectedRent = collectedRentRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.rentEntry.amountPaid,
    );

    return GridView.count(
      crossAxisCount: gridCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      childAspectRatio: 1.55,
      mainAxisSpacing: 07,
      children: [
        SummaryCard(
          icon: Icons.home,
          title: 'Total units',
          value: '${noOfUnits.length}',
          subtitle: '',
          fontSize: 12,
          onPressedCallBack: () {},
          iconCardColor: AppColors.primaryBlue,
        ),
        SummaryCard(
          icon: Icons.people_outline,
          title: 'Total tenants',
          value: '${propertyTenants.length}',
          subtitle: 'active tenants ',
          onPressedCallBack: () {},
          iconCardColor: AppColors.amber,
          fontSize: 12,
        ),

        SummaryCard(
          icon: Icons.attach_money,
          title: 'Expected Income / Month',
          value: ' ${formatMoneyWithCurrency(totalExpectedRent, 'Ksh')}',
          subtitle: '',
          onPressedCallBack: () {},
          iconCardColor: AppColors.orange,
          fontSize: 12,
        ),
        SummaryCard(
          icon: Icons.attach_money,
          title: 'Collected Income/',
          value: ' ${formatMoneyWithCurrency(collectedRent, 'Ksh')}',
          subtitle:
              'collected for the month of ${formatMonthAndYearName(DateTime.now())}',
          onPressedCallBack: () {},
          iconCardColor: AppColors.lightGreen,
          fontSize: 12,
        ),
        SummaryCard(isChartWidget: OccupancyCard(property: widget.property)),
      ],
    );
  }
}
