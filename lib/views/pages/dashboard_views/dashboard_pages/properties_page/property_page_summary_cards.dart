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
    List<RentalRecord> collectedRecords = appData.rentalRecords;

    // List<RentalRecord> collectedRentRecords = appData.rentalRecords
    //     .where(
    //       (record) => propertyUnits
    //           .map((unit) => unit.unitId)
    //           .toList()
    //           .any(
    //             (unitId) =>
    //                 record.unitId == unitId &&
    //                 record.rentalMonth.rentalMonth ==
    //                     formatMonthAndYearName(DateTime.now()),
    //           ),
    //     )
    //     .toList();

    double? collectedRent = collectedRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.rentEntry.amountPaid,
    );

    return PageDisplayCardsWidget(
      gridCount: gridCount,
      cards: [
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
          subtitle: 'every month',
          iconCardColor: AppColors.orange,
          onPressedCallBack: () {},
          // fontSize: 15,
        ),

        SummaryCard(
          icon: Icons.receipt_long_outlined,
          title: 'Collected Income ',
          value: formatMoneyWithCurrency(collectedRent, 'Ksh'),
          subtitle: 'so far',
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
  final bool isFromExpenses;
  final bool? isFromPropertyRentRecords;
  const SinglePropertyPageSummaryCards({
    super.key,
    required this.property,
    required this.isFromExpenses,
    this.isFromPropertyRentRecords,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SinglePropertyPageSummaryCardsState();
}

class _SinglePropertyPageSummaryCardsState
    extends ConsumerState<SinglePropertyPageSummaryCards> {
  @override
  Widget build(BuildContext context) {
    final gridCount = Responsiveness.isMobile(context)
        ? 2
        : widget.isFromExpenses
        ? 4
        : 3;
    final appData = ref.watch(userInformationProvider);
    //expenses
    List<FinancialRecord> expenses = appData.finances
        .where(
          (record) =>
              record.recordNature == FinancialRecordNature.expense &&
              record.propertyId == widget.property.propertyId,
        )
        .toList();
    //units in the property
    final noOfUnits = appData.units
        .where((unit) => unit.propertyId == widget.property.propertyId)
        .toList();
    //tenants in the property
    final propertyTenants = appData.tenants
        .where(
          (tenant) => noOfUnits.any(
            (unit) => unit.unitId == tenant.unitId && tenant.isActive == true,
          ),
        )
        .toList();
    //occupied units
    // final occupiedUnits = noOfUnits.where((u) => u.isOccupied == true).toList();
    //tenants in the units
    final
    //expected rent
    double
    totalExpectedRent = propertyTenants
        .map((tenant) => tenant.unitRent)
        .fold<double>(0.0, (total, unitRent) {
          final rent = unitRent?.rentAmount ?? 0.0;

          final utilities = (unitRent?.utilities ?? []).fold<double>(
            0.0,
            (sum, utility) => sum + utility.amountPayable,
          );

          return total + rent + utilities;
        });

    List<RentalRecord> collectedRentRecords =
        // widget.isFromPropertyRentRecords == true || widget.isFromExpenses
        // ?
        appData.rentalRecords
            .where((record) => record.propertyId == widget.property.propertyId)
            .toList();
    // : appData.rentalRecords
    //       .where(
    //         (record) => noOfUnits
    //             .map((unit) => unit.unitId)
    //             .toList()
    //             .any(
    //               (unitId) =>
    //                   record.unitId == unitId &&
    //                   record.rentalMonth.rentalMonth ==
    //                       formatMonthAndYearName(DateTime.now()),
    //             ),
    //       )
    //       .toList();

    double? collectedRent = collectedRentRecords.fold<double>(
      0.0,
      (sum, record) => sum + record.rentEntry.amountPaid,
    );
    log(
      'Collected Rental records: $collectedRentRecords \n collected rent : $collectedRent',
    );
    double? totalExpenses = ref
        .read(userInformationProvider.notifier)
        .calculateTotalExpenses(expenses);

    return PageDisplayCardsWidget(
      gridCount: gridCount,
      cards: [
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
          title: 'Collected Income ',
          value: ' ${formatMoneyWithCurrency(collectedRent, 'Ksh')}',
          subtitle:
              // widget.isFromExpenses || widget.isFromPropertyRentRecords == true
              // ?
              'Collected for this property',
          // : 'Month of ${formatMonthAndYearName(DateTime.now())}',
          onPressedCallBack: () {},
          iconCardColor: AppColors.lightGreen,
          fontSize: 12,
        ),
        SummaryCard(
          icon: Icons.attach_money,
          title: 'Total expenses ',
          value: ' ${formatMoneyWithCurrency(totalExpenses, 'Ksh')}',
          subtitle: 'total expenses incurred in the property',
          onPressedCallBack: () {},
          iconCardColor: AppColors.purpleColor,
          fontSize: 12,
        ),
        SummaryCard(isChartWidget: OccupancyCard(property: widget.property)),
      ],
    );
  }
}
