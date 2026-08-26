import 'package:another_flushbar/flushbar.dart';
import 'package:anyamar/constants/commons.dart';

Flushbar displayTopMessage(
  String title,
  String messageCode,
  Color backgroundColor,
) {
  return Flushbar(
    title: title,
    message: messageCode,
    routeBlur: 0.5,
    duration: Duration(seconds: 12),
    routeColor: AppColorsConstant.kBlue1.withValues(alpha: 0.3),
    blockBackgroundInteraction: true,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: backgroundColor,
    animationDuration: Duration(milliseconds: 500),
    flushbarStyle: FlushbarStyle.GROUNDED,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    progressIndicatorBackgroundColor: Colors.blueGrey,
  );
}

void displaySnackBar(
  BuildContext context,
  String information,
  Color backgroundColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(information),
      duration: Duration(seconds: 1),
      showCloseIcon: true,
      closeIconColor: AppColorsConstant.whiteColor,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: backgroundColor,
    ),
  );
}
