import 'dart:developer';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/users/person/person.dart';
import 'package:anyamar/data/services/db_rental_records.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbFinancesServiceProvider = Provider<DbFinancesService>((ref) {
  return DbFinancesService();
});

class DbFinancesService {
  String generateFinancialRecordId({required List<FinancialRecord> finances}) {
    final initials = 'FR';

    final existingIds = finances
        .map((entry) => entry.recordId)
        .whereType<String>();

    int highestNumber = 0;

    for (final id in existingIds) {
      // if (!id.startsWith(initials)) continue;

      final numberPart = id.substring(initials.length);

      final number = int.tryParse(numberPart);

      if (number != null && number > highestNumber) {
        highestNumber = number;
      }
    }

    final nextNumber = highestNumber + 1;

    return '$initials${nextNumber.toString().padLeft(4, '0')}';
  }

  //Provider
  final CollectionReference _financesRef = FirebaseFirestore.instance
      .collection('finances');

  // Add Record
  Future<FinancialRecord?> addRecord(FinancialRecord record) async {
    DocumentReference doc = _financesRef.doc();
    FinancialRecord? newRecord;
    try {
      await doc.set(record.toJson());
      newRecord = record;
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
        for (final rentalMonth in history.rentalMonths) {
          for (final entry in rentalMonth.rentEntries) {
            final financialRecord = FinancialRecord(
              recordId: entry.rentEntryId,
              datePaid: entry.paymentDate,
              amountPaid: entry.amountPaid,
              recordType: FinancialRecordTypes.rent,
              recordNature: FinancialRecordNature.revenue,
              paymentMethod: entry.paymentMethod,
              lastUpdatedDate: entry.lastUpdatedDate ?? DateTime.now(),
              paymentBy: Person(personName: history.tenantName ?? ''),
            );

            financialRecords.add(financialRecord);
          }
        }
      }
      // for (final history in rentHistories) {
      //   for (final entryMap in history.rentalMonths.rentEntries) {
      //     final SingleRentEntry entry = entryMap;

      //     final FinancialRecord financialRecord = FinancialRecord(
      //       recordId: entry.rentEntryId,
      //       datePaid: entry.paymentDate,
      //       amountPaid: entry.amountPaid,
      //       recordType: FinancialRecordTypes.rent,
      //       recordNature: FinancialRecordNature.revenue,
      //       paymentMethod: entry.paymentMethod,
      //       lastUpdatedDate: entry.lastUpdatedDate ?? DateTime.now(),
      //       paymentBy: Person(personName: history.tenantName ?? ''),
      //     );
      //     log(financialRecord.toString());

      //     financialRecords.add(financialRecord);
      //   }
      // }

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

  //Delete Financial record
  Future<bool> deleteFinancialRecord(FinancialRecord record) async {
    bool isSuccess = false;
    try {
      await _financesRef.doc(record.recordId).delete();
      log("Document successfully deleted!");
      isSuccess = true;
    } catch (e) {
      log("Error deleting document: $e");
      isSuccess = false;
    }
    return isSuccess;
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
