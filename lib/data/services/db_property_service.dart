import 'dart:developer';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbPropertyServiceProvider = Provider<DbPropertyService>((ref) {
  return DbPropertyService();
});

class DbPropertyService {
  //Provider
  final CollectionReference _propertiesRef = FirebaseFirestore.instance
      .collection('properties');

  // Add property
  Future<Property> addProperty(Property property) async {
    DocumentReference doc = _propertiesRef.doc();

    final Property newProperty = property.copyWith(propertyId: doc.id);
    final data = newProperty.toJson();
    try {
      log('Property JSON: $data');
      log(
        'propertyManager type: ${newProperty.propertyManager?.personName},',
      );
      await doc.set(data);

      log('Property entered succesfully : id: ${property.propertyId}');
    } on FirebaseException catch (e) {
      log('${e.message}');
    }
    return newProperty;
  }

  //Get list of properties

  Future<List<Property>> getUserProperties(String? userId) async {
    try {
      final snapshot = await _propertiesRef
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        return Property.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      log('error retrieving properties of user : $userId. Error: $e');
      rethrow;
    }
  }

  // Update property
  Future<Property?> updateProperty(Property property) async {
    final DocumentReference doc = _propertiesRef.doc(property.propertyId);
    try {
      await doc.update(property.toJson());
      log('Property updated successfully: ${property.propertyId}');
      return property;
    } on FirebaseException catch (e, stackTrace) {
      log('Error updating property: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

//Delete Property

  Future<bool> deletePropertyRecord(Property record) async {
    bool isSuccess = false;
    try {
      await _propertiesRef.doc(record.propertyId).delete();
      log("Document successfully deleted!");
      isSuccess = true;
    } catch (e) {
      log("Error deleting document: $e");
      isSuccess = false;
    }
    return isSuccess;
  }
}
