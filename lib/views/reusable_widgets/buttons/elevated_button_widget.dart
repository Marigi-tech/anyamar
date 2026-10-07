import 'package:anyamar/commons/exports.dart';

class ElevatedButtonWidget extends ConsumerWidget {
  final String buttonTitle;
  final VoidCallback onButtonPressedCallBack;
  final Icon? buttonIcon;
  final Color? buttonColor;
  final bool? isClear;
  const ElevatedButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.onButtonPressedCallBack,
    this.buttonIcon,
    this.buttonColor,
    this.isClear,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.read(themeIsDarkProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton.icon(
        onPressed: onButtonPressedCallBack,
        icon: buttonIcon,
        label: Text(buttonTitle),
        style: ElevatedButton.styleFrom(
          backgroundColor: isClear == true
              ? themeIsDark == true
                    ? AppColors.darkCard
                    : AppColors.lightCard
              : buttonColor ?? AppColors.buttonBlueColor,
          foregroundColor: isClear == true
              ? themeIsDark == true
                    ? AppColors.darkText
                    : AppColors.lightText
              : AppColors.whiteColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
