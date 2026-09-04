import 'package:anyamar/commons/exports.dart';

class FinancesPage extends ConsumerStatefulWidget {
  const FinancesPage({super.key});
  @override
  ConsumerState<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends ConsumerState<FinancesPage> {
  List<FinancialRecord> financialRecords = [];
  List<FinancialRecord> filteredRecords = [];
  String searchQuery = '';

  void filterFinancialRecordsData(String query) {
    setState(() {
      searchQuery = query.trim().toLowerCase();
    });
  }

  List<FinancialRecord> getFilteredRecords(
    List<FinancialRecord> financialRecords,
  ) {
    if (searchQuery.isEmpty) {
      return financialRecords;
    }

    return financialRecords
        .where((record) => record.matchesFinancialRecordsSearch(searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    financialRecords = ref.watch(
      userInformationProvider.select((state) => state.finances),
    );
    // Rebuild whenever provider or search query changes
    filteredRecords = getFilteredRecords(financialRecords);

    return DashboardPageShell(
      introText: 'Financial Records',
      stickyWidget: TableIntroWidget(
        dataLength: '${filteredRecords.length}',
        dataType: 'Financial records',
        onSearch: filterFinancialRecordsData,
        hasSearchBar: true,
        customWidgets: [
          CardButtonWidget(
            buttonTitle: 'Add Expense Record',
            backgroundColor: AppColorsConstant.redColor,
            fontColor: AppColorsConstant.whiteColor,
            onPressedCallBack: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => ExpenseRecord())),
          ),
          SizedBox(width: 5),
          CardButtonWidget(
            buttonTitle: 'Add Rent record',
            backgroundColor: AppColorsConstant.greenColor,
            fontColor: AppColorsConstant.whiteColor,
            onPressedCallBack: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => AddRentalRecord())),
          ),
        ],
      ),
      dashboardWidgets: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomDataTable(
            customDataColumns: [...buildFinancialRecordsHeaderRows()],
            customDataRows: [
              ...filteredRecords.toList().asMap().entries.map((entry) {
                int index = entry.key;
                FinancialRecord financialRecord = entry.value;

                return buildFinancialRecordsDataRow(
                  index + 1,
                  financialRecord,
                  context,
                  ref,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
