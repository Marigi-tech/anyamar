import 'package:flutter/material.dart';
import 'package:anyamar/constants/constants.dart';

class CardButtonWidget extends StatefulWidget {
  final String buttonTitle;
  final VoidCallback? onPressedCallBack;
  final IconData? buttonIcon;
  final double? titleFontSize;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? fontColor;
  const CardButtonWidget({
    super.key,
    required this.buttonTitle,
    this.onPressedCallBack,
    this.buttonIcon,
    this.padding,
    this.titleFontSize,
    this.backgroundColor,
    this.fontColor,
  });

  @override
  State<CardButtonWidget> createState() => _CardButtonWidgetState();
}

class _CardButtonWidgetState extends State<CardButtonWidget> {
  late bool cardIsHovered;

  @override
  void initState() {
    super.initState();
    cardIsHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) => setState(() => cardIsHovered = true),
      onExit: (event) => setState(() => cardIsHovered = false),
      child: GestureDetector(
        onTap: widget.onPressedCallBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Card(
            elevation: cardIsHovered == true ? 10.0 : 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: widget.backgroundColor,
            child: Padding(
              padding:
                  widget.padding ??
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                children: [
                  if (widget.buttonIcon != null)
                    Icon(
                      widget.buttonIcon,
                      size: 14,
                      color: cardIsHovered == true
                          ? AppColorsConstant.greenColor
                          : null,
                    ),
                  const SizedBox(width: 5.0),
                  Text(
                    widget.buttonTitle,
                    style: TextStyle(
                      fontSize: widget.titleFontSize ?? 14,
                      color: cardIsHovered == true
                          ? AppColorsConstant.greenColor
                          : widget.fontColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
