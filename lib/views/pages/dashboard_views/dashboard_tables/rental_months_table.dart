import 'package:anyamar/commons/exports.dart';

List<DataColumn> buildRentalMonthColumns() {
  return [
    const DataColumn(
      label: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Month", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text(
        "Amount Payable",
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
    ),

    const DataColumn(
      label: Text("Amount Paid", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Balance", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    const DataColumn(
      label: Text(
        "View & Update",
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
    ),

    const DataColumn(
      label: Text("Delete", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildRentalMonthDataRow(
  int index,
  BuildContext context,
  RentHistory rentHistory,
  RentalMonth rentalMonth,
  Unit unit,
  Tenant tenant,
) {
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);
  double? totalAmountPayableMonthly;
  if (rentalMonth.unitRent != null) {
    totalAmountPayableMonthly =
        rentalMonth.unitRent!.rentAmount +
        (rentalMonth.unitRent?.utilities ?? []).fold<double>(
          0,
          (sum, utility) => sum + utility.amountPayable,
        );
  } else {
    totalAmountPayableMonthly = 0;
  }
  final totalPaid = rentalMonth.rentEntries.fold<double>(
    0,
    (sum, entry) => sum + entry.amountPaid,
  );
  bool isExcess = false;
  final balance = totalAmountPayableMonthly - totalPaid;

  final excess = totalPaid - totalAmountPayableMonthly;

  PaymentStatus paymentStatus;
  if (totalPaid == 0) {
    paymentStatus = PaymentStatus.notPaid;
  } else if (totalPaid < totalAmountPayableMonthly) {
    paymentStatus = PaymentStatus.partial;
  } else if (totalPaid == totalAmountPayableMonthly) {
    paymentStatus = PaymentStatus.complete;
  } else {
    isExcess = true;
    paymentStatus = PaymentStatus.excess;
  }
  log(paymentStatus.label);
  return DataRow(
    onLongPress: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RentalMonthForm(
          currentMonth: rentalMonth,
          rentHistory: rentHistory,
          tenant: tenant,
          unit: unit,
        ),
      ),
    ),

    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(Text(rentalMonth.rentalMonth, style: cellStyle)),
      DataCell(
        Text(
          'Ksh ${formatMoney(totalAmountPayableMonthly).toString()} ',
          style: cellStyle,
        ),
      ),
      DataCell(
        Text('Ksh ${formatMoney(totalPaid).toString()} ', style: cellStyle),
      ),
      DataCell(
        Text(
          'Ksh  ${isExcess == true ? formatMoney(excess).toString() : formatMoney(balance).toString()} ',
          style: cellStyle,
        ),
      ),
      DataCell(
        ViewChevronCard(
          onPressedCallBack: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RentalMonthForm(
                currentMonth: rentalMonth,
                rentHistory: rentHistory,
                tenant: tenant,
                unit: unit,
              ),
            ),
          ),
        ),
      ),

      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.trash,
          iconColor: AppColorsConstant.redColor,
          onPressedCallBack: () async {},
        ),
      ),
    ],
  );
}
