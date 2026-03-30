import 'package:flutter/cupertino.dart';
import 'package:test_app/constants/commons.dart';

class CustomInputDecoration {
  static InputDecoration textInputDecoration({
    String? hintText,
    Widget? suffixIcon,
    Color? labelColor,
    Color? fillColor,
    Widget? prefixIcon,
    bool? isPassword,
  }) => InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    fillColor: AppColorsConstant.kPrimaryColor,
    hintStyle: CustomTextStyles.cardDescriptionStyle.copyWith(
      fontSize: 14,
      letterSpacing: 1,
      fontStyle: FontStyle.normal,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColorsConstant.kGrey3, width: 0.8),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColorsConstant.greenColor, width: 1.0),
    ),

    hintText: hintText,
    suffix: isPassword == true
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                //TODO: Use Riverpod to change state
              },
              child: Icon(CupertinoIcons.eye, size: 13),
            ),
          )
        : Text(''),
  );
}
