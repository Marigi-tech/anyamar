import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/data/constants.dart';

final themeIsDarkProvider = NotifierProvider<ThemeNotifier, bool>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    _loadTheme();
    return false; // default (light)
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(ThemeConstant.darkKey) ?? false;
    state = isDark;
  }

  Future<void> toggleTheme() async {
    state = !state;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ThemeConstant.darkKey, state);
  }

  Future<void> setTheme(bool isDark) async {
    state = isDark;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ThemeConstant.darkKey, state);
  }
}
