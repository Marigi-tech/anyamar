import '../../../data/constants/commons.dart';

class UncollapsedSideItem extends StatefulWidget {
  final String title;
  final VoidCallback? onPressedCallBack;
  final IconData icon;
  final bool? isLogOutButton;
  final int? index;
  const UncollapsedSideItem({
    super.key,
    required this.title,
    this.onPressedCallBack,
    required this.icon,
    this.isLogOutButton,
    this.index,
  });

  @override
  State<UncollapsedSideItem> createState() => _UncollapsedSideItemState();
}

class _UncollapsedSideItemState extends State<UncollapsedSideItem> {
  late BoxDecoration backgroundColor;
  late bool isHovered;
  late bool isSelected;

  @override
  void initState() {
    backgroundColor = _getNormalGradient();
    isHovered = false;
    isSelected = _getIsSelected();
    super.initState();
  }

  bool _getIsSelected() {
    return selectedSideItemNotifier.value == widget.index ? true : false;
  }

  BoxDecoration _getHoverGradient() {
    return widget.isLogOutButton == true
        ? AppGradient.gradientLightRed
        : AppGradient.gradientLightGreen;
  }

  BoxDecoration _getNormalGradient() {
    return selectedSideItemNotifier.value == widget.index
        ? AppGradient.gradientLightBlue
        : widget.isLogOutButton == true
        ? AppGradient.gradientRed
        : AppGradient.gradientTransparent;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          backgroundColor = _getHoverGradient();
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          backgroundColor = _getNormalGradient();
        });
      },
      child: GestureDetector(
        onTap: widget.onPressedCallBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          decoration: BoxDecoration(
            gradient: backgroundColor.gradient,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: isSelected || widget.isLogOutButton == true || isHovered
                    ? AppColorsConstant.whiteColor
                    : null,
              ),
              const SizedBox(width: 10),

              Flexible(
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isSelected || isHovered
                        ? AppColorsConstant.whiteColor
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
