import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants/commons.dart';

class ViewChevronCard extends StatefulWidget {
  final VoidCallback onPressedCallBack;
  const ViewChevronCard({super.key, required this.onPressedCallBack});

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
              CupertinoIcons.chevron_right,
              size: 15,
              color: isHovered
                  ? AppColorsConstant.lightGreenColor
                  : AppColorsConstant.darkBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
