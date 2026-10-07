import 'package:anyamar/commons/exports.dart';

class RowTitleWidget extends ConsumerWidget {
  final IconData? icon;
  final String text;
  final Color? iconColor;

  const RowTitleWidget({
    super.key,
    this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return Row(
      children: [
        Icon(icon, size: 14, color: iconColor),
        SizedBox(width: 10),
        Text(
          text,
          style: CustomTextStyles.cardDescriptionStyle.copyWith(
            fontStyle: FontStyle.normal,
            color: themeIsDark == true
                ? AppColors.darkText
                : AppColors.lightText,
          ),
        ),
      ],
    );
  }
}
