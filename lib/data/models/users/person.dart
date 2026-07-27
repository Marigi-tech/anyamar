import 'package:anyamar/data/models/enums/user_type_enum.dart';

class Person {
  final String? userId;
  final String userName;
  final String? email;
  final UserType? userType;
  final String? phoneNumber;
  final String? nationalId;

  Person({
    this.userId,
    required this.userName,
    this.email,
    this.userType,
    this.phoneNumber,
    this.nationalId,
  });
}
