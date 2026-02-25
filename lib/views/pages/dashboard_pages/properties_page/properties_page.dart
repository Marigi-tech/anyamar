import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/widgets/dashboard_widgets/intro_text_widget.dart';
import 'package:test_app/views/widgets/tables/properties_table.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

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
            SizedBox(
              height: headerHeight,
              child: IntroTextWidget(dashboardItem: 'Properties'),
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
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      2,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      3,
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      4,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      5,
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      6,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      7,
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      8,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      9,
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      10,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      11,
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      12,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      13,
                      "Sunrise Apartments",
                      "Nairobi",
                      "J. Mwangi",
                      "18",
                    ),
                    buildDataRow(
                      14,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
                    ),
                    buildDataRow(
                      15,
                      "Lavington Heights",
                      "Nairobi",
                      "A. Maragwa",
                      "32",
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
