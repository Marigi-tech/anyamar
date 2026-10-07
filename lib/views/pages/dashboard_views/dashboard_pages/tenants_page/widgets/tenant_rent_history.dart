import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/tenant_page/tenant_page_notifier.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_status_badge.dart';

class TenantRentHistory extends ConsumerStatefulWidget {
  final Tenant tenant;
  const TenantRentHistory({super.key, required this.tenant});

  @override
  ConsumerState<TenantRentHistory> createState() => _TenantRentHistoryState();
}

class _TenantRentHistoryState extends ConsumerState<TenantRentHistory> {
  List<RentalMonth> rentalMonths = [];
  String? tenantName;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);
    final rentRecords = appData.rentRecords.where(
      (r) => r.tenantId == widget.tenant.tenantId,
    );
    for (var record in rentRecords) {
      rentalMonths.add(record.rentalMonth);
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
    return ReusableDataTableWidget<RentalMonth>(
      items: rentalMonths,
      cardTitle: 'Rent History',
      searchHint: 'Search ',
      columns: [
        DataColumn(label: SizedBox(width: 25, child: Text("#"))),

        // DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("Month", style: headerStyle)),
        DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("Total owed", style: headerStyle)),
        DataColumn(label: Text("Paid", style: headerStyle)),
        DataColumn(label: Text("Payments", style: headerStyle)),
        DataColumn(label: Text("Status ", style: headerStyle)),
        DataColumn(label: Text("Actions", style: headerStyle)),
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
        // RentalRecord? rentRecord = rentRecords
        //     .where(
        //       (record) =>
        //           record.rentalMonth.rentalMonth == rentalMonth.rentalMonth,
        //     )
        //     .singleOrNull;
        List<SingleRentEntry> rentEntries = rentalMonth.rentEntries;

        //Instance of tenant
        final tenant = widget.tenant;
        // final tenant = tenants
        //     .where((t) => t.tenantId == rentRecord?.rentHistory.tenantId)
        //     .singleOrNull;
        //Instance of unit
        final unit = appData.units
            .where((u) => u.unitId == widget.tenant.unitId)
            .singleOrNull;

        // unitName = unit?.unitName ?? '';
        var number = index + 1;

        double? totalAmountPayableMonthly;
        totalAmountPayableMonthly = tenant.unitRent != null
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
            DataCell(Text(unit?.unitName ?? '', style: labelStyle)),
            DataCell(
              Text(
                formatMoneyWithCurrency(totalAmountPayableMonthly, 'Ksh'),
                style: labelStyle.copyWith(),
              ),
            ),
            DataCell(
              Text(
                formatMoneyWithCurrency(totalPaid, 'Ksh'),
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
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      ref
                          .read(tenantPageProvider.notifier)
                          .viewRentalMonth(rentalMonth, tenant);
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
                      ref
                          .read(tenantPageProvider.notifier)
                          .viewRentalMonth(rentalMonth, tenant);
                    },

                    icon: const Icon(Icons.more_vert, size: 18),
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
