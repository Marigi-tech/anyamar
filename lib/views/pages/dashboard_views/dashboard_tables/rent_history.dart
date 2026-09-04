import 'package:anyamar/commons/exports.dart';

List<DataColumn> buildRentalEntryColumns() {
  return [
    const DataColumn(
      label: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Month", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Amount", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    // const DataColumn(
    //   label: Text("Balance", style: TextStyle(fontWeight: FontWeight.w200)),
    // ),
    const DataColumn(
      label: Text("Status", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    const DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Delete", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildRentalEntryDataRow(
  int index,
  SingleRentEntry rentEntry,
  BuildContext context,
  PaymentStatus paymentStatus,
  WidgetRef ref,
  RentHistory rentHistory,
) {
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);
  // todo: get THE RENTAL MONTH GIVEN YOU HAVE THE RENT ENTRY;
  final monthIndex = rentHistory.rentalMonths.indexWhere(
    (month) => month.rentEntries.any(
      (entry) => entry.rentEntryId == rentEntry.rentEntryId,
    ),
  );

  final RentalMonth? currentMonth = monthIndex == -1
      ? null
      : rentHistory.rentalMonths[monthIndex];
  Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertModal(
          dialogTitle: 'Rental Entry',
          isDeleteModal: true,
          recordId: rentEntry.rentEntryId,
        );
      },
    );
  }

  return DataRow(
   
    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(Text(rentEntry.rentalMonth, style: cellStyle)),
      DataCell(
        Text('Ksh ${formatMoney(rentEntry.amountPaid)} ', style: cellStyle),
      ),

      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 150, maxHeight: 30),
          child: InformationBadge(
            text: paymentStatus.label,
            textColor: getPaymentStatus(paymentStatus).textColor,
            badgeColor: getPaymentStatus(paymentStatus).badgeColor,
          ),
        ),
      ),

      DataCell(
        ViewChevronCard(
          onPressedCallBack: () {},
          // onPressedCallBack: () => showDialog(
          //   context: context,
          //   builder: (context) => RentEntryModal(rentalMonth: currentMonth),
          // ),
        ),
      ),
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.trash,
          iconColor: AppColorsConstant.redColor,
          onPressedCallBack: () async {
            final shouldDelete = await showDeleteConfirmationDialog(context);

            if (shouldDelete != true) {
              return;
            }

            // IMPORTANT:
            // Get the notifier BEFORE any await.
            final rentNotifier = ref.read(
              rentProvider(rentHistory.tenantId).notifier,
            );

            final lazyLoader = LazyLoader(context: context);

            lazyLoader.showLoader();

            final db = DbRentalService();

            try {
              // 1. Delete from Firestore
              final isSuccessful = await db.deleteRentEntry(
                rentEntry,
                currentMonth!,
                rentHistory,
              );

              if (!isSuccessful) {
                return;
              }

              // 2. Update the already-obtained notifier.
              //
              // We are NOT calling ref.read() after await.
              await rentNotifier.removeRentEntryFromMemory(rentEntry);

              if (!context.mounted) {
                return;
              }

              displaySnackBar(
                context,
                'Rent entry deleted successfully',
                AppColorsConstant.greenColor,
              );
            } catch (e) {
              if (!context.mounted) {
                return;
              }

              displaySnackBar(
                context,
                'Error $e occurred when deleting the rent entry',
                AppColorsConstant.redColor,
              );
            } finally {
              if (context.mounted) {
                lazyLoader.hideLoader();
              }
            }
          },
        ),
      ),
    ],
  );
}
