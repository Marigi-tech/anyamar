import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_expense_record_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_rent_entry_state_page.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancesTable extends ConsumerStatefulWidget {
  final bool? isFromHomePage;
  final String introText;
  final List<FinancialRecord>? financialRecords;
  const FinancesTable({
    super.key,
    this.isFromHomePage,
    required this.introText,
    this.financialRecords,
  });

  @override
  ConsumerState<FinancesTable> createState() => _FinancesTableState();
}

class _FinancesTableState extends ConsumerState<FinancesTable> {
  String searchQuery = '';
  // String propertyName = '';
  // String unitName = '';
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);
    final finances =
        widget.financialRecords ??
        (widget.isFromHomePage == true
            ? appData.finances
                  .take(5)
                  .toList() //limit this to ten list items
            : appData.finances);
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

    return ReusableDataTableWidget<FinancialRecord>(
      items: finances,
      cardTitle: widget.isFromHomePage == true
          ? 'Recent Payments'
          : 'Financial records',
      cardTitleButtonWidget: widget.isFromHomePage == true
          ? TextButton(
              onPressed: () {},
              child: Text(
                'View all',
                style: GoogleFonts.inter(
                  color: const Color(0xFF2469DB),
                  fontSize: 12,
                ),
              ),
            )
          : SizedBox.shrink(),

      searchHint: 'Search ',

      columns: [
        DataColumn(label: SizedBox(width: 8, child: Text("#"))),
        DataColumn(label: Text("Date Paid", style: headerStyle)),
        DataColumn(label: Text("Amount", style: headerStyle)),
        DataColumn(label: Text("Record Type ", style: headerStyle)),
        DataColumn(label: Text('Payment By ', style: headerStyle)),
        DataColumn(label: Text('Method ', style: headerStyle)),
        DataColumn(label: Text("View", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (financialRecord, query) {
        final paymentMethod = financialRecord.paymentMethod?.label ?? '';
        final recordType = financialRecord.recordType.label;
        final recordNature = financialRecord.recordNature.label;
        final amount = financialRecord.amountPaid.toString();
        final personName = financialRecord.paymentBy.personName;
        final paymentDate = formatPrettyDate(financialRecord.datePaid);

        return paymentMethod.toLowerCase().contains(query) ||
            recordType.toLowerCase().contains(query) ||
            recordNature.toLowerCase().contains(query) ||
            personName.toLowerCase().contains(query) ||
            paymentDate.toLowerCase().contains(query) ||
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
      rowBuilder: (financialRecord, index) {
        final PaymentMethods? paymentMethod = financialRecord.paymentMethod;
        final recordType = financialRecord.recordType.label;
        final amount = financialRecord.amountPaid;
        final personName = financialRecord.paymentBy.personName;
        //Check if this is a rent Entry
        final SingleRentEntry? rentEntry = appData.rentalRecords
            .where(
              (record) =>
                  record.rentEntry.rentEntryId == financialRecord.recordId,
            )
            .map((record) => record.rentEntry)
            .singleOrNull;

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
                        formatPrettyDate(financialRecord.datePaid),
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
            DataCell(
              Text(formatMoneyWithCurrency(amount, 'Ksh'), style: labelStyle),
            ),
            DataCell(Text(recordType, style: labelStyle)),
            DataCell(Text(personName, style: labelStyle)),
            DataCell(PaymentMethodBadge(method: paymentMethod)),
            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      rentEntry != null
                          ? ref
                                .read(workspaceProvider.notifier)
                                .openForm(
                                  ViewRentEntryStatePage(
                                    financialRecord: rentEntry,
                                    introText:
                                        '${widget.introText} / rent record',
                                  ),
                                )
                          : ref
                                .read(workspaceProvider.notifier)
                                .openForm(
                                  ViewExpenseRecordStatePage(
                                    financialRecord: financialRecord,
                                    introText:
                                        '${widget.introText} / expense record',
                                  ),
                                );
                    },
                    icon: const Icon(Icons.chevron_right, size: 15),
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
