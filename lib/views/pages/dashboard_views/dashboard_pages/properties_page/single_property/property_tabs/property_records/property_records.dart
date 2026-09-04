import 'package:anyamar/commons/exports.dart';

class PropertyRecords extends ConsumerStatefulWidget {
  final Property property;
  const PropertyRecords({super.key, required this.property});

  @override
  ConsumerState<PropertyRecords> createState() => _PropertyRecordsState();
}

class _PropertyRecordsState extends ConsumerState<PropertyRecords> {
  List<FinancialRecord> propertyRecords = [];
  List<FinancialRecord> filteredRecords = [];
  String searchQuery = '';

  void filterFinancialRecordsTableData(String query) {
    setState(() {
      searchQuery = query.trim().toLowerCase();
    });
  }

  List<FinancialRecord> getFilteredFinancialRecords(
    List<FinancialRecord> currentRecords,
  ) {
    if (searchQuery.isEmpty) {
      return filteredRecords = currentRecords;
    } else {
      return filteredRecords = currentRecords
          .where((f) => f.matchesFinancialRecordsSearch(searchQuery))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    //todo: all expenses relating to a property
    propertyRecords = ref
        .watch(userInformationProvider.select((state) => state.finances))
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();

    filteredRecords = getFilteredFinancialRecords(propertyRecords);

    return Column(
      children: [
        SizedBox(height: 20),
        TableIntroWidget(
          dataLength: '${filteredRecords.length}',
          dataType: 'expense records',
          onSearch: filterFinancialRecordsTableData,
          onPressedCallBack: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => ExpenseRecord())),
        ),

        SizedBox(height: 30),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
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
        ),
      ],
    );
  }
}
