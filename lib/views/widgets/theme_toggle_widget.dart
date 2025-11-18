import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/notifiers.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeIsDarkNotifier,
      builder: (context, isDark, child) {
        return IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),

          onPressed: () async {
            themeIsDarkNotifier.value = !isDark;
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            await prefs.setBool(
              ThemeConstant.darkKey,
              themeIsDarkNotifier.value,
            );
          },
        );
      },
    );
  }
}
