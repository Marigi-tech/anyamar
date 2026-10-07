import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/reusable_widgets/badges/payment_method_badge.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancesTable extends ConsumerStatefulWidget {
  final bool? isFromHomePage;
  const FinancesTable({super.key, this.isFromHomePage});

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
    final appData = ref.watch(appDataProvider);
    final finances = widget.isFromHomePage == true
        ? appData.finances
              .take(5)
              .toList() //limit this to ten list items
        : appData.finances;
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
      cardTitle: widget.isFromHomePage == true ? 'Recent Payments' : '',
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
        final SingleRentEntry? rentEntry = appData.rentRecords
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
                                .read(financesPageProvider.notifier)
                                .viewRentEntryRecord(rentEntry)
                          : ref
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
                          rentEntry != null
                              ? ref
                                    .read(financesPageProvider.notifier)
                                    .viewRentEntryRecord(rentEntry)
                              : ref
                                    .read(financesPageProvider.notifier)
                                    .viewFinancialRecord(financialRecord);

                          break;

                        case 'edit':
                          rentEntry != null
                              ? ref
                                    .read(financesPageProvider.notifier)
                                    .updateRentEntryRecord(rentEntry)
                              : ref
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
                            Icon(CupertinoIcons.info, size: 18),
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

                      // const PopupMenuItem(
                      //   value: 'delete',
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.delete_outline, size: 18),
                      //       SizedBox(width: 10),
                      //       Text('Delete'),
                      //     ],
                      //   ),
                      // ),
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

List<DataColumn> buildFinancialRecordsHeaderRows() {
  return [
    const DataColumn(
      label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text(
        "Payment date",
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
    ),
    const DataColumn(
      label: Text("Amount", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(label: Text('')),
    const DataColumn(
      label: Text("Record Type", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Payment By", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    const DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Update", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Delete", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildFinancialRecordsDataRow(
  int index,
  FinancialRecord financialRecord,
  BuildContext context,
  WidgetRef ref,
) {
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);
  final currentUser = ref.watch(authServiceProvider).currentUser;

  RentHistory? currentRentHistory;
  RentalMonth? currentMonth;
  SingleRentEntry? currentEntry;

  Future<bool?> showDeleteConfirmationDialog(
    BuildContext context,
    FinancialRecord financialRecord,
  ) async {
    final db = DbRentalService();
    final myRentHistories = await db.getUserRentHistory(currentUser!.uid);
    for (final history in myRentHistories) {
      for (final month in history.rentalMonths) {
        for (final entry in month.rentEntries) {
          if (entry.rentEntryId == financialRecord.recordId) {
            currentEntry = entry;
            currentRentHistory = history;
            currentMonth = month;
            break;
          }
        }

        if (currentEntry != null) {
          break;
        }
      }

      if (currentEntry != null) {
        break;
      }
    }

    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertModal(
          dialogTitle: financialRecord.recordType == FinancialRecordTypes.rent
              ? 'Rental Entry'
              : 'Financial Record',
          isDeleteModal: true,
          recordId: financialRecord.recordType == FinancialRecordTypes.rent
              ? currentEntry?.rentEntryId
              : financialRecord.recordId,
        );
      },
    );
  }

  return DataRow(
    onLongPress: () => showDialog(
      context: context,
      builder: (context) =>
          financialRecord.recordType == FinancialRecordTypes.rent
          ? RentEntryModal(rentEntry: currentEntry!)
          : FinancialRecordModal(financialRecord: financialRecord),
    ),
    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(
        Text(formatPrettyDate(financialRecord.datePaid), style: cellStyle),
      ),
      DataCell(
        Text(
          'KSH ${formatMoney(financialRecord.amountPaid)} ',
          style: cellStyle,
        ),
      ),
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 80, maxHeight: 30),
          child: InformationBadge(
            text: financialRecord.recordNature.label,
            textColor: getPaymentType(financialRecord.recordNature).textColor,
            badgeColor: getPaymentType(financialRecord.recordNature).badgeColor,
          ),
        ),
      ),
      DataCell(Text(financialRecord.recordType.label, style: cellStyle)),
      DataCell(Text(financialRecord.paymentBy.personName, style: cellStyle)),

      DataCell(
        ViewChevronCard(
          onPressedCallBack: () {
            showDialog(
              context: context,
              builder: (context) =>
                  financialRecord.recordType == FinancialRecordTypes.rent &&
                      currentEntry != null
                  ? RentEntryModal(rentEntry: currentEntry!)
                  : FinancialRecordModal(financialRecord: financialRecord),
            );
          },
        ),
      ),
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.pencil,
          onPressedCallBack: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return financialRecord.recordType != FinancialRecordTypes.rent
                      ? ExpenseRecord(
                          financialRecord: financialRecord,
                        ) //todo: Update Rent revene records
                      : AddRentalRecord();
                },
              ),
            );
          },
        ),
      ),
      //Delete
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.trash,
          iconColor: AppColorsConstant.redColor,
          onPressedCallBack: () async {
            final shouldDelete = await showDeleteConfirmationDialog(
              context,
              financialRecord,
            );
            // User pressed Cancel or dismissed the dialog
            if (shouldDelete != true) {
              return;
            }

            LazyLoader lazyLoader = LazyLoader(context: context);
            lazyLoader.showLoader();
            final db = DbFinancesService();
            final rentDb = DbRentalService();
            try {
              final isSuccessful =
                  currentEntry != null &&
                      currentRentHistory != null &&
                      currentMonth != null
                  ? await rentDb.deleteRentEntry(
                      currentEntry!,
                      currentMonth!,
                      currentRentHistory!,
                    )
                  : await db.deleteFinancialRecord(financialRecord);
              if (isSuccessful) {
                await ref
                    .read(userInformationProvider.notifier)
                    .removeFinance(financialRecord.recordId);
                displaySnackBar(
                  context,
                  'Record deleted succesfully',
                  AppColorsConstant.greenColor,
                );
              }
              //
            } catch (e) {
              displaySnackBar(
                context,
                'Error $e occured when deleting the record',
                AppColorsConstant.redColor,
              );
            } finally {
              lazyLoader.hideLoader();
            }
          },
        ),
      ),
    ],
  );
}
