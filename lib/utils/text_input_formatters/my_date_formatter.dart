import 'package:anyamar/commons/exports.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only allow digits and /
    String text = newValue.text.replaceAll(RegExp(r'[^0-9/]'), '');

    // Remove existing separators so we can rebuild consistently
    final digits = text.replaceAll('/', '');

    if (digits.length > 8) {
      return oldValue;
    }

    // Build dd/MM/yyyy
    String formatted = '';

    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }

      formatted += digits[i];
    }

    // Work out where the cursor should go
    int cursorPosition = newValue.selection.baseOffset;

    final digitsBeforeCursor = newValue.text
        .substring(0, cursorPosition.clamp(0, newValue.text.length))
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length;

    cursorPosition = digitsBeforeCursor;

    if (digitsBeforeCursor >= 2) {
      cursorPosition++;
    }

    if (digitsBeforeCursor >= 4) {
      cursorPosition++;
    }

    cursorPosition = cursorPosition.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

String? validateDate(String? value) {
  final dateValue = value?.trim() ?? '';

  final currentDate = DateTime.now();

  if (dateValue.isEmpty) {
    return null;
  }

  final parts = dateValue.split('/');

  if (parts.length != 3) {
    return 'Use dd/MM/yyyy\n'
        'Example: ${formatStandardDate(currentDate)}';
  }

  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    return 'Invalid date';
  }

  final date = DateTime(year, month, day);

  if (date.year != year || date.month != month || date.day != day) {
    return 'Invalid date';
  }

  return null;
}

// String? validateDate(String? value) {
//   final parts = value!.split('/');
//   final currentDate = DateTime(
//     DateTime.now().year,
//     DateTime.now().month,
//     DateTime.now().day,
//   );
//   if (parts.length != 3) {
//     return 'Use dd/MM/yyyy \n Example : ${formatStandardDate(currentDate)}';
//   }

//   final day = int.tryParse(parts[0]);
//   final month = int.tryParse(parts[1]);
//   final year = int.tryParse(parts[2]);

//   if (day == null || month == null || year == null) {
//     return 'Invalid date';
//   }

//   final date = DateTime(year, month, day);

//   if (date.year != year || date.month != month || date.day != day) {
//     return 'Invalid date';
//   }

//   return null;
// }
