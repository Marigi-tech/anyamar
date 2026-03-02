import 'package:flutter/material.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';

class CardHeaderWidget extends StatelessWidget {
  final String cardTitle;
  final String buttonTitle;
  final VoidCallback? onPressedCallBack;
  final Color? buttonColor;
  final double? fontSize;
  const CardHeaderWidget({
    super.key,
    required this.cardTitle,
    required this.buttonTitle,
    this.onPressedCallBack,
    this.buttonColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return //Enter card title here
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardTitle,
                style: CustomTextStyles.cardTitleStyle.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [
                  //View button
                  ColorButtonWidget(
                    onPressedCallBack: onPressedCallBack ?? () {},
                    buttonTitle: buttonTitle,
                    fontSize: fontSize ?? 14,
                    buttonColor: buttonColor ?? AppColorsConstant.greenColor,
                  ),
                ],
              ),
            ],
          ),
          //Divider
          Divider(thickness: 0.18, height: 10.0),
        ],
      ),
    );
  }
}
