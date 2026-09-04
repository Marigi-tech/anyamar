// String? validateEmail(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return 'Enter an email address';
//   }

//   final email = value.trim();

//   final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

//   if (!emailRegex.hasMatch(email)) {
//     return 'Enter a valid email address';
//   }

//   return null;
// }
String? validateEmail(String? value, {bool required = true}) {
  final email = value?.trim() ?? '';

  if (email.isEmpty) {
    return required ? 'Enter email address' : null;
  }

  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  if (!emailRegex.hasMatch(email)) {
    return 'Enter a valid email address';
  }

  return null;
}
