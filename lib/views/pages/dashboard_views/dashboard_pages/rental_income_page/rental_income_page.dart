import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_status_badge.dart';

class RentalIcomePage extends ConsumerStatefulWidget {
  const RentalIcomePage({super.key});

  @override
  ConsumerState<RentalIcomePage> createState() => _RentalIcomePageState();
}

class _RentalIcomePageState extends ConsumerState<RentalIcomePage> {
  List<SingleRentEntry> rentEntries = [];
  String tenantName = '';
  String unitName = '';
  bool isAddRentalIncomeForm = false;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);
    final tenants = appData.tenants;
    final units = appData.units;
    final rentRecords = appData.rentRecords;
    for (var record in rentRecords) {
      rentEntries.add(record.rentEntry);
    }

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

    return isAddRentalIncomeForm == true
        ? DashboardPageStructure(
            introText: 'Rent Records',
            introButton: BackButton(
              onPressed: () {
                setState(() {
                  isAddRentalIncomeForm = false;
                });
              },
            ),
            pageTitle: 'Add Rent record',
            introRowWidgets: [],
            scrollableDashboardWidget: RentalRecordForm(
              onButtonPressedCallBack: () {
                LazyLoader lazyLoader = LazyLoader(context: context);
                lazyLoader.showLoader;
                setState(() {
                  isAddRentalIncomeForm = false;
                });
                lazyLoader.hideLoader;
              },
            ),
          )
        : DashboardPageStructure(
            introText: 'Rent Records',
            pageTitle: 'Rent Records',
            supplementaryText: 'All rental transactions are handled here',
            introRowWidgets: [
              ElevatedButtonWidget(
                buttonTitle: 'Add Rental record',
                buttonIcon: Icon(Icons.add),
                onButtonPressedCallBack: () {
                  setState(() {
                    isAddRentalIncomeForm = true;
                  });
                },
              ),
            ],
            scrollableDashboardWidget: ReusableDataTableWidget<SingleRentEntry>(
              items: rentEntries,
              searchHint: 'Search ',
              columns: [
                DataColumn(label: SizedBox(width: 25, child: Text("#"))),
                DataColumn(label: Text("Tenant", style: headerStyle)),
                DataColumn(label: Text("Unit", style: headerStyle)),
                DataColumn(label: Text("Rent Month", style: headerStyle)),
                DataColumn(label: Text("Total owed", style: headerStyle)),
                DataColumn(label: Text("Amount Paid", style: headerStyle)),
                DataColumn(label: Text("Date paid", style: headerStyle)),
                DataColumn(label: Text("Status ", style: headerStyle)),
                DataColumn(label: Text("Actions", style: headerStyle)),
              ],

              // --------------------------------------------
              // SEARCH
              // --------------------------------------------
              searchMatcher: (rentEntry, query) {
                return rentEntry.rentalMonth.toLowerCase().contains(query) ||
                    tenantName.toLowerCase().contains(query) ||
                    unitName.toLowerCase().contains(query) ||
                    rentEntry.amountPaid.toString().toLowerCase().contains(
                      query,
                    ) ||
                    rentEntry.amountPayable.toString().toLowerCase().contains(
                      query,
                    );
              },

              // --------------------------------------------
              // FILTER
              // --------------------------------------------
              onFilterPressed: () {
                // Show your property filter dialog
              },

              // --------------------------------------------
              // EXPORT
              // --------------------------------------------
              onExportPressed: () {
                // Export properties
              },

              // --------------------------------------------
              // ROW
              // --------------------------------------------
              rowBuilder: (rentEntry, index) {
                //get instance of  rentRecord
                RentalRecord? rentRecord = rentRecords
                    .where(
                      (record) =>
                          record.rentEntry.rentEntryId == rentEntry.rentEntryId,
                    )
                    .singleOrNull;

                //Instance of tenant
                final tenant = tenants
                    .where(
                      (t) => t.tenantId == rentRecord?.rentHistory.tenantId,
                    )
                    .singleOrNull;
                //Instance of unit
                final unit = units
                    .where((u) => u.unitId == tenant?.unitId)
                    .singleOrNull;

                tenantName = tenant?.tenantName ?? '';
                unitName = unit?.unitName ?? '';
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
                final totalPaid = rentEntry.amountPaid;
                PaymentStatus paymentStatus;

                if (totalPaid == 0) {
                  paymentStatus = PaymentStatus.pending;
                } else if (totalPaid < totalAmountPayableMonthly) {
                  paymentStatus = PaymentStatus.partial;
                } else if (totalPaid == totalAmountPayableMonthly) {
                  paymentStatus = PaymentStatus.complete;
                } else {
                  paymentStatus = PaymentStatus.excess;
                }

                return DataRow(
                  cells: [
                    DataCell(
                      SizedBox(
                        width: 25,
                        child: Text('${number++}', style: labelStyle),
                      ),
                    ),
                    DataCell(Text(tenantName, style: labelStyle)),
                    DataCell(Text(unitName, style: labelStyle)),
                    DataCell(Text(rentEntry.rentalMonth, style: labelStyle)),
                    DataCell(
                      Text(
                        'Ksh ${formatMoney(totalAmountPayableMonthly)}',
                        style: labelStyle.copyWith(color: AppColors.red),
                      ),
                    ),
                    DataCell(
                      Text(
                        'Ksh ${formatMoney(rentEntry.amountPaid)}',
                        style: labelStyle.copyWith(color: AppColors.darkGreen),
                      ),
                    ),
                    DataCell(
                      Text(
                        formatStandardDate(rentEntry.paymentDate),
                        style: labelStyle,
                      ),
                    ),

                    //Status goes here
                    DataCell(PaymentSatusBadge(status: paymentStatus)),
                    //Actions
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'View',
                            onPressed: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => SingleUnitPage(unit: unit),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.visibility_outlined,
                              size: 18,
                              color: Color(0xff1769F5),
                            ),
                          ),

                          IconButton(
                            tooltip: 'More',
                            onPressed: () {
                              // _showPropertyMenu(context, property);
                            },
                            icon: const Icon(Icons.more_vert, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       CustomBackButton(),
    //       Expanded(
    //         child: SingleChildScrollView(
    //           padding: EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Column(
    //             children: [
    //               CustomDataTable(
    //                 customDataColumns: [...buildRentalEntryColumns()],
    //                 customDataRows: [
    //                   ...entriesWithHistory.toList().asMap().entries.map((
    //                     entry,
    //                   ) {
    //                     int index = entry.key;
    //                     SingleRentEntry rentEntry = entry.value.$1;
    //                     RentHistory rentHistory = entry.value.$2;

    //                     double? totalAmountPayableMonthly;

    //                     totalAmountPayableMonthly = rentEntry.amountPayable;

    //                     final totalPaid = rentEntry.amountPaid;

    //                     PaymentStatus paymentStatus;
    //                     if (totalPaid == 0) {
    //                       paymentStatus = PaymentStatus.notPaid;
    //                     } else if (totalPaid < totalAmountPayableMonthly) {
    //                       paymentStatus = PaymentStatus.partial;
    //                     } else if (totalPaid == totalAmountPayableMonthly) {
    //                       paymentStatus = PaymentStatus.complete;
    //                     } else {
    //                       paymentStatus = PaymentStatus.excess;
    //                     }
    //                     log(paymentStatus.label);

    //                     return buildRentalEntryDataRow(
    //                       index + 1,
    //                       rentEntry,
    //                       context,
    //                       paymentStatus,
    //                       ref,
    //                       rentHistory,
    //                     );
    //                   }),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
