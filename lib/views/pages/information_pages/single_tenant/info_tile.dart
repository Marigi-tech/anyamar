import 'package:flutter/material.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/commons.dart';

class InfoTile extends StatelessWidget {
  final IconData tileIcon;
  final String tileTitle;
  final String tileDescription;
  final Widget? tileDescriptionWidget;
  final VoidCallback onTapCallBack;

  const InfoTile({
    super.key,
    required this.tileIcon,
    required this.tileTitle,
    required this.tileDescription,
    required this.onTapCallBack,
    this.tileDescriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        dense: true,
        leading: Icon(tileIcon, size: 15),
        title: Text(
          tileTitle,
          style: CustomTextStyles.cardDescriptionStyle.copyWith(
            inherit: true,
            fontStyle: FontStyle.normal,
            fontSize: 11,
          ),
        ),
        trailing:
            tileDescriptionWidget ??
            Text(
              tileDescription,
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                inherit: true,
                color: AppColorsConstant.darkBlueColor,
                fontSize: 11,
              ),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
    );
  }
}
