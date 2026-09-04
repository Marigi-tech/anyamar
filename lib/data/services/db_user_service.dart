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
    DocumentReference doc = _usersRef.doc(user.userId);
    final AppUser newUser = user;
    await doc.set(newUser.toJson());

    return newUser;
  }

  //update user
  Future<AppUser> updateUser(AppUser appUser) async {
    //todo: when testing is complete use this method

    final snapshot = await _usersRef
        .where('userId', isEqualTo: appUser.userId)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      throw Exception('No user document found for userId: ${appUser.userId}');
    }

    final doc = snapshot.docs.first.reference;

    await doc.update(appUser.toJson());

    return appUser;
  }

  //fetch user
  Future<AppUser?> getUserByUserId(String userId) async {
    try {
      final doc = await _usersRef.doc(userId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      final currentUser = AppUser.fromJson(doc.data() as Map<String, dynamic>);

      log(
        'current user id: ${currentUser.userId}, '
        'current user name: ${currentUser.userName}',
      );

      return currentUser;
    } catch (e, stackTrace) {
      log(
        'Error getting user by ID: $userId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
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
