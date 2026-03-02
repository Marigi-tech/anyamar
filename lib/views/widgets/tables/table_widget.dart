import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';

class TableWidget extends StatelessWidget {
  final List<TableRow> tableChildren;
  final Map<int, TableColumnWidth> tableColumnWidths;
  final Widget cardHeaderWidget;
  const TableWidget({
    super.key,
    required this.tableChildren,
    required this.tableColumnWidths,
    required this.cardHeaderWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        children: [
          //Enter Card header here
          cardHeaderWidget,
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Table(
              border: TableBorder.symmetric(
                outside: BorderSide.none,
                inside: BorderSide(
                  color: AppColorsConstant.blueGreyColor,
                  width: 0.09,
                ),
              ),
              columnWidths: tableColumnWidths,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,

              children: tableChildren,
            ),
          ),
        ],
      ),
    );
  }
}
