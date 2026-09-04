class MonthModel {
  final String monthName;
  final int monthNumber;
  const MonthModel({required this.monthName, required this.monthNumber});
}

List<MonthModel> appMonths = [
  MonthModel(monthName: 'January', monthNumber: 1),
  MonthModel(monthName: 'February', monthNumber: 2),
  MonthModel(monthName: 'March', monthNumber: 3),
  MonthModel(monthName: 'April', monthNumber: 4),
  MonthModel(monthName: 'May', monthNumber: 5),
  MonthModel(monthName: 'June', monthNumber: 6),
  MonthModel(monthName: 'July', monthNumber: 7),
  MonthModel(monthName: 'August', monthNumber: 8),
  MonthModel(monthName: 'September', monthNumber: 9),
  MonthModel(monthName: 'October', monthNumber: 10),
  MonthModel(monthName: 'November', monthNumber: 11),
  MonthModel(monthName: 'December', monthNumber: 12),
];

int getMonthNumber(String monthName) {
  final month = appMonths.firstWhere(
    (month) => month.monthName.toLowerCase() == monthName.toLowerCase(),
    orElse: () => MonthModel(monthName: '', monthNumber: 0),
  );

  return month.monthNumber;
}
