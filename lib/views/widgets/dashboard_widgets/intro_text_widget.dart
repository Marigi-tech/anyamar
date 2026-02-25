import 'package:test_app/data/constants/commons.dart';

class IntroTextWidget extends StatelessWidget {
  final String dashboardItem;
  const IntroTextWidget({super.key, required this.dashboardItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(
          text: TextSpan(
            text: 'Anyamar / ',
            style: TextStyle(
              color: AppColorsConstant.blueGreyColor,
              letterSpacing: 0.5,
            ),
            children: [
              TextSpan(
                text: dashboardItem,
                style: TextStyle(
                  color: themeIsDarkNotifier.value
                      ? AppColorsConstant.whiteColor
                      : AppColorsConstant.blueGreyColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
