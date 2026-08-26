import 'dart:developer';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbRentalServiceProvider = Provider<DbRentalService>((ref) {
  return DbRentalService();
});

// final currentTenantProvider = StreamProvider<DbRentalService?>((ref) {
//   final tenantRentHistory =  ref.watch(dbRentalServiceProvider);
//   return tenantRentHistory;
// });
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
    RentHistory currentRentHistory,
  ) async {
   
    final rentalEntry = rentEntry.toJson();
    final updatedHistory = currentRentHistory.copyWith(
      rentEntries: [...currentRentHistory.rentEntries, rentalEntry],
    );
    final DocumentReference doc = _rentHistoryRef.doc(
      currentRentHistory.historyId,
    );
    try {
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
  //
  //todo: get all rental records belonging to a specific tenant
  //todo: get all expenses belonging to a specific property
  //todo: get all user expenses
  //todo: get all generated income
  //todo: get all deposits
  //todo: update Tenant

  //todo: delete Tenant
}
