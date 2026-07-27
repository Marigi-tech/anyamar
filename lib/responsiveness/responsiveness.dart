import 'package:anyamar/constants/commons.dart';

class Responsiveness extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsiveness({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  //Check screen size
  //? Mobile screen
  static bool isMobile(BuildContext context) =>
      getSizeFromContext(context).width < 850;
  //? Tablet screen
  static bool isTablet(BuildContext context) =>
      getSizeFromContext(context).width < 1100 &&
      getSizeFromContext(context).width >= 850;
  //? Desktop screens
  static bool isDesktop(BuildContext context) =>
      getSizeFromContext(context).width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = getSizeFromContext(context);
    //If width > 1100, it's a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    //If width is less than 1100 and greater than 850, it's a tablet
    else if (size.width >= 850 && size.width < 1100) {
      return tablet;
    }
    //If width is less than 850, it's a phone
    else {
      return mobile;
    }
  }
}
