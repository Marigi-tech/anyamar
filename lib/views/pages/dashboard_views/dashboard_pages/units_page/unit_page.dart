import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/units_table.dart';

class UnitsPage extends ConsumerStatefulWidget {
  const UnitsPage({super.key}); 

  @override
  ConsumerState<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends ConsumerState<UnitsPage> {
  List<Unit> myUnits = [];
  List<Unit> filteredUnits = [];
  List<Tenant> myTenants = [];
  List<Property> myProperties = [];
  String searchQuery = '';

  void filterUnitData(String query) {
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
    myUnits = ref.watch(userInformationProvider.select((state) => state.units));
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );

    // Filtered Units
    filteredUnits = getFilteredUnits(myUnits);

    return DashboardPageShell(
      introText: 'Units',
      stickyWidget: TableIntroWidget(
        dataLength: '${filteredUnits.length}',
        dataType: 'Units',
        onSearch: filterUnitData,
        hasSearchBar: true,
        onPressedCallBack: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => AddUnit())),
      ),
      dashboardWidgets: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomDataTable(
            customDataColumns: [...buildHeaderColumns(true)],

            customDataRows: [
              ...filteredUnits.asMap().entries.map((entry) {
                int index = entry.key;
                Unit unit = entry.value;
                Property currentProperty = myProperties
                    .where((prop) => prop.propertyId == unit.propertyId)
                    .single;
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
                  true,
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

