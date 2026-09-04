import 'package:anyamar/commons/exports.dart';

class IdentityDocumentInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toUpperCase();

    // Maximum length
    if (text.length > 15) {
      return oldValue;
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

String? validateIdentityDocument(String? value, {bool required = true}) {
  final documentNumber = value?.trim() ?? '';

  if (documentNumber.isEmpty) {
    return required ? 'Enter National Id  / Passport number' : null;
  }

  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(documentNumber)) {
    return 'Use only letters and numbers';
  }
    if (documentNumber.length < 6 || documentNumber.length > 15) {
    return 'Enter a valid document number';
  }

  return null;
}

// String? validateIdentityDocument(String? value) {
//   if (value == null || value.trim().isEmpty) {
//     return 'Enter National ID or Passport number';
//   }

//   final documentNumber = value.trim();

//   if (!RegExp(r'^[A-Z0-9]+$').hasMatch(documentNumber)) {
//     return 'Use only letters and numbers';
//   }

//   if (documentNumber.length < 6 || documentNumber.length > 15) {
//     return 'Enter a valid document number';
//   }

//   return null;
// }
