import 'dart:developer';

import 'package:anyamar/data/models/enums/payment_status_enum.dart';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/rent_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Todo: Filtering
class RentHistoryPage extends ConsumerStatefulWidget {
  final RentHistory rentHistory;
  final Tenant tenant;
  const RentHistoryPage({
    super.key,
    required this.rentHistory,
    required this.tenant,
  });

  @override
  ConsumerState<RentHistoryPage> createState() => _RentHistoryPageState();
}

class _RentHistoryPageState extends ConsumerState<RentHistoryPage> {
  List<SingleRentEntry> rentEntries = [];
  List<SingleRentEntry> filteredEntries = [];
  String searchQuery = '';
  //Function that searches through rent entries

  @override
  Widget build(BuildContext context) {
    final rentHistoryAsync = ref.watch(rentProvider(widget.tenant.tenantId!));
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
            child: rentHistoryAsync.when(
              loading: () => const CircularProgressIndicator(),

              error: (error, stackTrace) {
                return Text('Error loading rent history: $error');
              },

              data: (history) {
                if (history == null) {
                  return const Text('No rent history');
                }

                rentEntries = history.rentalMonths
                    .expand((month) => month.rentEntries)
                    .toList();
                // final List<SingleRentEntry> rentEntries = history.rentEntries
                //     .map((entry) => SingleRentEntry.fromJson(entry))
                //     .toList();

                // return RentHistoryTable(
                //   rentEntries: rentEntries,
                //   rentHistory: history,
                // );
                return CustomDataTable(
                  customDataColumns: [...buildRentalEntryColumns()],
                  customDataRows: [
                    ...rentEntries.asMap().entries.map((entry) {
                      int index = entry.key;
                      SingleRentEntry rentEntry = entry.value;
                      double balance =
                          rentEntry.amountPayable - rentEntry.amountPaid;

                      PaymentStatus paymentStatus = balance == 0
                          ? PaymentStatus.complete
                          : rentEntry.amountPaid != 0 && balance > 0
                          ? PaymentStatus.partial
                          : PaymentStatus.notPaid;
                      log('Payment Status : ${paymentStatus.label}');

                      return buildRentalEntryDataRow(
                        index + 1,
                        rentEntry,
                        context,
                        paymentStatus,
                        ref,
                        history,
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
