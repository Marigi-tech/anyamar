import 'package:anyamar/constants/constants.dart';
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
              // Forces the DataTable to stretch to fill the screen width
              // but allows it to scroll horizontally if columns exceed the screen size.
              minWidth: constraints.maxWidth,
            ),
            child:
                // child: SingleChildScrollView(
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child:
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
