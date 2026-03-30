import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/providers/theme_provider.dart';

class IntroTextWidget extends ConsumerWidget {
  final String dashboardItem;
  const IntroTextWidget({super.key, required this.dashboardItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  color: ref.watch(themeIsDarkProvider)
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
