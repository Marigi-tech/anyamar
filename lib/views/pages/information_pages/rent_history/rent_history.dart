import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/rent_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RentHistoryPage extends ConsumerWidget {
  final RentHistory rentHistory;
  final Tenant tenant;
  const RentHistoryPage({
    super.key,
    required this.rentHistory,
    required this.tenant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rentHistoryAsync = ref.watch(rentProvider(tenant.tenantId!));
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

                final List<SingleRentEntry> rentEntries = history.rentEntries
                    .map((entry) => SingleRentEntry.fromJson(entry))
                    .toList();

                return RentHistoryTable(rentEntries: rentEntries);
              },
            ),
          ),
        ),
      ),
    );
  }
}
