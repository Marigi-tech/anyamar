
import 'package:anyamar/commons/exports.dart';
class CustomInputDecoration {
  static InputDecoration textInputDecoration({
    String? hintText,
    Widget? suffix,
    Color? labelColor,
    Color? fillColor,
    Widget? prefixIcon,
    bool? isPassword,
    Widget? suffixIcon,
    Widget? prefix,
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
    suffix: suffix,

    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    prefix: prefix
  );
}

