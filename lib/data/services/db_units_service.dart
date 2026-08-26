import 'dart:developer';

import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbUnitServiceProvider = Provider<DbUnitsService>((ref) {
  return DbUnitsService();
});

class DbUnitsService {
  //Provider
  final CollectionReference _unitsRef = FirebaseFirestore.instance.collection(
    'units',
  );

  // Add Unit
  Future<Unit> addUnit(Unit unit) async {
    DocumentReference doc = _unitsRef.doc();

    final Unit newUnit = unit.copyWith(unitId: doc.id);
    try {
      await doc.set(newUnit.toJson());
    } on FirebaseException catch (e) {
      log('${e.message}');
    }
    return newUnit;
  }
  //Get list of Units belonging to a user

  Future<List<Unit>> getUserUnits(String? userId) async {
    try {
      final snapshot = await _unitsRef.where('userId', isEqualTo: userId).get();

      return snapshot.docs.map((doc) {
        return Unit.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      log('error retrieving properties of property: $userId. Error: $e');
      rethrow;
    }
  }

  //Update Unit
  Future<Unit> updateUnit(Unit unit) async {
    final DocumentReference doc = _unitsRef.doc(unit.unitId);

    try {
      await doc.update(unit.toJson());

      log('Unit updated successfully: ${unit.unitId}');

      return unit;
    } on FirebaseException catch (e, stackTrace) {
      log('Error updating unit: $e', stackTrace: stackTrace);

      rethrow;
    }
  }

  //todo: delete Unit
}
