import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';

class ThemeConstant {
  static const String darkKey = 'isDarkKey';
}

class CustomTextStyles {
  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle cardDescriptionStyle = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle cardExtraDescriptionStyle = TextStyle(
    fontSize: 11,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle greenText = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: AppColorsConstant.lightGreenColor,
  );
}
