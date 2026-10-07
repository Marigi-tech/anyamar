import 'package:anyamar/commons/exports.dart';

class UserNameText extends ConsumerWidget {
  final bool? isInitials;
  const UserNameText({super.key, this.isInitials});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appUserAsync = ref.watch(appUserProvider);
    final userInfo = ref.watch(userInformationProvider);
    String getInitials(String name) {
      return name
          .trim()
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .map((word) => word[0].toUpperCase())
          .join();
    }

    // return appUserAsync.when(
    //   data: (AppUser? user) {
    //     if (user == null) {
    //       return const Text('User not found');
    final userName = userInfo.appData?.appUser?.userName ?? '';
    //     }
    return isInitials == true
        ? Text(
            getInitials(userName).toUpperCase(),

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,

              color: Color(0xff164FE8),
            ),
          )
        : Text(userName, style: TextStyle(fontWeight: FontWeight.w600));
  }
}

class TenantNameText extends ConsumerWidget {
  final bool? isInitials;
  final String tenantName;
  const TenantNameText({super.key, this.isInitials, required this.tenantName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String getInitials(String name) {
      return name
          .trim()
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .map((word) => word[0].toUpperCase())
          .join();
    }

    return isInitials == true
        ? Text(
            getInitials(tenantName).toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff164FE8),
            ),
          )
        : Text(tenantName, style: TextStyle(fontWeight: FontWeight.w600));
  }
}
