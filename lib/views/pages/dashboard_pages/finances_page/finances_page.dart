import 'package:anyamar/data/data_sets/financial_records.dart';
import 'package:anyamar/data/models/financial_record_model.dart';
import 'package:anyamar/views/pages/dashboard_pages/dashboard_page_shell.dart';
import 'package:anyamar/views/tables/financial_records_table.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/views/forms/financial_records/general_financial_record.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  List<FinancialRecord> financialRecords = [];
  List<FinancialRecord> filteredRecords = [];

  @override
  void initState() {
    super.initState();
    financialRecords = tempFinancialRecords.toList();
    filteredRecords = financialRecords;
  }

  void filterFinancialRecordsData(String query) {
    final search = query.toLowerCase();

    setState(() {
      filteredRecords = financialRecords
          .where((t) => t.matchesFinancialRecordsSearch(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardPageShell(
      introText: 'Financial Records',
      stickyWidget: TableIntroWidget(
        dataLength: '${filteredRecords.length}',
        dataType: 'Financial records',
        onSearch: filterFinancialRecordsData,
        hasSearchBar: true,
        onPressedCallBack: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => AddGeneralFinancialRecord())),
      ),
      dashboardWidgets: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: FinancialRecordsTable(financialRecords: filteredRecords),
        ),
      ],
    );
  }
}
