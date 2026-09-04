import 'package:flutter/material.dart';

//?Shadow colors
const shadow1 = Colors.grey;
const shadow2 = Colors.white54;

class AppShadows {
  static List<BoxShadow> buttonShadow = [
    BoxShadow(color: shadow1, offset: Offset(4, 4), blurRadius: 2),
    BoxShadow(color: shadow2, offset: Offset(-2, -2), blurRadius: 2),
  ];
}
