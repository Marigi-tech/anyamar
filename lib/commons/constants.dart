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
  static const Color lightNavColor = Color.fromARGB(255, 238, 239, 240);
  static const Color redColor = Colors.red;
  static const Color darkRedColor = Color.fromARGB(255, 133, 14, 6);
  static const Color transparentColor = Colors.transparent;
  static const orangeColor = Color.fromARGB(255, 240, 100, 31);
  static const kPrimaryColor = Color.fromRGBO(227, 237, 247, 1);
  static const kPrimaryLightColor = Color.fromARGB(255, 222, 252, 252);
  static const kWarningColor = Color(0xFFFFC00E);
  static const kLoadingColor = Color.fromRGBO(0, 116, 164, 1);
  static const kLoadingColor2 = Color.fromRGBO(0, 159, 112, 1);
  static const kLoadingColorContainer = Color(0xFF545CCC);
  static const kTransparent = Color.fromRGBO(0, 0, 0, 0);
  static const kWhite1 = Color.fromRGBO(255, 255, 255, 1);
  static const kWhite2 = Color.fromRGBO(229, 239, 250, 1);
  static const kWhite3 = Color.fromRGBO(228, 240, 250, 1);
  static const kWhite4 = Color.fromRGBO(255, 255, 255, 0.5);
  static const kWhite5 = Color.fromRGBO(227, 237, 247, 1);
  static const kWhite6 = Color.fromRGBO(237, 245, 252, 1);
  static const kWhite7 = Color.fromRGBO(255, 255, 255, 0.7);
  static const kGrey1 = Color.fromRGBO(110, 129, 160, 1);
  static const kGrey2 = Color.fromRGBO(255, 255, 255, 0.541);
  static const kGrey3 = Color.fromRGBO(158, 158, 158, 1);
  static const kGreen1 = Color.fromRGBO(0, 159, 112, 1);
  static const kGreen2 = Color.fromRGBO(0, 159, 112, 0.15);
  static const kGreen3 = Color.fromRGBO(16, 207, 150, 1);
  static const kGreen4 = Color.fromRGBO(41, 208, 250, 1);
  static const kGreen5 = Color.fromRGBO(0, 126, 160, 1);
  static const kGreen6 = Color.fromRGBO(0, 130, 75, 1);
  static const kRed1 = Color.fromRGBO(255, 127, 127, 1);
  static const kRed2 = Color.fromRGBO(163, 0, 0, 1);
  static const kRed3 = Color.fromRGBO(242, 0, 0, 1);
  static const kRed4 = Color.fromRGBO(242, 0, 0, 0.15);
  static const kOrange1 = Color.fromARGB(255, 240, 100, 31);
  static const kOrange2 = Color.fromARGB(255, 211, 78, 12);
  static const kBlack1 = Color.fromRGBO(53, 68, 73, 1);
  static const kBlack2 = Color.fromRGBO(0, 10, 15, 1);
  static const kBlack3 = Color.fromRGBO(0, 0, 0, 0.15);
  static const kBlack4 = Color.fromRGBO(35, 50, 55, 1);
  static const kBlack5 = Color.fromARGB(255, 69, 90, 100);
  static const kBlack6 = Color.fromRGBO(0, 0, 0, 1);
  static const kBlack7 = Color.fromRGBO(0, 0, 0, 0.35);
  static const kBlue1 = Color.fromRGBO(16, 159, 207, 1);
  static const kBlue2 = Color.fromRGBO(0, 116, 164, 1);
  static const kBlue3 = Color.fromRGBO(6, 149, 197, 1);
  static const kBlue4 = Color.fromRGBO(96, 125, 139, 1);
  static const kBlue5 = Color.fromRGBO(16, 159, 207, 1);
  static const kBlue6 = Color.fromRGBO(0, 116, 164, 1);
  static const kBlue7 = Color.fromRGBO(3, 169, 244, 1);
  static const kBlueGrey1 = Color.fromRGBO(96, 125, 139, 1);
  static const kYellow1 = Color.fromRGBO(255, 244, 184, 1);
  static const kYellow2 = Color.fromRGBO(202, 172, 0, 1);
  static const primaryColor = Color(0xFF2697FF);
  static const secondaryColor = Color(0xFF292929);
  static const secondaryColorLight = Color.fromARGB(255, 173, 171, 171);
  static const bgColor = Color(0xFF212121);
  static const bgColorLight = Colors.white;
  static const darkgreenColor = Color(0xFF2c614f);
  static const Color blue = Color(0xFF0D46BB);
  static const Color background = Color(0xFFEDEEF2);
  static const Color wrapperBg = Color(0xFF212121);
  static const btnGradientDark = Color(0XFF0074A4);
  static const sCaffoldColor = Color(0XFFE4F0FA);
  static const materialGreen = Colors.green;
  static const materialRed = Colors.red;
  static const materialBlack = Colors.black;
  static const materialWhite = Colors.white;
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
