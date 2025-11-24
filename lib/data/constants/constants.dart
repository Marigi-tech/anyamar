import 'package:flutter/material.dart';
import 'package:test_app/data/models/social_icon_model.dart';
export 'package:flutter_svg/flutter_svg.dart';

//Dictates the app's theme (dark or light)
class AppThemeModeConstant {
  static const String darkKey = 'isDarkKey';
}

//Dictates the app's text styles
class AppTextStylesConstant {
  static const TextStyle cardTitleStyle = TextStyle(
    color: Colors.teal,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle cardDescriptionStyle = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
  );
}

//Dictates App Colors
class AppColorsConstant {
  static const Color greenColor = Color.fromARGB(255, 69, 250, 78);
  static const Color lightGreenColor = Color.fromARGB(255, 4, 175, 13);
  static const Color darkGreenColor = Color.fromARGB(255, 7, 133, 9);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color yellowColor = Colors.yellowAccent;
  static const Color lightYellowColor = Colors.yellow;
  static const Color darkYellowColor = Color.fromARGB(255, 249, 168, 37);
  static const Color blueColor = Colors.blue;
  static const Color lightBlueColor = Colors.lightBlue;
  static const Color darkBlueColor = Color.fromARGB(255, 13, 71, 161);
  static const Color blueGreyColor = Colors.blueGrey;
  static const Color darkNavColor = Color.fromARGB(255, 51, 48, 48);
  static const Color lightNavColor = Color.fromARGB(255, 250, 245, 245);
}

//Dictates social signups
class AppSocialIconConstant {
  //? googleIcon
  static SocialIconModel googleIcon = SocialIconModel(
    iconPath: 'assets/icons/svg/google.svg',
    iconName: 'Continue with google',
  );
  //? apple
  static SocialIconModel appleIcon = SocialIconModel(
    iconPath: 'assets/icons/svg/apple.svg',
    iconName: 'Continue with apple',
  );
  //? meta Icon
  static SocialIconModel metaIcon = SocialIconModel(
    iconPath: 'assets/icons/svg/meta.svg',
    iconName: 'Continue with meta',
  );
}
