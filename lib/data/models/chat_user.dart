import 'package:anyamar/data/models/enums/user_type_enum.dart';

class ChatUser {
  final String userName;
  final String? phoneNumber;
  final String userId;
  final String? email;
  final UserType userType;
  ChatUser({
    required this.userName,
    this.phoneNumber,
    required this.userId,
    this.email,
    required this.userType,
  });
}
