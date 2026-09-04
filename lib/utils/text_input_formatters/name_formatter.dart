// String? validateUserName(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return 'Enter full name';
//   }

//   if (value.trim().length < 2) {
//     return 'Enter a valid name';
//   }

//   if (!RegExp(r"^[a-zA-Z]+([ '-][a-zA-Z]+)*$").hasMatch(value.trim())) {
//     return 'Enter a valid name';
//   }

//   return null;
// }
String? validateUserName(String? value, {bool required = true}) {
  final userName = value?.trim() ?? '';

  if (userName.isEmpty) {
    return required ? 'Enter Full name' : null;
  }

  if (userName.length < 2) {
    return 'Enter a valid name';
  }

  if (!RegExp(r"^[a-zA-Z]+([ '-][a-zA-Z]+)*$").hasMatch(userName.trim())) {
    return 'Enter a valid name';
  }

  return null;
}
