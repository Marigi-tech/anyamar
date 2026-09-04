import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/rental_month/rental_month_model.dart';
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

  // ============================================================
  // ADD RENT ENTRY TO A SPECIFIC RENTAL MONTH
  // ============================================================

  Future<RentHistory?> addRentEntry(
    SingleRentEntry newEntry,
    RentalMonth rentalMonth,
    RentHistory currentHistory,
  ) async {
    final db = DbRentalService();

    final updatedHistory = await db.addRentEntry(
      newEntry,
      rentalMonth,
      currentHistory,
    );

    state = AsyncData(updatedHistory);

    return updatedHistory;
  }
  //
  // ==========================================================
  // UPDATE STATE AFTER A CHANGE IN A RENT HISTORY
  //==========================================================

  // ============================================================
  // DELETE RENT ENTRY
  // ============================================================

  Future<RentHistory?> removeRentEntryFromMemory(
    SingleRentEntry rentEntry,
  ) async {
    final currentHistory = state.value;

    if (currentHistory == null) {
      return null;
    }

    // Go through every RentalMonth.
    //
    // If the rent entry exists inside that month,
    // remove it.
    //
    // Other months remain unchanged.
    final updatedMonths = currentHistory.rentalMonths.map((month) {
      final updatedEntries = month.rentEntries
          .where((entry) => entry.rentEntryId != rentEntry.rentEntryId)
          .toList();

      return month.copyWith(rentEntries: updatedEntries);
    }).toList();

    final updatedHistory = currentHistory.copyWith(rentalMonths: updatedMonths);

    // This is what causes widgets watching rentProvider(...)
    // to rebuild immediately.
    state = AsyncData(updatedHistory);

    return updatedHistory;
  }

  // ============================================================
  // ADD RENT HISTORY
  // ============================================================

  Future<RentHistory?> addTenantRentHistory(RentHistory rentHistory) async {
    final db = DbRentalService();

    final addedHistory = await db.addRentHistory(rentHistory);

    state = AsyncData(addedHistory);

    return addedHistory;
  }

  // ============================================================
  // CLEAR
  // ============================================================

  void clearTenantRentHistory() {
    state = const AsyncData(null);
  }
}
