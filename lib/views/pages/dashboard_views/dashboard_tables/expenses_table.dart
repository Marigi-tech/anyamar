import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';

class ExpensesTable extends ConsumerStatefulWidget {
  const ExpensesTable({super.key});

  @override
  ConsumerState<ExpensesTable> createState() => _ExpensesTableState();
}

class _ExpensesTableState extends ConsumerState<ExpensesTable> {
  String searchQuery = '';
  // String propertyName = '';
  // String unitName = '';
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);
    final expenses = appData.finances
        .where((f) => f.recordNature == FinancialRecordNature.expense)
        .toList();

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
      items: expenses,

      searchHint: 'Search ',

      columns: [
        DataColumn(label: SizedBox(width: 8, child: Text("#"))),
        DataColumn(label: Text("Date Paid", style: headerStyle)),
        DataColumn(label: Text("Amount", style: headerStyle)),
        DataColumn(label: Text("Record Type ", style: headerStyle)),
        DataColumn(label: Text('Payment By ', style: headerStyle)),
        DataColumn(label: Text('Method ', style: headerStyle)),
        DataColumn(label: Text("Actions", style: headerStyle)),
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
        final datePaid = formatPrettyDate(financialRecord.datePaid);

        return paymentMethod.toLowerCase().contains(query) ||
            recordType.toLowerCase().contains(query) ||
            recordNature.toLowerCase().contains(query) ||
            personName.toLowerCase().contains(query) ||
            amount.toLowerCase().contains(query) ||
            datePaid.toLowerCase().contains(query);
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
                      ref
                          .read(financesPageProvider.notifier)
                          .viewFinancialRecord(financialRecord);
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
                              .viewFinancialRecord(financialRecord);

                          break;

                        case 'edit':
                          ref
                              .read(financesPageProvider.notifier)
                              .updateFinancialRecord(financialRecord);

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
