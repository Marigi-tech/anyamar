import 'package:anyamar/commons/constants.dart';
import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  final List<DataColumn> customDataColumns;
  final List<DataRow> customDataRows;
  const CustomDataTable({
    super.key,
    required this.customDataColumns,
    required this.customDataRows,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
             
              minWidth: constraints.maxWidth,
            ),
            child:
             
                DataTable(
                  horizontalMargin: 12.0,
                  columnSpacing: 56.0,
                  border: TableBorder.symmetric(
                    outside: BorderSide.none,
                    inside: BorderSide(
                      color: AppColorsConstant.blueGreyColor,
                      width: 0.09,
                    ),
                  ),
                  columns: customDataColumns,
                  rows: customDataRows,
                ),
          ),
        );
      },
    );
  }
}
