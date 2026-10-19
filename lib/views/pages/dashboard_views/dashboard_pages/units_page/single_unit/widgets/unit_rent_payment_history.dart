import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/rental_month_widget.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_status_badge.dart';

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
  String? tenantName;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);
    final tenants = appData.tenants
        .where((t) => t.unitId == widget.unit.unitId)
        .toList();
    final units = appData.units;
    final rentRecords = appData.rentalRecords.where(
      (r) => r.unitId == widget.unit.unitId,
    );
    for (var record in rentRecords) {
      rentalMonths.add(record.rentalMonth);
    }
    final String introText = widget.introText;
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
      cardTitle: 'Rent History',
      searchHint: 'Search ',
      columns: [
        DataColumn(label: SizedBox(width: 25, child: Text("#"))),

        // DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("Month", style: headerStyle)),
        DataColumn(label: Text("Tenant", style: headerStyle)),
        DataColumn(label: Text("Total owed", style: headerStyle)),
        DataColumn(label: Text("Paid", style: headerStyle)),
        DataColumn(label: Text("Payments", style: headerStyle)),
        DataColumn(label: Text("Status ", style: headerStyle)),
        DataColumn(label: Text("View", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      // searchMatcher: (rentEntry, query) {
      //   return rentEntry.rentalMonth.toLowerCase().contains(query) ||
      //       tenantName.toLowerCase().contains(query) ||
      //       unitName.toLowerCase().contains(query) ||
      //       rentEntry.amountPaid.toString().toLowerCase().contains(query) ||
      //       rentEntry.amountPayable.toString().toLowerCase().contains(query);
      // },

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
        //get instance of  rentRecord
        RentalRecord? rentRecord = rentRecords
            .where(
              (record) =>
                  record.rentalMonth.rentalMonth == rentalMonth.rentalMonth,
            )
            .singleOrNull;
        List<SingleRentEntry> rentEntries = rentalMonth.rentEntries;

        //Instance of tenant
        final tenant = tenants
            .where((t) => t.tenantId == rentRecord?.rentHistory.tenantId)
            .singleOrNull;
        //Instance of unit
        final unit = units
            .where((u) => u.unitId == tenant?.unitId)
            .singleOrNull;
        //instance of property
        final property = appData.properties
            .where((p) => p.propertyId == unit?.propertyId)
            .singleOrNull;

        tenantName = tenant?.tenantName ?? '';
        // unitName = unit?.unitName ?? '';
        var number = index + 1;

        double? totalAmountPayableMonthly;
        totalAmountPayableMonthly = tenant != null
            ? tenant.unitRent != null
                  ? tenant.unitRent!.rentAmount +
                        (tenant.unitRent?.utilities ?? []).fold<double>(
                          0,
                          (sum, utility) => sum + utility.amountPayable,
                        )
                  : unit?.unitRent != null
                  ? unit!.unitRent!.rentAmount +
                        (unit.unitRent?.utilities ?? []).fold<double>(
                          0,
                          (sum, utility) => sum + utility.amountPayable,
                        )
                  : 0.0
            : 0.0;
        // totalAmountPayableMonthly = rentEntry.amountPayable;
        final totalPaid = rentEntries.fold<double>(
          0.0,
          (sum, entry) => sum + entry.amountPaid,
        );
        PaymentStatus paymentStatus;

        if (totalPaid < totalAmountPayableMonthly) {
          paymentStatus = PaymentStatus.partial;
        } else if (totalPaid == totalAmountPayableMonthly) {
          paymentStatus = PaymentStatus.complete;
        } else if (totalPaid > totalAmountPayableMonthly) {
          paymentStatus = PaymentStatus.excess;
        } else {
          paymentStatus = PaymentStatus.pending;
        }

        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 25,
                child: Text('${number++}', style: labelStyle),
              ),
            ),

            // DataCell(Text(unitName, style: labelStyle)),
            DataCell(Text(rentalMonth.rentalMonth, style: labelStyle)),
            DataCell(Text(tenantName ?? '', style: labelStyle)),
            DataCell(
              Text(
                'Ksh ${formatMoney(totalAmountPayableMonthly)}',
                style: labelStyle.copyWith(),
              ),
            ),
            DataCell(
              Text(
                'Ksh ${formatMoney(totalPaid)}',
                style: labelStyle.copyWith(),
              ),
            ),
            DataCell(Text(rentEntries.length.toString(), style: labelStyle)),

            //Status goes here
            DataCell(PaymentSatusBadge(status: paymentStatus)),
            //Actions
            DataCell(
              Row(
                children: [
                  // IconButton(
                  //   tooltip: 'View',
                  //   onPressed: () {
                  //     // Navigator.of(context).push(
                  //     //   MaterialPageRoute(
                  //     //     builder: (_) => SingleUnitPage(unit: unit),
                  //     //   ),
                  //     // );
                  //   },
                  //   icon: const Icon(
                  //     CupertinoIcons.chevron_right,
                  //     size: 18,
                  //     color: Color(0xff1769F5),
                  //   ),
                  // ),
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      ref
                          .read(workspaceProvider.notifier)
                          .openForm(
                            DashboardPageStructure(
                              introText: '$introText / month',
                              introRowWidgets: [],
                              pageTitle: rentalMonth.rentalMonth,
                              supplementaryText:
                                  '${tenant?.tenantName} |${unit?.unitName} | ${property?.propertyName}',
                              introButton: IntroButtonWidget(),
                              scrollableDashboardWidget: RentalMonthWidget(
                                rentalMonth: rentalMonth,
                                tenant: tenant!,
                                unit: unit,
                                introText: '$introText / month',
                              ),
                            ),
                          );
                      // _showPropertyMenu(context, property);
                    },
                    icon: const Icon(Icons.chevron_right, size: 18),
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
