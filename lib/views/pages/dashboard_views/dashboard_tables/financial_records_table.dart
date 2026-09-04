import 'package:anyamar/commons/exports.dart';

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
