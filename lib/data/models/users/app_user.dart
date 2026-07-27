import 'package:anyamar/data/models/enums/user_type_enum.dart';

class AppUser {
  final String userId;
  final String userName;
  final String email;
  final String password;
  final UserType userType;
  final String? phoneNumber;
  final String? nationalId;

  AppUser({
    required this.userId,
    required this.userName,
    required this.password,
    required this.email,
    required this.userType,
    this.phoneNumber,
    this.nationalId,
  });
}
