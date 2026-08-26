import 'dart:developer';
import 'package:anyamar/data/models/users/app_user.dart';
import 'package:anyamar/data/services/app_user_service.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNameText extends ConsumerWidget {
  const UserNameText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserAsync = ref.watch(appUserProvider);
    final currentUser = FirebaseAuth.instance.currentUser;
    final checkProvider = ref.read(authServiceProvider).currentUser;
    log('Current user:  ${currentUser?.email}');
    log('Provider user : ${checkProvider?.email}');
    return appUserAsync.when(
      data: (AppUser? user) {
        if (user == null) {
          return const Text('User not found');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(user.userName),
        );
      },
      loading: () => const Text('Loading...'),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
