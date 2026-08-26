import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/financial_records_table.dart';
import 'package:anyamar/views/pages/dashboard/finances/records/general_financial_record.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyRecords extends ConsumerStatefulWidget {
  final Property property;
  const PropertyRecords({super.key, required this.property});

  @override
  ConsumerState<PropertyRecords> createState() => _PropertyRecordsState();
}

class _PropertyRecordsState extends ConsumerState<PropertyRecords> {
  List<FinancialRecord>? propertyRecords = [];
  List<FinancialRecord>? filteredRecords = [];

  @override
  void initState() {
    super.initState();

    filteredRecords = propertyRecords;
  }

  void filterFinancialRecordsTableData(String query) {
    final search = query.toLowerCase();

    setState(() {
      filteredRecords = propertyRecords
          ?.where((f) => f.matchesFinancialRecordsSearch(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    //todo: all expenses relating to a property
    propertyRecords = ref
        .watch(userInformationProvider.select((state) => state.finances))
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    filteredRecords = propertyRecords;

    return Column(
      children: [
        SizedBox(height: 20),
        TableIntroWidget(
          dataLength: '${filteredRecords?.length ?? 0}',
          dataType: 'financial records',
          onSearch: filterFinancialRecordsTableData,
          onPressedCallBack: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddGeneralFinancialRecord()),
          ),
        ),

        SizedBox(height: 30),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
            child: FinancialRecordsTable(
              financialRecords: filteredRecords ?? [],
              // PropertyRecords: filteredTenants,
              // isUnitTenant: true,
            ),
          ),
        ),
      ],
    );
  }
}
