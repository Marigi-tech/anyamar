import 'package:anyamar/commons/exports.dart';

class PropertiesTable extends ConsumerStatefulWidget {
  const PropertiesTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PropertiesTableState();
}

class _PropertiesTableState extends ConsumerState<PropertiesTable> {
  List<Property> properties = [];
  List<Unit> units = [];
  List<Unit> occupiedUnits = [];
  List<Tenant> tenants = [];

  // double get occupancyRate {
  //   if (units.isEmpty) return 0;
  //   return occupiedUnits.length / units.length;
  // }

  // double get expectedRent {
  //   return occupiedUnits.fold<double>(0, (total, unit) {
  //     final rent = unit.unitRent?.rentAmount ?? 0;

  //     final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
  //       0,
  //       (sum, utility) => sum + utility.amountPayable,
  //     );

  //     return total + rent + utilities;
  //   });
  // }

  double propertyexpectedRent(List<Unit> occUnits) {
    return occUnits.fold<double>(0, (total, unit) {
      final rent = unit.unitRent?.rentAmount ?? 0;

      final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
        0,
        (sum, utility) => sum + utility.amountPayable,
      );

      return total + rent + utilities;
    });
  }

  double propertyCollectedRent(List<Tenant> propTenants) {
    double totalCollected = 0;

    for (final tenant in propTenants) {
      final appDataPro = ref.watch(appDataProvider);
      RentalRecord? tenantRentRecord = appDataPro.rentRecords
          .where((record) => record.rentHistory.tenantId == tenant.tenantId)
          .singleOrNull;
      if (tenantRentRecord == null) continue;

      for (final month in tenantRentRecord.rentHistory.rentalMonths) {
        final monthTotalPaid = month.rentEntries.fold<double>(
          0,
          (sum, entry) => sum + entry.amountPaid,
        );

        totalCollected += monthTotalPaid;
      }
    }

    return totalCollected;
  }

  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    properties = appData.properties;
    units = appData.units;
    occupiedUnits = appData.occupiedUnits;
    tenants = appData.tenants;
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final headerStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark ? AppColors.whiteColor : AppColors.blueGreyColor,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w200,
      letterSpacing: 0.6,
      fontSize: 14,
    );

    final labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );

    return ReusableDataTableWidget<Property>(
      items: properties,

      searchHint: 'Search properties...',

      columns: [
        DataColumn(
          label: SizedBox(width: 7, child: Text('#', style: headerStyle)),
        ),
        DataColumn(label: Text('Property ', style: headerStyle)),
        DataColumn(label: Text('Location', style: headerStyle)),
        DataColumn(label: Text('Total Units', style: headerStyle)),
        DataColumn(label: Text('Occupied', style: headerStyle)),
        DataColumn(label: Text('Vacant', style: headerStyle)),
        DataColumn(label: Text('Occupancy Rate', style: headerStyle)),
        DataColumn(label: Text('Collected Rent', style: headerStyle)),
        DataColumn(label: Text('Status', style: headerStyle)),
        DataColumn(label: Text('Actions', style: headerStyle)),
      ],
      searchMatcher: (property, query) {
        // final property = properties
        //     .where((p) => p.propertyId == property.propertyId)
        //     .firstOrNull;

        // final tenant = tenants
        //     .where((t) => t.unitId == unit.unitId)
        //     .firstOrNull;
        return true;
        // return unit.unitName.toLowerCase().contains(query) ||
        //     (property?.propertyName ?? '').toLowerCase().contains(query) ||
        //     (tenant?.tenantName ?? '').toLowerCase().contains(query);
      },

      onFilterPressed: () {
        // Show filter
      },

      onExportPressed: () {
        // Export
      },
      rowBuilder: (property, index) {
        List<Unit> propertyUnits = units
            .where((unit) => unit.propertyId == property.propertyId)
            .toList();
        List<Unit> propertyOccupiedUnits = units
            .where(
              (unit) =>
                  (unit.propertyId == property.propertyId) &&
                  (unit.isOccupied == true),
            )
            .toList();
        final propertyTenants = tenants
            .where(
              (tenant) => propertyOccupiedUnits.any(
                (unit) => unit.unitId == tenant.unitId,
              ),
            )
            .toList();
        final vacantUnits =
            propertyUnits.isNotEmpty && propertyOccupiedUnits.isNotEmpty
            ? propertyUnits.length - propertyOccupiedUnits.length
            : 0;
        final occupancy =
            propertyUnits.isNotEmpty && propertyOccupiedUnits.isNotEmpty
            ? propertyOccupiedUnits.length / propertyUnits.length
            : 0.0;
        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 8,
                child: Text('${index + 1}', style: labelStyle),
              ),
            ),
            DataCell(
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            avatarBackgroundColors[index %
                                    avatarBackgroundColors.length]
                                .withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.apartment,
                        color:
                            avatarBackgroundColors[index %
                                avatarBackgroundColors.length],
                        size: 15,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        property.propertyName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeIsDark == true
                              ? AppColors.whiteColor
                              : Color(0xff172554),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            DataCell(Text(property.propertyLocation)),
            DataCell(Text('${propertyUnits.length}')),
            DataCell(Text('${propertyOccupiedUnits.length}')),
            DataCell(Text('$vacantUnits')),
            DataCell(
              SizedBox(
                width: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(occupancy * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 5),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: occupancy,
                        minHeight: 7,
                        backgroundColor: const Color(0xffE6EAF0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DataCell(
              Text(
                'Ksh ${formatMoney(propertyCollectedRent(propertyTenants))}', // formatMoney(property.monthlyRent),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            DataCell(StatusBadge(status: 'active')),
            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      ref
                          .read(propertyPageProvider.notifier)
                          .showProperty(property);
                      // ref
                      //     .read(unitPageProvider.notifier)
                      //     .showUnit(unit, property: property);
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 15,
                      color: Color(0xff1769F5),
                    ),
                  ),

                  PopupMenuButton<String>(
                    tooltip: 'More',
                    icon: const Icon(Icons.more_vert, size: 18),
                    onSelected: (value) {
                      switch (value) {
                        case 'view':
                          ref
                              .read(propertyPageProvider.notifier)
                              .showProperty(property);
                          break;

                        case 'edit':
                          ref
                              .read(propertyPageProvider.notifier)
                              .showUpdateProperty(property);
                          break;

                        case 'delete':
                          _deleteProperty(context, ref, property);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.eye, size: 18),
                            SizedBox(width: 10),
                            Text('View'),
                          ],
                        ),
                      ),

                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 10),
                            Text('Update'),
                          ],
                        ),
                      ),

                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18),
                            SizedBox(width: 10),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> _deleteProperty(BuildContext context, WidgetRef ref, Property property) async {
  // final propertyDb = DbUnitsService();

  // await unitDb.deleteUnitRecord(unit);

  // ref.read(userInformationProvider.notifier).removeUnit(unit.unitId);
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool active = status.toLowerCase() == 'active';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xffE5F8EC) : const Color(0xffEEF1F5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: active ? const Color(0xff168344) : const Color(0xff526070),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}




// // 1. Columns
// List<DataColumn> buildHeaderColumns() {
//   return const [
//     DataColumn(
//       label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("Location", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("Managed By", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("Units", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("Update", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//     DataColumn(
//       label: Text("Delete", style: TextStyle(fontWeight: FontWeight.w200)),
//     ),
//   ];
// }

// // 2. Data Rows
// DataRow buildDataRow(
//   Property property,
//   int index,
//   BuildContext context,
//   List<Unit>? units,
//   WidgetRef ref,
// ) {
//   Future<bool?> showDeleteConfirmationDialog(
//     BuildContext context,
//     Property property,
//   ) {
//     return showDialog<bool>(
//       context: context,
//       builder: (dialogContext) {
//         return AlertModal(
//           dialogTitle: 'Property',
//           isDeleteModal: true,
//           recordId: property.propertyName,
//         );
//       },
//     );
//   }

//   return DataRow(
//     onLongPress: () => Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => SinglePropertyPage(property: property)),
//     ),
//     cells: [
//       // Index Column
//       DataCell(
//         Text(
//           '$index',
//           style: TextStyle(color: AppColorsConstant.blueGreyColor),
//         ),
//       ),
//       // Property Name
//       DataCell(
//         Text(
//           property.propertyName,
//           style: TextStyle(color: AppColorsConstant.blueGreyColor),
//         ),
//       ),
//       // Property Location
//       DataCell(
//         Text(
//           property.propertyLocation,
//           style: TextStyle(color: AppColorsConstant.blueGreyColor),
//         ),
//       ),
//       // Property Manager
//       DataCell(
//         Text(
//           property.propertyManager?.personName ?? '',
//           style: TextStyle(color: AppColorsConstant.blueGreyColor),
//         ),
//       ),
//       // Filtered Units Count
//       DataCell(
//         Text(
//           '${units?.where((element) => element.propertyId == property.propertyId).length}',
//           style: TextStyle(color: AppColorsConstant.blueGreyColor),
//         ),
//       ),
//       // Navigation Action Card
//       DataCell(
//         ViewChevronCard(
//           onPressedCallBack: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => SinglePropertyPage(property: property),
//               ),
//             );
//           },
//         ),
//       ),
//       // Update
//       DataCell(
//         ViewChevronCard(
//           iconData: CupertinoIcons.pencil,
//           onPressedCallBack: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (_) => AddProperty(currentProperty: property),
//               ),
//             );
//           },
//         ),
//       ),
//       DataCell(
//         ViewChevronCard(
//           iconData: CupertinoIcons.trash,
//           iconColor: AppColorsConstant.redColor,
//           onPressedCallBack: () async {
//             final shouldDelete = await showDeleteConfirmationDialog(
//               context,
//               property,
//             );
//             // User pressed Cancel or dismissed the dialog
//             if (shouldDelete != true) {
//               return;
//             }

//             LazyLoader lazyLoader = LazyLoader(context: context);
//             lazyLoader.showLoader();
//             final db = DbPropertyService();
//             try {
//               final isSuccessful = await db.deletePropertyRecord(property);
//               if (isSuccessful) {
//                 await ref
//                     .read(userInformationProvider.notifier)
//                     .removeProperty(property.propertyId);
//                 displaySnackBar(
//                   context,
//                   'Property deleted succesfully',
//                   AppColorsConstant.greenColor,
//                 );
//               }
//               //
//             } catch (e) {
//               displaySnackBar(
//                 context,
//                 'Error $e occured when deleting the property',
//                 AppColorsConstant.redColor,
//               );
//             } finally {
//               lazyLoader.hideLoader();
//             }
//           },
//         ),
//       ),
//     ],
//   );
// }

