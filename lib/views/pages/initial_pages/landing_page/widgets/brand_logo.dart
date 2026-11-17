import 'package:anyamar/commons/exports.dart';

class BrandLogo extends ConsumerWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeIsDarkProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.roofing_rounded, color: LandingHeroColors.teal, size: 34),
        SizedBox(width: 9),
        Text(
          'ANYAMAR',
          style: CustomTextStyles.cardDescriptionStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 3.5,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ],
    );
  }
}
