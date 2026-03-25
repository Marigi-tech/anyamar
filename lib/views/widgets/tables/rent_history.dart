import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/models/enums/payment_status_enum.dart';
import 'package:test_app/data/models/single_rental_entry_model.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/rent_entry_modal.dart';
import 'package:test_app/views/widgets/information_badges/information_badge_widget.dart';
import 'package:test_app/views/widgets/tables/view_chevron_card.dart';

TableRow buildRentHistoryHeaderRow() {
  return TableRow(
    children: [
      //?Index
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("", style: TextStyle(fontWeight: FontWeight.normal)),
      ),
      //?Rental month
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Month", style: TextStyle(fontWeight: FontWeight.normal)),
      ),

      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      //   child: Text(
      //     "Date Paid",
      //     style: TextStyle(fontWeight: FontWeight.normal),
      //   ),
      // ),
      //? Amount Paid
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          "Amount Paid (Ksh)",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      //? Status
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Status", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      //? View
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      //   child: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
      // ),
    ],
  );
}

TableRow buildRentHistoryDataRow(
  SingleRentEntry rentEntry,
  int index,
  BuildContext context,
  PaymentStatus paymentStatus,
) {
  return TableRow(
    children: [
      //? Index
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          '$index',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // ? Rental Month
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          rentEntry.rentalMonth,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      //   child: Text(
      //     formatStandardDate(rentEntry.paymentDate),
      //     style: TextStyle(color: AppColorsConstant.blueGreyColor),
      //   ),
      // ),
      //? Amount paid
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          'Ksh : ${rentEntry.amountPaid}',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      //? Status
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: InformationBadge(
          text: paymentStatus.label,
          textColor: getPaymentStatus(paymentStatus).textColor,
          badgeColor: getPaymentStatus(paymentStatus).badgeColor,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: ViewChevronCard(
          onPressedCallBack: () {
            // open modal
            showDialog(
              context: context,
              builder: (context) => RentEntryModal(rentEntry: rentEntry),
            );
          },

          //todo: button logic
        ),
      ),
    ],
  );
}

class RentHistoryTable extends StatelessWidget {
  final List<SingleRentEntry> rentEntries;
  const RentHistoryTable({super.key, required this.rentEntries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Table(
        border: TableBorder.symmetric(
          outside: BorderSide.none,
          inside: BorderSide(
            color: AppColorsConstant.blueGreyColor,
            width: 0.09,
          ),
        ),
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(1),
          // 0: IntrinsicColumnWidth(),
          // 1: IntrinsicColumnWidth(),
          // 2: IntrinsicColumnWidth(),
          // 3: IntrinsicColumnWidth(),
          // 4: IntrinsicColumnWidth(),
          // 5: FlexColumnWidth(4),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row
          buildRentHistoryHeaderRow(),

          ...rentEntries.toList().asMap().entries.map((entry) {
            int index = entry.key; // 0, 1, 2, ...
            SingleRentEntry rentEntry = entry.value;
            PaymentStatus paymentStatus =
                rentEntry.amountPayable - rentEntry.amountPaid == 0
                ? PaymentStatus.complete
                : rentEntry.amountPayable - rentEntry.amountPaid != 0
                ? PaymentStatus.partial
                : PaymentStatus.notPaid;
            return buildRentHistoryDataRow(
              rentEntry,
              index + 1,
              context,
              paymentStatus,
            );
          }),
        ],
      ),
    );
  }
}
