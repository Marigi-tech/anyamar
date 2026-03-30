import 'package:test_app/constants/commons.dart';

class PageTitleWidget extends StatelessWidget {
  final String pageTitle;
  const PageTitleWidget({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          pageTitle,
          style: CustomTextStyles.cardTitleStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
