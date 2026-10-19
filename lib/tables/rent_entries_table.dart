import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_rent_entry_state_page.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';

class RentalEntriesTable extends ConsumerStatefulWidget {
  final List<SingleRentEntry>? rentEntries;
  final Tenant? tenant;
  final Unit? unit;
  final String introText;
  const RentalEntriesTable({
    super.key,
    this.rentEntries,
    this.tenant,
    this.unit,
    required this.introText,
  });

  @override
  ConsumerState<RentalEntriesTable> createState() => _RentalEntriesTableState();
}

class _RentalEntriesTableState extends ConsumerState<RentalEntriesTable> {
  String searchQuery = '';
  List<SingleRentEntry> rentEntries = [];

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);
    final units = appData.units;
    String introText = widget.introText;
    final rentRecords = appData.rentalRecords;
    if (widget.rentEntries != null) {
      rentEntries = widget.rentEntries ?? [];
    } else {
      for (var record in rentRecords) {
        rentEntries.add(record.rentEntry);
      }
    }

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

    return ReusableDataTableWidget<SingleRentEntry>(
      items: rentEntries,
      searchHint: 'Search ',
      cardTitle: 'Rental records',
      columns: [
        DataColumn(label: SizedBox(width: 11, child: Text("#"))),
        DataColumn(label: Text("Date Paid", style: headerStyle)),
        DataColumn(label: Text("Amount", style: headerStyle)),
        if (widget.unit != null)
          DataColumn(label: Text("Tenant ", style: headerStyle)),
        if (widget.tenant != null && widget.unit == null)
          DataColumn(label: Text("Unit ", style: headerStyle)),
        DataColumn(label: Text('Method ', style: headerStyle)),
        if (widget.tenant == null)
          DataColumn(label: Text("Actions", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (rentEntry, query) {
        final paymentMethod = rentEntry.paymentMethod.label;
        final tenantName = rentEntry.tenantName ?? '';
        final amount = rentEntry.amountPaid.toString();
        final paymentDate = formatPrettyDate(rentEntry.paymentDate);

        return paymentMethod.toLowerCase().contains(query) ||
            paymentDate.toLowerCase().contains(query) ||
            tenantName.toLowerCase().contains(query) ||
            amount.toLowerCase().contains(query);
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
      rowBuilder: (rentEntry, index) {
        final paymentMethod = rentEntry.paymentMethod;
        final unitTenant = appData.tenants
            .where((tenant) => tenant.unitId == widget.unit?.unitId)
            .singleOrNull;

        final tenantName =
            rentEntry.tenantName ?? (unitTenant?.tenantName ?? 'N/A');
        final unitName = units
            .where((unit) => unit.unitId == rentEntry.unitId)
            .singleOrNull
            ?.unitName;
        final amount = rentEntry.amountPaid;

        var number = index + 1;

        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 18,
                child: Text(
                  '${number++}',
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 150,
                child: SizedBox(
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
                                  .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          CupertinoIcons.calendar,
                          color:
                              avatarBackgroundColors[index %
                                  avatarBackgroundColors.length],
                          size: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          formatPrettyDate(rentEntry.paymentDate),
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
            ),
            DataCell(
              Text(formatMoneyWithCurrency(amount, 'Ksh'), style: labelStyle),
            ),
            if (widget.unit != null)
              DataCell(Text(tenantName, style: labelStyle)),
            if (widget.tenant != null && widget.unit == null)
              DataCell(Text(unitName ?? 'N/A', style: labelStyle)),
            DataCell(PaymentMethodBadge(method: paymentMethod)),
            if (widget.tenant == null)
              DataCell(
                Row(
                  children: [
                    IconButton(
                      tooltip: 'View',
                      onPressed: () {
                        ref
                            .read(workspaceProvider.notifier)
                            .openForm(
                              ViewRentEntryStatePage(
                                financialRecord: rentEntry,
                                introText: '$introText / rent record',
                              ),
                            );
                      },
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
                            ref
                                .read(workspaceProvider.notifier)
                                .openForm(
                                  ViewRentEntryStatePage(
                                    financialRecord: rentEntry,
                                    introText: '$introText / rent record',
                                  ),
                                );
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'view',
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.info_circle, size: 18),
                              SizedBox(width: 10),
                              Text('View'),
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
