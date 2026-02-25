import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/data/notifiers.dart';
import 'package:test_app/views/pages/initial_pages/landing_page/landing_page.dart';

void main() {
  runApp(const MyApp());
  // List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // list.retainWhere((item) => item.isEven);
  // print(list);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setThemeMode();
    super.initState();
  }

  void setThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool(ThemeConstant.darkKey);
    themeIsDarkNotifier.value = repeat ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeIsDarkNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Lato',
            textTheme: TextTheme(
              headlineLarge: TextStyle(fontFamily: 'Montserrat'),
              headlineMedium: TextStyle(fontFamily: 'Montserrat'),
              titleLarge: TextStyle(fontFamily: 'Montserrat'),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColorsConstant.greenColor,
              brightness: value ? Brightness.dark : Brightness.light,
            ),
          ),
          home: LandingPage(),
        );
      },
    );
  }
}
