import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/providers/theme_provider.dart';

class NavItem extends ConsumerStatefulWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool? isHomeButton;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    this.isHomeButton,
  });

  @override
  ConsumerState<NavItem> createState() => _NavItemState();
}

class _NavItemState extends ConsumerState<NavItem> {
  late BoxDecoration backgroundColor;
  late bool isHovered;

  @override
  void initState() {
    super.initState();
    backgroundColor = _getNormalGradient();
    isHovered = false;
  }

  BoxDecoration _getHoverGradient() {
    return widget.isHomeButton == true
        ? AppGradient.gradientLightGreen
        : AppGradient.gradientLightBlue;
  }

  BoxDecoration _getNormalGradient() {
    return widget.isHomeButton == true
        ? AppGradient.gradientGreen
        : AppGradient.gradientTransparent;
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedPageNotifier.value == widget.index;

    return Tooltip(
      message: widget.label, // 👈 Tooltip text
      waitDuration: const Duration(milliseconds: 300),
      verticalOffset: 20,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColorsConstant.blackColor.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),

      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) {
          setState(() {
            backgroundColor = _getHoverGradient();
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            backgroundColor = _getNormalGradient();
            isHovered = false;
          });
        },

        child: ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (context, value, child) {
            return GestureDetector(
              onTap: () {
                selectedPageNotifier.value = widget.index;
              },

              child: Row(
                children: [
                  widget.isHomeButton == true
                      ? CentralButton(
                          index: widget.index,
                          backgroundColor: backgroundColor,
                        )
                      : Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            gradient: isSelected || isHovered
                                ? _getHoverGradient().gradient
                                : backgroundColor.gradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            widget.icon,
                            size: 18,
                            color:
                                ref.watch(themeIsDarkProvider) ==
                                    true //DarkTheme
                                ? isSelected || isHovered
                                      ? AppColorsConstant.whiteColor
                                      : AppColorsConstant.whiteColor
                                : //Light Theme
                                  isSelected || isHovered
                                ? AppColorsConstant.whiteColor
                                : const Color.fromARGB(255, 66, 67, 68),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
