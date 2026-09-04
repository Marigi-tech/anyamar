import 'package:anyamar/commons/exports.dart';


class UnitRentHistory extends ConsumerStatefulWidget {
  final Unit unit;
  const UnitRentHistory({super.key, required this.unit});

  @override
  ConsumerState<UnitRentHistory> createState() => _UnitRentHistoryState();
}

class _UnitRentHistoryState extends ConsumerState<UnitRentHistory> {
  List<Tenant> myTenants = [];
  final entriesWithHistory = <(SingleRentEntry, RentHistory)>[];

  @override
  Widget build(BuildContext context) {
    //get all tenants who have lived in this unit
    myTenants = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((tenant) => tenant.unitId == widget.unit.unitId)
        .toList();
    //get all their rentEntries
    for (final tenant in myTenants) {
      final historyAsync = ref.watch(rentProvider(tenant.tenantId!));

      historyAsync.whenData((history) {
        if (history == null) return;

        for (final month in history.rentalMonths) {
          for (final rentEntry in month.rentEntries) {
            entriesWithHistory.add((rentEntry, history));
          }
        }
      });
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomDataTable(
                    customDataColumns: [...buildRentalEntryColumns()],
                    customDataRows: [
                      ...entriesWithHistory.toList().asMap().entries.map((
                        entry,
                      ) {
                        int index = entry.key;
                        SingleRentEntry rentEntry = entry.value.$1;
                        RentHistory rentHistory = entry.value.$2;

                        double? totalAmountPayableMonthly;

                        totalAmountPayableMonthly = rentEntry.amountPayable;

                        final totalPaid = rentEntry.amountPaid;

                        PaymentStatus paymentStatus;
                        if (totalPaid == 0) {
                          paymentStatus = PaymentStatus.notPaid;
                        } else if (totalPaid < totalAmountPayableMonthly) {
                          paymentStatus = PaymentStatus.partial;
                        } else if (totalPaid == totalAmountPayableMonthly) {
                          paymentStatus = PaymentStatus.complete;
                        } else {
                          paymentStatus = PaymentStatus.excess;
                        }
                        log(paymentStatus.label);

                        return buildRentalEntryDataRow(
                          index + 1,
                          rentEntry,
                          context,
                          paymentStatus,
                          ref,
                          rentHistory,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //     },
    //   ),
    // );
  }
}
