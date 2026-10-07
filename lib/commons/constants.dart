import 'package:anyamar/commons/exports.dart';

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

class ThemeConstant {
  static const String darkKey = 'isDarkKey';
}

//Path constants
const svgIconsPath = 'assets/icons/svg/';
const pngIconsPath = 'assets/icons/png/';
const docIconsPath = 'assets/icons/png/docs';

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

String getInitials(String name) {
  return name
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase())
      .join();
}
