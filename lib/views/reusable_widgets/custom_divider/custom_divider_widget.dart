import 'package:anyamar/commons/exports.dart';

class CustomDividerWidget extends ConsumerWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          height: 1 / pixelRatio,
          color: themeIsDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class CardItemSeparator extends ConsumerWidget {
  const CardItemSeparator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 1 / pixelRatio,
          color: themeIsDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}

class CustomVerticalSeparator extends ConsumerWidget {
  const CustomVerticalSeparator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Container(
      width: 1 / pixelRatio,
      height: double.infinity,
      color: themeIsDark
          ? AppColors.darkBorder
          : AppColors.lightBorder,
    );
  }
}