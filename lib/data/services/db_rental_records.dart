import 'dart:developer';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/rental_month/rental_month_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbRentalServiceProvider = Provider<DbRentalService>((ref) {
  return DbRentalService();
});

class DbRentalService {
  //Provider
  final CollectionReference _rentHistoryRef = FirebaseFirestore.instance
      .collection('rent_history');

  // Add rent History
  Future<RentHistory?> addRentHistory(RentHistory record) async {
    DocumentReference doc = _rentHistoryRef.doc();
    final RentHistory newRecord = record.copyWith(historyId: record.tenantId);
    try {
      await doc.set(newRecord.toJson());
    } on FirebaseException catch (e) {
      log('${e.message}');
    }
    return newRecord;
  }

  //Get all tenants' rent histories belonging to a user
  Future<List<RentHistory>> getUserRentHistory(String? userId) async {
    try {
      final snapshot = await _rentHistoryRef
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        return RentHistory.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      log('error retrieving rent histories for user : $userId. Error: $e');
      rethrow;
    }
  }

  Future<List<SingleRentEntry>> getAllRentEntriesForUser(String userId) async {
    final rentHistories = await getUserRentHistory(userId);

    return rentHistories
        .expand((history) => history.rentalMonths)
        .expand((rentalMonth) => rentalMonth.rentEntries)
        .toList();
  }
  // Future<List<SingleRentEntry>?> getAllRentEntriesForUser(String userId) async {
  //   final rentHistories = await getUserRentHistory(userId);

  //   final List<SingleRentEntry> allRentEntries = [];

  //   for (final history in rentHistories) {
  //     for (final entryMap in history.rentEntries) {
  //       allRentEntries.add(entryMap);
  //     }
  //   }

  //   return allRentEntries;
  // }

  //Get a tenants Rent History
  Future<RentHistory?> getRentHistory(String tenantId) async {
    try {
      final doc = await _rentHistoryRef.doc(tenantId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      return RentHistory.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e, stackTrace) {
      log(
        'Error retrieving rent history for tenant: $tenantId',
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  //Add rental entry (updating a rent history)
  Future<RentHistory?> addRentEntry(
    SingleRentEntry rentEntry,
    RentalMonth rentalMonth,
    RentHistory currentRentHistory,
  ) async {
    try {
      // Make a copy of the existing months
      final updatedRentalMonths = List<RentalMonth>.from(
        currentRentHistory.rentalMonths,
      );

      // Find the index of the month we want
      final monthIndex = updatedRentalMonths.indexWhere(
        (month) => month.rentalMonth == rentalMonth.rentalMonth,
      );

      if (monthIndex != -1) {
        // ---------------------------------------------
        // Month already exists
        // ---------------------------------------------

        final existingMonth = updatedRentalMonths[monthIndex];

        final updatedMonth = existingMonth.copyWith(
          rentEntries: [...existingMonth.rentEntries, rentEntry],
        );

        updatedRentalMonths[monthIndex] = updatedMonth;
      } else {
        // ---------------------------------------------
        // Month doesn't exist
        // ---------------------------------------------

        final newMonth = rentalMonth.copyWith(rentEntries: [rentEntry]);

        updatedRentalMonths.add(newMonth);
      }

      // ---------------------------------------------
      // Create updated RentHistory
      // ---------------------------------------------

      final updatedHistory = currentRentHistory.copyWith(
        rentalMonths: updatedRentalMonths,
      );

      // ---------------------------------------------
      // Save to Firestore
      // ---------------------------------------------

      final DocumentReference doc = _rentHistoryRef.doc(
        currentRentHistory.historyId,
      );

      await doc.set(updatedHistory.toJson());

      log(
        'Rent entry added successfully for tenant: '
        '${currentRentHistory.tenantId}',
      );

      return updatedHistory;
    } on FirebaseException catch (e, stackTrace) {
      log('Error adding rent entry: ${e.message}', stackTrace: stackTrace);

      rethrow;
    }
  }
  // Future<RentHistory?> addRentEntry(
  //   SingleRentEntry rentEntry,
  //   RentalMonth rentalMonth,
  //   RentHistory currentRentHistory,
  // ) async {
  //   final rentalEntry = rentEntry;
  //   //find specific month

  //   final updatedHistory = currentRentHistory.copyWith(

  //     rentalMonths: [...currentRentHistory.rentEntries, rentalEntry],
  //   );
  //   final DocumentReference doc = _rentHistoryRef.doc(
  //     currentRentHistory.historyId,
  //   );
  //   try {
  //     await doc.set(updatedHistory.toJson());
  //     log(
  //       'Rent entry added successfully for tenant: '
  //       '${currentRentHistory.tenantId}',
  //     );
  //     return updatedHistory;
  //   } on FirebaseException catch (e, stackTrace) {
  //     log('Error adding rent entry: ${e.message}', stackTrace: stackTrace);
  //     rethrow;
  //   }
  // }

  //Delete a Single Rent Record
  Future<bool> deleteRentEntry(
    SingleRentEntry rentEntry,
    RentalMonth rentalMonth,
    RentHistory currentRentHistory,
  ) async {
    try {
      // Copy the existing rental months
      final updatedRentalMonths = List<RentalMonth>.from(
        currentRentHistory.rentalMonths,
      );

      // Find the month containing this rent entry
      final monthIndex = updatedRentalMonths.indexWhere(
        (month) => month.rentalMonth == rentalMonth.rentalMonth,
      );

      if (monthIndex == -1) {
        log(
          'Rental month ${rentalMonth.rentalMonth} '
          'not found for tenant ${currentRentHistory.tenantId}',
        );
        return false;
      }

      // Get the existing month
      final existingMonth = updatedRentalMonths[monthIndex];

      // Remove the specific rent entry
      final updatedEntries = existingMonth.rentEntries
          .where((entry) => entry.rentEntryId != rentEntry.rentEntryId)
          .toList();

      // Update the month
      final updatedMonth = existingMonth.copyWith(rentEntries: updatedEntries);

      // Replace the old month with the updated month
      updatedRentalMonths[monthIndex] = updatedMonth;

      // Update the entire history
      final updatedHistory = currentRentHistory.copyWith(
        rentalMonths: updatedRentalMonths,
      );

      // Save to Firestore
      final doc = _rentHistoryRef.doc(currentRentHistory.historyId);

      await doc.set(updatedHistory.toJson());

      log(
        'Rent entry ${rentEntry.rentEntryId} deleted successfully '
        'from ${rentalMonth.rentalMonth}',
      );

      return true;
    } on FirebaseException catch (e, stackTrace) {
      log('Error deleting rent entry: ${e.message}', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<RentHistory> updateRentHistory(RentHistory rentHistory) async {
    final doc = _rentHistoryRef.doc(rentHistory.historyId);

    try {
      await doc.set(rentHistory.toJson());

      log(
        'Rent history updated successfully for '
        '${rentHistory.tenantId}',
      );

      return rentHistory;
    } on FirebaseException catch (e, stackTrace) {
      log('Error updating rent history: ${e.message}', stackTrace: stackTrace);

      rethrow;
    }
  }
}
//   Future<bool> deleteRentEntry(
//     SingleRentEntry rentEntry,
//     RentHistory currentRentHistory,

//   ) async {
//     bool isSuccessful = false;

//     final updatedEntries = currentRentHistory.rentEntries
//         .where((entry) => entry.rentEntryId != rentEntry.rentEntryId)
//         .toList();
//     final updatedHistory = currentRentHistory.copyWith(
//       rentEntries: updatedEntries,
//     );

//     final doc = _rentHistoryRef.doc(currentRentHistory.historyId);

//     try {
//       await doc.set(updatedHistory.toJson());
//       log('Rent entry deleted ');
//       isSuccessful = true;
//       return isSuccessful;
//     } on FirebaseException catch (e, stackTrace) {
//       log('Error deleting rent entry: ${e.message}', stackTrace: stackTrace);
//       rethrow;
//     }
//   }
// }
