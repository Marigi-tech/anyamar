import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/rent_records_per_tenant_state.dart';

class RentPerPropertyTable extends ConsumerStatefulWidget {
  // final List<SingleRentEntry> rentEntries;
  final String introText;
  final Property property;

  const RentPerPropertyTable({
    super.key,
    // required this.rentEntries,
    required this.introText,
    required this.property,
  });

  @override
  ConsumerState<RentPerPropertyTable> createState() =>
      _RentPerPropertyTableState();
}

class _RentPerPropertyTableState extends ConsumerState<RentPerPropertyTable> {
  String searchQuery = '';
  List<SingleRentEntry> rentEntries = [];

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);

    List<RentalRecord> rentalRecords = appData.rentalRecords
        .where((record) => record.propertyId == widget.property.propertyId)
        .toList();

    rentEntries = rentalRecords
        .expand(
          (record) => record.rentHistory.rentalMonths.expand(
            (month) => month.rentEntries,
          ),
        )
        .toList();
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

    return ReusableDataTableWidget<SingleRentEntry>(
      items: rentEntries,
      searchHint: 'Search ',
      cardTitle: 'Rent records / Property',
      columns: [
        DataColumn(label: SizedBox(width: 18, child: Text("#"))),

        DataColumn(label: Text("Property", style: headerStyle)),
        // DataColumn(label: Text("Unit", style: headerStyle)),
        DataColumn(label: Text("No of Records", style: headerStyle)),
        DataColumn(label: Text('Amount', style: headerStyle)),
        DataColumn(label: Text("View", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (rentalRecord, query) {
        String? unitName =
            appData.units
                .where((unit) => unit.unitId == rentalRecord.unitId)
                .singleOrNull
                ?.unitName ??
            '';
        String? tenantName =
            appData.tenants
                .where((tenant) => tenant.tenantId == rentalRecord.tenantId)
                .singleOrNull
                ?.tenantName ??
            '';
        return tenantName.toLowerCase().contains(query) ||
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
      rowBuilder: (rentalRecord, index) {
        String? unitName =
            appData.units
                .where((unit) => unit.unitId == rentalRecord.unitId)
                .singleOrNull
                ?.unitName ??
            '';
        String? tenantName =
            appData.tenants
                .where((tenant) => tenant.tenantId == rentalRecord.tenantId)
                .singleOrNull
                ?.tenantName ??
            '';

        // List<SingleRentEntry> rentEntriesRecords = widget.rentEntries
        //     .where((record) => record.tenantId == tenant.tenantId)
        //     .toList();
        final double totalRent = rentalRecord.amountPaid;

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
                          getInitials(tenantName),
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tenantName,
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
            DataCell(Text(rentEntries.length.toString(), style: labelStyle)),
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
                            RentRecordsPerPropertyState(
                              property: widget.property,

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
