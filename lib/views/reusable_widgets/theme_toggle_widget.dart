import 'package:anyamar/commons/exports.dart';

class ThemeToggleWidget extends ConsumerWidget {
  final double? iconSize;
  const ThemeToggleWidget({super.key, this.iconSize = 18});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDarkMode = ref.watch(themeIsDarkProvider);
    return IconButton(
      icon: Icon(
        themeIsDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
        size: iconSize,
        color: themeIsDarkMode ? AppColors.darkText : AppColors.lightText,
      ),

      onPressed: () => ref.read(themeIsDarkProvider.notifier).toggleTheme(),
    );
  }
}
