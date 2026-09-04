import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/units_table.dart';

class PropertyUnits extends ConsumerStatefulWidget {
  final Property property;
  const PropertyUnits({super.key, required this.property});

  @override
  ConsumerState<PropertyUnits> createState() => _PropertyUnitsState();
}

class _PropertyUnitsState extends ConsumerState<PropertyUnits> {
  List<Unit> propertyUnits = [];
  List<Unit> filteredUnits = [];
  List<Tenant> myTenants = [];
  List<Property> myProperties = [];
  String searchQuery = '';

  void filterSingleUnitTableData(String query) {
    setState(() {
      searchQuery = query.trim().toLowerCase();
    });
  }

  List<Unit> getFilteredUnits(List<Unit> currentUnits) {
    if (searchQuery.isEmpty) {
      return currentUnits;
    } else {
      return filteredUnits = currentUnits
          .where((unit) => unit.matchesUnitSearch(searchQuery, myTenants))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    propertyUnits = ref
        .watch(userInformationProvider.select((state) => state.units))
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    filteredUnits = getFilteredUnits(propertyUnits);

    return Column(
      children: [
        SizedBox(height: 20),
        TableIntroWidget(
          dataLength: '${filteredUnits.length}',
          dataType: 'Units',
          onSearch: filterSingleUnitTableData,
          customWidgets: [
            CardButtonWidget(buttonTitle: 'View rent History'),
            SizedBox(width: 5),
            CardButtonWidget(
              buttonTitle: 'View tenant History',
              onPressedCallBack: () {},
            ),
          ],
          onPressedCallBack: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddUnit())),
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
              customDataColumns: [...buildHeaderColumns(false)],
              customDataRows: [
                ...filteredUnits.asMap().entries.map((entry) {
                  int index = entry.key;
                  Unit unit = entry.value;
                  Property currentProperty = widget.property;
                  final Tenant? tenantInformation = unit.tenantId != null
                      ? myTenants.singleWhere(
                          (element) => element.tenantId == unit.tenantId,
                        )
                      : null;
                  return buildDataRow(
                    unit,
                    index + 1,
                    context,
                    tenantInformation,
                    currentProperty,
                    false,
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
