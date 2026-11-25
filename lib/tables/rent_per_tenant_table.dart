import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/rent_records_per_tenant_state.dart';

class RentPerTenantTable extends ConsumerStatefulWidget {
  final List<Tenant> tenants;
  final List<SingleRentEntry> rentEntries;
  final String introText;

  const RentPerTenantTable({
    super.key,
    required this.tenants,
    required this.rentEntries,
    required this.introText,
  });

  @override
  ConsumerState<RentPerTenantTable> createState() => _RentPerTenantTableState();
}

class _RentPerTenantTableState extends ConsumerState<RentPerTenantTable> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);

    final TextStyle headerStyle = CustomTextStyles.cardDescriptionStyle
        .copyWith(
          color: themeIsDark != false
              ? AppColors.whiteColor
              : AppColors.blueGreyColor,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.6,
        );
    final TextStyle labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark != false ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );

    return ReusableDataTableWidget<Tenant>(
      items: widget.tenants,
      searchHint: 'Search ',
      cardTitle: 'Rent records / tenant',
      columns: [
        DataColumn(label: SizedBox(width: 18, child: Text("#"))),
        DataColumn(label: Text("Tenant", style: headerStyle)),
        DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("No of Records", style: headerStyle)),
        DataColumn(label: Text('Total Income', style: headerStyle)),
        DataColumn(label: Text("View", style: headerStyle)),
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
                                avatarBackgroundColors.length],

                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          getInitials(tenant.tenantName),
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tenant.tenantName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeIsDark != false
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
                      ref
                          .read(workspaceProvider.notifier)
                          .openForm(
                            RentRecordsPerTenantState(
                              rentRecords: rentEntriesRecords,
                              tenant: tenant,
                              introText: widget.introText,
                            ),
                          );
                    },
                    icon: const Icon(CupertinoIcons.chevron_right, size: 15),
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
