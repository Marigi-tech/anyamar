import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/widgets/dashboard_widgets/intro_text_widget.dart';
import 'package:test_app/views/widgets/tables/tenants_table.dart';

class TenantsPage extends StatelessWidget {
  const TenantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints.maxHeight is the full height available to TenantsPage.
        final double totalHeight = constraints.maxHeight;
        // The ratios are 1:8, totaling 9 parts (1 + 8).
        const int totalFlex = 9;
        final double unitHeight = totalHeight / totalFlex;

        final double headerHeight = unitHeight * 1; // 1/9th of the height
        final double tableHeight = unitHeight * 8; // 8/9ths of the height

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // --- HEADER (Flex: 1) ---
            // Replaced Expanded(flex: 1, ...) with SizedBox(height: headerHeight, ...)
            SizedBox(
              height: headerHeight,
              child: IntroTextWidget(dashboardItem: 'Tenants'),
            ),

            // --- SCROLLABLE TABLE (Flex: 8) ---
            // Replaced Expanded(flex: 8, ...) with SizedBox(height: tableHeight, ...)
            SizedBox(
              height: tableHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                // The rest of your table structure remains the same
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
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Header Row
                    buildHeaderRow(),

                    // Dummy Rows
                    buildDataRow(
                      1,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      2,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      3,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      4,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      5,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      6,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      7,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      8,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      9,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      10,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      11,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      12,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      13,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      14,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                    buildDataRow(
                      15,
                      "Yvonne Marigi",
                      "Unit 45901",
                      "0799509119",
                      "Unity Homes",
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
