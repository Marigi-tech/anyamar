import 'package:another_flushbar/flushbar.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';

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
  bool isSuccessful,
) {
  // Do not attempt to display a popup using a disposed context.
  if (!context.mounted) return;

  showGeneralDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierLabel: isSuccessful ? 'Notification' : 'Error',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 250),

    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: InfoUnavailableOverlay(
          isError: !isSuccessful,
          unavailableInfo: UnavailableInfoModel(
            text: isSuccessful ? 'Notification' : 'Error',
            supplementaryText: information,
            closeMethod: () {
              Navigator.of(dialogContext, rootNavigator: true).pop();
            },
            ctaButtonWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButtonWidget(
                  buttonTitle: 'Close',
                  buttonColor: isSuccessful
                      ? AppColors.lightGreen
                      : AppColors.red,
                  onButtonPressedCallBack: () {
                    Navigator.of(dialogContext, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
          ),
          child: const SizedBox.expand(),
        ),
      );
    },

    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
