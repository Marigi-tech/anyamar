import 'package:test_app/data/models/enums/user_type_enum.dart';

class Person {
  final String userId;
  final String userName;
  final String email;
  final UserType userType;
  final String? phoneNumber;
  final String? nationalId;

  Person({
    required this.userId,
    required this.userName,
    required this.email,
    required this.userType,
    this.phoneNumber,
    this.nationalId,
  });
}
