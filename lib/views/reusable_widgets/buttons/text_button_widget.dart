import 'package:anyamar/commons/exports.dart';

class AppTextButton extends StatefulWidget {
  final VoidCallback onPressedCallBack;
  final String buttonTitle;
  final Color? buttonColor;
  const AppTextButton({
    super.key,
    required this.onPressedCallBack,
    required this.buttonTitle,
    this.buttonColor,
  });

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressedCallBack,
      child: Text(
        widget.buttonTitle,
        style: CustomTextStyles.cardDescriptionStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          color: widget.buttonColor ?? AppColors.whiteColor,
        ),
      ),
    );
    // return TextButton(
    //   onPressed: widget.onPressedCallBack,
    //   child: Text(
    //     widget.buttonTitle,
    //     style: TextStyle(
    //       fontSize: 16,
    //       color: AppColorsConstant.whiteColor,
    //       fontWeight: FontWeight.w500,
    //     ),
    //   ),
    // );
  }
}
