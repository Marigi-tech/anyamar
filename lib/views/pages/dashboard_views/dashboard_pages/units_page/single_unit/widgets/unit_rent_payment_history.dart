import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/rental_month_widget.dart';

class UnitRentPaymentHistory extends ConsumerStatefulWidget {
  final Unit unit;
  final String introText;
  const UnitRentPaymentHistory({
    super.key,
    required this.unit,
    required this.introText,
  });

  @override
  ConsumerState<UnitRentPaymentHistory> createState() =>
      _UnitRentPaymentHistoryState();
}

class _UnitRentPaymentHistoryState
    extends ConsumerState<UnitRentPaymentHistory> {
  List<RentalMonth> rentalMonths = [];
  String? unitName;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);

    //Derive rentalMonths from rentalRecords
    rentalMonths = appData.rentalRecords
        .map((record) => record.rentHistory)
        .where((history) => history.unitId == widget.unit.unitId)
        .expand((history) => history.rentalMonths)
        .toSet()
        .toList();

    String introText = widget.introText;
    final TextStyle headerStyle = CustomTextStyles.cardDescriptionStyle
        .copyWith(
          color: themeIsDark == true
              ? AppColors.whiteColor
              : AppColors.blueGreyColor,

          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.6,
          fontSize: 14,
        );
    final TextStyle labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark == true ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );
    return ReusableDataTableWidget<RentalMonth>(
      items: rentalMonths,
      cardTitle: 'Unit\'s Rent Payment Records',
      searchHint: 'Search ',
      columns: [
        DataColumn(label: SizedBox(width: 25, child: Text("#"))),
        DataColumn(label: Text("Month", style: headerStyle)),
        DataColumn(label: Text("Amount Paid", style: headerStyle)),
        DataColumn(label: Text("Number Of Payments", style: headerStyle)),
        DataColumn(label: Text("View", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (rentalMonth, query) {
        return rentalMonth.rentalMonth.toLowerCase().contains(query);
      },

      // --------------------------------------------
      // FILTER
      // --------------------------------------------
      // onFilterPressed: () {
      //   // Show your property filter dialog
      // },

      // --------------------------------------------
      // EXPORT
      // --------------------------------------------
      // onExportPressed: () {
      //   // Export properties
      // },

      // --------------------------------------------
      // ROW
      // --------------------------------------------
      rowBuilder: (rentalMonth, index) {
        List<SingleRentEntry> rentEntries = rentalMonth.rentEntries;
        //Instance of property
        final property = appData.properties
            .where((p) => p.propertyId == widget.unit.propertyId)
            .singleOrNull;
        var number = index + 1;
        final totalPaid = rentEntries.fold<double>(
          0.0,
          (sum, entry) => sum + entry.amountPaid,
        );

        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 25,
                child: Text('${number++}', style: labelStyle),
              ),
            ),

            DataCell(Text(rentalMonth.rentalMonth, style: labelStyle)),

            DataCell(
              Text(
                formatMoneyWithCurrency(totalPaid, 'Ksh'),
                style: labelStyle.copyWith(),
              ),
            ),
            DataCell(Text(rentEntries.length.toString(), style: labelStyle)),

            //Actions
            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      ref
                          .read(workspaceProvider.notifier)
                          .openForm(
                            DashboardPageStructure(
                              introText: '$introText/  month ',
                              pageTitle: rentalMonth.rentalMonth,
                              supplementaryText:
                                  ' Unit : ${widget.unit.unitName} | Property : ${property?.propertyName}',
                              introRowWidgets: [],
                              introButton: IntroButtonWidget(),
                              scrollableDashboardWidget: RentalMonthWidget(
                                rentalMonth: rentalMonth,

                                introText: '$introText/  month ',
                              ),
                            ),
                          );
                    },
                    icon: const Icon(CupertinoIcons.chevron_right, size: 18),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
