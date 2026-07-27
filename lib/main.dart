import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/providers/theme_provider.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/landing_page.dart';

//NB THIS  IS A FLUTTER WEB PROJECT
//CUSTOMISATION FOR ANDROID AND IOS WILL BE DONE IN LATER ITERATIONS
void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeIsDarkProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        fontFamily: 'Lato',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: 'Montserrat'),
          headlineMedium: TextStyle(fontFamily: 'Montserrat'),
          titleLarge: TextStyle(fontFamily: 'Montserrat'),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorsConstant.greenColor,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        fontFamily: 'Lato',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: 'Montserrat'),
          headlineMedium: TextStyle(fontFamily: 'Montserrat'),
          titleLarge: TextStyle(fontFamily: 'Montserrat'),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorsConstant.greenColor,
          brightness: Brightness.dark,
        ),
      ),

      home: const LandingPage(),
    );
  }
}
