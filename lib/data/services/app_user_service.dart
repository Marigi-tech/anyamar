import 'package:anyamar/data/models/users/app_user.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appUserProvider = FutureProvider<AppUser?>((ref) async {
  // 1. Watch the auth state stream
  final authStateAsync = ref.watch(authStateProvider);

  // 2. Safely extract the Firebase user data
  final firebaseUser = authStateAsync.value;

  // 3. If there is no logged-in user or email is null, return null
  if (firebaseUser == null || firebaseUser.email == null) {
    return null;
  }

  // 4. Use DbService to fetch the app user details
  final dbService = ref.read(dbServiceProvider);
  return await dbService.getUserByEmail(firebaseUser.email!);
});
