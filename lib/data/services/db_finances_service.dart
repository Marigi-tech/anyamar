import 'dart:developer';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:anyamar/data/services/db_rental_records.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbFinancesServiceProvider = Provider<DbFinancesService>((ref) {
  return DbFinancesService();
});

class DbFinancesService {
  //Provider
  final CollectionReference _financesRef = FirebaseFirestore.instance
      .collection('finances');

  // Add Record
  Future<FinancialRecord?> addRecord(FinancialRecord record) async {
    DocumentReference doc = _financesRef.doc();
    final FinancialRecord newRecord = record.copyWith(recordId: doc.id);
    try {
      await doc.set(newRecord.toJson());
    } on FirebaseException catch (e) {
      log('${e.message}');
    }
    return newRecord;
  }

  //Update Financial Record
  Future<FinancialRecord> updateRecord(FinancialRecord record) async {
    final DocumentReference doc = _financesRef.doc(record.recordId);
    try {
      await doc.set(record.toJson());
      log('Financial Recors updated succesfully ');
      return record;
    } on FirebaseException catch (e, stackTrace) {
      log(
        'Error updating financial record: ${e.message}',
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  //Get list of records
  Future<List<FinancialRecord>> getFinancialRecords(String? userId) async {
    try {
      // --------------------------------------------------
      // 1. Get existing financial records
      // --------------------------------------------------
      final snapshot = await _financesRef
          .where('userId', isEqualTo: userId)
          .get();

      final List<FinancialRecord> financialRecords = snapshot.docs.map((doc) {
        return FinancialRecord.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // --------------------------------------------------
      // 2. Get all rent histories for this user
      // --------------------------------------------------
      final rentDB = DbRentalService();

      final List<RentHistory> rentHistories = await rentDB.getUserRentHistory(
        userId,
      );

      // --------------------------------------------------
      // 3. Convert every rent entry into a FinancialRecord
      // --------------------------------------------------
      for (final history in rentHistories) {
        for (final entryMap in history.rentEntries) {
          final SingleRentEntry entry = SingleRentEntry.fromJson(entryMap);

          final FinancialRecord financialRecord = FinancialRecord(
            recordId: entry.rentEntryId,
            datePaid: entry.paymentDate,
            amountPaid: entry.amountPaid,
            recordType: FinancialRecordTypes.rent,
            recordNature: FinancialRecordNature.revenue,
            paymentMethod: entry.paymentMethod.label,
            lastUpdatedDate: entry.lastUpdatedDate ?? DateTime.now(),
            paymentBy: {'personName': history.tenantName},
          );
          log(financialRecord.toString());

          financialRecords.add(financialRecord);
        }
      }

      // --------------------------------------------------
      // 4. Return everything together
      // --------------------------------------------------
      return financialRecords;
    } catch (e, stackTrace) {
      log(
        'Error retrieving financial records for user: $userId. '
        'Error: $e',
        stackTrace: stackTrace,
      );

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
