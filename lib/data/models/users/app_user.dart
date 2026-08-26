import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    String? userId,
    required String userName,
    required String userEmail,
    required String userPassword,
    required String userType,
    String? userPhoneNumber,
    String? userNationalId,
    required DateTime registrationDate,
    @Default(false) bool isAuthenticated,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
