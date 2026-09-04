import 'package:anyamar/commons/exports.dart';

class InfoTile extends StatelessWidget {
  final IconData tileIcon;
  final String tileTitle;
  final String tileDescription;
  final VoidCallback? onTapCallBack;
  final double? fontSize;
  final Widget? trailingWidget;
  final Color? titleColor;
  

  const InfoTile({
    super.key,
    required this.tileIcon,
    required this.tileTitle,
    required this.tileDescription,
    this.onTapCallBack,
    this.fontSize,
    this.trailingWidget,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        dense: true,
        leading: Icon(tileIcon, size: fontSize ?? 15),
        onTap: onTapCallBack,
        title: Text(
          tileTitle,
          style: CustomTextStyles.cardDescriptionStyle.copyWith(
            inherit: true,
            fontStyle: FontStyle.normal,
            fontSize: fontSize ?? 14,
            fontFamily: 'Lato',
          ),
        ),
        trailing:
            trailingWidget ??
            Text(
              tileDescription,
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                inherit: true,
                color: titleColor ?? AppColorsConstant.darkBlueColor,
                fontSize: fontSize ?? 14,
                fontFamily: 'Lato',
              ),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
    );
  }
}
