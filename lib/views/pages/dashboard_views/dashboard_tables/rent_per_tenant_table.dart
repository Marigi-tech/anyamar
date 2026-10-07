import 'package:anyamar/commons/exports.dart';

class RentPerTenantTable extends ConsumerStatefulWidget {
  final List<Tenant> tenants;
  final List<SingleRentEntry> rentEntries;

  const RentPerTenantTable({
    super.key,
    required this.tenants,
    required this.rentEntries,
  });

  @override
  ConsumerState<RentPerTenantTable> createState() => _RentPerTenantTableState();
}

class _RentPerTenantTableState extends ConsumerState<RentPerTenantTable> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);

    final TextStyle headerStyle = CustomTextStyles.cardDescriptionStyle
        .copyWith(
          color: themeIsDark == true
              ? AppColors.whiteColor
              : AppColors.blueGreyColor,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.6,
        );
    final TextStyle labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark == true ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );

    return ReusableDataTableWidget<Tenant>(
      items: widget.tenants,
      searchHint: 'Search ',

      columns: [
        DataColumn(label: SizedBox(width: 18, child: Text("#"))),
        DataColumn(label: Text("Tenant", style: headerStyle)),
        DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("No of Records", style: headerStyle)),
        DataColumn(label: Text('Total Income', style: headerStyle)),
        DataColumn(label: Text("Actions", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (tenant, query) {
        String? unitName =
            appData.units
                .where((unit) => unit.unitId == tenant.unitId)
                .singleOrNull
                ?.unitName ??
            '';

        return tenant.tenantName.toLowerCase().contains(query) ||
            unitName.toLowerCase().contains(query);
      },

      // --------------------------------------------
      // FILTER
      // --------------------------------------------
      onFilterPressed: () {
        // Show your property filter dialog
      },

      // --------------------------------------------
      // EXPORT
      // --------------------------------------------
      onExportPressed: () {
        // Export properties
      },

      // --------------------------------------------
      // ROW
      // --------------------------------------------
      rowBuilder: (tenant, index) {
        String? unitName =
            appData.units
                .where((unit) => unit.unitId == tenant.unitId)
                .singleOrNull
                ?.unitName ??
            '';

        List<SingleRentEntry> rentEntriesRecords = widget.rentEntries
            .where((record) => record.tenantId == tenant.tenantId)
            .toList();
        final double totalRent = rentEntriesRecords.fold<double>(
          0,
          (sum, record) => sum + record.amountPaid,
        );

        var number = index + 1;

        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 18,
                child: Text(
                  '${number++}',
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
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
                      child: Center(
                        child: Text(
                          getInitials(tenant.tenantName),
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                      // child: Icon(
                      //   Icons.apartment,
                      //   color:
                      //       avatarBackgroundColors[index %
                      //           avatarBackgroundColors.length],
                      //   size: 15,
                      // ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        // formatPrettyDate(expenseRecord.datePaid),
                        tenant.tenantName,
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
            DataCell(Text(unitName, style: labelStyle)),
            DataCell(
              Text(rentEntriesRecords.length.toString(), style: labelStyle),
            ),
            DataCell(
              Text(
                formatMoneyWithCurrency(totalRent, 'Ksh'),
                style: labelStyle,
              ),
            ),

            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      // ref
                      //     .read(financesPageProvider.notifier)
                      //     .viewFinancialRecord(expenseRecord);
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
                          // ref
                          //     .read(financesPageProvider.notifier)
                          //     .viewexpenseRecord(expenseRecord);

                          break;

                        case 'edit':
                          // ref
                          //     .read(financesPageProvider.notifier)
                          //     .updateexpenseRecord(expenseRecord);

                          break;

                        case 'delete':
                          // _deleteUnit(context, ref, unit);
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
