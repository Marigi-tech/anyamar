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
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 20),
        child: InkWell(
          onTap: () => Navigator.maybePop(context),
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            radius: isHovered ? 20 : 18,
            child: Icon(
              Icons.arrow_back,
              size: isHovered ? 22 : 19,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
