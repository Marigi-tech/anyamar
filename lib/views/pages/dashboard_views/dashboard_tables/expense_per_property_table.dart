import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';

class ExpensesPerPropertyTable extends ConsumerStatefulWidget {
  final List<Property> properties;
  final List<FinancialRecord> expenseRecords;

  const ExpensesPerPropertyTable({
    super.key,
    required this.properties,
    required this.expenseRecords,
  });

  @override
  ConsumerState<ExpensesPerPropertyTable> createState() =>
      _ExpensesPerPropertyTableState();
}

class _ExpensesPerPropertyTableState
    extends ConsumerState<ExpensesPerPropertyTable> {
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

    return ReusableDataTableWidget<Property>(
      items: widget.properties,
      searchHint: 'Search ',

      columns: [
        DataColumn(label: SizedBox(width: 18, child: Text("#"))),
        DataColumn(label: Text("Property", style: headerStyle)),
        DataColumn(label: Text("Units", style: headerStyle)),
        DataColumn(label: Text("No of records", style: headerStyle)),
        DataColumn(label: Text('Total expenses', style: headerStyle)),
        DataColumn(label: Text("Actions", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (property, query) {
        // final paymentMethod = expenseRecord.paymentMethod?.label ?? '';
        // final recordType = expenseRecord.recordType.label;
        // final recordNature = expenseRecord.recordNature.label;
        // final amount = expenseRecord.amountPaid.toString();
        // final personName = expenseRecord.paymentBy.personName;
        // final datePaid = formatPrettyDate(expenseRecord.datePaid);
        // Property? property = widget.properties
        //     .where(
        //       (property) => property.propertyId == expenseRecord.propertyId,
        //     )
        //     .singleOrNull;
        final propertyName = property.propertyName;

        return propertyName.toLowerCase().contains(query);
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
      rowBuilder: (property, index) {
        // final PaymentMethods? paymentMethod = expenseRecord.paymentMethod;
        // final recordType = expenseRecord.recordType.label;
        // final amount = expenseRecord.amountPaid;
        // final personName = expenseRecord.paymentBy.personName;
        // Property? property = widget.properties
        //     .where(
        //       (property) => property.propertyId == expenseRecord.propertyId,
        //     )
        //     .singleOrNull;
        final propertyName = property.propertyName;
        final units = appData.units
            .where((unit) => unit.propertyId == property.propertyId)
            .toList();
        final expenses = appData.finances
            .where(
              (expense) =>
                  expense.recordNature == FinancialRecordNature.expense,
            )
            .toList();
        List<FinancialRecord> expenseRecords = expenses
            .where((record) => record.propertyId == property.propertyId)
            .toList();
        final double totalExpense = expenseRecords.fold<double>(
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
                        // formatPrettyDate(expenseRecord.datePaid),
                        propertyName,
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
            DataCell(Text(units.length.toString(), style: labelStyle)),
            DataCell(Text(expenseRecords.length.toString(), style: labelStyle)),
            DataCell(
              Text(
                formatMoneyWithCurrency(totalExpense, 'Ksh'),
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
                          .read(financesPageProvider.notifier)
                          .viewPropertyExpenses(property);
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
                          ref
                              .read(financesPageProvider.notifier)
                              .viewPropertyExpenses(property);

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
