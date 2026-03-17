import 'package:intl/intl.dart';

String formatPrettyDate(DateTime date) {
  final dayName = DateFormat('EE').format(date); // DAY
  final month = DateFormat('MMM').format(date); // MONTH
  final year = DateFormat('yyyy').format(date); // YEAR

  return "$dayName , ${date.day} $month $year";
}

String formatStandardDate(DateTime date) {
  final dayName = DateFormat('d').format(date); // DAY
  final month = DateFormat('MM').format(date); // MONTH
  final year = DateFormat('yy').format(date); // YEAR

  return "$dayName , ${date.day} $month $year";
}
