import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';

class AppGradient {
  //Green color
  static const BoxDecoration gradientGreen = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.greenColor,
        AppColorsConstant.darkGreenColor,
        AppColorsConstant.lightGreenColor,
      ],
    ),
  );
  //Yellow color
  static const BoxDecoration gradientYellow = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.yellowColor,
        AppColorsConstant.lightYellowColor,
        AppColorsConstant.darkYellowColor,
      ],
    ),
  );

  //Blue color
  static const BoxDecoration gradientBlue = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.blueColor,
        AppColorsConstant.lightBlueColor,
        AppColorsConstant.darkBlueColor,
      ],
    ),
  );
  //Light Green
  static const BoxDecoration gradientLightGreen = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.darkGreenColor,
        AppColorsConstant.lightGreenColor,
        AppColorsConstant.greenColor,
      ],
    ),
  );
  //Light Yellow
  static const BoxDecoration gradientLightYellow = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.lightYellowColor,
        AppColorsConstant.darkYellowColor,
        AppColorsConstant.yellowColor,
      ],
    ),
  );
  //Light Blue
  static const BoxDecoration gradientLightBlue = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.lightBlueColor,
        AppColorsConstant.darkBlueColor,
        AppColorsConstant.blueColor,
      ],
    ),
  );
  //Transparent
  static const BoxDecoration gradientTransparent = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.transparent],
    ),
  );
  //Red color

  static const BoxDecoration gradientRed = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColorsConstant.redColor,
        Color.fromARGB(255, 207, 19, 5),
        Color.fromARGB(255, 121, 27, 21),
      ],
    ),
  );
  //Light Red
  static const BoxDecoration gradientLightRed = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 207, 19, 5),
        AppColorsConstant.redColor,
        Color.fromARGB(255, 121, 27, 21),
      ],
    ),
  );
}
