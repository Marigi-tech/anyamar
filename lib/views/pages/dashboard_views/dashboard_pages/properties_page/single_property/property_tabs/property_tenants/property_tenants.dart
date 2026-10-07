import 'package:anyamar/commons/exports.dart';

class PropertyTenants extends ConsumerStatefulWidget {
  final Property property;
  const PropertyTenants({super.key, required this.property});

  @override
  ConsumerState<PropertyTenants> createState() => _PropertyTenantsState();
}

class _PropertyTenantsState extends ConsumerState<PropertyTenants> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    final propertyUnits = appData.units
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    final propertyTenants = appData.tenants
        .where(
          (tenant) => propertyUnits.any((unit) => unit.unitId == tenant.unitId),
        )
        .toList();

    final columns = [
      TableColumnConfig(title: '#', flex: 0.3),
      TableColumnConfig(title: 'Name', flex: 1.1),
      TableColumnConfig(title: 'Phone Number', flex: 1.1),
      TableColumnConfig(title: 'National ID', flex: 1.1),
      TableColumnConfig(title: 'Unit name', flex: 1.0),
      TableColumnConfig(title: 'Rent / Month', flex: 1.0),
      TableColumnConfig(title: 'Actions', flex: 0.4),
    ];
    final rows = propertyTenants.map((tenant) {
      var index = propertyTenants.indexOf(tenant) + 1;
      Unit? unit = propertyUnits
          .where((unit) => unit.unitId == tenant.tenantId)
          .singleOrNull;
      return [
        ItemCell(value: '${index++}'),
        ItemCell(value: tenant.tenantName),
        ItemCell(value: tenant.tenantPhoneNumber ?? 'N/A'),
        ItemCell(value: tenant.tenantNationalId ?? 'N/A'),
        ItemCell(value: unit?.unitType?.label ?? 'N/A'),
        ItemCell(
          value: unit?.unitRent?.rentAmount != null
              ? formatMoneyWithCurrency(
                  unit?.unitRent?.rentAmount as num,
                  unit?.unitRent?.rentCurrency,
                )
              : 'N/A',
        ),

        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: UnitVacancyBadge(isOccupied: unit.isOccupied),
        // ),
        IconButton(
          icon: Icon(Icons.more_vert, size: 18, color: Color(0xFF7D8794)),
          onPressed: () {},
        ),
      ];
    }).toList();

    return SearchlessTableWidget(columns: columns, rows: rows);
  }
}

// class PropertyTenants extends ConsumerStatefulWidget {
//   final Property property;
//   const PropertyTenants({super.key, required this.property});

//   @override
//   ConsumerState<PropertyTenants> createState() => _PropertyTenantsState();
// }

// class _PropertyTenantsState extends ConsumerState<PropertyTenants> {
//   List<Tenant> propertyTenants = [];
//   List<Tenant> filteredTenants = [];
//   List<Property> myProperties = [];
//   String searchQuery = '';

//   void filterSingleTenantTableData(String query) {
//     setState(() {
//       searchQuery = query.trim().toLowerCase();
//     });
//   }

//   List<Tenant> getFilteredPropertyTenants(List<Tenant> currentTenants) {
//     if (searchQuery.isEmpty) {
//       return filteredTenants = currentTenants;
//     } else {
//       return filteredTenants = currentTenants
//           .where(
//             (tenant) => tenant.matchesTenantSearch(searchQuery, myProperties),
//           )
//           .toList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     propertyTenants = ref
//         .watch(userInformationProvider.select((state) => state.tenants))
//         .where((element) => element.propertyId == widget.property.propertyId)
//         .toList();
//     myProperties = ref.watch(
//       userInformationProvider.select((state) => state.properties),
//     );

//     filteredTenants = getFilteredPropertyTenants(propertyTenants);

//     return Column(
//       children: [
//         SizedBox(height: 20),
//         TableIntroWidget(
//           dataLength: '${filteredTenants.length}',
//           dataType: 'tenants',
//           onSearch: filterSingleTenantTableData,
//           onPressedCallBack: () => Navigator.of(
//             context,
//           ).push(MaterialPageRoute(builder: (_) => AddTenant())),
//         ),

//         SizedBox(height: 30),
//         Card(
//           elevation: 8,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),

//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
//             child: CustomDataTable(
//               customDataColumns: [...buildTenantHeaderRows(true, true)],
//               customDataRows: [
//                 ...filteredTenants.toList().asMap().entries.map((entry) {
//                   int index = entry.key;
//                   Tenant tenant = entry.value;

//                   return buildTenantDataRow(
//                     index + 1,
//                     tenant,
//                     context,
//                     null,
//                     ref,
//                     null,
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
