import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/data/services/db_rental_records.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rent_provider.g.dart';

@riverpod
class RentNotifier extends _$RentNotifier {
  @override
  FutureOr<RentHistory?> build(String tenantId) async {
    final db = DbRentalService();
    return await db.getRentHistory(tenantId);
  }
  Future<RentHistory?> addRentEntry(
    SingleRentEntry newEntry,
    RentHistory currentHistory,
  ) async {
    final db = DbRentalService();
    final updatedHistory = await db.addRentEntry(newEntry, currentHistory);

    state = AsyncData(updatedHistory);
    return updatedHistory;
  }

  Future<RentHistory?> addTenantRentHistory(RentHistory rentHistory) async {
    final db = DbRentalService();
    final addedHistory = await db.addRentHistory(rentHistory);
    state = AsyncData(addedHistory);
    return addedHistory;

  }

  void clearTenantRentHistory() {
    state = const AsyncData(null);
  }
}
