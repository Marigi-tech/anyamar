import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:anyamar/data/models/social_icon/social_icon_model.dart';

Widget socialIconButton(SocialIconModel socialIcon) {
  return InkWell(
    onTap: () {}, // TO DO: Add sign-in logic
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(socialIcon.iconPath, width: 13, height: 13),
          SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              child: Text(
                socialIcon.iconName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
