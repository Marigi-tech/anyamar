import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';

class RentalEntriesTable extends ConsumerStatefulWidget {
  final List<SingleRentEntry>? rentEntries;
  final Tenant? tenant;
  const RentalEntriesTable({super.key, this.rentEntries, this.tenant});

  @override
  ConsumerState<RentalEntriesTable> createState() => _RentalEntriesTableState();
}

class _RentalEntriesTableState extends ConsumerState<RentalEntriesTable> {
  String searchQuery = '';
  List<SingleRentEntry> rentEntries = [];

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);
    final units = appData.units;
    final rentRecords = appData.rentRecords;
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
      columns: [
        DataColumn(label: SizedBox(width: 11, child: Text("#"))),
        DataColumn(label: Text("Date Paid", style: headerStyle)),
        DataColumn(label: Text("Amount", style: headerStyle)),
        if (widget.tenant == null)
          DataColumn(label: Text("Tenant ", style: headerStyle)),
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
        final tenantName = rentEntry.tenantName ?? '';
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
                                  .withValues(alpha: 0.09),
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
            if (widget.tenant == null)
              DataCell(Text(tenantName, style: labelStyle)),
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
                            .read(financesPageProvider.notifier)
                            .viewRentEntryRecord(rentEntry);
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
                                .read(financesPageProvider.notifier)
                                .viewRentEntryRecord(rentEntry);
                            break;

                          case 'edit':
                            ref
                                .read(financesPageProvider.notifier)
                                .updateRentEntryRecord(rentEntry);
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
                              Icon(CupertinoIcons.info_circle, size: 18),
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
