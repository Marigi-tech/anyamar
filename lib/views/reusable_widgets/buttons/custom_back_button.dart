import 'package:anyamar/commons/exports.dart';

class CustomBackButton extends ConsumerStatefulWidget {
  final Color? color;
  const CustomBackButton({super.key, this.color});

  @override
  ConsumerState<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends ConsumerState<CustomBackButton> {
  Color? color;
  bool isHovered = false;
  Color? backgroundColor;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(themeIsDarkProvider);
    backgroundColor = isHovered
        ? AppColors.primaryBlue.withValues(alpha: 0.85)
        : isDark
        ? AppColors.darkElevatedCard.withValues(alpha: 0.85)
        : AppColors.lightCard.withValues(alpha: 0.85);

    textColor = isHovered
        ? AppColors.whiteColor.withValues(alpha: 0.85)
        : isDark
        ? AppColors.darkText
        : AppColors.lightText;

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
            ? const EdgeInsets.only(bottom: 3.0, top: 10, left: 20)
            : const EdgeInsets.only(top: 10, left: 20),
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
        child: AnimatedScale(
          scale: isHovered ? 1.0001 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInCubic,
          child: IconButton(
            hoverColor: AppColors.primaryBlue,
            color: isDark ? AppColors.darkElevatedCard : AppColors.lightCard,
            icon: Icon(
              Icons.arrow_back,
              size: 18,
              color: isHovered
                  ? AppColors.darkText
                  : isDark
                  ? AppColors.darkText
                  : AppColors.lightText,
            ),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
      ),
    );
  }
}
