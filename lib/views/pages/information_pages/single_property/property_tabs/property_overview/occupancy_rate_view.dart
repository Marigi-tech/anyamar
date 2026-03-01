import 'package:flutter/material.dart';

// Color getPercentageColor(double percentage) {
//   if (percentage < 20) {
//     return Colors.red;
//   } else if (percentage >= 20 && percentage < 50) {
//     return Colors.purple;
//   } else if (percentage >= 50 && percentage < 80) {
//     return Colors.orange;
//   } else {
//     return Colors.green;
//   }
// }

// String getOccupancyRate(double noOfTenants, double noOfUnits) {
//   return '${noOfTenants / noOfUnits * 100}';
// }
({String text, Color color}) getOccupancyInfo(
  double noOfTenants,
  double noOfUnits,
) {
  final percentage = (noOfUnits == 0) ? 0 : (noOfTenants / noOfUnits) * 100;

  Color color;
  if (percentage < 20) {
    color = Colors.red;
  } else if (percentage < 50) {
    color = Colors.purple;
  } else if (percentage < 80) {
    color = Colors.orange;
  } else {
    color = Colors.green;
  }

  return (text: "${percentage.toStringAsFixed(0)}%", color: color);
}
