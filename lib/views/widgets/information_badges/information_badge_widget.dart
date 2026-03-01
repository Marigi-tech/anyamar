import 'package:flutter/material.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/commons.dart';

class InformationBadge extends StatelessWidget {
  final String text;
  final Color badgeColor;
  final Color textColor;
  const InformationBadge({
    super.key,
    required this.text,
    required this.badgeColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        border: Border.all(color: badgeColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: CustomTextStyles.cardDescriptionStyle.copyWith(
          color: badgeColor,
          fontSize: 13,
        ),
      ),
    );
    // return Badge(
    //   backgroundColor: badgeColor,
    //   textColor: textColor,
    //   smallSize: 15,
    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //   label: Text(text),
    //   textStyle: CustomTextStyles.cardDescriptionStyle,

    // );
  }
}

//Occupancy status method
({Color textColor, Color badgeColor}) getOccupancyStatus(bool? isOccupied) {
  Color backgroundColor;
  Color textColor;

  if (isOccupied == true) {
    backgroundColor = AppColorsConstant.lightGreenColor;
    textColor = AppColorsConstant.darkGreenColor;
  } else {
    textColor = AppColorsConstant.darkRedColor;
    backgroundColor = AppColorsConstant.redColor;
  }

  return (textColor: textColor, badgeColor: backgroundColor);
}
