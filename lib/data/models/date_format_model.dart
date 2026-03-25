import 'package:intl/intl.dart';

String formatPrettyDate(DateTime date) {
  final dayName = DateFormat('EE').format(date); // DAY
  final month = DateFormat('MMM').format(date); // MONTH
  final year = DateFormat('yyyy').format(date); // YEAR

  return "$dayName , ${date.day} $month $year";
}

String formatStandardDate(DateTime date) {
  final dayName = DateFormat('dd').format(date); // DAY
  final month = DateFormat('MM').format(date); // MONTH
  final year = DateFormat('yy').format(date); // YEAR

  return "$dayName,$month,$year";
}

String formatJustTheTime(DateTime date) {
  final hourMinute = DateFormat.jm().format(date);

  return hourMinute;
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String formatDayName(DateTime date) {
  final now = DateTime.now();

  if (isSameDay(date, now)) return "TODAY";

  final yesterday = now.subtract(const Duration(days: 1));
  if (isSameDay(date, yesterday)) return "YESTERDAY";

  return "${date.day}/${date.month}/${date.year}";
}
