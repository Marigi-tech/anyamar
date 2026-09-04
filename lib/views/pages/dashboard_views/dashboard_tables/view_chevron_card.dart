import 'package:flutter/cupertino.dart';
import 'package:anyamar/commons/exports.dart';

class ViewChevronCard extends StatefulWidget {
  final VoidCallback onPressedCallBack;
  final IconData? iconData;
  final Color? iconColor;
  const ViewChevronCard({
    super.key,
    required this.onPressedCallBack,
    this.iconData,
    this.iconColor,
  });

  @override
  State<ViewChevronCard> createState() => _ViewChevronCardState();
}

class _ViewChevronCardState extends State<ViewChevronCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressedCallBack,
        child: Card(
          elevation: isHovered ? 8 : 5,
          surfaceTintColor: isHovered ? AppColorsConstant.blueGreyColor : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 06, horizontal: 06),
            child: Icon(
              widget.iconData ?? CupertinoIcons.chevron_right,
              size: 15,
              color:
                  widget.iconColor ??
                  (isHovered
                      ? AppColorsConstant.lightGreenColor
                      : AppColorsConstant.darkBlueColor),
            ),
          ),
        ),
      ),
    );
  }
}
