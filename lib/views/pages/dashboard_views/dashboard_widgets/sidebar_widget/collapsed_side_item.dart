import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/selected_page_provider/selected_page_notifier.dart';

class CollapsedSideItem extends ConsumerStatefulWidget {
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
  ConsumerState<CollapsedSideItem> createState() => _CollapsedSideItemState();
}

class _CollapsedSideItemState extends ConsumerState<CollapsedSideItem> {
  late bool isHovered;
  late bool isSelected;

  @override
  void initState() {
    isHovered = false;
    isSelected = false;
    // isSelected = _getIsSelected();
    super.initState();
  }

  bool _getIsSelected(int selectedPage) {
    return selectedPage == widget.index ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(selectedPageProvider);
    isSelected = _getIsSelected(selectedPage);
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
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 06.0),
        child: MouseRegion(
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
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isHovered
                    ? AppGradient.gradientLightGreen.gradient
                    : isSelected
                    ? AppGradient.gradientBlue.gradient
                    : AppGradient.gradientTransparent.gradient,
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  widget.icon,
                  size: 18,
                  color: widget.isLogOutButton == true
                      ? AppColorsConstant.redColor
                      : isSelected || isHovered
                      ? AppColorsConstant.lightNavColor
                      : AppColorsConstant.blueGreyColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
