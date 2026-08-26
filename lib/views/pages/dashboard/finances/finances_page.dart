
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_page_shell.dart';
import 'package:anyamar/views/pages/dashboard/finances/records/general_financial_record.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/financial_records_table.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancesPage extends ConsumerStatefulWidget {
  const FinancesPage({super.key});
  @override
  ConsumerState<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends ConsumerState<FinancesPage> {
  List<FinancialRecord> financialRecords = [];
  List<FinancialRecord> filteredRecords = [];

  @override
  void initState() {
    super.initState();
   
    filteredRecords = financialRecords;
  }

  void filterFinancialRecordsData(String query) {
    // final search = query.toLowerCase();

    // setState(() {
    //   filteredRecords = financialRecords
    //       .where((t) => t.matchesFinancialRecordsSearch(search))
    //       .toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
     financialRecords = ref.watch(userInformationProvider.select((state) => state.finances));
     filteredRecords = financialRecords;
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
