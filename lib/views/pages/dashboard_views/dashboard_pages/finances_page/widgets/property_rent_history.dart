import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/property_rental_month.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_status_badge.dart';

class PropertyRentHistory extends ConsumerStatefulWidget {
  final Property property;
  final String introText;
  const PropertyRentHistory({
    super.key,
    required this.property,
    required this.introText,
  });

  @override
  ConsumerState<PropertyRentHistory> createState() =>
      _PropertyRentHistoryState();
}

class _PropertyRentHistoryState extends ConsumerState<PropertyRentHistory> {
  List<SingleRentEntry> rentalEntries = [];
  String? tenantName;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);
    final notifier = ref.read(userInformationProvider.notifier);

    List<RentalMonth> rentalMonths = appData.rentalRecords
        .where((record) => record.propertyId == widget.property.propertyId)
        .map((record) => record.rentalMonth)
        .toSet()
        .toList();

    String introText = widget.introText;
    final TextStyle headerStyle = CustomTextStyles.cardDescriptionStyle
        .copyWith(
          color: themeIsDark != false
              ? AppColors.whiteColor
              : AppColors.blueGreyColor,

          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.6,
          fontSize: 14,
        );
    final TextStyle labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark != false ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );
    return ReusableDataTableWidget<RentalMonth>(
      items: rentalMonths,
      cardTitle: 'Property Rent History',
      searchHint: 'Search ',
      columns: [
        DataColumn(label: SizedBox(width: 25, child: Text("#"))),

        // DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("Month", style: headerStyle)),
        // DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("Total owed", style: headerStyle)),
        DataColumn(label: Text("Total Paid", style: headerStyle)),
        DataColumn(label: Text("Payments", style: headerStyle)),
        DataColumn(label: Text("Status ", style: headerStyle)),
        DataColumn(label: Text("View", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (rentalMonth, query) {
        String? amountPaid = ref
            .read(userInformationProvider.notifier)
            .calculateMonthlyAmountPaid(rentalMonth)
            .toString();
        String? noofPayments = rentalMonth.rentEntries.length
            .toDouble()
            .toString();
        return rentalMonth.rentalMonth.toLowerCase().contains(query) ||
            amountPaid.toLowerCase().contains(query) ||
            noofPayments.toLowerCase().contains(query);
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
        rentalEntries = rentalMonth.rentEntries;
        List<Tenant> propertyTenants = appData.tenants
            .where((tenant) => tenant.propertyId == widget.property.propertyId)
            .toList();

        var number = index + 1;

        double? totalAmountPayableMonthly;
        totalAmountPayableMonthly =
            propertyTenants
                .map(
                  (tenant) =>
                      notifier.calculateMonthlyAmountPayable(tenant.unitRent),
                )
                .singleOrNull ??
            0.0;

        final totalPaid = notifier.calculateMonthlyAmountPaid(rentalMonth);
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
            DataCell(Text(rentalMonth.rentalMonth, style: labelStyle)),
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
            DataCell(Text(rentalEntries.length.toString(), style: labelStyle)),

            //Status goes here
            DataCell(PaymentSatusBadge(status: paymentStatus)),
            //Actions
            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'view',
                    onPressed: () {
                      ref
                          .read(workspaceProvider.notifier)
                          .openForm(
                            DashboardPageStructure(
                              introText: '$introText/  month ',
                              pageTitle: rentalMonth.rentalMonth,
                              supplementaryText:
                                  'Property : ${widget.property.propertyName}',
                              introRowWidgets: [
                                ElevatedButtonWidget(
                                  buttonTitle: 'Export',
                                  buttonColor: AppColors.purpleColor,
                                  onButtonPressedCallBack: () {
                                    // toDo: Generate receipt
                                  },
                                ),
                              ],
                              introButton: IntroButtonWidget(),
                              scrollableDashboardWidget:
                                  PropertyRentalMonthWidget(
                                    rentalMonth: rentalMonth,
                                    property: widget.property,
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
