import 'package:anyamar/commons/exports.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeIsDarkProvider);
    return IconButton(
      icon: Icon(themeMode ? Icons.light_mode : Icons.dark_mode_outlined),

      onPressed: () => ref.read(themeIsDarkProvider.notifier).toggleTheme(),
    );
  }
}
