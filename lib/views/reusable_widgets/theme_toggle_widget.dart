import 'package:anyamar/commons/exports.dart';

class ThemeToggleWidget extends ConsumerStatefulWidget {
  final double? iconSize;
  const ThemeToggleWidget({super.key, this.iconSize = 18});

  @override
  ConsumerState<ThemeToggleWidget> createState() => _ThemeToggleWidgetState();
}

class _ThemeToggleWidgetState extends ConsumerState<ThemeToggleWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
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
      child: AnimatedPadding(
        padding: isHovered
            ? const EdgeInsets.only(bottom: 3.0) // Lifts the card up by 6px
            : const EdgeInsets.only(top: 3.0), // Rest state
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,

        child: AnimatedScale(
          scale: isHovered ? 1.0001 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInCubic,
          child: IconButton(
            hoverColor: AppColors.primaryBlue,
            color: themeIsDark
                ? AppColors.darkElevatedCard
                : AppColors.lightCard,
            icon: Icon(
              themeIsDark ? Icons.light_mode : Icons.dark_mode_outlined,
              size: widget.iconSize,
              color: isHovered
                  ? AppColors.darkText
                  : themeIsDark
                  ? AppColors.darkText
                  : AppColors.lightText,
            ),

            onPressed: () =>
                ref.read(themeIsDarkProvider.notifier).toggleTheme(),
          ),
        ),
      ),
    );
  }
}
