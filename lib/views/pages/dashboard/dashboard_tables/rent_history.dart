import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/enums/payment_status_enum.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/views/pages/information_pages/rent_entry_modal.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/view_chevron_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<DataColumn> buildColumns() {
  return [
    const DataColumn(
      label: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Month", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Amount", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    const DataColumn(
      label: Text("Balance", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Status", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    const DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildDataRow(
  int index,
  SingleRentEntry rentEntry,
  BuildContext context,
  PaymentStatus paymentStatus,
) {
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);
  final balance = rentEntry.amountPayable - rentEntry.amountPaid;

  return DataRow(
    onLongPress: () => showDialog(
      context: context,
      builder: (context) => RentEntryModal(rentEntry: rentEntry),
    ),
    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(Text(rentEntry.rentalMonth, style: cellStyle)),
      DataCell(Text('Ksh ${rentEntry.amountPaid} ', style: cellStyle)),
      DataCell(Text('Ksh $balance', style: cellStyle)),
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 150, maxHeight: 30),
          child: InformationBadge(
            text: paymentStatus.label,
            textColor: getPaymentStatus(paymentStatus).textColor,
            badgeColor: getPaymentStatus(paymentStatus).badgeColor,
          ),
        ),
      ),

      DataCell(
        ViewChevronCard(
          onPressedCallBack: () => showDialog(
            context: context,
            builder: (context) => RentEntryModal(rentEntry: rentEntry),
          ),
        ),
      ),
    ],
  );
}

// 3. Updated Main Widget
class RentHistoryTable extends ConsumerWidget {
  final List<SingleRentEntry> rentEntries;
  const RentHistoryTable({super.key, required this.rentEntries});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomDataTable(
      customDataColumns: [...buildColumns()],
      customDataRows: [
        ...rentEntries.asMap().entries.map((entry) {
          int index = entry.key;
          SingleRentEntry rentEntry = entry.value;
          double balance = rentEntry.amountPayable - rentEntry.amountPaid;

          PaymentStatus paymentStatus = balance == 0
              ? PaymentStatus.complete
              : rentEntry.amountPaid != 0 && balance > 0
              ? PaymentStatus.partial
              : PaymentStatus.notPaid;

          return buildDataRow(index + 1, rentEntry, context, paymentStatus);
        }),
      ],
    );
  }
}
