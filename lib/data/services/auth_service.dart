import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// //todo:use riverpod for state management
// ValueNotifier<AuthService> authServiceNotifier = ValueNotifier(AuthService());
// 1. Provider for the AuthService instance

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

//A provider that listens to authstate changes
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges =>
      _firebaseAuth.authStateChanges(); //checking connection

  //create account
  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // sign in
  Future<UserCredential> signInUser({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // sign out
  Future<void> signOutUser() async {
    return _firebaseAuth.signOut();
  }

  //reset password
  Future<void> resetPassword({required String email}) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //update userName
  Future<void> updateUserName({required String newName}) async {
    return await currentUser!.updateDisplayName(newName);
  }

  //Delete account
  Future deleteAccount({
    required String email,
    required String password,
  }) async {
    // return await _firebaseAuth.(
    //   email: email,
    //   password: password,
    // );
    AuthCredential authCredential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    // AuthCredential authCredential = EmailAuthProvider.credential(
    //   email: email,
    //   password: password,
    // );
    await currentUser!.reauthenticateWithCredential(authCredential);
    await currentUser!.delete();
    await _firebaseAuth.signOut();
  }

  //verify email
  Future<void> verifyEmail() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      rethrow;
    }
  }
  //Sign in with google
  // Future<void> signInWithGoogle ()async  {
  //   final googleProvider = GoogleAuthProvider();

  // }
  // / get user with userId
  //Fetch current user
  User? fetchCurrentUser() {
    User? authUser;
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        authUser = user;
        log('${authUser!.email}');
      }
    });
    return authUser;
  }

  //reset password from current password
  Future<void> passwordReset({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    AuthCredential authCredential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(authCredential);
    await currentUser!.reauthenticateWithCredential(authCredential);
    await currentUser!.updatePassword(newPassword);
  }
}
