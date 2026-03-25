import 'package:flutter/material.dart';
import 'package:test_app/data/data_sets/rent_history.dart';
import 'package:test_app/data/models/single_rental_entry_model.dart';
import 'package:test_app/views/widgets/dashboard_widgets/intro_text_widget.dart';
import 'package:test_app/views/widgets/table_intro_widget/table_intro_widget.dart';
import 'package:test_app/views/widgets/tables/rent_history.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  List<SingleRentEntry> rentRecords = [];
  List<SingleRentEntry> filteredRecords = [];

  @override
  void initState() {
    super.initState();
    rentRecords = rentHistory
        .expand<SingleRentEntry>(
          (history) => history.rentEntries!.cast<SingleRentEntry>(),
        )
        .toList();

    filteredRecords = rentRecords;
  }

  void filterFinancialRecordsData(String query) {
    // final search = query.toLowerCase();

    setState(() {
      filteredRecords = rentRecords;
      // filteredFinances = myFinances
      //     .where((t) => t.matchesPropertySearch(search))
      //     .toList();
    });
  }

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
            SizedBox(
              height: headerHeight,
              child: IntroTextWidget(dashboardItem: 'Financial records'),
            ),

            SizedBox(
              height: tableHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),

                child: Column(
                  children: [
                    TableIntroWidget(
                      dataLength: '${filteredRecords.length}',
                      dataType: 'Financial records',
                      onSearch: filterFinancialRecordsData,
                      // onSearch: filterSinglePropertyTableData,
                    ),

                    SizedBox(height: 30),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 30.0,
                        ),
                        child: RentHistoryTable(rentEntries: filteredRecords),
                      ),
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
