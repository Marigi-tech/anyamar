import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';

class AppTextButton extends StatefulWidget {
  final VoidCallback onPressedCallBack;
  final String buttonTitle;
  const AppTextButton({
    super.key,
    required this.onPressedCallBack,
    required this.buttonTitle,
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
        style: TextStyle(
          fontSize: 16,
          color: AppColorsConstant.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
