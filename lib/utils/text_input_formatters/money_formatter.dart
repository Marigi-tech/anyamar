import 'package:flutter/services.dart';

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove everything except digits
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return const TextEditingValue();
    }

    // Add commas every 3 digits
    final formatted = formatMoneyValue(digits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String formatMoneyValue(String digits) {
  return digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => ',',
  );
}

String formatMoney(num amount) {
  return amount
      .toStringAsFixed(amount % 1 == 0 ? 0 : 2)
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
}
