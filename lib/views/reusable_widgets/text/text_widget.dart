import 'package:anyamar/commons/exports.dart';

class PageTitleWidget extends StatelessWidget {
  final String pageTitle;
  const PageTitleWidget({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        pageTitle,
        style: CustomTextStyles.cardTitleStyle.copyWith(
          fontSize: 22,
          // color: AppColorsConstant.darkBlueColor,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
