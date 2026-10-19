import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/methods/delete_item_function.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/forms/add_property_form.dart';

class PropertiesTable extends ConsumerStatefulWidget {
  final String introText;
  const PropertiesTable({super.key, required this.introText});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PropertiesTableState();
}

class _PropertiesTableState extends ConsumerState<PropertiesTable> {
  List<Property> properties = [];
  List<Unit> units = [];
  List<Unit> occupiedUnits = [];
  List<Tenant> tenants = [];
  // double _propertyExpectedRent(List<Unit> occupiedUnits) {
  //   return occupiedUnits.fold<double>(0, (total, unit) {
  //     final rent = unit.unitRent?.rentAmount ?? 0;

  //     final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
  //       0,
  //       (sum, utility) => sum + utility.amountPayable,
  //     );

  //     return total + rent + utilities;
  //   });
  // }

  double _propertyCollectedRent({
    required List<Tenant> propertyTenants,
    required List<RentalRecord> rentalRecords,
  }) {
    double totalCollected = 0;

    for (final tenant in propertyTenants) {
      final matchingRecords = rentalRecords.where(
        (record) => record.rentHistory.tenantId == tenant.tenantId,
      );

      for (final record in matchingRecords) {
        for (final month in record.rentHistory.rentalMonths) {
          totalCollected += month.rentEntries.fold<double>(
            0,
            (sum, entry) => sum + entry.amountPaid,
          );
        }
      }
    }

    return totalCollected;
  }

  // double propertyexpectedRent(List<Unit> occUnits) {
  //   return occUnits.fold<double>(0, (total, unit) {
  //     final rent = unit.unitRent?.rentAmount ?? 0;

  //     final utilities = (unit.unitRent?.utilities ?? []).fold<double>(
  //       0,
  //       (sum, utility) => sum + utility.amountPayable,
  //     );

  //     return total + rent + utilities;
  //   });
  // }

  // double propertyCollectedRent(List<Tenant> propTenants) {
  //   double totalCollected = 0;

  //   for (final tenant in propTenants) {
  //     final appDataPro = ref.watch(userInformationProvider);
  //     RentalRecord? tenantRentRecord = appDataPro.rentalRecords
  //         .where((record) => record.rentHistory.tenantId == tenant.tenantId)
  //         .singleOrNull;
  //     if (tenantRentRecord == null) continue;

  //     for (final month in tenantRentRecord.rentHistory.rentalMonths) {
  //       final monthTotalPaid = month.rentEntries.fold<double>(
  //         0,
  //         (sum, entry) => sum + entry.amountPaid,
  //       );

  //       totalCollected += monthTotalPaid;
  //     }
  //   }

  //   return totalCollected;
  // }

  Property _latestProperty({
    required Property property,
    required List<Property> properties,
  }) {
    for (final latest in properties) {
      if (latest.propertyId == property.propertyId) {
        return latest;
      }
    }

    return property;
  }

  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    properties = appData.properties;
    units = appData.units;
    occupiedUnits = appData.occupiedUnits;
    tenants = appData.tenants;
    final rentalRecords = appData.rentalRecords;
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
        // final propUnits = appData.units
        //     .where((unit) => unit.propertyId == property.propertyId)
        //     .toList();

        // return property.propertyName.toLowerCase().contains(query) ||
        //     property.propertyLocation.toLowerCase().contains(query) ||
        //     property.propertyFloors.toString().toLowerCase().contains(query) ||
        //     propUnits.toString().toLowerCase().contains(query);
        final currentProperty = _latestProperty(
          property: property,
          properties: properties,
        );

        final propertyUnits = units
            .where((unit) => unit.propertyId == currentProperty.propertyId)
            .toList();

        return currentProperty.propertyName.toLowerCase().contains(query) ||
            currentProperty.propertyLocation.toLowerCase().contains(query) ||
            currentProperty.propertyFloors.toString().contains(query) ||
            propertyUnits.toString().toLowerCase().contains(query);
      },

      onFilterPressed: () {
        // Show filter
      },

      onExportPressed: () {
        // Export
      },
      rowBuilder: (property, index) {
        // Always resolve the most recent version from Riverpod.
        final currentProperty = _latestProperty(
          property: property,
          properties: properties,
        );

        final propertyUnits = units
            .where((unit) => unit.propertyId == currentProperty.propertyId)
            .toList();

        final propertyOccupiedUnits = propertyUnits
            .where((unit) => unit.isOccupied)
            .toList();

        final vacantUnits = propertyUnits.length - propertyOccupiedUnits.length;

        final occupancy = propertyUnits.isEmpty
            ? 0.0
            : propertyOccupiedUnits.length / propertyUnits.length;

        final propertyTenants = tenants.where((tenant) {
          return propertyOccupiedUnits.any(
            (unit) => unit.unitId == tenant.unitId,
          );
        }).toList();

        final collectedRent = _propertyCollectedRent(
          propertyTenants: propertyTenants,
          rentalRecords: rentalRecords,
        );

        void openPropertyDetails() {
          ref
              .read(workspaceProvider.notifier)
              .openForm(
                DashboardPageStructure(
                  introText: '${widget.introText} / property',
                  pageTitle: currentProperty.propertyName,
                  supplementaryText:
                      '${currentProperty.propertyLocation} | '
                      '${currentProperty.propertyFloors} Floors | '
                      '${propertyUnits.length} Units',
                  introRowWidgets: [],
                  introButton: IntroButtonWidget(),
                  scrollableDashboardWidget: SinglePropertyPage(
                    property: currentProperty,
                    introText: '${widget.introText} / property',
                  ),
                ),
              );
        }

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
                        currentProperty.propertyName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeIsDark
                              ? AppColors.whiteColor
                              : const Color(0xff172554),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DataCell(Text(currentProperty.propertyLocation)),
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
                'Ksh ${formatMoney(collectedRent)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            DataCell(StatusBadge(status: 'active')),
            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: openPropertyDetails,
                    icon: const Icon(
                      CupertinoIcons.chevron_right,
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
                          openPropertyDetails();
                          break;

                        case 'edit':
                          ref
                              .read(workspaceProvider.notifier)
                              .openForm(
                                DashboardPageStructure(
                                  introText: '${widget.introText} / update property',
                                  pageTitle: currentProperty.propertyName,
                                  introRowWidgets: [],
                                  introButton: IntroButtonWidget(),
                                  scrollableDashboardWidget: AddPropertyForm(
                                    currentProperty: currentProperty,
                                  ),
                                ),
                              );
                          break;

                        case 'delete':
                          deleteItemFunction(
                            context,
                            'Property',
                            currentProperty.propertyName,
                            _deleteProperty,
                          );
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.eye, size: 18),
                            SizedBox(width: 10),
                            Text('View'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 10),
                            Text('Update'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
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

Future<void> _deleteProperty(
  BuildContext context,
  WidgetRef ref,
  Property property,
) async {
  final propertyDb = DbPropertyService();

  await propertyDb.deletePropertyRecord(property);

  ref
      .read(userInformationProvider.notifier)
      .removeProperty(property.propertyId);
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
