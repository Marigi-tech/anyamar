import 'dart:developer';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbTenantServiceProvider = Provider<DbTenantService>((ref) {
  return DbTenantService();
});

class DbTenantService {
  //Provider
  final CollectionReference _tenantsRef = FirebaseFirestore.instance.collection(
    'tenants',
  );

  // Add Tenant
  Future<Tenant> addTenant(Tenant tenant) async {
    log('getting to the db service');
    DocumentReference doc = _tenantsRef.doc();
    final Tenant newTenant = tenant.copyWith(tenantId: doc.id);
    try {
      await doc.set(newTenant.toJson());
    } on FirebaseException catch (e) {
      log('${e.message}');
    }
    return newTenant;
  }

  //Get list of tenants

  Future<List<Tenant>> getUserTenants(String? userId) async {
    try {
      final snapshot = await _tenantsRef
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) {
        return Tenant.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      log('error retrieving tenants : $userId. Error: $e');
      rethrow;
    }
  }

  //todo: update Tenant
  Future<Tenant?> updateTenant(Tenant tenant) async {
    final DocumentReference doc = _tenantsRef.doc(tenant.tenantId);

    try {
      await doc.update(tenant.toJson());

      log('Tenant updated successfully: ${tenant.tenantId}');

      return tenant;
    } on FirebaseException catch (e, stackTrace) {
      log('Error updating tenant: $e', stackTrace: stackTrace);

      rethrow;
    }
  }

  //todo: delete Tenant
}
