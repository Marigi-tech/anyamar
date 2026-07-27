import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/date_format_model.dart';
import 'package:anyamar/data/models/financial_record_model.dart';
import 'package:anyamar/views/pages/information_pages/financial_record_modal.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:anyamar/views/tables/custom_data_table.dart';
import 'package:anyamar/views/tables/view_chevron_card.dart';

List<DataColumn> buildFinancialRecordsHeaderRows() {
  return [
    const DataColumn(
      label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text(
        "Payment date",
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
    ),
    const DataColumn(
      label: Text("Amount", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(label: Text('')),
    const DataColumn(
      label: Text("Record Type", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Payment By", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    const DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildFinancialRecordsDataRow(
  int index,
  FinancialRecord financialRecord,
  BuildContext context,
) {
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);

  return DataRow(
    onLongPress: () =>
        () => showDialog(
          context: context,
          builder: (context) =>
              FinancialRecordModal(financialRecord: financialRecord),
        ),
    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(
        Text(formatPrettyDate(financialRecord.datePaid), style: cellStyle),
      ),
      DataCell(Text('KSH ${financialRecord.amountPaid} ', style: cellStyle)),
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 80, maxHeight: 30),
          child: InformationBadge(
            text: financialRecord.recordNature.label,
            textColor: getPaymentType(financialRecord.recordNature).textColor,
            badgeColor: getPaymentType(financialRecord.recordNature).badgeColor,
          ),
        ),
      ),
      DataCell(Text(financialRecord.recordType.label, style: cellStyle)),
      DataCell(Text(financialRecord.paymentBy.userName, style: cellStyle)),
      DataCell(
        ViewChevronCard(
          onPressedCallBack: () {
            showDialog(
              context: context,
              builder: (context) =>
                  FinancialRecordModal(financialRecord: financialRecord),
            );
          },
        ),
      ),
    ],
  );
}

class FinancialRecordsTable extends StatelessWidget {
  final List<FinancialRecord> financialRecords;
  const FinancialRecordsTable({super.key, required this.financialRecords});

  @override
  Widget build(BuildContext context) {
    return CustomDataTable(
      customDataColumns: [...buildFinancialRecordsHeaderRows()],
      customDataRows: [
        ...financialRecords.toList().asMap().entries.map((entry) {
          int index = entry.key;
          FinancialRecord financialRecord = entry.value;

          return buildFinancialRecordsDataRow(
            index + 1,
            financialRecord,
            context,
          );
        }),
      ],
    );
  }
}
