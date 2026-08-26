import 'dart:developer';

import 'package:anyamar/data/models/users/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//todo:use riverpod for state management
ValueNotifier<DbService> dbServiceNotifier = ValueNotifier(DbService());
// Add this provider where you define your services
final dbServiceProvider = Provider<DbService>((ref) {
  return DbService();
});

class DbService {
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection(
    'users',
  );
  // AppUser? get currentAppUser =>;

  Future<AppUser?> createUser(AppUser user) async {
    DocumentReference doc = _usersRef.doc();
    final AppUser newUser = user;
    await doc.set(newUser.toJson());

    return newUser;
  }

  //update user
  Future<void> updateUser(
    String userId,
    Map<String, dynamic> dataToUpdate,
  ) async {
    try {
      await _usersRef.doc(userId).update(dataToUpdate);
    } catch (e) {
      rethrow;
    }
  }

  //fetch user
  Future<AppUser> getUserByUserId(String userId) async {
    AppUser? user;

    try {
      DocumentSnapshot userRef = await _usersRef.doc(userId).get();
      user = AppUser.fromJson(userRef.data() as Map<String, dynamic>);
    } catch (e) {
      log('error in get by user id: $e');
      rethrow;
    }
    log('returning esom user from db: $userId, ${user.toJson()}');

    return user;
  }

  // Get user by email and password
  Future<AppUser?> getUserByEmail(String? userEmail) async {
    AppUser? user;

    try {
      QuerySnapshot snapshot = await _usersRef
          .where('userEmail', isEqualTo: userEmail)
          .get();
      if (snapshot.docs.isNotEmpty) {
        user = AppUser.fromJson(
          snapshot.docs[0].data() as Map<String, dynamic>,
        );
      }
    } on FirebaseException catch (e) {
      log('error retrieving email by id: $e');
      rethrow;
    }
    return user;
  }

  //todo: delete user
  Future<void> deleteUser() async {}

  //todo: validate user

  //todo: emailverification

  //todo: reset password
}
