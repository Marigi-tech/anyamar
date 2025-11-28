import 'package:test_app/data/constants/commons.dart';

class CollapsedSideItem extends StatefulWidget {
  final String title;
  final VoidCallback? onPressedCallBack;
  final IconData icon;
  final bool? isLogOutButton;
  final int? index;
  const CollapsedSideItem({
    super.key,
    required this.title,
    this.onPressedCallBack,
    required this.icon,
    this.isLogOutButton,
    this.index,
  });

  @override
  State<CollapsedSideItem> createState() => _CollapsedSideItemState();
}

class _CollapsedSideItemState extends State<CollapsedSideItem> {
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
        ? AppGradient.gradientRed
        : AppGradient.gradientLightGreen;
  }

  BoxDecoration _getNormalGradient() {
    return selectedSideItemNotifier.value == widget.index
        ? AppGradient.gradientLightBlue
        : AppGradient.gradientTransparent;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.title, // 👈 Tooltip text
      waitDuration: const Duration(milliseconds: 300),
      verticalOffset: -45,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 48, 48).withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: AppColorsConstant.whiteColor,
        fontSize: 12,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 13.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHovered = true;
              backgroundColor = _getHoverGradient();
            });
          },
          onExit: (event) {
            setState(() {
              backgroundColor = _getNormalGradient();
            });
          },
          child: GestureDetector(
            onTap: widget.onPressedCallBack,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: backgroundColor.gradient,
                shape: BoxShape.circle,
              ),

              child: Icon(widget.icon, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
