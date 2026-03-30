import 'package:test_app/constants/commons.dart';

class BaseIcon extends StatelessWidget {
  final VoidCallback? onPressedCallback;
  final Color? color;
  final String iconFileName;
  final double width;
  final double height;
  final bool? isPng;
  final bool? isDoc;

  final IconData? materialIcon;

  const BaseIcon({
    super.key,
    required this.iconFileName,
    this.isPng = false,
    this.isDoc,
    this.onPressedCallback,
    this.color,
    this.width = 15.0,
    this.height = 15.0,
    this.materialIcon,
  });

  @override
  Widget build(BuildContext context) {
    final String svgAsset = isDoc == true
        ? docIconsPath + iconFileName
        : isPng == false
        ? svgIconsPath + iconFileName
        : pngIconsPath + iconFileName;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        onPressed: onPressedCallback,
        icon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: isPng == true
              ? Image.asset(
                  svgAsset,
                  color: color ?? AppColorsConstant.blueGreyColor,
                  width: width,
                  height: height,
                )
              : materialIcon != null
              ? Icon(
                  materialIcon,
                  color: color ?? AppColorsConstant.blueGreyColor,
                  size: height,
                )
              : SvgPicture.asset(
                  svgAsset,
                  colorFilter: ColorFilter.mode(
                    color ?? AppColorsConstant.blueGreyColor,
                    BlendMode.srcIn,
                  ),
                  width: width,
                  height: height,
                ),
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
