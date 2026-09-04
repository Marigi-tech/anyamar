import 'package:anyamar/commons/exports.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // Allow + only as the first character
    if (text.contains('+')) {
      text = '+${text.replaceAll('+', '')}';
    }

    // Remove anything that isn't a digit or +
    text = text.replaceAll(RegExp(r'[^0-9+]'), '');

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

String? validatePhoneNumber(String? value, {bool required = true}) {
  final phone = value?.trim() ?? '';

  if (phone.isEmpty) {
    return required ? 'Enter phone number' : null;
  }

  final phoneRegex = RegExp(r'^\+?[0-9]+$');

  if (!phoneRegex.hasMatch(phone)) {
    return 'Enter a valid phone number';
  }

  final digitsOnly = phone.replaceFirst('+', '');

  if (digitsOnly.length < 9 || digitsOnly.length > 15) {
    return 'Phone number must be between 9 and 15 digits';
  }

  return null;
}

// String? validatePhoneNumber(String? value, bool? canBeEmpty) {
//   if (canBeEmpty == true && (value == null || value.trim().isEmpty)) {
//     return 'Enter phone number';
//   }

//   final phone = value.trim();

//   // Optional + at the beginning, followed by digits
//   final phoneRegex = RegExp(r'^\+?[0-9]+$');

//   if (!phoneRegex.hasMatch(phone)) {
//     return 'Enter a valid phone number';
//   }

//   // Optional: enforce a reasonable length
//   final digitsOnly = phone.replaceFirst('+', '');

//   if (digitsOnly.length < 9 || digitsOnly.length > 15) {
//     return 'Phone number must be between 9 and 15 digits';
//   }

//   return null;
// }
