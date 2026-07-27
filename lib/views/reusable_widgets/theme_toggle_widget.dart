import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/providers/theme_provider.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeIsDarkProvider);
    return IconButton(
      icon: Icon(themeMode ? Icons.light_mode : CupertinoIcons.moon, size: 20),

      onPressed: () => ref.read(themeIsDarkProvider.notifier).toggleTheme(),
    );
  }
}
